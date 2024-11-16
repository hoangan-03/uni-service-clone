class DepositRequest {
  int price = 0;
  DepositRequest({
    required this.price,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'price': price,
      };
}
