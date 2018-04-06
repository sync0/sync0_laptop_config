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
 * @fileoverview Utility containing code for sorting and searching arrays.
 */

/**
 * The default name space for the clock application.
 *
 */
var clockApp = clockApp || {};

/**
 * Name space to holding the methods for sorting and searching operations.
 */
clockApp.ds = {};

/**
 * Performs quick sort on the array passed as parameter.
 * @param {Array} array To be sorted.
 */
clockApp.ds.quick_sort = function(array) {
  clockApp.ds.qsort(array, 0, array.length);
}

/**
 *
 * @param {Array} array Array to be sorted.
 * @param {Number} begin Starting index that will be used to calculate pivot.
 * @param {Number} end End index that will be used to calculate pivot.
 */
clockApp.ds.qsort = function(array, begin, end) {
  if (end - 1 > begin) {
    var pivot = begin + Math.floor(Math.random() * (end - begin));

    pivot = clockApp.ds.partition(array, begin, end, pivot);

    clockApp.ds.qsort(array, begin, pivot);
    clockApp.ds.qsort(array, pivot + 1, end);
  }
}

/**
 * Partitions the array according to pivot
 * @param {Array} array Array to be partitioned.
 * @param {Number} begin Start index.
 * @param {Number} end End index.
 * @param {Number} pivot The point at which to initiate partition.
 * @return {Number} store The new index for pivot.
 */
clockApp.ds.partition = function(array, begin, end, pivot) {
  var piv = array[pivot];
  array.swap(pivot, end - 1);
  var store = begin;
  var ix;
  for (ix = begin; ix < end - 1; ++ix) {
    if (array[ix] <= piv) {
      array.swap(store, ix);
      ++store;
    }
  }
  array.swap(end - 1, store);
  return store;
}

/**
 * Performs a binary search on city list.
 * @param {Array} theList The list of user's cities.
 * @param {String} key The city to be searched in list.
 * @return {Number} The index at which the match is found else -1.
 */
clockApp.ds.binarySearch = function(theList, key) {
  var left = 0;
  var right = theList.length - 1;
  while (left <= right) {
    var mid = parseInt((left + right) / 2);
    if (theList[mid] == key) {
      return mid;
    } else if (theList[mid] < key) {
      left = mid + 1;
    } else {
      right = mid - 1;
    }
  }
  // When element is not found.
  return -1;
}

/**
 * Implementation of swap function in Array.
 * @param {Number} a Number to be compared and swapped.
 * @param {Number} b Number to be compared and swapped.
 */
Array.prototype.swap = function(a, b) {
  var tmp = this[a];
  this[a] = this[b];
  this[b] = tmp;
};
