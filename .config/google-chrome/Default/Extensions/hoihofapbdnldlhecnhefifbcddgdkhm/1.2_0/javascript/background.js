/*
* Copyright (C) 2011 Google Inc. All rights reserved.
* Redistribution and use in source and binary forms, with or without
* modification, are permitted provided that the following conditions are
* met:
*
*     * Redistributions of source code must retain the above copyright
* notice, this list of conditions and the following disclaimer.
*     * Redistributions in binary form must reproduce the above
* copyright notice, this list of conditions and the following disclaimer
* in the documentation and/or other materials provided with the
* distribution.
*     * Neither the name of Google Inc. nor the names of its
* contributors may be used to endorse or promote products derived from
* this software without specific prior written permission.
*
* THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
* "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
* LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
* A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
* OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
* SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
* LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
* DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
* THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
* (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
* OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

/**
 * @fileoverview Contains javascript to handle the background process
 *  related functionalities of the clock module. It communicates with
 *  clock-db.js for all database related calls. Initializes and maintains the
 *  listener for alarms to be played.
 */

/**
 * Array containing days of the week.
 */
var daysElement = [
  'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'
];

/**
 * The default Alarm Clock Object.
 * @constructor
 */
function AlarmClock() {
  /**
   * [Array] contains list of all existing alarms.
   */
  this.existingAlarms = [];

  /**
   * Boolean contains true if any alarm is added/deleted/modified or
   * on alarm play.
   */
  this.isUpdated = false;

  /**
   * [Array] contains list of currently playing alarms.
   */
  this.currentAlarm = [];

  /**
   * Contains the alarm id of alarm open in edit mode.
   */
  this.alarmId = null;

  /**
   * Boolean contains true if an alarm is currently playing.
   */
  this.isActiveAlarm = false;
}

/**
 * The default Alarm Clock Data Object.
 * @constructor
 */
function AlarmClockData() {
  /**
   * The alarm id.used as a primary key in database.
   */
  this.id = 0;

  /**
   * Alarm time in HH:MM (am/pm)format.
   */
  this.alarmTime = '';

  /**
   * Boolean - contains true if alarm is set in repeat mode.
   */
  this.isRepeat = false;

  /**
   * Contains the days on which to play the alarm.
   */
  this.repeatDays = '';

  /**
   * Contains the sound file to play for the alarm.
   */
  this.sound = '';

  /**
   * Boolean - Contains false if alarm is disabled by the user.
   */
  this.isEnabled = false;

  /**
   * Contains whether an alarm is a snooze or a normal alarm.
   */
  this.alarmType = '';

  /**
   * Stores the alarmTime in Milliseconds for a non-repetitive alarms.
   */
  this.alarmTimeMS = 0;
}

/**
 * Buzz the alarm at the specified alarm time.
 * @param {Object} alarmData Contains the state of the alarm to be played.
 */
AlarmClock.prototype.buzzAlarm = function(alarmData) {
  var isOpen = false;
  $(alarmData.sound).play();
  ac.isActiveAlarm = true;
  ac.alarmId = null;
  var arr = chrome.extension.getViews();
  for (var i = 0; i < arr.length; i++) {
    var url = arr[i].document.URL;
    if (url.indexOf('base.html') != -1) {
      isOpen = true;
    }
  }
  if (isOpen) {
    ac.gotoAlarmTab(alarmData);
  } else {
    var url = chrome.extension.getURL('base.html');
    var winRef = window.open(url, '',
        'menubar=no,location=no,resizable=no,status=no');
    ac.gotoAlarmTab(alarmData);
  }
};

/**
 * Switches to the alarm tab on the clock.
 * @param {Object} alarmData Contains the state of the alarm to be played.
 */
AlarmClock.prototype.gotoAlarmTab = function(alarmData) {
  chrome.extension.sendRequest({
    message: 'gotoAlarmTab',
    alarmTime: alarmData.alarmTime
  }, function() {
    if (alarmData.isRepeat == 'false') {
      ac.deleteAlarm(alarmData.id, null);
    }
  });
};

/**
 * Initiates the alarm listen process when application is loaded.
 */
AlarmClock.prototype.initiateAlarmListen = function() {
  var sec = new Date().getSeconds();
  setTimeout(ac.startAlarmListener, (60 - sec) * 1000);
};

/**
 * Starts the alarm listener at the start of first minute after
 * the application loads.
 */
AlarmClock.prototype.startAlarmListener = function() {
  var interval = setInterval(ac.getAlarms, 60 * 1000);
};

/**
 * Stops all playing alarms every one minute and fetch fresh
 * alarms from DB if isUpdate flag is false.
 */
AlarmClock.prototype.getAlarms = function() {
  var flag = false;
  if (ac.isActiveAlarm) {
    flag = true;
    for (var i = 0; i < ac.currentAlarm.length; i++) {
      $(ac.currentAlarm[i].sound).currentTime = 0;
      $(ac.currentAlarm[i].sound).pause();
    }
    ac.currentAlarm = new Array();
    ac.isActiveAlarm = false;
  }
  if (ac.isUpdated || flag) {
    ac.getAllAlarms(ac.setExistingAlarms);
  } else {
    ac.checkCurrentAlarms();
  }

};

