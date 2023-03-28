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
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.lease;
    if (value != null) {
      result
        ..add('lease')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.listedBy;
    if (value != null) {
      result
        ..add('listed_by')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
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
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.price;
    if (value != null) {
      result
        ..add('price')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.propertyName;
    if (value != null) {
      result
        ..add('propertyName')
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
              specifiedType: const FullType(String)) as String?;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'lease':
          result.lease = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'listed_by':
          result.listedBy = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'neighbourhood':
          result.neighbourhood = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'numOfBedroom':
          result.numOfBedroom = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'price':
          result.price = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'propertyName':
          result.propertyName = serializers.deserialize(value,
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

class _$ListingRecord extends ListingRecord {
  @override
  final String? address;
  @override
  final String? description;
  @override
  final String? dimension;
  @override
  final String? id;
  @override
  final String? lease;
  @override
  final String? listedBy;
  @override
  final String? neighbourhood;
  @override
  final String? numOfBedroom;
  @override
  final String? price;
  @override
  final String? propertyName;
  @override
  final DocumentReference<Object?>? ffRef;

  factory _$ListingRecord([void Function(ListingRecordBuilder)? updates]) =>
      (new ListingRecordBuilder()..update(updates))._build();

  _$ListingRecord._(
      {this.address,
      this.description,
      this.dimension,
      this.id,
      this.lease,
      this.listedBy,
      this.neighbourhood,
      this.numOfBedroom,
      this.price,
      this.propertyName,
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
        id == other.id &&
        lease == other.lease &&
        listedBy == other.listedBy &&
        neighbourhood == other.neighbourhood &&
        numOfBedroom == other.numOfBedroom &&
        price == other.price &&
        propertyName == other.propertyName &&
        ffRef == other.ffRef;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, address.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, dimension.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, lease.hashCode);
    _$hash = $jc(_$hash, listedBy.hashCode);
    _$hash = $jc(_$hash, neighbourhood.hashCode);
    _$hash = $jc(_$hash, numOfBedroom.hashCode);
    _$hash = $jc(_$hash, price.hashCode);
    _$hash = $jc(_$hash, propertyName.hashCode);
    _$hash = $jc(_$hash, ffRef.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ListingRecord')
          ..add('address', address)
          ..add('description', description)
          ..add('dimension', dimension)
          ..add('id', id)
          ..add('lease', lease)
          ..add('listedBy', listedBy)
          ..add('neighbourhood', neighbourhood)
          ..add('numOfBedroom', numOfBedroom)
          ..add('price', price)
          ..add('propertyName', propertyName)
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

  String? _dimension;
  String? get dimension => _$this._dimension;
  set dimension(String? dimension) => _$this._dimension = dimension;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _lease;
  String? get lease => _$this._lease;
  set lease(String? lease) => _$this._lease = lease;

  String? _listedBy;
  String? get listedBy => _$this._listedBy;
  set listedBy(String? listedBy) => _$this._listedBy = listedBy;

  String? _neighbourhood;
  String? get neighbourhood => _$this._neighbourhood;
  set neighbourhood(String? neighbourhood) =>
      _$this._neighbourhood = neighbourhood;

  String? _numOfBedroom;
  String? get numOfBedroom => _$this._numOfBedroom;
  set numOfBedroom(String? numOfBedroom) => _$this._numOfBedroom = numOfBedroom;

  String? _price;
  String? get price => _$this._price;
  set price(String? price) => _$this._price = price;

  String? _propertyName;
  String? get propertyName => _$this._propertyName;
  set propertyName(String? propertyName) => _$this._propertyName = propertyName;

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
      _id = $v.id;
      _lease = $v.lease;
      _listedBy = $v.listedBy;
      _neighbourhood = $v.neighbourhood;
      _numOfBedroom = $v.numOfBedroom;
      _price = $v.price;
      _propertyName = $v.propertyName;
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
            id: id,
            lease: lease,
            listedBy: listedBy,
            neighbourhood: neighbourhood,
            numOfBedroom: numOfBedroom,
            price: price,
            propertyName: propertyName,
            ffRef: ffRef);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
