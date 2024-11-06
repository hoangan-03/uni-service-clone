class AddToCartRequest {
  String idProduct = '';
  int quantity = 0;
  AddToCartRequest({
    required this.idProduct,
    required this.quantity,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'idProduct': idProduct,
        'quantity': quantity,
      };
}
