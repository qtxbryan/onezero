import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'users_record.g.dart';

abstract class UsersRecord implements Built<UsersRecord, UsersRecordBuilder> {
  static Serializer<UsersRecord> get serializer => _$usersRecordSerializer;

  @BuiltValueField(wireName: 'Citizenship')
  String? get citizenship;

  @BuiltValueField(wireName: 'Martial')
  String? get martial;

  String? get address;

  String? get age;

  String? get applicationStatus;

  String? get applicationType;

  String? get averageMonthlyHousehold;

  String? get displayName;

  String? get email;

  String? get emailAddress;

  String? get firstTime;

  String? get phoneNumber;

  @BuiltValueField(wireName: 'photo_url')
  String? get photoUrl;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(UsersRecordBuilder builder) => builder
    ..citizenship = ''
    ..martial = ''
    ..address = ''
    ..age = ''
    ..applicationStatus = ''
    ..applicationType = ''
    ..averageMonthlyHousehold = ''
    ..displayName = ''
    ..email = ''
    ..emailAddress = ''
    ..firstTime = ''
    ..phoneNumber = ''
    ..photoUrl = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<UsersRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  UsersRecord._();
  factory UsersRecord([void Function(UsersRecordBuilder) updates]) =
      _$UsersRecord;

  static UsersRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createUsersRecordData({
  String? citizenship,
  String? martial,
  String? address,
  String? age,
  String? applicationStatus,
  String? applicationType,
  String? averageMonthlyHousehold,
  String? displayName,
  String? email,
  String? emailAddress,
  String? firstTime,
  String? phoneNumber,
  String? photoUrl,
}) {
  final firestoreData = serializers.toFirestore(
    UsersRecord.serializer,
    UsersRecord(
      (u) => u
        ..citizenship = citizenship
        ..martial = martial
        ..address = address
        ..age = age
        ..applicationStatus = applicationStatus
        ..applicationType = applicationType
        ..averageMonthlyHousehold = averageMonthlyHousehold
        ..displayName = displayName
        ..email = email
        ..emailAddress = emailAddress
        ..firstTime = firstTime
        ..phoneNumber = phoneNumber
        ..photoUrl = photoUrl,
    ),
  );

  return firestoreData;
}
