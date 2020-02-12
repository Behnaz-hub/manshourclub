
class ShopCard {
  final String acid;
  final String cid;
  final String product_id;
  final String count;
  final List<Details> product_datails;

  ShopCard({this.acid,
    this.cid,
    this.count,
    this.product_id,
    this.product_datails,
  });

  factory ShopCard.fromJson(Map<String, dynamic> json) {
    return ShopCard(
        acid: json['acid'],
        cid: json['cid'],
        product_id: json['product_id'],
        count: json['count'],
        product_datails: json['product_datails'],
        );

  }
}
  class Details {
  final String product_id;
  final String gid;
  final String provider_id;
  final String sdate;
  final String edit_date;
  final String details;
  final String product_name;
  final String quantity;
  final String pic;
  final String price;
  final String weight;
  final String width;

  Details({
    this.product_id,
    this.gid,
    this.provider_id,
    this.sdate,
    this.edit_date,
    this.details,
    this.product_name,
    this.quantity,
    this.pic,
    this.price,
    this.weight,
    this.width});

  factory Details.fromJson(Map<String, dynamic> parsedJson) {

    return Details(
      product_id: parsedJson['product_id'],
      gid: parsedJson['gid'],
      provider_id: parsedJson['provider_id'],
      sdate: parsedJson['sdate'],
      edit_date: parsedJson['edit_date'],
      details: parsedJson['details'],
      product_name: parsedJson['product_name'],
      quantity: parsedJson['quantity'],
      pic: parsedJson['pic'],
      price: parsedJson['price'],
      weight: parsedJson['weight'],
      width: parsedJson['width'],
    );
  }

}


