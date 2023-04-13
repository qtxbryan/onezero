class Listing {
  String? id;
  String? address;
  String? description;
  String? dimension;
  String? lease;
  String? neighbourhood;
  String? numOfBedroom;
  String? price;
  String? propertyName;
  String? listed_by_email;
  String? upload_url;

  String? get getId => this.id;

  set setId(String? id) => this.id = id;

  get getAddress => this.address;

  set setAddress(address) => this.address = address;

  get getDescription => this.description;

  set setDescription(description) => this.description = description;

  get getDimension => this.dimension;

  set setDimension(dimension) => this.dimension = dimension;

  get getLease => this.lease;

  set setLease(lease) => this.lease = lease;

  get getNeighbourhood => this.neighbourhood;

  set setNeighbourhood(neighbourhood) => this.neighbourhood = neighbourhood;

  get getNumOfBedroom => this.numOfBedroom;

  set setNumOfBedroom(numOfBedroom) => this.numOfBedroom = numOfBedroom;

  get getPrice => this.price;

  set setPrice(price) => this.price = price;

  get getPropertyName => this.propertyName;

  set setPropertyName(value) {
    this.propertyName = value;
  }

  get listedby_email => this.listed_by_email;

  set listedby_email(value) => this.listed_by_email = value;

  get uploadurl => this.upload_url;

  set setUploadUrl(value) => this.upload_url = value;

  Listing({
    this.id,
    required this.address,
    required this.description,
    required this.dimension,
    required this.lease,
    required this.neighbourhood,
    required this.numOfBedroom,
    required this.price,
    required this.propertyName,
    required this.listed_by_email,
    this.upload_url,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'address': address,
        'description': description,
        'dimension': dimension,
        'lease': lease,
        'neighbourhood': neighbourhood,
        'numOfBedroom': numOfBedroom,
        'price': price,
        'propertyName': propertyName,
        'Listed_by_email': listed_by_email,
      };

  factory Listing.fromJson(Map<String, dynamic> json) => Listing(
        id: json['id'],
        address: json['address'],
        description: json['description'],
        dimension: json['dimension'],
        lease: json['lease'],
        neighbourhood: json['neighbourhood'],
        numOfBedroom: json['numOfBedroom'],
        price: json['price'],
        propertyName: json['propertyName'],
        listed_by_email: json['listed_by_email'],
      );

  factory Listing.fromMap(Map<String, dynamic> map, String id) {
    return Listing(
      id: id,
      address: map['address'],
      description: map['description'],
      dimension: map['dimension'],
      lease: map['lease'],
      neighbourhood: map['neighbourhood'],
      numOfBedroom: map['numOfBedroom'],
      price: map['price'],
      propertyName: map['propertyName'],
      listed_by_email: map['listedByEmail'],
      upload_url: map['uploadUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'description': description,
      'dimension': dimension,
      'lease': lease,
      'neighbourhood': neighbourhood,
      'numOfBedroom': numOfBedroom,
      'price': price,
      'propertyName': propertyName,
      'listedByEmail': listed_by_email,
      'uploadUrl': upload_url,
    };
  }
}
