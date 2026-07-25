class RegisterRequestModels {
  String? name;
  String? email;
  String? password;
  String? phone;
  String? role;

  RegisterRequestModels({
    this.name,
    this.email,
    this.password,
    this.phone,
    this.role,
  });

  RegisterRequestModels.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['phone'] = this.phone;
    data['role'] = this.role;
    return data;
  }
}
