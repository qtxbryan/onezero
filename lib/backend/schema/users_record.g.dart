// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<UsersRecord> _$usersRecordSerializer = new _$UsersRecordSerializer();

class _$UsersRecordSerializer implements StructuredSerializer<UsersRecord> {
  @override
  final Iterable<Type> types = const [UsersRecord, _$UsersRecord];
  @override
  final String wireName = 'UsersRecord';

  @override
  Iterable<Object?> serialize(Serializers serializers, UsersRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.citizenship;
    if (value != null) {
      result
        ..add('Citizenship')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.martial;
    if (value != null) {
      result
        ..add('Martial')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.address;
    if (value != null) {
      result
        ..add('address')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.age;
    if (value != null) {
      result
        ..add('age')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.applicationStatus;
    if (value != null) {
      result
        ..add('applicationStatus')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.applicationType;
    if (value != null) {
      result
        ..add('applicationType')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.averageMonthlyHousehold;
    if (value != null) {
      result
        ..add('averageMonthlyHousehold')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.displayName;
    if (value != null) {
      result
        ..add('displayName')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.email;
    if (value != null) {
      result
        ..add('email')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.emailAddress;
    if (value != null) {
      result
        ..add('emailAddress')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.firstTime;
    if (value != null) {
      result
        ..add('firstTime')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.phoneNumber;
    if (value != null) {
      result
        ..add('phoneNumber')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.photoUrl;
    if (value != null) {
      result
        ..add('photo_url')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.ffRef;
    if (value != null) {
      result
        ..add('Document__Reference__Field')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType.nullable(Object)])));
    }
    return result;
  }

  @override
  UsersRecord deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UsersRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'Citizenship':
          result.citizenship = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'Martial':
          result.martial = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'address':
          result.address = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'age':
          result.age = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'applicationStatus':
          result.applicationStatus = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'applicationType':
          result.applicationType = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'averageMonthlyHousehold':
          result.averageMonthlyHousehold = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'displayName':
          result.displayName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'emailAddress':
          result.emailAddress = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'firstTime':
          result.firstTime = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'phoneNumber':
          result.phoneNumber = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'photo_url':
          result.photoUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'Document__Reference__Field':
          result.ffRef = serializers.deserialize(value,
              specifiedType: const FullType(DocumentReference, const [
                const FullType.nullable(Object)
              ])) as DocumentReference<Object?>?;
          break;
      }
    }

    return result.build();
  }
}

class _$UsersRecord extends UsersRecord {
  @override
  final String? citizenship;
  @override
  final String? martial;
  @override
  final String? address;
  @override
  final String? age;
  @override
  final String? applicationStatus;
  @override
  final String? applicationType;
  @override
  final String? averageMonthlyHousehold;
  @override
  final String? displayName;
  @override
  final String? email;
  @override
  final String? emailAddress;
  @override
  final String? firstTime;
  @override
  final String? phoneNumber;
  @override
  final String? photoUrl;
  @override
  final DocumentReference<Object?>? ffRef;

  factory _$UsersRecord([void Function(UsersRecordBuilder)? updates]) =>
      (new UsersRecordBuilder()..update(updates))._build();

  _$UsersRecord._(
      {this.citizenship,
      this.martial,
      this.address,
      this.age,
      this.applicationStatus,
      this.applicationType,
      this.averageMonthlyHousehold,
      this.displayName,
      this.email,
      this.emailAddress,
      this.firstTime,
      this.phoneNumber,
      this.photoUrl,
      this.ffRef})
      : super._();

  @override
  UsersRecord rebuild(void Function(UsersRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UsersRecordBuilder toBuilder() => new UsersRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UsersRecord &&
        citizenship == other.citizenship &&
        martial == other.martial &&
        address == other.address &&
        age == other.age &&
        applicationStatus == other.applicationStatus &&
        applicationType == other.applicationType &&
        averageMonthlyHousehold == other.averageMonthlyHousehold &&
        displayName == other.displayName &&
        email == other.email &&
        emailAddress == other.emailAddress &&
        firstTime == other.firstTime &&
        phoneNumber == other.phoneNumber &&
        photoUrl == other.photoUrl &&
        ffRef == other.ffRef;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, citizenship.hashCode);
    _$hash = $jc(_$hash, martial.hashCode);
    _$hash = $jc(_$hash, address.hashCode);
    _$hash = $jc(_$hash, age.hashCode);
    _$hash = $jc(_$hash, applicationStatus.hashCode);
    _$hash = $jc(_$hash, applicationType.hashCode);
    _$hash = $jc(_$hash, averageMonthlyHousehold.hashCode);
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, emailAddress.hashCode);
    _$hash = $jc(_$hash, firstTime.hashCode);
    _$hash = $jc(_$hash, phoneNumber.hashCode);
    _$hash = $jc(_$hash, photoUrl.hashCode);
    _$hash = $jc(_$hash, ffRef.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UsersRecord')
          ..add('citizenship', citizenship)
          ..add('martial', martial)
          ..add('address', address)
          ..add('age', age)
          ..add('applicationStatus', applicationStatus)
          ..add('applicationType', applicationType)
          ..add('averageMonthlyHousehold', averageMonthlyHousehold)
          ..add('displayName', displayName)
          ..add('email', email)
          ..add('emailAddress', emailAddress)
          ..add('firstTime', firstTime)
          ..add('phoneNumber', phoneNumber)
          ..add('photoUrl', photoUrl)
          ..add('ffRef', ffRef))
        .toString();
  }
}

class UsersRecordBuilder implements Builder<UsersRecord, UsersRecordBuilder> {
  _$UsersRecord? _$v;

  String? _citizenship;
  String? get citizenship => _$this._citizenship;
  set citizenship(String? citizenship) => _$this._citizenship = citizenship;

  String? _martial;
  String? get martial => _$this._martial;
  set martial(String? martial) => _$this._martial = martial;

  String? _address;
  String? get address => _$this._address;
  set address(String? address) => _$this._address = address;

  String? _age;
  String? get age => _$this._age;
  set age(String? age) => _$this._age = age;

  String? _applicationStatus;
  String? get applicationStatus => _$this._applicationStatus;
  set applicationStatus(String? applicationStatus) =>
      _$this._applicationStatus = applicationStatus;

  String? _applicationType;
  String? get applicationType => _$this._applicationType;
  set applicationType(String? applicationType) =>
      _$this._applicationType = applicationType;

  String? _averageMonthlyHousehold;
  String? get averageMonthlyHousehold => _$this._averageMonthlyHousehold;
  set averageMonthlyHousehold(String? averageMonthlyHousehold) =>
      _$this._averageMonthlyHousehold = averageMonthlyHousehold;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _emailAddress;
  String? get emailAddress => _$this._emailAddress;
  set emailAddress(String? emailAddress) => _$this._emailAddress = emailAddress;

  String? _firstTime;
  String? get firstTime => _$this._firstTime;
  set firstTime(String? firstTime) => _$this._firstTime = firstTime;

  String? _phoneNumber;
  String? get phoneNumber => _$this._phoneNumber;
  set phoneNumber(String? phoneNumber) => _$this._phoneNumber = phoneNumber;

  String? _photoUrl;
  String? get photoUrl => _$this._photoUrl;
  set photoUrl(String? photoUrl) => _$this._photoUrl = photoUrl;

  DocumentReference<Object?>? _ffRef;
  DocumentReference<Object?>? get ffRef => _$this._ffRef;
  set ffRef(DocumentReference<Object?>? ffRef) => _$this._ffRef = ffRef;

  UsersRecordBuilder() {
    UsersRecord._initializeBuilder(this);
  }

  UsersRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _citizenship = $v.citizenship;
      _martial = $v.martial;
      _address = $v.address;
      _age = $v.age;
      _applicationStatus = $v.applicationStatus;
      _applicationType = $v.applicationType;
      _averageMonthlyHousehold = $v.averageMonthlyHousehold;
      _displayName = $v.displayName;
      _email = $v.email;
      _emailAddress = $v.emailAddress;
      _firstTime = $v.firstTime;
      _phoneNumber = $v.phoneNumber;
      _photoUrl = $v.photoUrl;
      _ffRef = $v.ffRef;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UsersRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UsersRecord;
  }

  @override
  void update(void Function(UsersRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UsersRecord build() => _build();

  _$UsersRecord _build() {
    final _$result = _$v ??
        new _$UsersRecord._(
            citizenship: citizenship,
            martial: martial,
            address: address,
            age: age,
            applicationStatus: applicationStatus,
            applicationType: applicationType,
            averageMonthlyHousehold: averageMonthlyHousehold,
            displayName: displayName,
            email: email,
            emailAddress: emailAddress,
            firstTime: firstTime,
            phoneNumber: phoneNumber,
            photoUrl: photoUrl,
            ffRef: ffRef);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
