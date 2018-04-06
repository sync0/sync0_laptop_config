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
 * @fileoverview Timer front end code.
 */

/**
 * Global timer variables.
 */
var hourValue;
var minValue;
var secValue;

/**
 * Indicates if the timer is paused.
 */
var pauseIndicator = false;

/**
 *
 */
var intervalRefrence;
/**
 * Validates the data in the 'hours' field on key press event.
 */
$('hours_timer').onkeypress = validateDigits;

/**
 * Validates the data in the 'minutes' field on key press event.
 */
$('minutes_timer').onkeypress = validateDigits;

/**
 * Validates the data in the 'seconds' field on key press event.
 */
$('seconds_timer').onkeypress = validateDigits;

/**
 * Increases or Decreases the value of 'hours' field on click of up and down
 * keyboard buttons
 */
$('hours_timer').onkeydown = onKeyUpDownEventsTimer;

/**
 * Increases or Decreases the value of 'minutes' field on click of up and down
 * keyboard buttons
 */
$('minutes_timer').onkeydown = onKeyUpDownEventsTimer;

/**
 * Increases or Decreases the value of 'seconds' field on click of up and down
 * keyboard buttons
 */
$('seconds_timer').onkeydown = onKeyUpDownEventsTimer;

/**
 * Prevents the user from entering invalid value in the hours field.
 */
$('hours_timer').onkeyup = checkElementValTimer;

/**
 * Prevents the user from entering invalid value in the minutes field.
 */
$('minutes_timer').onkeyup = checkElementValTimer;

/**
 * Prevents the user from entering invalid value in the seconds field.
 */
$('seconds_timer').onkeyup = checkElementValTimer;

/**
 * Used to increase of decrease the time components using up and down arrows
*/
function onKeyUpDownEventsTimer() {
  var e = window.event;
  var keyunicode = e.keyCode;
  if (keyunicode == UP_ARROW) {
    changeTime('timer', 'i');
  } else if (keyunicode == DOWN_ARROW) {
      changeTime('timer', 'd');
  }
}

/**
 * Validates the time entered in the hours, minutes and seconds field of
 * the timer.
 * @param {String} elementId Id of the html element.
*/
function validateTimeOfTimer(elementId) {
  var val = $(elementId).value;
  if (!val) {
    $(elementId).value = '00';
  } else {
    val = parseInt(val, 10);
    if (val < 10) {
      val = '' + 0 + val;
    } else if (val > 59) {
      (elementId != 'hours_timer') && (val = '00');
    }
    $(elementId).value = val;
  }
  $(elementId).className = 'alarmTime';
}

/**
 * Sets the timer value after reading values set by user.
 */
function setTimer() {
  hourValue = $('hours_timer').value;
  minValue = $('minutes_timer').value;
  secValue = $('seconds_timer').value;
  $('timer_set_button').style.display = 'none';
  $('alarmSound_timer').style.display = 'none';
  $('timer_start_button').style.display = '';
  enableDisableTimer(true);
  checkLengthOfDigits();
}

/**
 * Enables or disables the timer elements on click of SET button.
 * @param {Boolean} flag Determines whether to enable or disable the timer.
 */
function enableDisableTimer(flag) {
  $('hours_timer').disabled = flag;
  $('minutes_timer').disabled = flag;
  $('seconds_timer').disabled = flag;
  $('increase_timer').disabled = flag;
  $('decrease_timer').disabled = flag;
}

/**
 * Adds a 0 in the beginning of the value if it is less than 10.
 */
function checkLengthOfDigits() {
  if (('' + hourValue).length <= 1) {
    hourValue = hourValue < 10 ? '0' + hourValue : hourValue;
  }
  if (('' + minValue).length <= 1) {
    minValue = minValue < 10 ? '0' + minValue : minValue;
  }
  if (('' + secValue).length <= 1) {
    secValue = secValue < 10 ? '0' + secValue : secValue;
  }
}

