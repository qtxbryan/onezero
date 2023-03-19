class Listing {
  String id;
  final String? address;
  final String? description;
  final int? dimension;
  final int? lease;
  final String? neighbourhood;
  final int? numOfBedroom;
  final double? price;
  final String? propertyName;

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
      };

  static Listing fromJson(Map<String, dynamic> json) => Listing(
      id: json['id'],
      address: json['address'],
      description: json['description'],
      dimension: json['dimension'],
      lease: json['lease'],
      neighbourhood: json['neighbourhood'],
      numOfBedroom: json['numOfBedroom'],
      price: json['price'],
      propertyName: json['propertyName']);
}
