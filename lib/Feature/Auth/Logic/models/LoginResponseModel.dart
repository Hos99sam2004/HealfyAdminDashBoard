// class LoginResponseModels {
//   String? token;
//   String? sId;
//   String? name;
//   String? email;
//   String? role;
//   String? phone;
//   bool? isVerified;
//   bool? isTeacherVerified;
//   String? teacherStatus;
//   List<Images>? images;
//   String? createdAt;
//   String? updatedAt;
//   int? iV;

//   LoginResponseModels({
//     this.token,
//     this.sId,
//     this.name,
//     this.email,
//     this.role,
//     this.phone,
//     this.isVerified,
//     this.isTeacherVerified,
//     this.teacherStatus,
//     this.images,
//     this.createdAt,
//     this.updatedAt,
//     this.iV,
//   });

//   LoginResponseModels.fromJson(Map<String, dynamic> json) {
//     token = json['token'];
//     sId = json['_id'];
//     name = json['name'];
//     email = json['email'];
//     role = json['role'];
//     phone = json['phone'];
//     isVerified = json['isVerified'];
//     isTeacherVerified = json['isTeacherVerified'];
//     teacherStatus = json['teacherStatus'];
//     if (json['images'] != null) {
//       images = <Images>[];
//       json['images'].forEach((v) {
//         images!.add(new Images.fromJson(v));
//       });
//     }
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     iV = json['__v'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['token'] = this.token;
//     data['_id'] = this.sId;
//     data['name'] = this.name;
//     data['email'] = this.email;
//     data['role'] = this.role;
//     data['phone'] = this.phone;
//     data['isVerified'] = this.isVerified;
//     data['isTeacherVerified'] = this.isTeacherVerified;
//     data['teacherStatus'] = this.teacherStatus;
//     if (this.images != null) {
//       data['images'] = this.images!.map((v) => v.toJson()).toList();
//     }
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     data['__v'] = this.iV;
//     return data;
//   }
// }

// class Images {
//   String? url;
//   String? publicId;
//   String? sId;

//   Images({this.url, this.publicId, this.sId});

//   Images.fromJson(Map<String, dynamic> json) {
//     url = json['url'];
//     publicId = json['publicId'];
//     sId = json['_id'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['url'] = this.url;
//     data['publicId'] = this.publicId;
//     data['_id'] = this.sId;
//     return data;
//   }
// }

import 'package:supabase_flutter/supabase_flutter.dart';

class LoginResponseModels {
  final User? user;
  final Session? session;

  LoginResponseModels({
     required this.user,
     required this.session,
  });
}