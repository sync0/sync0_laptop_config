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
 * @fileoverview Contains the logic to display the analog, digital clock and
 * calendar.
 */

/**
 * Clock namespace.
 */
var clockApp = clockApp || {};

/**
 * @const Defines the angle to be used in drawing clock markers.
 */
var markerAngle = Math.PI / 600;

/**
 * Object containing static information.
 */
clockApp.calendarMappings = {
  'monthArrayShort': ['Jan',
                      'Feb',
                      'Mar',
                      'Apr',
                      'May',
                      'Jun',
                      'Jul',
                      'Aug',
                      'Sep',
                      'Oct',
                      'Nov',
                      'Dec'],
 'dayArray': ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
};

/**
 * A wrapper class to hold canvas object and it's properties.
 *
 * @param {Object} canvasObj DOM object of Canvas.
 * @constructor
 */
clockApp.Canvas = function(canvasObj) {
  this.canvas = canvasObj;
};

/**
 * Customizable properties of an analog clock.
 * @constructor Constructs AnalogClockProperties with default values.
 */
clockApp.AnalogClockProperties = function() {
  this.clockXCoordinate = 30;
  this.clockYCoordinate = 35;
  this.clockRadius = 20;
  this.clockBgroundStartGradient = '#fff';
  this.clockBgroundEndGradient = '#F1F4F7';
  this.clockTimeOffSet = 0;

  this.minHandColor = 'black';
  this.minuteHandLineWidth = 2;
  this.minuteHandLineCap = 'round';
  this.minHandLengthToClockRadiusRatio = 0.6;

  this.secHandLineWidth = 1;
  this.secHandLineCap = 'round';
  this.secHandLengthToClockRadiusRatio = 0.65;
  this.secHandColor = 'red';

  this.hourHandLineWidth = 3;
  this.hourHandLineCap = 'round';
  this.hourHandLengthToClockRadiusRatio = 0.4;
  this.hourHandColor = 'black';

  this.innerCircleImgX = '26';
  this.innerCircleImgY = '31';
};

/**
 * Wrapper over canvas DOM object.
 * @constructor Constructs a clock Object.
 * @param {AnalogClockProperties} clockProperties Customized analog clock
 *     properties.
 */
clockApp.Clock = function(clockProperties) {
  this.clockProperties = (!clockProperties) ?
      new clockApp.AnalogClockProperties() : clockProperties;
  // Class level date object.
  this.dateObject;
};

/**
 * Paint's the clock on canvas.
 * @param {Object} canvasObj Canvas Object where clock is to be painted.
 */
clockApp.Clock.prototype.paint = function(canvasObj) {
  // This clears the canvas.
  canvasObj.canvas.width = canvasObj.canvas.width;
  // Requires a 2d context.
  var context = canvasObj.canvas.getContext(TWOD_CONTEXT);
  this.dateObject = new Date();
  if (this.clockProperties.clockTimeOffSet) {
    this.dateObject = new Date(this.dateObject.getTime() +
        this.clockProperties.clockTimeOffSet * 60 * 1000);
  }
  if (this.clockProperties.backgroundImage) {
    context.drawImage(this.clockProperties.backgroundImage,
        this.clockProperties.bgImageX,
        this.clockProperties.bgImageY);
  }

  this.drawHourHand(context);
  this.drawSecondsHand(context);
  this.drawMinuteHand(context);
  this.drawInnerCircle(context);

};

/**
 * Draw's the outer circle of clock on canvas.
 * @param {Object} ctx The canvas context object.
 */
clockApp.Clock.prototype.drawOuterCircle = function(ctx) {

  ctx.lineWidth = 0.1;
  ctx.beginPath();

  ctx.arc(this.clockProperties.clockXCoordinate,
      this.clockProperties.clockYCoordinate,
      this.clockProperties.clockRadius, 0, Math.PI * 2, true);

  var gradient = ctx.createRadialGradient(this.clockProperties.clockXCoordinate,
      this.clockProperties.clockYCoordinate, 0,
      this.clockProperties.clockXCoordinate,
      this.clockProperties.clockYCoordinate,
      this.clockProperties.clockRadius);
  this.drawShadow(ctx);
  gradient.addColorStop(true, this.clockProperties.clockBgroundStartGradient);
  gradient.addColorStop(false, this.clockProperties.clockBgroundEndGradient);
  ctx.fillStyle = gradient;
  ctx.fill();
  ctx.stroke();

  this.clearShadow(ctx);
};

