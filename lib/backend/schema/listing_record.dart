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

  String? get dimension;

  String? get id;

  String? get lease;

  @BuiltValueField(wireName: 'listed_by')
  String? get listedBy;

  String? get neighbourhood;

  String? get numOfBedroom;

  String? get price;

  String? get propertyName;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(ListingRecordBuilder builder) => builder
    ..address = ''
    ..description = ''
    ..dimension = ''
    ..id = ''
    ..lease = ''
    ..listedBy = ''
    ..neighbourhood = ''
    ..numOfBedroom = ''
    ..price = ''
    ..propertyName = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('listing');

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
  String? dimension,
  String? id,
  String? lease,
  String? listedBy,
  String? neighbourhood,
  String? numOfBedroom,
  String? price,
  String? propertyName,
}) {
  final firestoreData = serializers.toFirestore(
    ListingRecord.serializer,
    ListingRecord(
      (l) => l
        ..address = address
        ..description = description
        ..dimension = dimension
        ..id = id
        ..lease = lease
        ..listedBy = listedBy
        ..neighbourhood = neighbourhood
        ..numOfBedroom = numOfBedroom
        ..price = price
        ..propertyName = propertyName,
    ),
  );

  return firestoreData;
}
