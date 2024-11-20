class TransferRequest {
  String recipientId = "";
  int amount = 0;
  TransferRequest({
    required this.recipientId,
    required this.amount,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'recipientId': recipientId,
        'amount': amount,
      };
}
