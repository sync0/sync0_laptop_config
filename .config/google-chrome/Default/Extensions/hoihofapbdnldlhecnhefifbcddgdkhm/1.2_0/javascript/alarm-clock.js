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
 * @fileoverview Handles the UI specific functionalities of the Alarm clock.
 *  It communicates with background.js for all database related calls.
 */

/**
 * The default background page object.
 */
var bg = chrome.extension.getBackgroundPage();

/**
 * Validates the data in the 'hours' field on key press event.
 */
$('hours').onkeypress = validateDigits;

/**
 * Validates the data in the 'minutes' field on key press event.
 */
$('minutes').onkeypress = validateDigits;

/**
 * Increases or Decreases the value of 'hours' field on click of up and down
 * keyboard buttons
 */
$('hours').onkeydown = onKeyUpDownEvents;

/**
 * Increases or Decreases the value of 'minutes' field on click of up and down
 * keyboard buttons
 */
$('minutes').onkeydown = onKeyUpDownEvents;

/**
 * Toggles the value of 'ampm' field on click of up and down keyboard buttons
 */
$('ampm').onkeyup = onKeyUpDownEvents;

/**
 * Prevents the user from entering invalid value in the hours field.
 */
$('hours').onkeyup = checkElementVal;

/**
 * Prevents the user from entering invalid value in the minutes field.
 */
$('minutes').onkeyup = checkElementVal;

/**
 * Checks if the value in the element is a valid value for that field.
 * If the value is invalid, reverts back the value to the old value.
 * @see tempVal Picked from clock-util.js and contains the last stored value of
 * active element (hours/minutes.). If the new value entered by user is
 * invalid, the value is reverted to this value.
 */
function checkElementVal() {
  var comp;
  switch (active) {
    case 1:
      comp = 'hours';
      break;
    case 2:
      comp = 'minutes';
      break;
  }
  var val = $(comp).value;

  switch (comp) {
    case 'hours':
      if (parseInt(val, 10) > 12) {
        $(comp).value = tempVal;
        return false;
      }
      break;
    case 'minutes':
      if (parseInt(val, 10) > 59) {
        $(comp).value = tempVal;
        return false;
      }
      break;
  }
  tempVal = 0;
}

/**
 * Displays the existing alarms on the screen.
 * @param {Array} alarms - contains details of alarms set by the user.
 */
function populateAlarms(alarms) {
  if (alarms.length == 0) {
    displayNewAlarm();
  } else {
    var tpl = $('alarmTemplate').value;
    var result = '';
    for (var i = 0, j = alarms.length; i < j; ++i) {
      var alarmData = alarms[i];
      if (alarmData.alarmType != 'snooze') {
        alarmData.border = (i == (j - 1)) ? 0 : 1;
        if (alarmData.isEnabled == 'true') {
          alarmData.checkAlarm = 'checked';
        } else {
          alarmData.checkAlarm = 'unchecked';
        }
        result += tpl.supplant(alarmData);
      }
    }
    if (result) {
      $('alarmData').innerHTML = result;
      displayExistingAlarms();
    } else {
      displayNewAlarm();
    }
  }
}

/**
 * Validates the value of hours and minutes field data. Attached to elements'
 * onblur event.
 * @param {string} elementId - the element whose value is to be validated.
 */
function validateTime(elementId) {
  var val = $(elementId).value;
  if (!val) {
    $(elementId).value = '00';
  } else {
    val = parseInt(val, 10);
    if (elementId == 'hours') {
      if (val < 10) {
        $(elementId).value = '' + 0 + val;
      } else if (val > 12) {        // fixes 5187509
        $(elementId).value = '00';
      }
    } else if (elementId == 'minutes') {
      if (val < 10) {
        $(elementId).value = '' + 0 + val;
      } else if (val > 59) {        // fixes 5187509
        $(elementId).value = '00';
      }
    }
  }
  $(elementId).className = 'alarmTime';
}

/**
 * Increases or Decreases the time components using up and down arrows.
 */
function onKeyUpDownEvents() {
  var e = window.event;
  var keyunicode = e.keyCode;
  if (keyunicode == UP_ARROW) {
    changeTime('alarm', 'i');
  } else if (keyunicode == DOWN_ARROW) {
    changeTime('alarm', 'd');
  }
}

