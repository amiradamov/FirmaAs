class ProdModel{
  String? IDK;
  String? N_GROUP;
  String? N_PROD;
  String? GROUP_NAME;
  String? TOV_NAME;
  String? WEB_PRICE;
  String? PRICE;
  String? OST;

ProdModel(
    {this.IDK,
    this.N_GROUP,
    this.N_PROD,
    this.GROUP_NAME,
    this.TOV_NAME,
    this.WEB_PRICE,
    this.PRICE,
    this.OST}) ;

  ProdModel.fromJson(Map<String,dynamic> json) {
    IDK = json['IDK'];
    N_GROUP = json['N_GROUP'];
    N_PROD = json['N_PROD'];
    GROUP_NAME = json['GROUP_NAME'];
    TOV_NAME = json['TOV_NAME'];
    WEB_PRICE = json['WEB_PRICE'];
    PRICE = json['PRICE'];
    OST = json['OST'];
  }
}