class UserInfoModel {
  int id;
  String fName;
  String lName;
  String email;
  String image;
  String phone;
  String password;
  String college_name;
  int orderCount;
  int memberSinceDays;

  UserInfoModel(
      {this.id,
        this.fName,
        this.lName,
        this.email,
        this.image,
        this.phone,
        this.password,
        this.college_name,
        this.orderCount,
        this.memberSinceDays});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fName = json['f_name'];
    lName = json['l_name'];
    email = json['email'];
    image = json['image'];
    phone = json['phone'];
    password = json['password'];
    college_name = json['college_name'];
    orderCount = json['order_count'];
    memberSinceDays = json['member_since_days'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['f_name'] = this.fName;
    data['l_name'] = this.lName;
    data['email'] = this.email;
    data['image'] = this.image;
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['college_name'] = this.college_name;
    data['order_count'] = this.orderCount;
    data['member_since_days'] = this.memberSinceDays;
    return data;
  }
}