/**
 * Toggle between repeat and no repeat values.
 * @param {boolean} flag Enabled or Disabled.
 */
function onRepeat(flag) {
  var val = flag == 'e' ? '' : 'disabled';
  for (var i = 0; i < bg.daysElement.length; i++) {
    $(bg.daysElement[i]).disabled = val;
  }
}

/**
 * Toggles an element's class name for Days elements.
 * @param {string} id elementId of the element selected.
 */
function toggleDays(id) {
  var dayClass = $(id).className;
  $(id).className = (dayClass == 'daysSelect') ? 'days' : 'daysSelect';
}

/**
 * Prepares an Object of type AlarmClockData to store alarm data
 * entered by the user.
 */
function saveAlarm() {
  var hours = $('hours').value;
  var min = $('minutes').value;
  var ampm = $('ampm').value;

  var alarmData = new bg.AlarmClockData();
  alarmData.isEnabled = true;
  alarmData.alarmType = 'alarm';
  alarmData.sound = $('selectSound').dataset.sound;

  var isRepeat = $('repeatYes').checked;
  if (isRepeat) {
    alarmData.isRepeat = true;
    var elements = document.getElementsByClassName('daysSelect');
    var repeatDays = new Array();
    for (var i = 0, element; element = elements[i]; ++i) {
      repeatDays.push(element.id);
    }
    alarmData.repeatDays = (repeatDays.length > 0) ? repeatDays : null;
    hours = bg.ac.covertTo24HourFormat(hours, ampm);
    var alarmTime = hours + ':' + min;
    alarmData.alarmTime = alarmTime;
  }

  if (!alarmData.repeatDays || !isRepeat) {
    alarmData.isRepeat = false;
    var alarmDate = getAlarmDate(hours, min, ampm);
    alarmData.alarmTime = alarmDate.getTime();
    var day = alarmDate.getDay();
    alarmData.repeatDays = bg.daysElement[day];
  }
  bg.ac.saveAlarm(alarmData);
}

/**
 * Gets the alarm date based on the alarm time entered by user.
 * @param {string} hours The hours entered by user.
 * @param {string} min The minutes entered by user.
 * @param {string} ampm The am/pm value selected by user.
 * @return {Date} alarm_date Date containing the alarm time.
 */
function getAlarmDate(hours, min, ampm) {
  var alarmDate = new Date();
  min = parseInt(min, 10);
  hours = bg.ac.covertTo24HourFormat(hours, ampm);
  alarmDate.setHours(hours);
  alarmDate.setMinutes(min);
  alarmDate.setSeconds(0, 0);
  if (alarmDate.getTime() < new Date().getTime()) {
    alarmDate.setDate(alarmDate.getDate() + 1);
  }
  return alarmDate;
}

/**
 * Resets the alarm screen.
 */
function setNewAlarm() {
  bg.ac.alarmId = '';
  $('hours').value = '00';
  $('minutes').value = '00';
  $('ampm').value = 'am';
  $('repeatNo').checked = 'checked';
  onRepeat('d');
  for (var i = 0; i < bg.daysElement.length; i++) {
    $(bg.daysElement[i]).className = 'days';
  }
  $('selectSound').value = 'Sound: Digital';
  $('selectSound').dataset.sound = 'audio_digi';
  displayNewAlarm();
}

/**
 * Displays the new alarm screen.
 */
function displayNewAlarm() {
  $('alarmData').style.display = 'none';
  $('audioBar').style.display = 'none';
  $('clockContainer').style.display = '';
  $('functionBar').style.display = '';
  $('soundData').style.display = 'none';
  $('done').style.display = '';
  $('delete').style.display = '';
  $('add').style.display = 'none';
  $('delete').disabled = 'true';
  $('delete').className = 'button-gray-disabled';
  $('hours').focus();
}

/**
 * Displays the existing alarm screen.
 */
function displayExistingAlarms() {
  $('clockContainer').style.display = 'none';
  $('audioBar').style.display = 'none';
  $('alarmData').style.display = 'block';
  $('functionBar').style.display = '';
  $('done').style.display = 'none';
  $('delete').style.display = 'none';
  $('add').style.display = '';
}