/**
 * Sets the alarms fetched from DB into the existing alarms array.
 * @param {Array} result Contains the alarms fetched from database.
 */
AlarmClock.prototype.setExistingAlarms = function(result) {
  ac.existingAlarms = [];
  for (var i = 0; i < result.rows.length; i++) {
    var row = result.rows.item(i);
    var alarm = ac.getAlarmFromRow(row);
    ac.existingAlarms.push(alarm);
  }
  ac.isUpdated = false;
  ac.populateAlarms();
};

/**
 * Send request to the base view to populate the alarms.
 */
AlarmClock.prototype.populateAlarms = function() {
  chrome.extension.sendRequest({
    message: 'populateAlarms',
    alarms: ac.existingAlarms
  }, function() {});
};

/**
 * Checks if any alarm is to be played in the current minute.
 */
AlarmClock.prototype.checkCurrentAlarms = function() {
  if (ac.existingAlarms) {
    var time = new Date();
    for (var i = 0; i < ac.existingAlarms.length; i++) {
      var alarm = new AlarmClockData();
      alarm = ac.existingAlarms[i];
      var isRepeat = alarm.isRepeat;
      if (isRepeat == 'true') {
        var alarmTime = alarm.alarmTimeMS;
        var hours = parseInt(alarmTime.substring(0, 2), 10);
        var min = parseInt(alarmTime.substring(3, 5), 10);
        var day = daysElement[time.getDay()];
        if (time.getHours() == hours && time.getMinutes() == min &&
           (alarm.repeatDays.indexOf(day) != -1) &&
           alarm.isEnabled == 'true') {
             ac.currentAlarm.push(alarm);
             ac.buzzAlarm(alarm);
        }
      } else {
        var alarmTime = new Date(alarm.alarmTimeMS);
        if (alarmTime.getHours() == time.getHours() &&
           alarmTime.getMinutes() == time.getMinutes()) {
             if (alarm.isEnabled == 'true') {
               ac.currentAlarm.push(alarm);
               ac.buzzAlarm(alarm);
             } else {
               ac.deleteAlarm(alarm.id, ac.refreshAlarms);
             }
        }
      }
    }
  }
};

/**
 * Stop the playing alarm.
 * @param {object} alarmData The state of the currently playing alarm.
 */
AlarmClock.prototype.stopAlarm = function(alarmData) {
  if (!alarmData) {
    alarmData = ac.currentAlarm.pop();
  }
  if (alarmData) {
    $(alarmData.sound).currentTime = 0;
    $(alarmData.sound).pause();
    ac.isActiveAlarm = false;
    ac.refreshAlarms();
  }
};

/**
 * Snooze the playing alarm for 5 minutes.
 */
AlarmClock.prototype.snoozeAlarm = function() {
  var time = new Date();
  var snoozeAlarm = new AlarmClockData();
  var alarmData = ac.currentAlarm.pop();
  $(alarmData.sound).currentTime = 0;
  $(alarmData.sound).pause();
  ac.isActiveAlarm = false;
  snoozeAlarm.id = null;
  snoozeAlarm.sound = alarmData.sound;
  snoozeAlarm.isEnabled = true;
  snoozeAlarm.alarmType = 'snooze';
  snoozeAlarm.isRepeat = alarmData.isRepeat;
  var snoozeTime = ac.getSnoozeTime(time.getTime());
  snoozeAlarm.alarmTime = snoozeTime.getTime();
  snoozeAlarm.repeatDays = bg.daysElement[snoozeTime.getDay()];
  clockApp.db.insertSnooze(snoozeAlarm, ac.refreshAlarms);
};

/**
 * Gets the snooze time (HH:MM) by adding 5 minutes to current time.
 * @param {long} time Contains the current date object.
 * @return {date} date Contains the snooze date.
 */
AlarmClock.prototype.getSnoozeTime = function(time) {
  var date = new Date(time + (5 * 60 * 1000));
  date.setSeconds(0, 0);
  return date;
};

/**
 * Converts time into 12 hour time format
 * @param {Date} date Date of alarm.
 * @param {string} time Time in 24 hour format.
 * @return {string} Time in 24 hour format.
 */
AlarmClock.prototype.convertTo12HourFormat = function(date, time) {
  var hours;
  var min;
  var ampm;
  if (date) {
    hours = date.getHours();
    min = date.getMinutes();
  } else {
    time = time.split(/[: ]/);
    hours = parseInt(time[0], 10);
    min = parseInt(time[1], 10);
  }
  if (hours >= 12) {
    if (hours > 12) {
      hours = hours % 12;
    }
    ampm = 'pm';
  } else {
    ampm = 'am';
    if (hours == 0) {
      hours = 12;
    }
  }
  hours = (hours < 10) ? ('' + 0 + hours) : hours;
  min = (min < 10) ? ('' + 0 + min) : min;
  return hours + ':' + min + ' ' + ampm;
};

