class Vendor {
  int? id;
  String? type;
  String? name;
  String? b_name;
  String? email;
  String? town;
  String? city;
  String?  relevant_docs;
  String? files;

  Vendor({
      this.id,
      this.type,
      this.name,
      this.b_name,
      this.email,
      this.town,
      this.city,
      this.relevant_docs,
      this.files
  });
  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
      id: json['id'],
      type: json['type'],
      name: json['name'],
      b_name: json['b_name'],
      email: json['email'],
      town: json['town'],
      city: json['city'],
      relevant_docs: json['relevant_docs'],
      files: json['file'],
    );
  }
}