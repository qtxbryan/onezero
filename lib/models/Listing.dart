class Listing {
  String id;
  final String? address;
  final String? description;
  final String? dimension;
  final String? lease;
  final String? neighbourhood;
  final String? numOfBedroom;
  final String? price;
  final String? propertyName;
  final String? listed_by_email;

  Listing({
    this.id = '',
    required this.address,
    required this.description,
    required this.dimension,
    required this.lease,
    required this.neighbourhood,
    required this.numOfBedroom,
    required this.price,
    required this.propertyName,
    required this.listed_by_email,
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
}
