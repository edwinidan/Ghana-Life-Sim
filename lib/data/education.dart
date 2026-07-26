class EducationProgram {
  final String id;
  final String name;
  final String levelGranted;
  final int durationYears;
  final int costPerYear;
  final int minAge;
  final String? prerequisite;
  final List<String> acceptedPrerequisites;
  final int smartsRequired;
  final String? completionFlag;
  final bool preservesEducationLevel;

  const EducationProgram({
    String? id,
    required this.name,
    required this.levelGranted,
    required this.durationYears,
    required this.costPerYear,
    required this.minAge,
    this.prerequisite,
    this.acceptedPrerequisites = const [],
    required this.smartsRequired,
    this.completionFlag,
    this.preservesEducationLevel = false,
  }) : id = id ?? name;

  bool accepts(String currentLevel) {
    if (acceptedPrerequisites.isNotEmpty) {
      return acceptedPrerequisites.contains(currentLevel);
    }
    return prerequisite == null || prerequisite == currentLevel;
  }
}

final List<EducationProgram> allPrograms = [
  EducationProgram(
    id: 'primary',
    name: 'Primary School',
    levelGranted: 'Primary',
    durationYears: 6,
    costPerYear: 0,
    minAge: 4,
    prerequisite: null,
    smartsRequired: 0,
  ),
  EducationProgram(
    id: 'jhs',
    name: 'Junior High School',
    levelGranted: 'JHS',
    durationYears: 3,
    costPerYear: 0,
    minAge: 10,
    prerequisite: 'Primary',
    smartsRequired: 20,
  ),
  EducationProgram(
    id: 'shs',
    name: 'Senior High School',
    levelGranted: 'SHS',
    durationYears: 3,
    costPerYear: 2,
    minAge: 13,
    prerequisite: 'JHS',
    smartsRequired: 35,
  ),
  EducationProgram(
    id: 'tvet',
    name: 'TVET / Vocational Training',
    levelGranted: 'Vocational',
    durationYears: 2,
    costPerYear: 3,
    minAge: 15,
    prerequisite: 'JHS',
    smartsRequired: 25,
  ),
  EducationProgram(
    id: 'university',
    name: 'University',
    levelGranted: 'University',
    durationYears: 4,
    costPerYear: 5,
    minAge: 17,
    prerequisite: 'SHS',
    smartsRequired: 55,
  ),
  EducationProgram(
    id: 'apprenticeship',
    name: 'Skilled Apprenticeship',
    levelGranted: 'Vocational',
    durationYears: 3,
    costPerYear: 1,
    minAge: 15,
    prerequisite: 'JHS',
    smartsRequired: 20,
  ),
  EducationProgram(
    id: 'nursing_teacher_training',
    name: 'Nursing / Teacher Training College',
    levelGranted: 'Tertiary Diploma',
    durationYears: 3,
    costPerYear: 4,
    minAge: 17,
    prerequisite: 'SHS',
    smartsRequired: 48,
  ),
  EducationProgram(
    id: 'technical_university',
    name: 'Technical University',
    levelGranted: 'University',
    durationYears: 4,
    costPerYear: 4,
    minAge: 17,
    prerequisite: 'SHS',
    smartsRequired: 45,
  ),
  EducationProgram(
    id: 'national_service',
    name: 'National Service Scheme',
    levelGranted: 'NSS',
    durationYears: 1,
    costPerYear: 0,
    minAge: 20,
    acceptedPrerequisites: ['University', 'Tertiary Diploma'],
    smartsRequired: 0,
    completionFlag: 'nss_completed',
    preservesEducationLevel: true,
  ),
];
