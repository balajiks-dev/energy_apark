class EmployeeListModel {
  final String id;
  final String name;
  final String email;

  EmployeeListModel({
   required this.id,
   required this.name,
   required this.email,
  });

  factory EmployeeListModel.fromJson(Map<String, dynamic> json) {
    return EmployeeListModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}
