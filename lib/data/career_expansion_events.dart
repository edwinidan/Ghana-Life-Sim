import '../models/event.dart';

/// Dedicated story depth for the Commerce and Sports & Media life paths.
final List<LifeEvent> careerExpansionEvents = [
  LifeEvent(
    id: 'career.commerce.target_pressure.v1',
    category: 'career',
    title: 'Quarter-End Target Pressure 📊',
    description:
        'Your team is behind target and your manager wants everyone to stay late for the final week.',
    minAge: 20,
    maxAge: 60,
    requiredCareer: 'Commerce',
    choices: [
      EventChoice(
        text: 'Lead the late-night push',
        statChanges: {'discipline': 8, 'reputation': 7, 'health': -4},
        outcome:
            'The team crossed the line. Management remembered who steadied the room.',
      ),
      EventChoice(
        text: 'Protect the team from burnout',
        statChanges: {'connections': 8, 'happiness': 5, 'reputation': -2},
        outcome:
            'The target slipped, but your colleagues trusted you far more afterwards.',
      ),
    ],
  ),
  LifeEvent(
    id: 'career.commerce.client_gift.v1',
    category: 'career',
    title: 'The Client’s “Small Gift” 🎁',
    description:
        'A supplier leaves an expensive phone on your desk just before contract renewal.',
    minAge: 22,
    maxAge: 60,
    requiredCareer: 'Commerce',
    choices: [
      EventChoice(
        text: 'Declare and return it',
        statChanges: {'reputation': 12, 'discipline': 8},
        outcome:
            'Compliance cleared you, and the story quietly improved your standing.',
      ),
      EventChoice(
        text: 'Keep it discreetly',
        statChanges: {'money': 6, 'discipline': -9, 'happiness': -3},
        outcome:
            'The phone was nice. Every compliance email afterwards felt personal.',
      ),
    ],
  ),
  LifeEvent(
    id: 'career.commerce_regional_transfer.v1',
    category: 'career',
    title: 'Regional Transfer Offer 🚌',
    description:
        'The company offers you a larger territory outside Accra and a difficult portfolio to repair.',
    minAge: 25,
    maxAge: 55,
    requiredCareer: 'Commerce',
    choices: [
      EventChoice(
        text: 'Take the challenge',
        statChanges: {'connections': 12, 'reputation': 8, 'happiness': -4},
        outcome:
            'The move was uncomfortable, but your professional network doubled.',
      ),
      EventChoice(
        text: 'Stay close to home',
        statChanges: {'happiness': 7, 'connections': -3},
        outcome:
            'You kept your support system and waited for a better-timed opening.',
      ),
    ],
  ),
  LifeEvent(
    id: 'career.commerce_currency_shock.v1',
    category: 'career',
    title: 'Currency Shock Hits the Budget 💱',
    description:
        'Imported inputs jump in price overnight and the annual budget no longer makes sense.',
    minAge: 24,
    maxAge: 60,
    requiredCareer: 'Commerce',
    choices: [
      EventChoice(
        text: 'Renegotiate every contract',
        statChanges: {'smarts': 8, 'streetSense': 8, 'reputation': 4},
        outcome:
            'Weeks of difficult calls saved the company from the worst of the shock.',
      ),
      EventChoice(
        text: 'Cut costs immediately',
        statChanges: {'discipline': 7, 'connections': -7, 'money': 4},
        outcome:
            'The numbers improved, but the teams carrying the cuts did not forget.',
      ),
    ],
  ),
  LifeEvent(
    id: 'career.commerce_board_presentation.v1',
    category: 'career',
    title: 'Your First Board Presentation 🏢',
    description:
        'You have ten minutes to defend a strategy in front of people who interrupt professionally.',
    minAge: 28,
    maxAge: 60,
    requiredCareer: 'Commerce',
    choices: [
      EventChoice(
        text: 'Lead with the hard numbers',
        statChanges: {'smarts': 7, 'reputation': 10},
        outcome: 'The questions were sharp, but your evidence was sharper.',
      ),
      EventChoice(
        text: 'Win the room with the story',
        statChanges: {'connections': 10, 'reputation': 6, 'discipline': -2},
        outcome:
            'They remembered the vision and approved a cautious first phase.',
      ),
    ],
  ),
  LifeEvent(
    id: 'career.sports_media_breakthrough.v1',
    category: 'career',
    title: 'The Breakthrough Fixture 🎙️',
    description:
        'A last-minute absence puts you on the biggest match or live broadcast of your career.',
    minAge: 18,
    maxAge: 45,
    requiredCareer: 'Sports & Media',
    choices: [
      EventChoice(
        text: 'Take the spotlight',
        statChanges: {'reputation': 13, 'health': -4, 'happiness': 8},
        outcome:
            'You delivered under pressure and woke up to a much larger audience.',
      ),
      EventChoice(
        text: 'Support from behind the scenes',
        statChanges: {'discipline': 8, 'connections': 7},
        outcome:
            'The show succeeded, and senior people noticed your reliability.',
      ),
    ],
  ),
  LifeEvent(
    id: 'career.sports_media_injury.v1',
    category: 'career',
    title: 'Injury Before Selection 🩹',
    description:
        'A painful knock arrives days before trials and the medical team advises patience.',
    minAge: 18,
    maxAge: 40,
    requiredCareer: 'Sports & Media',
    choices: [
      EventChoice(
        text: 'Rest and recover properly',
        statChanges: {'health': 5, 'discipline': 7, 'reputation': -3},
        outcome:
            'You missed the moment but returned without turning one injury into three.',
      ),
      EventChoice(
        text: 'Play through it',
        statChanges: {'reputation': 9, 'health': -13, 'happiness': 3},
        outcome:
            'The courage impressed people. Your body sent a much less positive review.',
      ),
    ],
  ),
  LifeEvent(
    id: 'career.sports_media_rights_dispute.v1',
    category: 'career',
    title: 'Image Rights Dispute 📸',
    description:
        'A brand uses your face in a campaign beyond the deal you signed.',
    minAge: 20,
    maxAge: 55,
    requiredCareer: 'Sports & Media',
    choices: [
      EventChoice(
        text: 'Challenge them formally',
        statChanges: {'reputation': 8, 'discipline': 7, 'connections': -3},
        outcome:
            'The settlement was fair and your next contract was much tighter.',
      ),
      EventChoice(
        text: 'Use the exposure',
        statChanges: {'connections': 10, 'money': -3, 'streetSense': 5},
        outcome:
            'You traded payment for reach and made sure the next campaign cost more.',
      ),
    ],
  ),
  LifeEvent(
    id: 'career.sports_media_false_story.v1',
    category: 'career',
    title: 'A False Story Trends 📱',
    description:
        'A gossip page posts a confident, detailed, and completely invented story about you.',
    minAge: 20,
    maxAge: 60,
    requiredCareer: 'Sports & Media',
    choices: [
      EventChoice(
        text: 'Correct it with receipts',
        statChanges: {'reputation': 9, 'streetSense': 5},
        outcome:
            'Your evidence travelled farther than the rumour and the page deleted quietly.',
      ),
      EventChoice(
        text: 'Ignore the noise',
        statChanges: {'discipline': 9, 'happiness': -4},
        outcome:
            'The cycle moved on. Silence protected your time, if not your mood.',
      ),
    ],
  ),
  LifeEvent(
    id: 'career.sports_media_mentorship.v1',
    category: 'career',
    title: 'A Talented Rookie Needs Help 🌟',
    description:
        'A young athlete or presenter asks you for honest guidance through the industry.',
    minAge: 28,
    maxAge: 65,
    requiredCareer: 'Sports & Media',
    choices: [
      EventChoice(
        text: 'Mentor them seriously',
        statChanges: {'reputation': 10, 'connections': 8, 'happiness': 5},
        outcome:
            'Their first major success felt unexpectedly like one of your own.',
      ),
      EventChoice(
        text: 'Offer one useful introduction',
        statChanges: {'connections': 5, 'discipline': 3},
        outcome:
            'You opened one door and left them responsible for walking through it.',
      ),
    ],
  ),
];
