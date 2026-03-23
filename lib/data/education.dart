class EducationProgram {
  final String name;
  final String levelGranted;
  final int durationYears;
  final int costPerYear;
  final int minAge;
  final String? prerequisite;
  final int smartsRequired;

  const EducationProgram({
    required this.name,
    required this.levelGranted,
    required this.durationYears,
    required this.costPerYear,
    required this.minAge,
    this.prerequisite,
    required this.smartsRequired,
  });
}

final List<EducationProgram> allPrograms = [
  EducationProgram(
    name: 'Primary School',
    levelGranted: 'Primary',
    durationYears: 6,
    costPerYear: 0,
    minAge: 4,
    prerequisite: null,
    smartsRequired: 0,
  ),
  EducationProgram(
    name: 'Junior High School',
    levelGranted: 'JHS',
    durationYears: 3,
    costPerYear: 0,
    minAge: 10,
    prerequisite: 'Primary',
    smartsRequired: 20,
  ),
  EducationProgram(
    name: 'Senior High School',
    levelGranted: 'SHS',
    durationYears: 3,
    costPerYear: 2,
    minAge: 13,
    prerequisite: 'JHS',
    smartsRequired: 35,
  ),
  EducationProgram(
    name: 'Vocational Training',
    levelGranted: 'Vocational',
    durationYears: 2,
    costPerYear: 3,
    minAge: 15,
    prerequisite: 'JHS',
    smartsRequired: 25,
  ),
  EducationProgram(
    name: 'University',
    levelGranted: 'University',
    durationYears: 4,
    costPerYear: 5,
    minAge: 17,
    prerequisite: 'SHS',
    smartsRequired: 55,
  ),
];
