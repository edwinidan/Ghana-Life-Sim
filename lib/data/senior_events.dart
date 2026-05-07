import '../models/event.dart';

final List<LifeEvent> seniorEvents = [
  // DAILY LIFE IN OLD AGE (8)
  LifeEvent(
    title: 'The Staircase Challenge 🧗🏾‍♂️',
    description: 'You went to visit a friend, but they live on the 3rd floor of an apartment without an elevator.',
    minAge: 65,
    maxAge: 90,
    choices: [
      EventChoice(
        text: 'Climb it slowly and steadily',
        statChanges: {'health': -5, 'discipline': 10, 'reputation': 5},
        outcome: 'You made it up! You spent the next twenty minutes breathing like a marathon runner.',
      ),
      EventChoice(
        text: 'Call them to come down',
        statChanges: {'smarts': 8, 'health': 5, 'happiness': 2},
        outcome: 'They came down to the car. No pride was lost, and your knees are entirely grateful.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Where Are My Glasses? 👓',
    description: 'You have been searching for your reading glasses for thirty minutes. The whole house is helping.',
    minAge: 65,
    maxAge: 90,
    choices: [
      EventChoice(
        text: 'Keep shouting at everyone to look properly',
        statChanges: {'happiness': -5, 'connections': -5, 'reputation': -2},
        outcome: 'Your grandchild finally pointed out that they were completely resting on your head.',
      ),
      EventChoice(
        text: 'Sit down and try to remember calmly',
        statChanges: {'smarts': 5, 'discipline': 8, 'health': 2},
        outcome: 'You closed your eyes and remembered leaving them in the fridge next to the fruit juice.',
      ),
    ],
  ),
  LifeEvent(
    title: 'New Technology 📱',
    description: 'Your children bought you a new tablet. You cannot figure out how to make a WhatsApp video call.',
    minAge: 65,
    maxAge: 90,
    choices: [
      EventChoice(
        text: 'Ask the 10-year-old grandchild to teach you',
        statChanges: {'smarts': 8, 'connections': 10, 'happiness': 10},
        outcome: 'They taught you patiently. Now you continuously call your children at 6 AM just to show them your ceiling.',
      ),
      EventChoice(
        text: 'Return to your reliable "Yam" phone',
        statChanges: {'streetSense': 5, 'happiness': 5, 'smarts': -5},
        outcome: 'You put the tablet in a drawer. The old Nokia keypad never fails you.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Morning Walk 🌅',
    description: 'You woke up at 5:30 AM. The air is crisp and the neighborhood is quiet.',
    minAge: 65,
    maxAge: 85,
    choices: [
      EventChoice(
        text: 'Take a brisk walk around the block',
        statChanges: {'health': 12, 'happiness': 10, 'discipline': 8},
        outcome: 'You walked for thirty minutes. You feel strong, vibrant, and alive.',
      ),
      EventChoice(
        text: 'Stay in bed listening to the morning radio',
        statChanges: {'happiness': 8, 'health': -2, 'smarts': 5},
        outcome: 'You listened to political talk shows and drank tea. A perfect, peaceful morning.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Driving Debate 🚗',
    description: 'Your reflexes are slowing down. Your children suggest you stop driving and use an Uber or a driver.',
    minAge: 70,
    maxAge: 90,
    choices: [
      EventChoice(
        text: 'Hand over the keys gracefully',
        statChanges: {'health': 10, 'smarts': 10, 'happiness': -10},
        outcome: 'You surrendered your independence. It hurts, but you know it is the safest decision.',
      ),
      EventChoice(
        text: 'Resist and keep driving stubbornly',
        statChanges: {'discipline': -10, 'streetSense': -5, 'reputation': -5},
        outcome: 'You scraped the gate reversing. They forcefully took the car keys away that same evening.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Sunday Afternoon Visitors 👨‍👩‍👧',
    description: 'Three of your adult children arrived unannounced with all your grandchildren. The house is chaotic.',
    minAge: 65,
    maxAge: 90,
    choices: [
      EventChoice(
        text: 'Rejoice and host them energetically',
        statChanges: {'happiness': 15, 'connections': 15, 'health': -5},
        outcome: 'You cooked, carried babies, and laughed. You had to sleep for two straight days afterward.',
      ),
      EventChoice(
        text: 'Sit quietly in your chair and watch',
        statChanges: {'health': 5, 'happiness': 10, 'discipline': 8},
        outcome: 'You watched your legacy interact. It felt like watching a beautiful, chaotic movie you directed.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Garden Hobby 🪴',
    description: 'You suddenly have a massive desire to grow plantains and tomatoes in the backyard.',
    minAge: 65,
    maxAge: 85,
    choices: [
      EventChoice(
        text: 'Throw yourself into gardening',
        statChanges: {'health': 10, 'happiness': 12, 'money': 5},
        outcome: 'Three months later, you harvested your own plantains. The joy was absolutely unmatched.',
      ),
      EventChoice(
        text: 'Pay a laborer to do it',
        statChanges: {'money': -5, 'health': -2, 'discipline': -5},
        outcome: 'You became a supervisor. The crops grew, but you missed out on the actual therapeutic work.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Random Aches 🩺',
    description: 'You woke up and your shoulder hurts. You did nothing to injure it; you just slept on it wrong.',
    minAge: 65,
    maxAge: 85,
    choices: [
      EventChoice(
        text: 'Apply Aboliki ointment and endure',
        statChanges: {'health': 5, 'discipline': 8, 'streetSense': 5},
        outcome: 'You smell of strong menthol. The pain subsided gradually over three days.',
      ),
      EventChoice(
        text: 'Demand a full hospital scan',
        statChanges: {'money': -10, 'health': 2, 'smarts': 5},
        outcome: ' The doctor essentially told you that you are just old. You paid 500 GHS for that information.',
      ),
    ],
  ),

  // HEALTH AND DECLINE (8)
  LifeEvent(
    title: 'The Hospital Admission 🏥',
    description: 'A bad bout of malaria and fatigue required you to be admitted to the ward for three days.',
    minAge: 68,
    maxAge: 90,
    choices: [
      EventChoice(
        text: 'Rest fully and let the nurses work',
        statChanges: {'health': 15, 'discipline': 10, 'happiness': -5},
        outcome: 'You recovered wonderfully. Your body just needed absolute, enforced rest.',
      ),
      EventChoice(
        text: 'Complain about the food and try to leave',
        statChanges: {'health': -8, 'reputation': -5, 'discipline': -10},
        outcome: 'You stressed the nurses and your family out. Recovery took much longer than expected.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Caregiver Debate 🧑🏾‍⚕️',
    description: 'Your children are meeting to discuss hiring a live-in nurse for you because you fell recently.',
    minAge: 75,
    maxAge: 90,
    choices: [
      EventChoice(
        text: 'Accept the help gratefully',
        statChanges: {'health': 15, 'happiness': 5, 'connections': 10},
        outcome: 'The nurse is incredibly kind. You feel safer, and your children finally stopped worrying.',
      ),
      EventChoice(
        text: 'Refuse stubbornly. "I am not disabled!"',
        statChanges: {'reputation': 5, 'health': -15, 'connections': -10},
        outcome: 'You chased the nurse away. Two weeks later you fell again, terrifying everyone.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Hospital vs Herbal 🌿',
    description: 'Your diabetes medication makes you dizzy. A friend recommends a powerful bitter root from the village.',
    minAge: 65,
    maxAge: 85,
    choices: [
      EventChoice(
        text: 'Stick strictly to the doctor\'s drugs',
        statChanges: {'health': 10, 'smarts': 10, 'discipline': 12},
        outcome: 'Your doctor adjusted the dosage. The dizziness vanished and your sugars are stable.',
      ),
      EventChoice(
        text: 'Drink the bitter root heavily',
        statChanges: {'health': -15, 'streetSense': -5, 'smarts': -10},
        outcome: 'Your kidneys went into distress. You ended up in an emergency room.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The False Alarm 🚨',
    description: 'You felt a sharp pain in your chest. You thought it was the end and called everyone.',
    minAge: 65,
    maxAge: 90,
    choices: [
      EventChoice(
        text: 'Go to the ER via ambulance',
        statChanges: {'health': 5, 'money': -10, 'reputation': -5},
        outcome: 'It was severe heartburn/acid reflux. You feel relieved, but slightly embarrassed.',
      ),
      EventChoice(
        text: 'Sit down, drink water, and observe',
        statChanges: {'discipline': 8, 'smarts': 5, 'health': -2},
        outcome: 'You burped massively after drinking water. The "heart attack" completely disappeared.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Fading Hearing 👂',
    description: 'You realize people are mumbling a lot lately. You actually need a hearing aid.',
    minAge: 70,
    maxAge: 90,
    choices: [
      EventChoice(
        text: 'Get the hearing aid fitted',
        statChanges: {'health': 10, 'money': -8, 'happiness': 10},
        outcome: 'You can hear the birds singing again! And your loud neighbors, unfortunately.',
      ),
      EventChoice(
        text: 'Just smile and nod at what people say',
        statChanges: {'streetSense': 8, 'connections': -5, 'happiness': -2},
        outcome: 'You agreed to things you didn\'t hear. You accidentally consented to hosting Christmas.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Dietary Restrictions 🍚',
    description: 'The doctor banned you from eating salt, sugar, and red meat permanently.',
    minAge: 65,
    maxAge: 90,
    choices: [
      EventChoice(
        text: 'Follow the bland diet religiously',
        statChanges: {'health': 15, 'discipline': 15, 'happiness': -10},
        outcome: 'Your food tastes like wet cardboard, but your vitals are like a 30-year-old\'s.',
      ),
      EventChoice(
        text: 'Cheat on the weekend cautiously',
        statChanges: {'happiness': 10, 'health': -5, 'streetSense': 5},
        outcome: 'That Sunday waakye with salted beef gave you immeasurable joy. Worth the small risk.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Walking Stick 🦯',
    description: 'Your knees are failing. A beautiful, carved wooden walking stick was gifted to you.',
    minAge: 70,
    maxAge: 90,
    choices: [
      EventChoice(
        text: 'Use it proudly like a chief',
        statChanges: {'reputation': 15, 'health': 10, 'looks': 5},
        outcome: 'You walk with immense authority. It supports your weight and makes you look incredibly wise.',
      ),
      EventChoice(
        text: 'Hide it out of vanity',
        statChanges: {'looks': -5, 'health': -10, 'discipline': -5},
        outcome: 'You struggled to walk without it and eventually tripped. Pride goes before a fall.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Memory Lane 🧠',
    description: 'You clearly remember an event from 1982, but you forgot what you ate for breakfast today.',
    minAge: 75,
    maxAge: 90,
    choices: [
      EventChoice(
        text: 'Start writing your memoirs',
        statChanges: {'smarts': 10, 'happiness': 12, 'reputation': 5},
        outcome: 'You documented your vivid past. Your family treasures the written history immensely.',
      ),
      EventChoice(
        text: 'Joke about your fading memory',
        statChanges: {'happiness': 8, 'connections': 5, 'streetSense': 5},
        outcome: 'You used humor to cope. As long as you remember your children, the rest is details.',
      ),
    ],
  ),

  // RELATIONSHIPS AND FAMILY (7)
  LifeEvent(
    title: 'Golden Anniversary 🥂',
    description: 'You and your spouse have made it to 40/50 years of marriage. It is a massive milestone.',
    minAge: 65,
    maxAge: 85,
    choices: [
      EventChoice(
        text: 'Throw a thanksgiving service',
        statChanges: {'connections': 15, 'reputation': 15, 'happiness': 15},
        outcome: 'The church celebrated you. You renewed your vows and cried beautiful tears of joy.',
      ),
      EventChoice(
        text: 'A quiet dinner just the two of you',
        statChanges: {'happiness': 12, 'connections': 5, 'money': 5},
        outcome: 'You held hands and remembered the journey. Peaceful, intimate, and perfect.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Losing a Spouse 🕊️',
    description: 'The hardest moment of your life. Your partner of decades has passed away.',
    minAge: 65,
    maxAge: 90,
    choices: [
      EventChoice(
        text: 'Lean heavily on your children and faith',
        statChanges: {'health': -10, 'happiness': -15, 'connections': 12},
        outcome: 'The grief is a physical weight, but your family surrounded you with love to keep you going.',
      ),
      EventChoice(
        text: 'Shut down and isolate yourself',
        statChanges: {'health': -15, 'happiness': -20, 'connections': -15},
        outcome: 'You locked yourself in the house. The depression accelerated your own physical decline.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Prodigal Returns 🚪',
    description: 'The child or sibling you haven\'t spoken to in 15 years shows up unannounced to see you.',
    minAge: 65,
    maxAge: 90,
    choices: [
      EventChoice(
        text: 'Forgive them completely and embrace',
        statChanges: {'happiness': 15, 'connections': 15, 'health': 5},
        outcome: 'You let go of the grudge. The reunion lifted a massive spiritual weight off your chest.',
      ),
      EventChoice(
        text: 'Demand an apology before entering',
        statChanges: {'discipline': 10, 'reputation': 5, 'happiness': -5},
        outcome: 'They apologized weeping. You maintained your standard, but the reconciliation still happened.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Storyteller 🗣️',
    description: 'Your teenage grandchild sits at your feet and asks: "Grandpa/Grandma, what was life like when you were young?"',
    minAge: 65,
    maxAge: 90,
    choices: [
      EventChoice(
        text: 'Tell them amazing true stories',
        statChanges: {'connections': 15, 'happiness': 12, 'reputation': 8},
        outcome: 'You regaled them with stories of Ghana in the 70s. You became their absolute hero.',
      ),
      EventChoice(
        text: 'Tell them exaggerated lies to sound cool',
        statChanges: {'streetSense': 10, 'happiness': 8, 'reputation': 5},
        outcome: 'You told them you used to walk 40 miles to school barefoot fighting leopards. They actually believed it.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Old Friends Passing ⚰️',
    description: 'You received news that the last remaining friend from your youth has passed away.',
    minAge: 75,
    maxAge: 90,
    choices: [
      EventChoice(
        text: 'Attend the funeral despite mobility issues',
        statChanges: {'health': -8, 'reputation': 10, 'connections': 5},
        outcome: 'You paid your final respects. It was exhausting, but you honored a lifetime of friendship.',
      ),
      EventChoice(
        text: 'Send a tribute and stay home',
        statChanges: {'health': 5, 'happiness': -5, 'discipline': 5},
        outcome: 'Your children read your tribute. You mourned safely in your armchair.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Scammer Call 📞',
    description: 'Someone called claiming your grandson is in police custody and needs 5,000 GHS sent to mobile money immediately.',
    minAge: 65,
    maxAge: 90,
    choices: [
      EventChoice(
        text: 'Panic and send the money',
        statChanges: {'health': -10, 'money': -15, 'smarts': -10},
        outcome: 'Your heart raced as you sent it. Later, your grandson walked in eating an apple. Scammed.',
      ),
      EventChoice(
        text: 'Call your grandson directly to verify',
        statChanges: {'smarts': 15, 'discipline': 10, 'streetSense': 15},
        outcome: 'Your grandson answered immediately. You insulted the scammer fluently in your local dialect and hung up.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Unsolicited Caregiver 🧑🏾‍🦱',
    description: 'A distant relative sends their teenage child to "live with you and help around the house".',
    minAge: 65,
    maxAge: 85,
    choices: [
      EventChoice(
        text: 'Accept the help',
        statChanges: {'connections': 8, 'health': 5, 'money': -5},
        outcome: 'The teenager actually helps a lot with errands, though they eat an incredible amount of food.',
      ),
      EventChoice(
        text: 'Send them straight back',
        statChanges: {'discipline': 8, 'streetSense': 5, 'connections': -8},
        outcome: 'You want peace, not a teenager playing loud TikToks all day. Your relative was offended.',
      ),
    ],
  ),

  // LEGACY AND FINAL DECISIONS (7)
  LifeEvent(
    title: 'The Inheritance Talk 📜',
    description: 'You gather all your children to officially show them your Will and property documents.',
    minAge: 70,
    maxAge: 90,
    choices: [
      EventChoice(
        text: 'Maintain firm authority',
        statChanges: {'discipline': 15, 'reputation': 10, 'connections': 5},
        outcome: 'You stopped any arguments before they started. The boundaries are clear. Complete peace.',
      ),
      EventChoice(
        text: 'Ask them what they want',
        statChanges: {'smarts': -10, 'connections': -5, 'happiness': -10},
        outcome: 'A massive argument erupted in the living room over the house. Total chaos.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Passing Down Heirlooms 💍',
    description: 'You decide it is time to give away your precious kente clothes, jewelry, and watches.',
    minAge: 75,
    maxAge: 90,
    choices: [
      EventChoice(
        text: 'Give them to those who will appreciate them',
        statChanges: {'connections': 12, 'happiness': 10, 'reputation': 8},
        outcome: 'You saw their eyes light up receiving the family treasures. A beautiful transfer of legacy.',
      ),
      EventChoice(
        text: 'Sell them and enjoy the cash',
        statChanges: {'money': 15, 'streetSense': 10, 'reputation': -10},
        outcome: 'You liquidated your antiques and bought expensive vitamins. Your children were horrified.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Dark Secret 🤫',
    description: 'You hold a major family secret from 30 years ago. Do you take it to the grave?',
    minAge: 75,
    maxAge: 90,
    choices: [
      EventChoice(
        text: 'Take it to the grave',
        statChanges: {'discipline': 15, 'streetSense': 10, 'connections': 5},
        outcome: 'Some things are better left buried. You protected the family\'s peace permanently.',
      ),
      EventChoice(
        text: 'Confess to your eldest child',
        statChanges: {'happiness': 5, 'reputation': -15, 'connections': -10},
        outcome: 'You unburdened your conscience, but traumatized your child forever. Selfish, but freeing.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Final Pilgrimage / Trip ✈️',
    description: 'You want to make one last major trip to your hometown (or Mecca/Jerusalem) while you still can.',
    minAge: 65,
    maxAge: 85,
    choices: [
      EventChoice(
        text: 'Defy doctor\'s orders and travel',
        statChanges: {'health': -15, 'happiness': 20, 'reputation': 10},
        outcome: 'You made the journey! You returned completely exhausted and bedridden, but with profound spiritual peace.',
      ),
      EventChoice(
        text: 'Stay home and do it virtually via video',
        statChanges: {'health': 8, 'discipline': 5, 'happiness': -5},
        outcome: 'You stayed alive safely. Your family recorded the village for you. It wasn\'t the same, but you are alive.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Bedridden Season 🛏️',
    description: 'Your health has finally forced you to stay in bed permanently. Your world has shrunk to one room.',
    minAge: 80,
    maxAge: 90,
    choices: [
      EventChoice(
        text: 'Accept it with graceful prayers',
        statChanges: {'happiness': 10, 'connections': 10, 'reputation': 10},
        outcome: 'You became a fountain of peace. Visiting you felt like visiting a holy sanctuary.',
      ),
      EventChoice(
        text: 'Become bitter and difficult',
        statChanges: {'happiness': -15, 'connections': -15, 'health': -5},
        outcome: 'You cursed your failing body and shouted at caretakers. People visited only out of obligation.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Last Words 🗣️',
    description: 'You feel your strength fading significantly. The family is gathered at your bedside.',
    minAge: 80,
    maxAge: 90,
    choices: [
      EventChoice(
        text: 'Give them your final blessing',
        statChanges: {'connections': 15, 'happiness': 15, 'reputation': 15},
        outcome: 'You placed your hand on them and spoke peace, unity, and love. Your final act was deeply beautiful.',
      ),
      EventChoice(
        text: 'Issue a strict final warning',
        statChanges: {'discipline': 15, 'streetSense': 10, 'reputation': 5},
        outcome: 'You warned them not to sell the family house under penalty of ancestral curses. They trembled and agreed.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Final Twilight 🌅',
    description: 'The pain is gone. The room is quiet. A profound sense of peace washes over you. It is time.',
    minAge: 65,
    maxAge: 90,
    choices: [
      EventChoice(
        text: 'Close your eyes and let go',
        statChanges: {'happiness': 15, 'health': 0}, // Health 0 signifies the end logic handled elsewhere
        outcome: 'You smiled softly. You lived a full, incredible Ghanaian life. The ancestors are waiting. You rest peacefully.',
      ),
    ],
  ),
];
