import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'listing_record.g.dart';

abstract class ListingRecord
    implements Built<ListingRecord, ListingRecordBuilder> {
  static Serializer<ListingRecord> get serializer => _$listingRecordSerializer;

  String? get address;

  String? get description;

  int? get dimension;

  int? get lease;

  String? get neighbourhood;

  int? get numOfBedroom;

  int? get price;

  String? get propertyName;

  String? get listingpic;

  int? get numOfBathroom;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(ListingRecordBuilder builder) => builder
    ..address = ''
    ..description = ''
    ..dimension = 0
    ..lease = 0
    ..neighbourhood = ''
    ..numOfBedroom = 0
    ..price = 0
    ..propertyName = ''
    ..listingpic = ''
    ..numOfBathroom = 0;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Listing');

  static Stream<ListingRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<ListingRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  ListingRecord._();
  factory ListingRecord([void Function(ListingRecordBuilder) updates]) =
      _$ListingRecord;

  static ListingRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createListingRecordData({
  String? address,
  String? description,
  int? dimension,
  int? lease,
  String? neighbourhood,
  int? numOfBedroom,
  int? price,
  String? propertyName,
  String? listingpic,
  int? numOfBathroom,
}) {
  final firestoreData = serializers.toFirestore(
    ListingRecord.serializer,
    ListingRecord(
      (l) => l
        ..address = address
        ..description = description
        ..dimension = dimension
        ..lease = lease
        ..neighbourhood = neighbourhood
        ..numOfBedroom = numOfBedroom
        ..price = price
        ..propertyName = propertyName
        ..listingpic = listingpic
        ..numOfBathroom = numOfBathroom,
    ),
  );

  return firestoreData;
}
