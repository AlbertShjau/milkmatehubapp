import 'feed_model.dart';

class OrderModel {
  String orderId;
  String supplierId;
  DateTime orderDate;
  List<FeedModel> feeds;

  OrderModel({
    required this.orderId,
    required this.supplierId,
    required this.orderDate,
    required this.feeds,
  });

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'supplierId': supplierId,
      'orderDate': orderDate.toIso8601String(),
      'feeds': feeds.map((feed) => feed.toJson()).toList(),
    };
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderId: json['orderId'],
      supplierId: json['supplierId'],
      orderDate: DateTime.parse(json['orderDate']),
      feeds: List<FeedModel>.from(json['feeds'].map((feedJson) => FeedModel.fromJson(feedJson))),
    );
  }
}