function startTimer() {
  pauseIndicator = false;
  $('outerDiv_timer').style.display = 'none';
  $('timer_display').style.display = '';
  $('timer_start_button').style.display = 'none';
  $('timer_pause_button').style.display = '';
  $('timer_display_subtitle').style.display = '';
  decrementTimer();
}

/**
 * Starts the timer.
 */
function decrementTimer() {
  if (intervalRefrence || null != intervalRefrence) {
    clearInterval(intervalRefrence);
  }

  if (!pauseIndicator) {
    if (secValue == 0) {
      if (minValue == 0) {
        hourValue = --hourValue;
        if (hourValue < 0) {
          $('hours_timer').value = '00';
          endOfTimer();
          return;
        }
        checkLengthOfDigits();
        $('timer_display').innerHTML = '<span>' + hourValue +
            ' : ' + minValue + ' : ' + secValue + '</span>';
        minValue = 60;
      }
      minValue = --minValue;
      checkLengthOfDigits();
      $('timer_display').innerHTML = '<span>' + hourValue +
          ' : ' + minValue + ' : ' + secValue + '</span>';
      secValue = 60;
    }
    secValue = --secValue;
    checkLengthOfDigits();
    $('timer_display').innerHTML = '<span>' + hourValue +
        ' : ' + minValue + ' : ' + secValue + '</span>';

    intervalRefrence = setInterval(decrementTimer, ONE_SECOND);
  }
}

/**
 * Does the post processing operations on timer display after it is finished
 *  executing.
 */
function endOfTimer() {
  $('timer_display').innerHTML = '<span>' + '00' +
      ' : ' + '00' + ' : ' + '00' + '</span>';
  $('timer_display').childNodes[0].style.color = '# 9E0404';
  $('timer_start_button').style.display = '';
  $('timer_start_button').className = 'button-blue-disabled';
  $('timer_pause_button').style.display = 'none';
  var sound = $('selectSound_timer').dataset.sound;
  if (sound) {
    bg.playSound(sound);
  }
}

/**
 * Pauses the timer.
 */
function pauseTimer() {
  pauseIndicator = true;
  $('timer_pause_button').style.display = 'none';
  $('timer_start_button').style.display = '';
  $('seconds_timer').value = secValue;
  $('minutes_timer').value = minValue;
  $('hours_timer').value = hourValue;
}

/**
 * Resets the timer.
 */
function resetTimer() {
  $('seconds_timer').value = '00';
  $('minutes_timer').value = '00';
  $('hours_timer').value = '00';
  enableDisableTimer(false);
  pauseIndicator = false;
  $('timer_set_button').style.display = '';
  $('timer_display').style.display = 'none';
  $('outerDiv_timer').style.display = '';
  $('timer_pause_button').style.display = 'none';
  $('timer_start_button').style.display = 'none';
  $('timer_start_button').className = 'button-blue button-big';
  $('timer_display_subtitle').style.display = 'none';
  $('alarmSound_timer').style.display = '';
  var sound = $('selectSound_timer').dataset.sound;
  if (sound) {
    bg.stopSound(sound);
  }
}

/**
 * Checks to see if the value in the element is a valid value for that field.
 * If the value is invalid, reverts the value to the old value.
 * @see tempVal Picked from clock-util.js and contains the last stored value
 * of the active element (hours/minutes/seconds). If the new value entered
 * by user is invalid, the value is reverted back to this value.
 */
function checkElementValTimer() {
  var comp;
  switch (active) {
    case 1:
      comp = 'hours_timer';
      break;
    case 2:
      comp = 'minutes_timer';
      break;
    case 3:
      comp = 'seconds_timer';
      break;
  }
  var val = $(comp).value;

  switch (comp) {
    case 'hours_timer':
      if (parseInt($(comp).value, 10) > 99)
        $(comp).value = tempVal;
      break;
    case 'minutes_timer':
      if (parseInt($(comp).value, 10) > 59)
        $(comp).value = tempVal;
      break;
    case 'seconds_timer':
      if (parseInt($(comp).value, 10) > 59)
        $(comp).value = tempVal;
      break;
  }
  tempVal = 0;
}
