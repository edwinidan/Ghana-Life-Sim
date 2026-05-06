import '../models/event.dart';

final List<LifeEvent> consequenceEvents = [
  LifeEvent(
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
    title: 'Family Brings Up Old Disappointment 🧾',
    description:
        'At a gathering, someone casually mentions the time you did not help the family. Somehow everyone suddenly remembers every detail.',
    minAge: 20,
    maxAge: 80,
    baseWeight: 12,
    requiredFlags: ['family_disappointed'],
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
];
