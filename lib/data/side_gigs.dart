class SideGig {
  final String name;
  final String description;
  final int monthlyIncome;
  final int minAge;
  final Map<String, int> statRequirements;
  final String? requiredCareer;

  const SideGig({
    required this.name,
    required this.description,
    required this.monthlyIncome,
    required this.minAge,
    this.statRequirements = const {},
    this.requiredCareer,
  });
}

final List<SideGig> allSideGigs = [
  SideGig(
    name: 'Private Tutor',
    description: 'Teaching other people\'s stubborn children what school failed to teach them.',
    monthlyIncome: 600,
    minAge: 16,
    statRequirements: {'smarts': 50},
  ),
  SideGig(
    name: 'Uber/Bolt Driver',
    description: 'Navigating Accra traffic and explaining Ghana politics to strangers.',
    monthlyIncome: 800,
    minAge: 20,
    statRequirements: {'streetSense': 40},
  ),
  SideGig(
    name: 'Mobile Money Agent',
    description: 'Handling other people\'s money and somehow never getting rich yourself.',
    monthlyIncome: 500,
    minAge: 18,
    statRequirements: {'streetSense': 35},
  ),
  SideGig(
    name: 'Event MC',
    description: 'Talking loudly into a microphone at funerals and outdoorings.',
    monthlyIncome: 700,
    minAge: 20,
    statRequirements: {'looks': 45, 'happiness': 50},
  ),
  SideGig(
    name: 'Hair Braider / Barber',
    description: 'Listening to gossip for 3 hours and charging for the haircut.',
    monthlyIncome: 550,
    minAge: 15,
    statRequirements: {'looks': 40},
  ),
  SideGig(
    name: 'Food Vendor',
    description: 'Selling jollof that people say is better than their mother\'s cooking.',
    monthlyIncome: 650,
    minAge: 17,
    statRequirements: {'streetSense': 30},
  ),
  SideGig(
    name: 'Freelance Designer',
    description: 'Making logos for people who say "just make it pop" with no brief.',
    monthlyIncome: 900,
    minAge: 18,
    statRequirements: {'smarts': 60},
  ),
  SideGig(
    name: 'Church Musician',
    description: 'Playing keys every Sunday whether you feel the spirit or not.',
    monthlyIncome: 400,
    minAge: 16,
    statRequirements: {'happiness': 55},
  ),
  SideGig(
    name: 'Social Media Manager',
    description: 'Posting for brands and pretending their content is interesting.',
    monthlyIncome: 750,
    minAge: 18,
    statRequirements: {'smarts': 50, 'looks': 40},
  ),
  SideGig(
    name: 'Sports Coach',
    description: 'Training the next Asamoah Gyan. Probably.',
    monthlyIncome: 600,
    minAge: 22,
    statRequirements: {'health': 55, 'discipline': 50},
  ),
  SideGig(
    name: 'Legal Clerk',
    description: 'Filing documents and knowing exactly which laws everyone is breaking.',
    monthlyIncome: 700,
    minAge: 22,
    statRequirements: {'smarts': 65},
    requiredCareer: 'Civil Service',
  ),
  SideGig(
    name: 'Medical Locum',
    description: 'Covering shifts at clinics and praying the equipment works.',
    monthlyIncome: 1200,
    minAge: 24,
    statRequirements: {'smarts': 70},
    requiredCareer: 'Healthcare',
  ),
];