/**
 * Draw's the inner circle of clock onto the canvas.
 * @param {Object} ctx The canvas context object.
 */
clockApp.Clock.prototype.drawInnerCircle = function(ctx) {
  var clockInnerCircleRadius = this.clockProperties.clockRadius / 10;
  ctx.drawImage(this.clockProperties.innerCircleImg,
      this.clockProperties.innerCircleImgX,
      this.clockProperties.innerCircleImgY);

  //Fix for http://b/viewIssue?id=3203989
  //ctx.stroke();
};

/**
 * Draw's the clock's shadow.
 * @param {Object} ctx The canvas context object.
 */
clockApp.Clock.prototype.drawShadow = function(ctx) {
  ctx.shadowOffsetX = -1;
  ctx.shadowOffsetY = -1;
  ctx.shadowBlur = 4;
  ctx.shadowColor = 'rgb(0, 10, 1)';

};

/**
 * Clears the clocks shadow.
 * @param {Object} ctx The canvas context object.
 */
clockApp.Clock.prototype.clearShadow = function(ctx) {
  ctx.shadowOffsetX = 0;
  ctx.shadowOffsetY = 0;
  ctx.shadowBlur = 0;
  ctx.shadowColor = '';
};

/**
 * Draw's the minute hand of clock on canvas.
 * @param {Object} ctx The canvas context object.
 */
clockApp.Clock.prototype.drawMinuteHand = function(ctx) {
  var date = this.dateObject;
  var min = date.getMinutes();

  var minHandLength = this.clockProperties.minHandLengthToClockRadiusRatio *
      this.clockProperties.clockRadius;
  ctx.lineWidth = this.clockProperties.minuteHandLineWidth;
  ctx.lineCap = this.clockProperties.minuteHandLineCap;

  ctx.save();
  ctx.translate(this.clockProperties.clockXCoordinate,
      this.clockProperties.clockYCoordinate);
  ctx.rotate(Math.PI * (2 * (min / 60) - 0.5));
  this.drawShadow(ctx);
  ctx.beginPath();
  ctx.moveTo(minHandLength / 4, 0);
  ctx.lineTo(minHandLength, 0);

  ctx.strokeStyle = this.clockProperties.minHandColor;
  ctx.stroke();
  ctx.restore();
  this.clearShadow(ctx);
};

/**
 * Draw's the second hand of clock on canvas.
 * @param {Object} ctx The canvas context object.
 */
clockApp.Clock.prototype.drawSecondsHand = function(ctx) {
  var sec = this.dateObject.getSeconds();
  var secHandLength = this.clockProperties.secHandLengthToClockRadiusRatio *
      this.clockProperties.clockRadius;
  ctx.lineWidth = this.clockProperties.secHandLineWidth;
  ctx.lineCap = this.clockProperties.secHandLineCap;

  ctx.save();
  ctx.translate(this.clockProperties.clockXCoordinate,
      this.clockProperties.clockYCoordinate);
  ctx.rotate(Math.PI * (2 * (sec / 60) - 0.5));
  this.drawShadow(ctx);
  ctx.beginPath();
  ctx.moveTo(0, 0);
  ctx.lineTo(secHandLength, 0);

  ctx.strokeStyle = this.clockProperties.secHandColor;
  ctx.stroke();
  ctx.restore();
  this.clearShadow(ctx);
};

/**
 * Draw's the hour hand of clock on canvas.
 * @param {Object} ctx The canvas context object.
 */
clockApp.Clock.prototype.drawHourHand = function(ctx) {
  var date = this.dateObject;
  var hour = date.getHours();
  var min = date.getMinutes();
  var hourHandLength = this.clockProperties.hourHandLengthToClockRadiusRatio *
                       this.clockProperties.clockRadius;
  if (hour >= 12) {
    hour = hour - 12;
  }

  ctx.lineWidth = this.clockProperties.hourHandLineWidth;
  ctx.lineCap = this.clockProperties.hourHandLineCap;

  ctx.save();
  ctx.translate(this.clockProperties.clockXCoordinate,
          this.clockProperties.clockYCoordinate);
  ctx.rotate(Math.PI * (2 * (hour / 12) - 0.5));

  ctx.beginPath();
  ctx.moveTo(0, 0);
  ctx.lineTo(hourHandLength, 0);

  ctx.strokeStyle = this.clockProperties.hourHandColor;
  ctx.stroke();
  ctx.restore();

};

