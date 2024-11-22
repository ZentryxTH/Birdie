import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/structs/index.dart';
import '/auth/firebase_auth/auth_util.dart';

List<AvailabilityStruct>? initialAvailability() {
  final List<AvailabilityStruct> availability = [];

  final List<String> dayOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  for (final day in dayOfWeek) {
    availability.add(
        AvailabilityStruct(dayOfWeek: day, startTime: null, endTime: null));
  }

  return availability;
}

List<DateTime>? getAvailableSlot(
  List<DateTime> bookings,
  DateTime dateArg,
  List<AvailabilityStruct> availability,
) {
  final matchingAvailability = availability
      .where((a) =>
          a.dayOfWeek.toLowerCase() ==
          DateFormat('EEEE').format(dateArg).toLowerCase())
      .toList();

// Next, we need to create a list of DateTime objects representing the half-hourly blocks between the start and end times of each matching DayOfWeekWithTimeStruct object.
  final availableSlots = <DateTime>[];
  for (final a in matchingAvailability) {
    if (a.hasStartTime() && a.hasEndTime()) {
      final startHour = a.startTime!.hour;
      final endHour = a.endTime!.hour;
      final startMinute = a.startTime!.minute;
      final endMinute = a.endTime!.minute;

      for (var hour = startHour; hour <= endHour; hour++) {
        for (var minute = 0; minute < 60; minute += 120) {
          if (hour == startHour && minute < startMinute) {
            continue; // Skip this half-hour block before the start time.
          }

          if (hour == endHour && minute >= endMinute) {
            break; // Exit the minute loop when reaching or exceeding the end time.
          }

          availableSlots.add(
              DateTime(dateArg.year, dateArg.month, dateArg.day, hour, minute));
        }
      }
    }
  }

  // Finally, we need to filter out any DateTime objects that match the bookings list.
  final availableSlotsFiltered = availableSlots
      .where((slot) => !bookings.any((booking_state) =>
          booking_state.hour == slot.hour &&
          booking_state.minute == slot.minute &&
          booking_state.day == slot.day &&
          booking_state.month == slot.month &&
          booking_state.year == slot.year))
      .toList();

  DateTime now = DateTime.now();

  return availableSlotsFiltered.where((slot) => slot.isAfter(now)).toList();
}

DateTime? stringtoTime(
  String? hourArg,
  DateTime? dateArg,
) {
  // output the combination of date from dateArg and hourArg (Hm: format)
  if (hourArg == null || dateArg == null) {
    return null;
  }

  final hourMin = hourArg.split(':');
  final hour = int.tryParse(hourMin[0]) ?? 0;
  final minute = int.tryParse(hourMin[1]) ?? 0;
  return DateTime(dateArg.year, dateArg.month, dateArg.day, hour, minute);
}