/**
 * Gets the AlarmClockData object from the row returned by DB.
 * @param {object} row The state of the alarm as fetched from DB.
 * @return {object} alarmData The AlarmClockData object for a row from DB.
 */
AlarmClock.prototype.getAlarmFromRow = function(row) {
  var alarmData = new AlarmClockData();
  alarmData.id = row['id'];
  alarmData.isRepeat = row['isRepeat'];
  var alarmTime = row['time'];
  if (alarmData.isRepeat == 'false') {
    var alarmTimeMS = new Date(parseInt(alarmTime));
    alarmData.alarmTimeMS = parseInt(alarmTime);
    alarmData.alarmTime = ac.convertTo12HourFormat(alarmTimeMS);
  } else {
    alarmData.alarmTimeMS = alarmTime;
    alarmData.alarmTime = ac.convertTo12HourFormat(null, alarmTime);
  }
  alarmData.repeatDays = row['isRepeat'] ? row['repeat'] : ' ';
  alarmData.sound = row['sound'];
  alarmData.alarmType = row['alarmType'];
  alarmData.isEnabled = row['isEnabled'];
  return alarmData;
};

/**
 * Saves alarm into the database.
 * @param {object} alarm The state of the currently playing alarm.
 */
AlarmClock.prototype.saveAlarm = function(alarm) {
  alarm.id = ac.alarmId;
  if (alarm.id) {
    clockApp.db.updateAlarm(alarm, ac.refreshAlarms);
  } else {
    clockApp.db.insertAlarm(alarm, ac.refreshAlarms);
  }
};

/**
 * Deletes alarm from the database.
 * @param {integer} alarmId The id of the alarm to be deleted.
 * @param {function} callback The callback function to be called.
 */
AlarmClock.prototype.deleteAlarm = function(alarmId, callback) {
  if (callback) {
    clockApp.db.deleteAlarm(alarmId, ac.refreshAlarms);
  } else {
    clockApp.db.deleteAlarm(alarmId, null);
  }
};

/**
 * Refreshes the alarms clock page.
 */
AlarmClock.prototype.refreshAlarms = function() {
  if (!ac.isUpdated) {
    ac.populateAlarms();
  } else {
    ac.getAllAlarms(ac.setExistingAlarms);
  }
};

/**
 * Gets all alarms from the database.
 * @param {function} callback The callback function to be called.
 */
AlarmClock.prototype.getAllAlarms = function(callback) {
  ac.alarmId = null;
  clockApp.db.getAllAlarms(callback);
};

/**
 * Sends request to the base page to open the new alarm screen.
 */
AlarmClock.prototype.setNewAlarm = function() {
  chrome.extension.sendRequest({
    message: 'setNewAlarm'
  }, function() {});
};

/**
 * Deletes all the expired alarms from the database at application load.
 * @param {string} result The alarms fetched from DB on application load.
 */
AlarmClock.prototype.deleteExpiredAlarms = function(result) {
  var expAlarms = new Array();
  var currTimeMS = new Date().getTime();
  for (var i = 0; i < result.rows.length; i++) {
    var row = result.rows.item(i);
    var alarm = ac.getAlarmFromRow(row);
    var date = alarm.alarmTimeMS;
    var isRepeat = alarm.isRepeat;
    if (isRepeat == 'false') {
      if (date < currTimeMS) {
        console.log('alarm to be deleted ', row['id']);
        expAlarms.push(alarm.id);
      } else {
        ac.existingAlarms.push(alarm);
      }
    } else {
      ac.existingAlarms.push(alarm);
    }
  }
  if (expAlarms.length > 0) {
    clockApp.db.deleteAlarm(expAlarms.toString(), ac.populateAlarms);
  } else {
    ac.populateAlarms();
  }
};

/**
 * Changes the hours from 12 to 24 hour format.
 * @param {string} hours The hours entered by user.
 * @param {string} ampm The ampm entered by user.
 * @return {string} hours Changed into 24 hr format.
 */
AlarmClock.prototype.covertTo24HourFormat = function(hours, ampm) {
  hours = parseInt(hours, 10);
  if (ampm == 'pm') {
    hours += (hours < 12 ? 12 : 0);
  } else {
    hours %= 12;
  }
  return hours;
};

/**
 * Enables or Disables the alarms.
 * @param {integer} alarmId Primary key of alarm to be toggled.
 * @param {boolean} flag Value (true/false) to be set in the selected alarm.
 */
AlarmClock.prototype.enableDisableAlarm = function(alarmId, flag) {
  clockApp.db.enableDisableAlarm(alarmId, flag, ac.refreshAlarms);
};

/**
 * The default Alarm clock object.
 */
var ac = new AlarmClock();
