class CareerLevel {
  final String title;
  final int salary;
  final Map<String, int> statRequirements;

  CareerLevel({
    required this.title,
    required this.salary,
    required this.statRequirements,
  });
}

class CareerData {
  final String name;
  final List<CareerLevel> levels; // index 0 = entry, 1 = mid, 2 = senior
  final List<String> acceptedEducationLevels;
  final List<String> acceptedSpecializations;
  final String summary;

  CareerData({
    required this.name,
    required this.levels,
    this.acceptedEducationLevels = const [],
    this.acceptedSpecializations = const [],
    this.summary = '',
  });
}

final List<CareerData> allCareers = [
  CareerData(
    name: 'Civil Service',
    acceptedEducationLevels: ['SHS', 'Tertiary Diploma', 'University'],
    summary: 'Stable public-sector work with a path into national leadership.',
    levels: [
      CareerLevel(
        title: 'Junior Officer',
        salary: 1800,
        statRequirements: {'discipline': 40},
      ),
      CareerLevel(
        title: 'Senior Officer',
        salary: 3200,
        statRequirements: {'discipline': 60, 'smarts': 50},
      ),
      CareerLevel(
        title: 'Director',
        salary: 6000,
        statRequirements: {'discipline': 75, 'connections': 60},
      ),
    ],
  ),
  CareerData(
    name: 'Healthcare',
    acceptedEducationLevels: ['Tertiary Diploma', 'University'],
    acceptedSpecializations: ['Health Sciences'],
    summary: 'Clinical care, demanding shifts, and respected specialist work.',
    levels: [
      CareerLevel(
        title: 'Nurse / Medical Assistant',
        salary: 2200,
        statRequirements: {'smarts': 55, 'health': 50},
      ),
      CareerLevel(
        title: 'Doctor / Pharmacist',
        salary: 5500,
        statRequirements: {'smarts': 70, 'health': 60},
      ),
      CareerLevel(
        title: 'Senior Consultant',
        salary: 10000,
        statRequirements: {'smarts': 80, 'reputation': 65},
      ),
    ],
  ),
  CareerData(
    name: 'Education',
    acceptedEducationLevels: ['Tertiary Diploma', 'University'],
    acceptedSpecializations: ['Education'],
    summary: 'Teach, mentor, and progress into school leadership.',
    levels: [
      CareerLevel(
        title: 'Class Teacher',
        salary: 1600,
        statRequirements: {'smarts': 45},
      ),
      CareerLevel(
        title: 'Senior Teacher / HOD',
        salary: 2800,
        statRequirements: {'smarts': 55, 'reputation': 45},
      ),
      CareerLevel(
        title: 'Headmaster / Principal',
        salary: 5000,
        statRequirements: {'smarts': 65, 'reputation': 65, 'connections': 50},
      ),
    ],
  ),
  CareerData(
    name: 'Tech',
    acceptedEducationLevels: ['Vocational', 'Tertiary Diploma', 'University'],
    acceptedSpecializations: ['Engineering & Technology', 'Technical Trade'],
    summary: 'Build digital products and technical systems.',
    levels: [
      CareerLevel(
        title: 'Junior Developer / IT Support',
        salary: 2500,
        statRequirements: {'smarts': 60},
      ),
      CareerLevel(
        title: 'Software Engineer',
        salary: 5000,
        statRequirements: {'smarts': 70},
      ),
      CareerLevel(
        title: 'Tech Lead / CTO',
        salary: 12000,
        statRequirements: {'smarts': 80, 'connections': 55},
      ),
    ],
  ),
  CareerData(
    name: 'Trade',
    summary: 'Grow from hands-on selling into wholesale distribution.',
    levels: [
      CareerLevel(
        title: 'Shop Attendant / Trader',
        salary: 1200,
        statRequirements: {'streetSense': 40},
      ),
      CareerLevel(
        title: 'Established Trader',
        salary: 3000,
        statRequirements: {'streetSense': 55, 'money': 40},
      ),
      CareerLevel(
        title: 'Wholesale Distributor',
        salary: 7000,
        statRequirements: {'streetSense': 70, 'connections': 50},
      ),
    ],
  ),
  CareerData(
    name: 'Entertainment',
    summary: 'Build an audience through music, comedy, and live performance.',
    levels: [
      CareerLevel(
        title: 'Upcoming Artist / Comedian',
        salary: 800,
        statRequirements: {'looks': 50, 'happiness': 50},
      ),
      CareerLevel(
        title: 'Known Act',
        salary: 4000,
        statRequirements: {'looks': 60, 'reputation': 55},
      ),
      CareerLevel(
        title: 'Star / Celebrity',
        salary: 15000,
        statRequirements: {'looks': 70, 'reputation': 80},
      ),
    ],
  ),
  CareerData(
    name: 'Hustle',
    summary: 'A risky informal path powered by nerve and connections.',
    levels: [
      CareerLevel(
        title: 'Street Hustle',
        salary: 900,
        statRequirements: {'streetSense': 35},
      ),
      CareerLevel(
        title: 'Connected Operator',
        salary: 2500,
        statRequirements: {'streetSense': 60, 'connections': 40},
      ),
      CareerLevel(
        title: 'Big Man / Oga',
        salary: 8000,
        statRequirements: {'streetSense': 75, 'connections': 65},
      ),
    ],
  ),
  CareerData(
    name: 'Commerce',
    acceptedEducationLevels: ['SHS', 'Tertiary Diploma', 'University'],
    acceptedSpecializations: ['Business & Administration', 'General Studies'],
    summary: 'Private-sector operations, finance, sales, and management.',
    levels: [
      CareerLevel(
        title: 'Sales / Operations Associate',
        salary: 2200,
        statRequirements: {'smarts': 42, 'discipline': 38},
      ),
      CareerLevel(
        title: 'Account Manager / Analyst',
        salary: 4800,
        statRequirements: {'smarts': 58, 'reputation': 45},
      ),
      CareerLevel(
        title: 'Commercial Director',
        salary: 11000,
        statRequirements: {'smarts': 68, 'connections': 60},
      ),
    ],
  ),
  CareerData(
    name: 'Sports & Media',
    acceptedEducationLevels: [
      'SHS',
      'Vocational',
      'Tertiary Diploma',
      'University',
    ],
    acceptedSpecializations: ['Arts, Media & Sport'],
    summary: 'Compete, report, produce, and lead in Ghanaian sport and media.',
    levels: [
      CareerLevel(
        title: 'Academy Athlete / Production Assistant',
        salary: 1600,
        statRequirements: {'health': 55, 'reputation': 30},
      ),
      CareerLevel(
        title: 'Professional / Producer',
        salary: 5200,
        statRequirements: {'health': 62, 'reputation': 55},
      ),
      CareerLevel(
        title: 'National Star / Media Executive',
        salary: 14000,
        statRequirements: {'reputation': 78, 'connections': 55},
      ),
    ],
  ),
];
