class DietryModel {
  final String name;
  bool isSelected;

  DietryModel({required this.name, required this.isSelected});
}

List<DietryModel> dietryList = [
  DietryModel(name: 'Gluten', isSelected: false),
  DietryModel(name: 'Eggs', isSelected: false),
  DietryModel(name: 'Nuts', isSelected: false),
  DietryModel(name: 'Dairy', isSelected: false),
  DietryModel(name: 'Seafood', isSelected: false),
  DietryModel(name: 'Shellfish', isSelected: false),
  DietryModel(name: 'Soy', isSelected: false),
  DietryModel(name: 'Sesame', isSelected: false),
];
