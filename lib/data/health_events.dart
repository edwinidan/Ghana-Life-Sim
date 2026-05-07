import '../models/event.dart';

final List<LifeEvent> healthEvents = [
  // ── ILLNESS EVENTS ───────────────────────────────────────────────────────

  LifeEvent(
    title: 'Malaria Season 🦟',
    description:
        'You woke up shaking like a phone on vibrate. Classic Ghana malaria season. The fever is high, the joints are screaming, and the mosquito net you ignored is hanging there judging you.',
    minAge: 5,
    maxAge: 90,
    choices: [
      EventChoice(
        text: 'Go to the hospital immediately',
        statChanges: {'health': 15, 'money': -5},
        outcome: 'The doctor gave you Artemether and a stern lecture. You recovered well.',
      ),
      EventChoice(
        text: 'Try local remedies — herbs and neem leaf steam',
        statChanges: {'health': 5, 'money': -2},
        outcome: 'The herbs helped a little. You survived but it took two weeks.',
      ),
      EventChoice(
        text: 'Sleep it off — malaria is part of life',
        statChanges: {'health': -15},
        outcome: 'You toughed it out but the malaria lingered. Your body paid the price.',
        illnessToAdd: 'Malaria',
      ),
    ],
  ),

  LifeEvent(
    title: 'Diabetes Diagnosis 🍬',
    description:
        'The doctor said your blood sugar is "aggressively Ghanaian". You need to cut the Milo, the kenkey with sugar, and the weekly jollof. Your pancreas has filed a formal complaint.',
    minAge: 35,
    maxAge: 90,
    choices: [
      EventChoice(
        text: 'Follow the treatment plan strictly',
        statChanges: {'health': 15, 'money': -5, 'happiness': -5},
        outcome: 'You changed your diet and started medication. The numbers improved.',
      ),
      EventChoice(
        text: 'Manage it with diet changes only — no drugs',
        statChanges: {'health': 5, 'money': -2},
        outcome: 'You cut back on sugar. Partial improvement. Your doctor is skeptical.',
      ),
      EventChoice(
        text: 'Ignore it — the ancestors did not have diabetes',
        statChanges: {'health': -15},
        outcome: 'You kept eating how you wanted. The condition worsened quietly.',
        illnessToAdd: 'Diabetes',
      ),
    ],
  ),

  LifeEvent(
    title: 'Heart Attack Scare 💔',
    description:
        'Your chest tightened at the office. Your body sent a very urgent memo. Your colleagues panicked. Someone called your name three times like they were casting out a demon.',
    minAge: 40,
    maxAge: 90,
    choices: [
      EventChoice(
        text: 'Rush to the hospital — no arguments',
        statChanges: {'health': 15, 'money': -5, 'happiness': -5},
        outcome: 'They ran every test. Mild cardiac event. You are on medication and lifestyle changes now.',
      ),
      EventChoice(
        text: 'Rest at home and take some aspirin',
        statChanges: {'health': 5, 'money': -2},
        outcome: 'You rested for a week. The pain subsided. Your heart is still on probation.',
      ),
      EventChoice(
        text: 'Walk it off — it was probably the jollof',
        statChanges: {'health': -15},
        outcome: 'You dismissed it. Your heart filed another complaint. Things got worse.',
        illnessToAdd: 'Heart Disease',
      ),
    ],
  ),

  LifeEvent(
    title: 'Stroke Warning Signs 🧠',
    description:
        'Your left arm went numb. Your speech slurred for a few minutes. Your family noticed before you did. The doctor called it a TIA — a warning stroke. Your brain is giving you one last chance.',
    minAge: 45,
    maxAge: 90,
    choices: [
      EventChoice(
        text: 'Get full neurological workup at the hospital',
        statChanges: {'health': 15, 'money': -5},
        outcome: 'They found a blood clot risk. You started blood thinners. Crisis averted for now.',
      ),
      EventChoice(
        text: 'Take the herbal tonic from the pharmacy',
        statChanges: {'health': 5, 'money': -2},
        outcome: 'Some improvement. The numbness went away but you still feel fragile.',
      ),
      EventChoice(
        text: 'It was stress — rest will fix it',
        statChanges: {'health': -15},
        outcome: 'You never got properly checked. The warning signs returned more aggressively.',
        illnessToAdd: 'Stroke Risk',
      ),
    ],
  ),

  LifeEvent(
    title: 'High Blood Pressure 🩺',
    description:
        'The nurse said your BP is 160/100. She looked at you the way people look at a car that is clearly not roadworthy. You have been eating too much salt, working too hard, and worrying about everything.',
    minAge: 30,
    maxAge: 90,
    choices: [
      EventChoice(
        text: 'Start medication and change your diet completely',
        statChanges: {'health': 15, 'money': -5},
        outcome: 'Three months later your BP is almost normal. The nurse is proud of you.',
      ),
      EventChoice(
        text: 'Reduce salt and try to stress less',
        statChanges: {'health': 5, 'money': -2},
        outcome: 'Some improvement. Your numbers are better but not great. Acceptable.',
      ),
      EventChoice(
        text: 'BP runs in the family — nothing to do',
        statChanges: {'health': -15},
        outcome: 'The pressure kept building. Headaches became constant. Things got complicated.',
        illnessToAdd: 'Hypertension',
      ),
    ],
  ),

  LifeEvent(
    title: 'Mental Health Crisis 🌧️',
    description:
        'You haven\'t been yourself lately. The pressure has been building for months. You stopped answering calls. The joy you used to feel about small things is gone. Your mind is heavy and you don\'t know how to explain it to anyone.',
    minAge: 18,
    maxAge: 90,
    choices: [
      EventChoice(
        text: 'Seek professional help — talk to a therapist',
        statChanges: {'health': 15, 'happiness': 15, 'money': -5},
        outcome: 'You started sessions. It was hard at first. Slowly, things got lighter.',
      ),
      EventChoice(
        text: 'Open up to a trusted friend or family member',
        statChanges: {'health': 5, 'happiness': 10, 'money': -2},
        outcome: 'Talking helped more than you expected. You are not carrying it alone anymore.',
      ),
      EventChoice(
        text: 'Push through — Ghanaians don\'t talk about this',
        statChanges: {'health': -15, 'happiness': -15},
        outcome: 'The weight got heavier. You kept functioning but something important dimmed inside.',
        illnessToAdd: 'Depression',
      ),
    ],
  ),

  LifeEvent(
    title: 'Typhoid Fever 🤒',
    description:
        'You ate something suspicious at a chop bar. Three days later you are flat on your back with a 39-degree fever and a stomach sending Morse code. The doctor suspects typhoid.',
    minAge: 10,
    maxAge: 90,
    choices: [
      EventChoice(
        text: 'Go to the hospital for a Widal test and treatment',
        statChanges: {'health': 15, 'money': -5},
        outcome: 'Confirmed typhoid. IV antibiotics, three days admission. You bounced back fully.',
      ),
      EventChoice(
        text: 'Buy antibiotics from the pharmacy and rest',
        statChanges: {'health': 5, 'money': -2},
        outcome: 'The antibiotics helped. You recovered slowly but avoided the hospital bill.',
      ),
      EventChoice(
        text: 'Drink lots of water and hope for the best',
        statChanges: {'health': -15},
        outcome: 'Two weeks of misery. You recovered but your body took a serious beating.',
        illnessToAdd: 'Typhoid',
      ),
    ],
  ),

  LifeEvent(
    title: 'Kidney Stones ⚡',
    description:
        'The pain hit you like a trotro running a red light. Lower back, radiating forward, absolute chaos. The doctor said kidney stones. You said you have never prayed so hard in your life.',
    minAge: 25,
    maxAge: 90,
    choices: [
      EventChoice(
        text: 'Hospital immediately — get proper imaging and treatment',
        statChanges: {'health': 15, 'money': -5},
        outcome: 'They managed it medically. You passed the stone and wanted to frame it.',
      ),
      EventChoice(
        text: 'Drink a lot of water and take painkillers',
        statChanges: {'health': 5, 'money': -2},
        outcome: 'Painful but it worked eventually. You now drink more water than you ever have.',
      ),
      EventChoice(
        text: 'Tough it out — pain is just weakness leaving the body',
        statChanges: {'health': -15},
        outcome: 'The stone did not pass easily. You developed a kidney infection on top of it.',
        illnessToAdd: 'Kidney Disease',
      ),
    ],
  ),

  LifeEvent(
    title: 'Chest Infection 😷',
    description:
        'The harmattan dust has been brutal this year. Your chest is tight, your cough sounds like a diesel generator, and you have been breathing like you owe someone money.',
    minAge: 5,
    maxAge: 90,
    choices: [
      EventChoice(
        text: 'See a doctor for proper diagnosis and medication',
        statChanges: {'health': 15, 'money': -5},
        outcome: 'Acute bronchitis. Antibiotics and rest. You recovered in a week.',
      ),
      EventChoice(
        text: 'Steam inhalation and local cough syrup',
        statChanges: {'health': 5, 'money': -2},
        outcome: 'The steam helped. It cleared after two weeks. Your lungs are grateful.',
      ),
      EventChoice(
        text: 'Keep going to work — resting is for the weak',
        statChanges: {'health': -15},
        outcome: 'The infection deepened into pneumonia. You finally rested — in a hospital bed.',
        illnessToAdd: 'Respiratory Illness',
      ),
    ],
  ),

  LifeEvent(
    title: 'Hernia Diagnosis 🏥',
    description:
        'Something has been bulging in your lower abdomen for months. You kept ignoring it. The doctor is now using words like "surgical repair" and "sooner rather than later". Your body has been sending invoices you have been refusing to open.',
    minAge: 20,
    maxAge: 90,
    choices: [
      EventChoice(
        text: 'Schedule the surgery right away',
        statChanges: {'health': 15, 'money': -5},
        outcome: 'Surgery went well. Six weeks recovery. You came back stronger.',
      ),
      EventChoice(
        text: 'Use a support belt and monitor it closely',
        statChanges: {'health': 5, 'money': -2},
        outcome: 'The belt helped manage it. The doctor is watching it carefully.',
      ),
      EventChoice(
        text: 'It doesn\'t hurt that much — surgery can wait',
        statChanges: {'health': -15},
        outcome: 'It got worse. The hernia strangulated. Emergency surgery ended up costing triple.',
        illnessToAdd: 'Hernia',
      ),
    ],
  ),

  // ── ACCIDENT EVENTS ──────────────────────────────────────────────────────

  LifeEvent(
    title: 'Trotro Accident 🚌💥',
    description:
        'The Accra-Kumasi road claimed another victim — almost you. The trotro driver was overtaking on a blind corner and clipped an oncoming lorry. Glass everywhere. The mate was still collecting fares when the car stopped spinning.',
    minAge: 16,
    maxAge: 90,
    choices: [
      EventChoice(
        text: 'Go straight to Komfo Anokye for proper treatment',
        statChanges: {'health': 10, 'money': -6},
        outcome: 'Three stitches and a fractured rib. You are alive and furious. The driver ran away.',
      ),
      EventChoice(
        text: 'Let someone bandage it at home and rest',
        statChanges: {'health': -10, 'money': -1},
        outcome: 'You managed at home but the wound got infected. Two weeks in bed.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Motorbike Collision 🏍️',
    description:
        'A motorbike knocked you at a junction in the rain. You both slid. You hit the gutter edge. The okada rider apologised profusely but had no insurance, no documents, and apparently no brakes.',
    minAge: 16,
    maxAge: 90,
    choices: [
      EventChoice(
        text: 'Get to the hospital for X-rays and proper dressing',
        statChanges: {'health': 10, 'money': -6},
        outcome: 'No broken bones, thankfully. Deep abrasions dressed properly. You heal clean.',
      ),
      EventChoice(
        text: 'Clean the cuts yourself and put some Robb on it',
        statChanges: {'health': -10, 'money': -1},
        outcome: 'The Robb did its best. The wounds took longer to heal than they should have.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Ladder Fall 🪜',
    description:
        'You fell off a ladder fixing something at home. You were on the fourth rung when the base slipped. You did not fly — you arrived at the ground faster than planned. Your ankle disagrees with the whole situation.',
    minAge: 16,
    maxAge: 90,
    choices: [
      EventChoice(
        text: 'Go to the hospital — get it properly assessed',
        statChanges: {'health': 10, 'money': -6},
        outcome: 'Sprained ankle, bruised pride. Doctor wrapped it and sent you home with crutches.',
      ),
      EventChoice(
        text: 'Ice it and wrap it yourself',
        statChanges: {'health': -10, 'money': -1},
        outcome: 'The ankle swelled badly. You limped for a month on what turned out to be a small fracture.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Fight Gone Too Far 👊',
    description:
        'What started as a verbal argument escalated rapidly. Someone threw a bottle. You got hit in the head. The whole neighbourhood witnessed it. Blood was involved. Dignity was also a casualty.',
    minAge: 16,
    maxAge: 90,
    choices: [
      EventChoice(
        text: 'Get to the hospital — head wounds are serious',
        statChanges: {'health': 10, 'money': -6, 'reputation': -5},
        outcome: 'Four stitches and a CT scan. No serious damage. The doctor asked how many you got.',
      ),
      EventChoice(
        text: 'Wash it up at home and act like nothing happened',
        statChanges: {'health': -10, 'money': -1, 'reputation': -10},
        outcome: 'The cut closed but slowly. Your head ached for weeks. The story spread anyway.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Workplace Accident ⚠️',
    description:
        'Something went wrong at work. Equipment, a fall, a colleague\'s mistake — it doesn\'t matter now. What matters is that you are sitting here injured, and HR is already asking questions.',
    minAge: 18,
    maxAge: 90,
    choices: [
      EventChoice(
        text: 'Insist on proper medical treatment and document everything',
        statChanges: {'health': 10, 'money': -6},
        outcome: 'You were treated and filed an incident report. The company paid the bill. Mostly.',
      ),
      EventChoice(
        text: 'Shake it off — complaining might cost you the job',
        statChanges: {'health': -10, 'money': -1},
        outcome: 'You powered through. The injury never healed properly. Your body kept score.',
      ),
    ],
  ),
];
