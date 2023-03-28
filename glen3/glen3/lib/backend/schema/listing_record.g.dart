// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listing_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ListingRecord> _$listingRecordSerializer =
    new _$ListingRecordSerializer();

class _$ListingRecordSerializer implements StructuredSerializer<ListingRecord> {
  @override
  final Iterable<Type> types = const [ListingRecord, _$ListingRecord];
  @override
  final String wireName = 'ListingRecord';

  @override
  Iterable<Object?> serialize(Serializers serializers, ListingRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.address;
    if (value != null) {
      result
        ..add('address')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.description;
    if (value != null) {
      result
        ..add('description')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.dimension;
    if (value != null) {
      result
        ..add('dimension')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.lease;
    if (value != null) {
      result
        ..add('lease')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.neighbourhood;
    if (value != null) {
      result
        ..add('neighbourhood')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.numOfBedroom;
    if (value != null) {
      result
        ..add('numOfBedroom')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.price;
    if (value != null) {
      result
        ..add('price')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.propertyName;
    if (value != null) {
      result
        ..add('propertyName')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.listingpic;
    if (value != null) {
      result
        ..add('listingpic')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.numOfBathroom;
    if (value != null) {
      result
        ..add('numOfBathroom')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
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
  ListingRecord deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ListingRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'address':
          result.address = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'dimension':
          result.dimension = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'lease':
          result.lease = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'neighbourhood':
          result.neighbourhood = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'numOfBedroom':
          result.numOfBedroom = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'price':
          result.price = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'propertyName':
          result.propertyName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'listingpic':
          result.listingpic = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'numOfBathroom':
          result.numOfBathroom = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
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

class _$ListingRecord extends ListingRecord {
  @override
  final String? address;
  @override
  final String? description;
  @override
  final int? dimension;
  @override
  final int? lease;
  @override
  final String? neighbourhood;
  @override
  final int? numOfBedroom;
  @override
  final int? price;
  @override
  final String? propertyName;
  @override
  final String? listingpic;
  @override
  final int? numOfBathroom;
  @override
  final DocumentReference<Object?>? ffRef;

  factory _$ListingRecord([void Function(ListingRecordBuilder)? updates]) =>
      (new ListingRecordBuilder()..update(updates))._build();

  _$ListingRecord._(
      {this.address,
      this.description,
      this.dimension,
      this.lease,
      this.neighbourhood,
      this.numOfBedroom,
      this.price,
      this.propertyName,
      this.listingpic,
      this.numOfBathroom,
      this.ffRef})
      : super._();

  @override
  ListingRecord rebuild(void Function(ListingRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ListingRecordBuilder toBuilder() => new ListingRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ListingRecord &&
        address == other.address &&
        description == other.description &&
        dimension == other.dimension &&
        lease == other.lease &&
        neighbourhood == other.neighbourhood &&
        numOfBedroom == other.numOfBedroom &&
        price == other.price &&
        propertyName == other.propertyName &&
        listingpic == other.listingpic &&
        numOfBathroom == other.numOfBathroom &&
        ffRef == other.ffRef;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc($jc(0, address.hashCode),
                                            description.hashCode),
                                        dimension.hashCode),
                                    lease.hashCode),
                                neighbourhood.hashCode),
                            numOfBedroom.hashCode),
                        price.hashCode),
                    propertyName.hashCode),
                listingpic.hashCode),
            numOfBathroom.hashCode),
        ffRef.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ListingRecord')
          ..add('address', address)
          ..add('description', description)
          ..add('dimension', dimension)
          ..add('lease', lease)
          ..add('neighbourhood', neighbourhood)
          ..add('numOfBedroom', numOfBedroom)
          ..add('price', price)
          ..add('propertyName', propertyName)
          ..add('listingpic', listingpic)
          ..add('numOfBathroom', numOfBathroom)
          ..add('ffRef', ffRef))
        .toString();
  }
}

class ListingRecordBuilder
    implements Builder<ListingRecord, ListingRecordBuilder> {
  _$ListingRecord? _$v;

  String? _address;
  String? get address => _$this._address;
  set address(String? address) => _$this._address = address;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  int? _dimension;
  int? get dimension => _$this._dimension;
  set dimension(int? dimension) => _$this._dimension = dimension;

  int? _lease;
  int? get lease => _$this._lease;
  set lease(int? lease) => _$this._lease = lease;

  String? _neighbourhood;
  String? get neighbourhood => _$this._neighbourhood;
  set neighbourhood(String? neighbourhood) =>
      _$this._neighbourhood = neighbourhood;

  int? _numOfBedroom;
  int? get numOfBedroom => _$this._numOfBedroom;
  set numOfBedroom(int? numOfBedroom) => _$this._numOfBedroom = numOfBedroom;

  int? _price;
  int? get price => _$this._price;
  set price(int? price) => _$this._price = price;

  String? _propertyName;
  String? get propertyName => _$this._propertyName;
  set propertyName(String? propertyName) => _$this._propertyName = propertyName;

  String? _listingpic;
  String? get listingpic => _$this._listingpic;
  set listingpic(String? listingpic) => _$this._listingpic = listingpic;

  int? _numOfBathroom;
  int? get numOfBathroom => _$this._numOfBathroom;
  set numOfBathroom(int? numOfBathroom) =>
      _$this._numOfBathroom = numOfBathroom;

  DocumentReference<Object?>? _ffRef;
  DocumentReference<Object?>? get ffRef => _$this._ffRef;
  set ffRef(DocumentReference<Object?>? ffRef) => _$this._ffRef = ffRef;

  ListingRecordBuilder() {
    ListingRecord._initializeBuilder(this);
  }

  ListingRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _address = $v.address;
      _description = $v.description;
      _dimension = $v.dimension;
      _lease = $v.lease;
      _neighbourhood = $v.neighbourhood;
      _numOfBedroom = $v.numOfBedroom;
      _price = $v.price;
      _propertyName = $v.propertyName;
      _listingpic = $v.listingpic;
      _numOfBathroom = $v.numOfBathroom;
      _ffRef = $v.ffRef;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ListingRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ListingRecord;
  }

  @override
  void update(void Function(ListingRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ListingRecord build() => _build();

  _$ListingRecord _build() {
    final _$result = _$v ??
        new _$ListingRecord._(
            address: address,
            description: description,
            dimension: dimension,
            lease: lease,
            neighbourhood: neighbourhood,
            numOfBedroom: numOfBedroom,
            price: price,
            propertyName: propertyName,
            listingpic: listingpic,
            numOfBathroom: numOfBathroom,
            ffRef: ffRef);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
