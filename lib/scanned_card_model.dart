class ScannedCardModel {
  final String number;
  final String cardholder;
  final String expiry;

  ScannedCardModel({
    this.number = '',
    this.cardholder = '',
    this.expiry = '',
  });

  factory ScannedCardModel.fromJson(Map<String, dynamic> json) {
    return ScannedCardModel(
      number: json['cardNumber'] ?? '',
      cardholder: json['cardHolderName'] ?? '',
      expiry: json['expiryDate'] ?? '',
    );
  }

  @override
  String toString() => '''
        number: $number
        cardholder: $cardholder
        expiry: $expiry
      ''';
}
