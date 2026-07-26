class PersonState {
  const PersonState({
    required this.id,
    required this.name,
    required this.relationType,
    required this.age,
    required this.alive,
    required this.bond,
    this.location = 'Ghana',
    this.occupation = '',
    this.flags = const [],
  });

  final String id;
  final String name;
  final String relationType;
  final int age;
  final bool alive;
  final int bond;
  final String location;
  final String occupation;
  final List<String> flags;
}