/**
 * Class representing customizable properties of Digital clock.
 * @constructor
 */
clockApp.DigitalClockProperties = function() {
  this.timeDisplayTemplate = 'page1-time-tpl';
  this.dayMonthNameTemplate = 'page1-char-time-tpl';
  this.clockTimeOffSet = 0;
};

/**
 * Class containing logic to display digital clock.
 * @param {DigitalClockProperties} timeDisplayProperties Customized time
 *     properties.
 * @constructor
 */
clockApp.Time = function(timeDisplayProperties) {
  this.timeDisplayProperties = !timeDisplayProperties ?
      new clockApp.DigitalClockProperties() : timeDisplayProperties;
};

/**
 * Paints the digital clock on the basis of DigitalClockProperties.
 * @param {String} timeDisplayDiv Div where digital clock is to be displayed.
 * @param {String} dateDisplayDiv Div where date and month are to be displayed.
 */
clockApp.Time.prototype.paint = function(timeDisplayDiv, dateDisplayDiv) {
  var date = new Date();

  if (this.timeDisplayProperties.clockTimeOffSet) {
    date = new Date(date.getTime() +
        this.timeDisplayProperties.clockTimeOffSet * 60 * 1000);
  }

  var timeMeridian = date.getHours() >= 12 ? 'pm' : 'am';
  var hours = date.getHours();
  hours = (hours > 12) ? hours % 12 : hours;
  var mins = date.getMinutes();

  hours = clockApp.Time.checkLengthOfDigits(hours);
  mins = clockApp.Time.checkLengthOfDigits(mins);

  $(timeDisplayDiv).innerHTML =
      $(this.timeDisplayProperties.timeDisplayTemplate).value.supplant(
          {hours: hours, min: mins,
           partOfDay: timeMeridian});

  var day = clockApp.calendarMappings.dayArray[date.getDay() - 1];
  var month = clockApp.calendarMappings.monthArrayShort[date.getMonth()];
  var dateNumber = date.getDate();
  dateNumber = clockApp.Time.checkLengthOfDigits(dateNumber);

  $(dateDisplayDiv).innerHTML =
      $(this.timeDisplayProperties.dayMonthNameTemplate).value.supplant(
          {day: day, month: month, dateNumber: dateNumber});
};

/**
 * Checks the value, if it's less than 10 and appends 0 to value.
 * @param {Number} value The number to be checked.
 * @return {Number} value The updated value.
 */
clockApp.Time.checkLengthOfDigits = function(value) {
  return value < 10 ? '0' + value : value;
};

/**
 * Class representing customizable Calendar properties.
 * @constructor
 */
clockApp.CalendarProperties = function() {
  this.showWeekNum = false;
  this.allowNone = false;
  this.showToday = false;
  this.useNarrowWeekdayNames = true;
  this.useSimpleNavigationMenu = true;
  this.customizeViewCallback = null;
};

/**
 * Creates a calendar using closure API's.
 * @param {CalendarProperties} calendarProperties Customized calendar
 *      properties.
 * @constructor
 */
clockApp.Calendar = function(calendarProperties) {
  this.calendarProperties = !calendarProperties ?
      clockApp.CalendarProperties : calendarProperties;
};

/**
 * Paints the Calendar on the basis of CalendarProperties.
 * @param {String} displayDIV DIV where calendar is to be displayed.
 */
clockApp.Calendar.prototype.paint = function(displayDIV) {
  $(displayDIV).innerHTML = '';
  var datePicker = new goog.ui.DatePicker();
  datePicker.render($(displayDIV));
  datePicker.setShowWeekNum(this.calendarProperties.showWeekNum);
  datePicker.setAllowNone(this.calendarProperties.allowNone);
  datePicker.setShowToday(this.calendarProperties.showToday);
  datePicker.setUseNarrowWeekdayNames(
      this.calendarProperties.useNarrowWeekdayNames);
  datePicker.setUseSimpleNavigationMenu(
      this.calendarProperties.useSimpleNavigationMenu);
  if (this.calendarProperties.customizeViewCallback) {
    this.calendarProperties.customizeViewCallback();
  }
};
