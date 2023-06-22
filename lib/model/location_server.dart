class LocationServer {
  DeliveryTarget? deliveryTarget;

  LocationServer({this.deliveryTarget});

  LocationServer.fromJson(Map<String, dynamic> json) {
    deliveryTarget = json['deliveryTarget'] != null
        ? DeliveryTarget.fromJson(json['deliveryTarget'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (deliveryTarget != null) {
      data['deliveryTarget'] = deliveryTarget!.toJson();
    }
    return data;
  }
}

class DeliveryTarget {
  String? longitude;
  String? latitude;

  DeliveryTarget({this.longitude, this.latitude});

  DeliveryTarget.fromJson(Map<String, dynamic> json) {
    longitude = json['longitude'];
    latitude = json['latitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    return data;
  }
}