/**
 * Returns the sound name based on the file.
 * @param {string} title the title of the sound file selected.
 * @return {string} name of the sound file selected.
 */
function getSound(title) {
  switch (title) {
    case 'audio_digi':
      return 'Sound: Digital';
      break;
    case 'audio_door':
      return 'Sound: Door bell';
      break;
    case 'audio_drum':
      return 'Sound: Drum roll';
      break;
    case 'audio_lond':
      return 'Sound: London bridge';
      break;
    case 'audio_robit':
      return 'Sound: Robit';
      break;
    case 'audio_train':
      return 'Sound: Train station';
      break;
    case 'audio_twin':
      return 'Sound: Twingle little star';
      break;
    default:
      break;
  }
}

/**
 * Opens an alarm in the edit mode.
 * @param {integer} id Alarm id from database.
 * @param {string} time Alarm time to display.
 * @param {string} isRepeat Checks if the alarm is repetitive or not.
 * @param {string} repeatDays The days on which to repeat the alarm.
 * @param {string} sound The sound to play for the alarm.
 */
function openAlarm(id, time, isRepeat, repeatDays, sound) {
  bg.ac.alarmId = id;
  // Time format (HH:MM am/pm) ex. 04:52 pm.
  $('hours').value = time.substring(0, 2);
  $('minutes').value = time.substring(3, 5);
  $('ampm').value = time.substring(6, 8);
  $('selectSound').dataset.sound = sound;
  $('selectSound').value = getSound(sound);
  for (var i = 0; i < bg.daysElement.length; i++) {
    $(bg.daysElement[i]).className = 'days';
  }
  if (isRepeat == 'true') {
    $('repeatYes').checked = 'checked';
    onRepeat('e');
    var repeat = repeatDays.split(',');
    for (var i = 0; i < repeat.length; i++) {
      $(repeat[i]).className = 'daysSelect';
    }
  } else {
    $('repeatNo').checked = 'checked';
    onRepeat('d');
  }
  displayNewAlarm();
  $('delete').disabled = false;
  $('delete').className = 'button-gray';
}

/**
 * Stops the alarm sound.
 */
function stopAlarm() {
  bg.ac.stopAlarm();
}

/**
 * Snooze the alarm for 5 minutes.
 */
function snoozeAlarm() {
  bg.ac.snoozeAlarm();
}

/**
 * Chrome event listeners for the messages from background page.
 */
chrome.extension.onRequest.addListener(function(request, sender, sendResponse) {
  if (!request.message) {
    return;
  }
  switch (request.message) {
    case 'gotoAlarmTab':
      gotoAlarmTab(request.alarmTime);
      sendResponse();
      break;
    case 'populateAlarms':
      populateAlarms(request.alarms);
      sendResponse();
      break;
    case 'setNewAlarm':
      setNewAlarm();
      sendResponse();
      break;
  }
});

/**
 * Selects the alarm play screen.
 * @param {string} alarmTime The time at which alarm will play.
 */
function gotoAlarmTab(alarmTime) {
  $('alarmTimeText').value = alarmTime;
  if (clockApp.selectedTab) {
    clockApp.selectedTab.className = 'unselected';
    clockApp.selectedTabContent.style.display = 'none';
  }
  $('alarm-tab').className = 'selected';
  $('div3').style.display = 'block';
  clockApp.selectedTab = $('alarm-tab');
  clockApp.selectedTabContent = $('div3');

  $('clockContainer').style.display = 'none';
  $('functionBar').style.display = 'none';
  $('alarmData').style.display = 'none';
  $('soundData').style.display = 'none';
  $('audioBar').style.display = '';
}

/**
 * Enables/Disables the alarm.
 * @param {string} elementId The selected alarm.
 */
function enableDisableAlarm(elementId) {
  event.stopPropagation();
  var id = elementId.substring(6);
  bg.ac.enableDisableAlarm(id, $(elementId).checked);
}

/**
 * Deletes an alarm.
 * @return {boolean} returns false id no alarms is available for deletion.
 */
function deleteAlarm() {
  var alarmId = bg.ac.alarmId;
  if (alarmId) {
    bg.ac.deleteAlarm(alarmId, 'refresh');
    return;
  } else {
    console.log('no alarm to delete');
    return false;
  }
}
