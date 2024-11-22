import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class BookingRecord extends FirestoreRecord {
  BookingRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "bookName" field.
  String? _bookName;
  String get bookName => _bookName ?? '';
  bool hasBookName() => _bookName != null;

  // "bookDesc" field.
  String? _bookDesc;
  String get bookDesc => _bookDesc ?? '';
  bool hasBookDesc() => _bookDesc != null;

  // "availability" field.
  List<AvailabilityStruct>? _availability;
  List<AvailabilityStruct> get availability => _availability ?? const [];
  bool hasAvailability() => _availability != null;

  // "ownerRef" field.
  DocumentReference? _ownerRef;
  DocumentReference? get ownerRef => _ownerRef;
  bool hasOwnerRef() => _ownerRef != null;

  // "price" field.
  double? _price;
  double get price => _price ?? 0.0;
  bool hasPrice() => _price != null;

  void _initializeFields() {
    _bookName = snapshotData['bookName'] as String?;
    _bookDesc = snapshotData['bookDesc'] as String?;
    _availability = getStructList(
      snapshotData['availability'],
      AvailabilityStruct.fromMap,
    );
    _ownerRef = snapshotData['ownerRef'] as DocumentReference?;
    _price = castToType<double>(snapshotData['price']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('booking');

  static Stream<BookingRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => BookingRecord.fromSnapshot(s));

  static Future<BookingRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => BookingRecord.fromSnapshot(s));

  static BookingRecord fromSnapshot(DocumentSnapshot snapshot) =>
      BookingRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static BookingRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      BookingRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'BookingRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is BookingRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createBookingRecordData({
  String? bookName,
  String? bookDesc,
  DocumentReference? ownerRef,
  double? price,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'bookName': bookName,
      'bookDesc': bookDesc,
      'ownerRef': ownerRef,
      'price': price,
    }.withoutNulls,
  );

  return firestoreData;
}

class BookingRecordDocumentEquality implements Equality<BookingRecord> {
  const BookingRecordDocumentEquality();

  @override
  bool equals(BookingRecord? e1, BookingRecord? e2) {
    const listEquality = ListEquality();
    return e1?.bookName == e2?.bookName &&
        e1?.bookDesc == e2?.bookDesc &&
        listEquality.equals(e1?.availability, e2?.availability) &&
        e1?.ownerRef == e2?.ownerRef &&
        e1?.price == e2?.price;
  }

  @override
  int hash(BookingRecord? e) => const ListEquality()
      .hash([e?.bookName, e?.bookDesc, e?.availability, e?.ownerRef, e?.price]);

  @override
  bool isValidKey(Object? o) => o is BookingRecord;
}
