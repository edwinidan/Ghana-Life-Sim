class BusinessType {
  final String name;
  final String emoji;
  final String description;
  final int startupCost;
  final int baseMonthlyIncome;
  final int minAge;
  final Map<String, int> statRequirements;

  const BusinessType({
    required this.name,
    required this.emoji,
    required this.description,
    required this.startupCost,
    required this.baseMonthlyIncome,
    required this.minAge,
    required this.statRequirements,
  });
}

const List<BusinessType> allBusinessTypes = [
  BusinessType(
    name: 'Chop Bar',
    emoji: '🍲',
    description:
        'Feeding Ghana one waakye at a time. Everyone owes you credit.',
    startupCost: 15,
    baseMonthlyIncome: 2500,
    minAge: 20,
    statRequirements: {'streetSense': 40},
  ),
  BusinessType(
    name: 'Barbershop / Salon',
    emoji: '✂️',
    description:
        'Cutting hair and collecting information since day one.',
    startupCost: 12,
    baseMonthlyIncome: 2000,
    minAge: 18,
    statRequirements: {'looks': 40},
  ),
  BusinessType(
    name: 'Poultry Farm',
    emoji: '🐔',
    description:
        'The chickens don\'t respect you but the money does.',
    startupCost: 20,
    baseMonthlyIncome: 3000,
    minAge: 22,
    statRequirements: {'discipline': 45},
  ),
  BusinessType(
    name: 'Clothing / Fashion',
    emoji: '👗',
    description:
        'Dressing Ghana one ankara at a time. Mostly on credit.',
    startupCost: 18,
    baseMonthlyIncome: 2200,
    minAge: 20,
    statRequirements: {'looks': 50},
  ),
  BusinessType(
    name: 'Provisions Shop',
    emoji: '🛒',
    description:
        'Selling Milo, matches and Indomie to the whole neighbourhood.',
    startupCost: 10,
    baseMonthlyIncome: 1800,
    minAge: 18,
    statRequirements: {'streetSense': 35},
  ),
  BusinessType(
    name: 'Transport (Trotro/Taxi)',
    emoji: '🚐',
    description:
        'The road is your office. The passengers are your problems.',
    startupCost: 25,
    baseMonthlyIncome: 3500,
    minAge: 22,
    statRequirements: {'streetSense': 50, 'discipline': 40},
  ),
];
