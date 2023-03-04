class ModelsModel {
  final String id;
  final int created;
  final String root;

  ModelsModel({required this.id, required this.created, required this.root});
  factory ModelsModel.fromJson(Map<String, dynamic> json) =>
      ModelsModel(id: json['id'], created: json['created'], root: json['root']);

  static List<ModelsModel> fromSnapshot(List model) {
    return model.map((e) => ModelsModel.fromJson(e)).toList();
  }
}
