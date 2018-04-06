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
 * @fileoverview Stop clock back end functionality.
 */

/**
 * Clock global name space.
 */
var clockApp = clockApp || {};

/**
 * Stop watch name space
 */
clockApp.Stopwatch = {};

/**
 * Constructs the stop watch-like timer.
 *
 * @constructor
 */
clockApp.Stopwatch.Object = function() {
  /**
   * The time we've started, used to calculate the elapsed time.
   * @type {number}
   */
  this.startedTime = 0;

  /**
   * The current running count.
   * @type {number}
   */
  this.elapsed = 0;

  /**
   * Whether the watch is running.
   * @type {boolean}
   */
  this.active = false;
};

/**
 * Starts the timer, which fires all its events every time its time interval
 * passes.
 */
clockApp.Stopwatch.Object.prototype.start = function() {
  this.active = true;
  this.startedTime = new Date();
};


/**
 * Resets the counter and doesn't stop the stop watch.
 * @param {number} opt_elapsed The elapsed number of milliseconds to reset the
 *     stop watch to. Default is 0.
 */
clockApp.Stopwatch.Object.prototype.reset = function(opt_elapsed) {
  this.elapsed = opt_elapsed || 0;
  this.startedTime = new Date();
};

/**
 * Returns the amount of time that has passed as a number of milliseconds.
 * This method updates the current time so you can get a sort of running count.
 * @return {number} The number of milliseconds elapsed.
 */
clockApp.Stopwatch.Object.prototype.updateAndGetElapsed = function() {
  if (this.active) {
    var time = new Date();
    this.elapsed += time - this.startedTime;
    this.startedTime = time;
  }
  return this.elapsed;
};


/**
 * Checks whether this stopwatch is currently running.
 * @return {boolean} Whether the stopwatch is active.
 */
clockApp.Stopwatch.Object.prototype.isActive = function() {
  return this.active;
};

/**
 * Updates elapsed time and returns a object containing formatted time string
 *   and the time in milliseconds.
 * @return {Object} The formatted string and time in milliseconds.
 */
clockApp.Stopwatch.Object.prototype.getTimeObject = function() {
  this.updateAndGetElapsed();
  var formattedTime = {};
  formattedTime.time = this.elapsed;

  var current = this.elapsed;
  var hours = Math.floor(current / (60 * 60 * 1000));
  var minutes = '00' + Math.floor((current / (60 * 1000)) % 60);
  var seconds = '00' + Math.floor((current / 1000) % 60);
  minutes = minutes.substring(minutes.length - 2);
  seconds = seconds.substring(seconds.length - 2);
  var milliseconds = '' + current;
  milliseconds = milliseconds.substring((milliseconds.length - 3),
      milliseconds.length);

  hours > 0 ? hours = hours + ':' : hours = '00:';
  formattedTime.displayString =
      '<span>' + hours + minutes + ':' + seconds + '</span> ' + milliseconds;

  return formattedTime;
};

