class TransferRequest {
  String recipientId = "";
  String amount = "";
  TransferRequest({
    required this.recipientId,
    required this.amount,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'recipientId': recipientId,
        'amount': amount,
      };
}
