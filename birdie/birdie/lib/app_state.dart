import 'package:flutter/material.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  List<AvailabilityStruct> _availability = [];
  List<AvailabilityStruct> get availability => _availability;
  set availability(List<AvailabilityStruct> value) {
    _availability = value;
  }

  void addToAvailability(AvailabilityStruct value) {
    availability.add(value);
  }

  void removeFromAvailability(AvailabilityStruct value) {
    availability.remove(value);
  }

  void removeAtIndexFromAvailability(int index) {
    availability.removeAt(index);
  }

  void updateAvailabilityAtIndex(
    int index,
    AvailabilityStruct Function(AvailabilityStruct) updateFn,
  ) {
    availability[index] = updateFn(_availability[index]);
  }

  void insertAtIndexInAvailability(int index, AvailabilityStruct value) {
    availability.insert(index, value);
  }
}
