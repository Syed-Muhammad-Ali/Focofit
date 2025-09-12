class MedicalModel {
  final String title;
  bool isSelected;
  MedicalModel({required this.title, this.isSelected = false});
}

List<MedicalModel> medicalList = [
  MedicalModel(title: 'Hypertension'),
  MedicalModel(title: 'Diabetes or insulin resistance'),
  MedicalModel(title: 'Asthma'),
  MedicalModel(title: 'High cholesterol'),
  MedicalModel(title: 'Lung disease'),
  MedicalModel(title: 'Heart disease'),
  MedicalModel(title: 'Kidney disease'),
  MedicalModel(title: 'Liver disease'),
  MedicalModel(title: 'Thyroid disease'),
  MedicalModel(title: 'Other'),
];
