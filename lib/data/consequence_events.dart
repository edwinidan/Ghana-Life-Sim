import '../models/event.dart';

final List<LifeEvent> consequenceEvents = [
  LifeEvent(
    id: 'family.support.request.v1',
    category: 'family',
    chainId: 'family_support_memory',
    title: 'Family Support Request 💸',
    description:
        'A family member calls with a very serious voice. School fees, rent, or hospital bills are due, and somehow your name has entered the matter.',
    minAge: 18,
    maxAge: 75,
    baseWeight: 14,
    choices: [
      EventChoice(
        text: 'Send what you can',
        statChanges: {'reputation': 8, 'happiness': 3, 'money': -2},
        cashChange: -800,
        outcome:
            'You sent money. The family praised you in the group chat, then immediately went quiet before anyone asked for more.',
      ),
      EventChoice(
        text: 'Say you are also struggling',
        statChanges: {'happiness': -4, 'reputation': -6, 'discipline': 4},
        flagToAdd: 'family_disappointed',
        outcome:
            'You told them the truth. Nobody insulted you directly, but the silence was doing push-ups.',
      ),
      EventChoice(
        text: 'Borrow money and help',
        statChanges: {'reputation': 12, 'happiness': -5, 'money': -4},
        debtChange: 1200,
        outcome:
            'You helped, but the money came from debt. Everyone says God will bless you. The lender says payment is due next month.',
      ),
    ],
  ),
  LifeEvent(
    id: 'finance.debt_collector.v1',
    category: 'money',
    title: 'Debt Collector Call 📞',
    description:
        'Your phone rings. It is not a friend, not a crush, not opportunity. It is someone reminding you that debt has memory.',
    minAge: 18,
    maxAge: 85,
    baseWeight: 24,
    requiredFlags: ['in_debt'],
    choices: [
      EventChoice(
        text: 'Make a payment',
        statChanges: {'happiness': 3, 'money': 2, 'discipline': 5},
        cashChange: -1000,
        debtChange: -1000,
        outcome:
            'You paid something. The pressure reduced a little, which is not the same as peace, but it is close enough for today.',
      ),
      EventChoice(
        text: 'Negotiate for more time',
        statChanges: {'streetSense': 6, 'happiness': -3},
        debtChange: 400,
        outcome:
            'You negotiated. They agreed, then added charges with the confidence of a bank that has never known shame.',
      ),
      EventChoice(
        text: 'Ignore the call',
        statChanges: {'happiness': -8, 'reputation': -5, 'discipline': -4},
        debtChange: 800,
        outcome: 'You ignored it. The problem did not ignore you back.',
      ),
    ],
  ),
  LifeEvent(
    id: 'family.child_attention.v1',
    category: 'family',
    title: 'Your Child Needs Attention 👶',
    description:
        'Your child has been acting differently lately. A teacher, relative, or neighbour says you should pay closer attention before small things become big things.',
    minAge: 25,
    maxAge: 70,
    baseWeight: 18,
    requiredFlags: ['has_children'],
    choices: [
      EventChoice(
        text: 'Spend real time with them',
        statChanges: {'happiness': 8, 'reputation': 4, 'money': -1},
        cashChange: -500,
        outcome:
            'You made time. It cost money and energy, but the bond at home grew stronger.',
      ),
      EventChoice(
        text: 'Be strict immediately',
        statChanges: {'discipline': 5, 'happiness': -4, 'reputation': 2},
        outcome:
            'You restored order quickly. Whether you restored trust is another matter.',
      ),
      EventChoice(
        text: 'Focus on work instead',
        statChanges: {'money': 4, 'happiness': -6, 'reputation': -3},
        flagToAdd: 'distant_parent',
        outcome: 'You chose the grind. The house noticed.',
      ),
    ],
  ),
  LifeEvent(
    id: 'family.old_disappointment.v1',
    category: 'family',
    chainId: 'family_support_memory',
    title: 'Family Brings Up Old Disappointment 🧾',
    description:
        'At a gathering, someone casually mentions the time you did not help the family. Somehow everyone suddenly remembers every detail.',
    minAge: 20,
    maxAge: 80,
    baseWeight: 12,
    requiredFlags: ['family_disappointed'],
    minimumYearsAfterFlags: {'family_disappointed': 2},
    choices: [
      EventChoice(
        text: 'Apologise and repair things',
        statChanges: {'reputation': 8, 'happiness': 4, 'discipline': 3},
        cashChange: -600,
        flagToRemove: 'family_disappointed',
        outcome:
            'You swallowed pride and repaired the bridge. It was not cheap, but peace returned.',
      ),
      EventChoice(
        text: 'Stand by your decision',
        statChanges: {'discipline': 6, 'reputation': -4, 'happiness': -3},
        outcome:
            'You stood firm. Some people respected it. Some people are still typing.',
      ),
    ],
  ),
  LifeEvent(
    id: 'education.family_sacrifice.v1',
    category: 'education',
    chainId: 'education_family_sacrifice',
    title: 'A Costly Education Choice 🎓',
    description:
        'A promising programme is available, but accepting it will stretch the whole household.',
    minAge: 16,
    maxAge: 24,
    choices: [
      EventChoice(
        text: 'Accept the family sacrifice',
        statChanges: {'smarts': 8, 'happiness': -3},
        cashChange: -1200,
        flagToAdd: 'education_family_sacrifice',
        outcome:
            'Your family rearranged its plans so you could keep studying. Nobody forgot the cost.',
      ),
      EventChoice(
        text: 'Choose the affordable path',
        statChanges: {'discipline': 6, 'happiness': 2},
        outcome: 'You chose a path the household could carry without breaking.',
      ),
    ],
  ),
  LifeEvent(
    id: 'education.sacrifice_returns.v1',
    category: 'career',
    chainId: 'education_family_sacrifice',
    title: 'The Sacrifice Comes Back Around 🤝',
    description:
        'A relative who supported your education now needs help—and remembers exactly why you have opportunities.',
    minAge: 20,
    maxAge: 45,
    requiredFlags: ['education_family_sacrifice'],
    minimumYearsAfterFlags: {'education_family_sacrifice': 3},
    choices: [
      EventChoice(
        text: 'Return the support',
        statChanges: {'reputation': 10, 'happiness': 5},
        cashChange: -1800,
        flagToRemove: 'education_family_sacrifice',
        outcome:
            'You returned the support. The old sacrifice became a family success story.',
      ),
      EventChoice(
        text: 'Explain that you cannot help yet',
        statChanges: {'discipline': 4, 'reputation': -6},
        outcome:
            'They accepted your answer, but the history between you grew heavier.',
      ),
    ],
  ),
  LifeEvent(
    id: 'hustle.old_trouble_returns.v1',
    category: 'risk',
    chainId: 'risky_hustle_consequence',
    title: 'Old Hustle Trouble Returns 🚨',
    description:
        'Someone from a risky hustle has returned with screenshots, names, and an unpaid demand.',
    minAge: 18,
    maxAge: 65,
    requiredFlags: ['risky_hustle_trouble'],
    minimumYearsAfterFlags: {'risky_hustle_trouble': 1},
    choices: [
      EventChoice(
        text: 'Pay and close the matter',
        statChanges: {'happiness': -4, 'discipline': 5},
        cashChange: -1500,
        flagToRemove: 'risky_hustle_trouble',
        outcome:
            'You paid, collected proof, and closed the chapter before it grew teeth.',
      ),
      EventChoice(
        text: 'Call their bluff',
        statChanges: {'streetSense': 6, 'reputation': -10},
        debtChange: 800,
        outcome: 'They did not disappear. The pressure became more expensive.',
      ),
    ],
  ),
  LifeEvent(
    id: 'relationship.exposure_aftermath.v1',
    category: 'relationship',
    chainId: 'betrayal_aftermath',
    title: 'The Betrayal Still Has a Voice 💔',
    description:
        'Long after the exposure, the story returns through family gossip and an unexpected message.',
    minAge: 20,
    maxAge: 70,
    requiredFlags: ['betrayal_exposed'],
    minimumYearsAfterFlags: {'betrayal_exposed': 1},
    choices: [
      EventChoice(
        text: 'Own the harm and apologise',
        statChanges: {'discipline': 8, 'reputation': 4, 'happiness': -2},
        flagToRemove: 'betrayal_exposed',
        outcome:
            'You apologised without excuses. Forgiveness was not guaranteed, but the truth stopped running.',
      ),
      EventChoice(
        text: 'Dismiss it as old news',
        statChanges: {'reputation': -8, 'happiness': -3},
        outcome: 'You dismissed it. Other people did not.',
      ),
    ],
  ),
  LifeEvent(
    id: 'business.family_investment.v1',
    category: 'business',
    chainId: 'business_family_investment',
    title: 'Family Money for the Business 🏪',
    description:
        'A relative offers capital for your business, but their idea of support includes opinions and access.',
    minAge: 21,
    maxAge: 65,
    requiresBusiness: true,
    choices: [
      EventChoice(
        text: 'Accept the family investment',
        statChanges: {'connections': 8, 'happiness': 2},
        cashChange: 2500,
        flagToAdd: 'family_business_investor',
        outcome:
            'The money arrived quickly. So did daily calls asking how “our business” was doing.',
      ),
      EventChoice(
        text: 'Keep ownership clear',
        statChanges: {'discipline': 8, 'connections': -3},
        outcome: 'You declined politely and kept the business entirely yours.',
      ),
    ],
  ),
  LifeEvent(
    id: 'business.family_investor_collects.v1',
    category: 'business',
    chainId: 'business_family_investment',
    title: 'The Family Investor Collects 📊',
    description:
        'Your relative now wants a return, a job for someone, and a say in every decision.',
    minAge: 23,
    maxAge: 75,
    requiresBusiness: true,
    requiredFlags: ['family_business_investor'],
    minimumYearsAfterFlags: {'family_business_investor': 2},
    choices: [
      EventChoice(
        text: 'Buy out their interest',
        statChanges: {'discipline': 6, 'connections': -2},
        cashChange: -3200,
        flagToRemove: 'family_business_investor',
        outcome:
            'You paid for clean ownership. Family gatherings became awkward but the books became simpler.',
      ),
      EventChoice(
        text: 'Give them influence',
        statChanges: {'connections': 8, 'discipline': -5},
        flagToAdd: 'family_runs_business',
        flagToRemove: 'family_business_investor',
        outcome:
            'The family gained influence. Decisions now move through a WhatsApp group.',
      ),
    ],
  ),
];
