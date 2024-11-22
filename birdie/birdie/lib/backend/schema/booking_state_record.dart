import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class BookingStateRecord extends FirestoreRecord {
  BookingStateRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "attendeeRef" field.
  DocumentReference? _attendeeRef;
  DocumentReference? get attendeeRef => _attendeeRef;
  bool hasAttendeeRef() => _attendeeRef != null;

  // "bookRef" field.
  DocumentReference? _bookRef;
  DocumentReference? get bookRef => _bookRef;
  bool hasBookRef() => _bookRef != null;

  // "ownerRef" field.
  DocumentReference? _ownerRef;
  DocumentReference? get ownerRef => _ownerRef;
  bool hasOwnerRef() => _ownerRef != null;

  // "bookedTime" field.
  DateTime? _bookedTime;
  DateTime? get bookedTime => _bookedTime;
  bool hasBookedTime() => _bookedTime != null;

  void _initializeFields() {
    _attendeeRef = snapshotData['attendeeRef'] as DocumentReference?;
    _bookRef = snapshotData['bookRef'] as DocumentReference?;
    _ownerRef = snapshotData['ownerRef'] as DocumentReference?;
    _bookedTime = snapshotData['bookedTime'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('booking_state');

  static Stream<BookingStateRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => BookingStateRecord.fromSnapshot(s));

  static Future<BookingStateRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => BookingStateRecord.fromSnapshot(s));

  static BookingStateRecord fromSnapshot(DocumentSnapshot snapshot) =>
      BookingStateRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static BookingStateRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      BookingStateRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'BookingStateRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is BookingStateRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createBookingStateRecordData({
  DocumentReference? attendeeRef,
  DocumentReference? bookRef,
  DocumentReference? ownerRef,
  DateTime? bookedTime,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'attendeeRef': attendeeRef,
      'bookRef': bookRef,
      'ownerRef': ownerRef,
      'bookedTime': bookedTime,
    }.withoutNulls,
  );

  return firestoreData;
}

class BookingStateRecordDocumentEquality
    implements Equality<BookingStateRecord> {
  const BookingStateRecordDocumentEquality();

  @override
  bool equals(BookingStateRecord? e1, BookingStateRecord? e2) {
    return e1?.attendeeRef == e2?.attendeeRef &&
        e1?.bookRef == e2?.bookRef &&
        e1?.ownerRef == e2?.ownerRef &&
        e1?.bookedTime == e2?.bookedTime;
  }

  @override
  int hash(BookingStateRecord? e) => const ListEquality()
      .hash([e?.attendeeRef, e?.bookRef, e?.ownerRef, e?.bookedTime]);

  @override
  bool isValidKey(Object? o) => o is BookingStateRecord;
}
