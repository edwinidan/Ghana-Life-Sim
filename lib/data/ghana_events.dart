import '../models/event.dart';

final List<LifeEvent> ghanaEvents = [
  // EXISTING (2)
  LifeEvent(
    title: 'Dumsor Strikes 🕯️',
    description:
        'You are watching the climax of a huge football match. Suddenly, total darkness. ECG has struck.',
    minAge: 10,
    maxAge: 60,
    choices: [
      EventChoice(
        text: 'Curse ECG loudly in the darkness',
        statChanges: {'happiness': -5, 'streetSense': 5},
        outcome:
            'You shouted into the void with the rest of your neighborhood. Nothing changed, but it felt good.',
      ),
      EventChoice(
        text: 'Quickly find the radio to listen',
        statChanges: {'smarts': 5, 'discipline': 5},
        outcome:
            'You caught the last minute on joy FM. You survived the darkness with information.',
      ),
    ],
  ),
  LifeEvent(
    title: 'MoMo Mistake 💸',
    description:
        'You accidentally sent 500 cedis to the wrong mobile money number.',
    minAge: 16,
    maxAge: 60,
    choices: [
      EventChoice(
        text: 'Call them aggressively to reverse it',
        statChanges: {'streetSense': -5, 'money': -10},
        outcome:
            'They insulted you, switched off the phone, and vanished. The money is gone.',
      ),
      EventChoice(
        text: 'Call MTN Customer Service immediately',
        statChanges: {'smarts': 10, 'discipline': 5, 'happiness': 2},
        outcome:
            'After waiting on hold for 30 minutes listening to the jingle, they reversed the transaction!',
      ),
    ],
  ),

  // DUMSOR AND UTILITIES (3)
  LifeEvent(
    title: 'ECG Bill Shock 🧾',
    description: 'The ECG meter reader left a bill for the month. It is three times your usual amount.',
    minAge: 20,
    maxAge: 60,
    choices: [
      EventChoice(
        text: 'Go to the ECG office to fight them',
        statChanges: {'discipline': 8, 'reputation': 5, 'happiness': -5},
        outcome: 'You queued for three hours to complain. They checked the meter and admitted an error.',
      ),
      EventChoice(
        text: 'Just pay it to avoid disconnection',
        statChanges: {'money': -12, 'health': 2, 'discipline': -5},
        outcome: 'You paid the ridiculous bill. The pain in your wallet will last all month.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Generator Fuel ⛽',
    description: 'Dumsor hits at 1 AM. Your generator is out of fuel, and the mosquitoes are waiting.',
    minAge: 20,
    maxAge: 60,
    choices: [
      EventChoice(
        text: 'Open the windows and hope for breeze',
        statChanges: {'health': -8, 'happiness': -10, 'discipline': 5},
        outcome: 'You were eaten alive by mosquitoes. You woke up tired and covered in bites.',
      ),
      EventChoice(
        text: 'Drive to the 24-hour filling station',
        statChanges: {'money': -8, 'streetSense': 8, 'health': 5},
        outcome: 'You navigated dangerous dark roads for fuel, but slept in blissful AC.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Ghana Water Fails 🪣',
    description: 'Water has not flowed through the taps for five straight days. Your poly tank is completely empty.',
    minAge: 18,
    maxAge: 60,
    choices: [
      EventChoice(
        text: 'Pay a high price for a private tanker',
        statChanges: {'money': -15, 'health': 10, 'reputation': 5},
        outcome: 'The tanker poured muddy water into your tank, but at least you can flush the toilet.',
      ),
      EventChoice(
        text: 'Fetch "Kufuor Gallon" from the neighborhood well',
        statChanges: {'health': -5, 'discipline': 15, 'money': 5},
        outcome: 'You carried yellow gallons on your head like old times. Your neck hurts, but you survived.',
      ),
    ],
  ),

  // MOBILE MONEY AND DIGITAL LIFE (4)
  LifeEvent(
    title: 'Suspect MoMo Agent 🧢',
    description: 'You want to withdraw cash. The MoMo agent says "the network is slow" and stares at your phone screen repeatedly.',
    minAge: 16,
    maxAge: 50,
    choices: [
      EventChoice(
        text: 'Cancel the transaction immediately',
        statChanges: {'streetSense': 15, 'reputation': -2, 'smarts': 10},
        outcome: 'You walked away. You probably just saved your account from a clever scammer.',
      ),
      EventChoice(
        text: 'Let them hold your phone to "try again"',
        statChanges: {'money': -15, 'smarts': -15, 'happiness': -15},
        outcome: 'They memorized your PIN. You woke up the next day with 0.00 GHS in your account.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Network Palava 📶',
    description: 'You are submitting a crucial deadline document. The internet data suddenly finishes at 99% upload.',
    minAge: 16,
    maxAge: 50,
    choices: [
      EventChoice(
        text: 'Rush to buy scratch cards from the street',
        statChanges: {'streetSense': 8, 'discipline': 5, 'money': -5},
        outcome: 'You bought credit, loaded it with sweat pouring down your face, and hit send just in time.',
      ),
      EventChoice(
        text: 'Borrow data from the network',
        statChanges: {'smarts': 5, 'money': -8, 'connections': -2},
        outcome: 'The emergency data worked, but the network charged you 20% interest on it tomorrow.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Tech Support Child 📱',
    description: 'Your auntie in the village calls you for the fourth time this week asking how to send a WhatsApp voice note.',
    minAge: 16,
    maxAge: 40,
    choices: [
      EventChoice(
        text: 'Explain it patiently again',
        statChanges: {'discipline': 10, 'connections': 10, 'happiness': -5},
        outcome: 'You spent thirty painful minutes guiding her. She finally sent a 10-minute voice note of herself singing.',
      ),
      EventChoice(
        text: 'Tell her your battery is dying',
        statChanges: {'streetSense': 8, 'connections': -5, 'reputation': -5},
        outcome: 'You escaped the call. She complained to your mother that you are becoming arrogant.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Unsolicited Video Call 📹',
    description: 'A relative from abroad video calls you randomly while you are wearing an old torn shirt in your messy room.',
    minAge: 18,
    maxAge: 50,
    choices: [
      EventChoice(
        text: 'Decline and reply "I\'m busy"',
        statChanges: {'discipline': 5, 'reputation': 5, 'connections': -5},
        outcome: 'You saved your dignity. They assumed you were at an important business meeting.',
      ),
      EventChoice(
        text: 'Pick it up and angle the camera to the ceiling',
        statChanges: {'streetSense': 10, 'smarts': 5, 'looks': -5},
        outcome: 'They talked to your ceiling fan for twenty minutes. They think you live quite well.',
      ),
    ],
  ),

  // FUNERALS AND OUTDOORINGS (4)
  LifeEvent(
    title: 'Unexpected Duties 🕊️',
    description: 'You arrive at a family funeral and the elders point at you to serve drinks to 100 people.',
    minAge: 18,
    maxAge: 50,
    choices: [
      EventChoice(
        text: 'Serve humbly and respect tradition',
        statChanges: {'reputation': 15, 'discipline': 10, 'connections': 10},
        outcome: 'You carried the Fanta and Coke trays gracefully. The elders noted your extreme humility.',
      ),
      EventChoice(
        text: 'Pretend you have a stomach ache and hide',
        statChanges: {'streetSense': 10, 'reputation': -10, 'connections': -8},
        outcome: 'You hid in your car with the AC on. The family gossiped about your laziness.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Party Funeral 🎊',
    description: 'It is a funeral, but the DJ is playing current hit songs and people are dancing aggressively.',
    minAge: 18,
    maxAge: 60,
    choices: [
      EventChoice(
        text: 'Join the dance floor energetically',
        statChanges: {'happiness': 15, 'reputation': -5, 'streetSense': 10},
        outcome: 'You danced away the sorrow! The older folks judged you, but the youth loved the energy.',
      ),
      EventChoice(
        text: 'Shake your head and sit solemnly',
        statChanges: {'discipline': 10, 'reputation': 10, 'happiness': -5},
        outcome: 'You maintained proper decorum. You looked heavily dignified among the chaos.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Outdooring Pressure 👶',
    description: 'You are invited to a baby outdooring. The MC is loudly announcing everyone\'s financial gift.',
    minAge: 20,
    maxAge: 60,
    choices: [
      EventChoice(
        text: 'Give a massive amount to show off',
        statChanges: {'money': -15, 'reputation': 15, 'connections': 10},
        outcome: 'The MC shouted your name with a microphone echo. You are broke, but legendary.',
      ),
      EventChoice(
        text: 'Drop a small envelope quietly and leave',
        statChanges: {'money': 5, 'streetSense': 8, 'reputation': -8},
        outcome: 'You avoided the financial trap. The MC called you "the quiet one".',
      ),
    ],
  ),
  LifeEvent(
    title: 'Public Funeral Contribution 🗣️',
    description: 'The chief mourner reads the donation list. Your business rival just donated double your amount.',
    minAge: 25,
    maxAge: 60,
    choices: [
      EventChoice(
        text: 'Go back and top up your donation loudly',
        statChanges: {'money': -15, 'reputation': 12, 'smarts': -10},
        outcome: 'You reclaimed your throne of prestige. Your savings account is critically injured.',
      ),
      EventChoice(
        text: 'Ignore it and eat your Jollof',
        statChanges: {'discipline': 15, 'money': 5, 'happiness': 5},
        outcome: 'You ate your food while they wasted their money on ego. Maximum maturity.',
      ),
    ],
  ),

  // FOOD CULTURE (5)
  LifeEvent(
    title: 'The Jollof War 🇬🇭🇳🇬',
    description: 'A Nigerian friend confidently states that Nigerian Jollof is better at a dinner table.',
    minAge: 15,
    maxAge: 50,
    choices: [
      EventChoice(
        text: 'Defend Ghana Jollof with historical facts',
        statChanges: {'reputation': 10, 'smarts': 10, 'connections': 5},
        outcome: 'You eloquently destroyed their argument. The table cheered for the Motherland.',
      ),
      EventChoice(
        text: 'Flip the table (metaphorically) in anger',
        statChanges: {'happiness': -5, 'streetSense': -5, 'reputation': -8},
        outcome: 'You got wildly defensive. They laughed at your lack of chill.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Polite Eating 🍲',
    description: 'You visit an auntie. She forces a massive bowl of heavily salted fufu on you. You just ate at home.',
    minAge: 12,
    maxAge: 40,
    choices: [
      EventChoice(
        text: 'Force yourself to eat it all',
        statChanges: {'connections': 15, 'health': -10, 'happiness': -8},
        outcome: 'You suffered through the sodium poisoning. She now thinks you are her favorite relative.',
      ),
      EventChoice(
        text: 'Refuse politely saying you are full',
        statChanges: {'health': 5, 'connections': -15, 'reputation': -5},
        outcome: 'She took the bowl away muttering about how children these days disrespect food.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Waakye Line 🍛',
    description: 'Your favorite Waakye seller has a line of 30 people waiting under the hot sun.',
    minAge: 15,
    maxAge: 45,
    choices: [
      EventChoice(
        text: 'Join the queue strictly',
        statChanges: {'discipline': 15, 'health': -5, 'happiness': -5},
        outcome: 'You waited an hour in the heat. The waakye tasted heavenly, but your shoes are dusty.',
      ),
      EventChoice(
        text: 'Bribe a street boy to queue for you',
        statChanges: {'money': -5, 'streetSense': 15, 'happiness': 10},
        outcome: 'Peak efficiency! The boy got your food fast. Time is money.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Stolen Kontomire 🥬',
    description: 'You left the remaining delicious kontomire stew in the fridge. Returning later, the bowl is washed clean.',
    minAge: 10,
    maxAge: 35,
    choices: [
      EventChoice(
        text: 'Interrogate the entire household loudly',
        statChanges: {'reputation': -5, 'discipline': 5, 'happiness': -10},
        outcome: 'Nobody confessed. You remained incredibly angry and hungry the whole night.',
      ),
      EventChoice(
        text: 'Let it go and fry some eggs',
        statChanges: {'happiness': 5, 'health': 5, 'smarts': 5},
        outcome: 'You chose peace. The eggs were good, but the kontomire betrayal will not be forgotten.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The VIP Order 🍱',
    description: 'You walk into the chop bar and the lady immediately starts dishing out "Fufu with goat and extra soup". She knows you too well.',
    minAge: 18,
    maxAge: 60,
    choices: [
      EventChoice(
        text: 'Smile proudly as a VIP',
        statChanges: {'reputation': 10, 'happiness': 12, 'connections': 10},
        outcome: 'You are officially a chop bar legend. They even gave you an extra piece of meat.',
      ),
      EventChoice(
        text: 'Feel embarrassed and ask for Kenkey instead',
        statChanges: {'looks': -5, 'happiness': -5, 'streetSense': -5},
        outcome: 'The lady looked deeply offended. You ate the kenkey in awkward silence.',
      ),
    ],
  ),

  // RELIGION AND SPIRITUALITY (4)
  LifeEvent(
    title: 'Suspicious Prophecy 🙏🏾',
    description: 'A visiting pastor points at you and says, "There is a spiritual padlock on your finances!"',
    minAge: 18,
    maxAge: 60,
    choices: [
      EventChoice(
        text: 'Fall down and receive the prayers',
        statChanges: {'happiness': 5, 'connections': 5, 'money': -10},
        outcome: 'You were intensely prayed for. Then he asked for a "seed" offering of 500 GHS to break the lock.',
      ),
      EventChoice(
        text: 'Stare at him blankly',
        statChanges: {'smarts': 10, 'reputation': -5, 'discipline': 8},
        outcome: 'He moved on to the next person. The church aunties gave you massive side-eyes.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Special Offering 💵',
    description: 'The church announces an emergency building fund. The pastor says, "If you can give 1000 GHS, come forward!"',
    minAge: 20,
    maxAge: 60,
    choices: [
      EventChoice(
        text: 'Walk forward in faith (and debt)',
        statChanges: {'money': -15, 'reputation': 15, 'connections': 10},
        outcome: 'The congregation clapped. You have no idea how you are paying rent next month.',
      ),
      EventChoice(
        text: 'Bow your head like you are praying heavily',
        statChanges: {'money': 5, 'streetSense': 15, 'reputation': -5},
        outcome: 'You avoided eye contact until the offering ended. Spiritually questionable, financially sound.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Prayer Warrior Auntie ⚔️',
    description: 'Your auntie visits, pours holy oil at your doorstep, and declares your house a battleground against witches.',
    minAge: 20,
    maxAge: 50,
    choices: [
      EventChoice(
        text: 'Allow her to finish her rituals',
        statChanges: {'connections': 10, 'reputation': 5, 'health': 5},
        outcome: 'Your house smells like olive oil for a week, but she is happy and peaceful.',
      ),
      EventChoice(
        text: 'Tell her to stop ruining your tiles',
        statChanges: {'connections': -15, 'reputation': -10, 'discipline': 5},
        outcome: 'She left calling you an agent of darkness. Family ties are completely ruined.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Three Days Dry Fasting 🍽️',
    description: 'Your church calls a mandatory 3-day dry fast. No food, no water, starting tomorrow at 6 AM.',
    minAge: 18,
    maxAge: 60,
    choices: [
      EventChoice(
        text: 'Participate fully in faith',
        statChanges: {'health': -15, 'discipline': 15, 'happiness': 5},
        outcome: 'You felt faint by day two, but you pushed through. You attained spiritual superiority.',
      ),
      EventChoice(
        text: 'Fast publicly, eat privately',
        statChanges: {'streetSense': 15, 'health': 10, 'discipline': -15},
        outcome: 'You looked holy at church while digesting a massive bowl of banku you ate at midnight.',
      ),
    ],
  ),

  // TRAFFIC AND TRANSPORT (4)
  LifeEvent(
    title: 'The Trotro Mate 🚐',
    description: 'You gave the mate a 50 GHS note for a 5 GHS fare. You are nearing your stop and he hasn\'t given your change.',
    minAge: 16,
    maxAge: 60,
    choices: [
      EventChoice(
        text: 'Start an aggressive argument',
        statChanges: {'reputation': -5, 'streetSense': 10, 'money': 8},
        outcome: 'You shouted. The passengers supported you. He magically produced your change from his socks.',
      ),
      EventChoice(
        text: 'Wait quietly hoping he remembers',
        statChanges: {'discipline': 5, 'money': -10, 'happiness': -8},
        outcome: 'You got down and the trotro sped off before you could ask. You played yourself.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Accra Gridlock 🚗',
    description: 'You have a crucial job interview at 9 AM. You left at 6 AM, but the road is a parking lot. It is 8:45 AM.',
    minAge: 18,
    maxAge: 60,
    choices: [
      EventChoice(
        text: 'Abandon the car/trotro and take an Okada',
        statChanges: {'health': -5, 'streetSense': 15, 'money': -5},
        outcome: 'You hopped on a bike, dodged cars like a stuntman, and made it exactly at 8:59 AM sweating profusely.',
      ),
      EventChoice(
        text: 'Sit in the car and cry',
        statChanges: {'happiness': -10, 'discipline': -5, 'health': -5},
        outcome: 'You arrived at 10 AM. The interview was over. Classic Accra defeat.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Shortcut 🛣️',
    description: 'Your Uber driver decides to take a "magic shortcut" through a muddy, unpaved neighborhood to avoid traffic.',
    minAge: 18,
    maxAge: 60,
    choices: [
      EventChoice(
        text: 'Suggest he turns back immediately',
        statChanges: {'discipline': 8, 'smarts': 8, 'streetSense': -2},
        outcome: 'He grumbled but turned back. You lost time, but no axles were broken.',
      ),
      EventChoice(
        text: 'Trust the driver\'s local knowledge',
        statChanges: {'health': -5, 'happiness': -10, 'reputation': -5},
        outcome: 'The car got stuck in a muddy trench. You both had to step out and push the car in your office clothes.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Okada Terror 🏍️',
    description: 'Your Okada rider is weaving between moving articulated trucks at 80km/h on the highway.',
    minAge: 18,
    maxAge: 50,
    choices: [
      EventChoice(
        text: 'Hold on tight and close your eyes',
        statChanges: {'health': -10, 'streetSense': 5, 'happiness': -15},
        outcome: 'You survived, but your soul left your body three times. You kissed the ground upon arrival.',
      ),
      EventChoice(
        text: 'Scream at him to slow down',
        statChanges: {'reputation': -5, 'discipline': 5, 'health': 5},
        outcome: 'He hissed and slowed down safely. Better to be an annoying passenger than a dead one.',
      ),
    ],
  ),

  // FAMILY AND COMMUNITY OBLIGATIONS (4)
  LifeEvent(
    title: 'Family Reunion Coordinator 📋',
    description: 'The family elders just announced that YOU will be the main coordinator for the upcoming 200-person family reunion.',
    minAge: 22,
    maxAge: 50,
    choices: [
      EventChoice(
        text: 'Accept the honor and start planning',
        statChanges: {'connections': 15, 'reputation': 10, 'health': -10},
        outcome: 'You organized a phenomenal event. Everyone was impressed, but you developed hypertension from the stress.',
      ),
      EventChoice(
        text: 'Flee the country (or hide)',
        statChanges: {'streetSense': 10, 'connections': -15, 'reputation': -10},
        outcome: 'You ghosted them. Your uncle had to do it. You are officially the black sheep.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Village Visitor 🧳',
    description: 'Your second cousin from the village shows up with three massive suitcases. They say they are staying "for a while".',
    minAge: 25,
    maxAge: 60,
    choices: [
      EventChoice(
        text: 'Welcome them and clear a room',
        statChanges: {'connections': 10, 'money': -10, 'happiness': -5},
        outcome: 'They stayed for eight months. You fed them daily, displaying peak Ghanaian hospitality.',
      ),
      EventChoice(
        text: 'Give them transport money back after 3 days',
        statChanges: {'discipline': 15, 'money': -5, 'connections': -15},
        outcome: 'You sent them packing. You protected your space, but the village gossips will destroy your name.',
      ),
    ],
  ),
  LifeEvent(
    title: 'WhatsApp Group Explosion 📱',
    description: 'A massive argument breaks out in the extended family WhatsApp group over politics and land.',
    minAge: 18,
    maxAge: 60,
    choices: [
      EventChoice(
        text: 'Type a long, unifying voice of reason',
        statChanges: {'smarts': 10, 'reputation': 10, 'connections': 5},
        outcome: 'Your message brought sudden peace. They called you the "Wise One" and the argument stopped.',
      ),
      EventChoice(
        text: 'Send a hilarious, inappropriate sticker',
        statChanges: {'streetSense': 10, 'happiness': 5, 'discipline': -10},
        outcome: 'The old folks were horrified. You were instantly removed by the Admin (your uncle). Peace at last.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Free Uber 🚘',
    description: 'You bought your first car. Now perfectly healthy relatives call you to drop them everywhere.',
    minAge: 22,
    maxAge: 45,
    choices: [
      EventChoice(
        text: 'Drive them everywhere out of duty',
        statChanges: {'connections': 10, 'money': -15, 'health': -5},
        outcome: 'You became the unpaid family chauffeur. Your fuel budget collapsed entirely.',
      ),
      EventChoice(
        text: 'Start complaining about fuel costs loudly',
        statChanges: {'streetSense': 12, 'discipline': 5, 'connections': -5},
        outcome: 'You complained about fuel hitting 15 GHS a liter. The calls magically stopped.',
      ),
    ],
  ),

  // SCAMS AND STREET SMARTS (4)
  LifeEvent(
    title: 'The Trusted Investment 🤝',
    description: 'Someone from your church introduces you to an investment bringing 40% returns in one month.',
    minAge: 20,
    maxAge: 55,
    choices: [
      EventChoice(
        text: 'Give them your life savings',
        statChanges: {'money': -20, 'smarts': -15, 'happiness': -15}, // Caps applied later
        outcome: 'Menzgold 2.0. The office closed down overnight. You wept bitterly in the rain.',
      ),
      EventChoice(
        text: 'Smile and walk away immediately',
        statChanges: {'smarts': 15, 'discipline': 10, 'money': 5},
        outcome: 'You preserved your wealth. Six months later, you saw the "CEO" being arrested on the news.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Bus Stop Proposal 📑',
    description: 'A well-dressed man at a trotro station says his truck of gold/diamonds broke down and he needs 500 GHS for towing.',
    minAge: 16,
    maxAge: 50,
    choices: [
      EventChoice(
        text: 'Give him the money, expecting a reward',
        statChanges: {'money': -10, 'smarts': -10, 'happiness': -5},
        outcome: 'You waited at that station for three hours. The man, the gold, and the truck were illusions.',
      ),
      EventChoice(
        text: 'Tell him to call the police for help',
        statChanges: {'streetSense': 15, 'smarts': 5, 'happiness': 2},
        outcome: 'He looked angry and immediately walked away to find a new victim. You win.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Missing Contractor 🏗️',
    description: 'You paid a contractor 20,000 GHS to buy cement and iron rods. His phone is now switched off.',
    minAge: 25,
    maxAge: 55,
    choices: [
      EventChoice(
        text: 'Hunt him down with heavily built men',
        statChanges: {'reputation': -5, 'streetSense': 10, 'money': 5},
        outcome: 'You found him hiding in Kasoa. You recovered half the money, but things got very messy.',
      ),
      EventChoice(
        text: 'Report to the slow police system',
        statChanges: {'discipline': 8, 'money': -15, 'happiness': -10},
        outcome: 'You filed a report. It gathered dust. The money is essentially gone forever.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Payment Before Interview 💻',
    description: 'You received an email saying you got the oil company job! But you must pay 500 GHS for "training materials" first.',
    minAge: 20,
    maxAge: 40,
    choices: [
      EventChoice(
        text: 'Pay the fee out of desperation',
        statChanges: {'money': -10, 'smarts': -10, 'happiness': -8},
        outcome: 'You paid. The email address was deleted the next day. A painful 419 lesson.',
      ),
      EventChoice(
        text: 'Delete the email and hiss',
        statChanges: {'streetSense': 10, 'smarts': 10, 'discipline': 5},
        outcome: 'You spotted the scam instantly. True street smarts activated.',
      ),
    ],
  ),

  // POLITICS AND ELECTIONS (4)
  LifeEvent(
    title: 'Election Colors 🔴🔵',
    description: 'It is election season. You wore a polo shirt of a certain primary color to the market.',
    minAge: 18,
    maxAge: 60,
    choices: [
      EventChoice(
        text: 'Wave at the political fans shouting at you',
        statChanges: {'reputation': 5, 'connections': 5, 'happiness': 5},
        outcome: 'They cheered for you thinking you belong to their party. Free goodwill!',
      ),
      EventChoice(
        text: 'Run home and change the shirt',
        statChanges: {'streetSense': 10, 'discipline': 5, 'health': 2},
        outcome: 'You avoided political profiling. Better safe than involved in a market argument.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Party T-Shirt 👕',
    description: 'A campaign van is throwing free branded T-shirts and bags of rice in your neighborhood.',
    minAge: 18,
    maxAge: 60,
    choices: [
      EventChoice(
        text: 'Fight for a huge bag of rice',
        statChanges: {'health': -5, 'money': 10, 'reputation': -5},
        outcome: 'You wrestled a teenager for the rice. You have free food, but no dignity left.',
      ),
      EventChoice(
        text: 'Stand far away and observe',
        statChanges: {'discipline': 8, 'reputation': 5, 'happiness': -2},
        outcome: 'You kept your pride intact, but you had to buy your own supper that night.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Family Politics 🗣️',
    description: 'Your uncle is passionately defending a very terrible government policy at the dinner table.',
    minAge: 18,
    maxAge: 60,
    choices: [
      EventChoice(
        text: 'Present him with actual statistics',
        statChanges: {'smarts': 12, 'connections': -10, 'reputation': -5},
        outcome: 'You proved him wrong logically. He angrily called you disrespectful and left.',
      ),
      EventChoice(
        text: 'Nod and say "Hmm, Ghana..."',
        statChanges: {'discipline': 10, 'streetSense': 10, 'happiness': 2},
        outcome: 'The ultimate neutral response. The argument died down and everyone enjoyed the meal.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Abandoned Road 🚧',
    description: 'The contractor who was grading your neighborhood road abandoned the equipment after elections.',
    minAge: 25,
    maxAge: 60,
    choices: [
      EventChoice(
        text: 'Organize protests to block the highway',
        statChanges: {'reputation': 15, 'connections': 5, 'health': -5},
        outcome: 'The media covered it! The MCE panicked and the contractor miraculously returned the next week.',
      ),
      EventChoice(
        text: 'Buy a 4x4 car and ignore the problem',
        statChanges: {'money': -15, 'streetSense': 5, 'happiness': 10},
        outcome: 'You solved the problem privately. Your car handles the craters like a tank.',
      ),
    ],
  ),

  // CULTURE AND TRADITIONS (4)
  LifeEvent(
    title: 'Greeting the Elders 👴🏾',
    description: 'You arrive late to a family gathering. There are 20 elders seated in a semi-circle.',
    minAge: 15,
    maxAge: 50,
    choices: [
      EventChoice(
        text: 'Go round and shake every single hand',
        statChanges: {'connections': 15, 'reputation': 10, 'discipline': 5},
        outcome: 'You adhered strictly to custom. They nodded approvingly at your excellent upbringing.',
      ),
      EventChoice(
        text: 'Wave generally and sit in the back',
        statChanges: {'streetSense': 5, 'reputation': -15, 'connections': -10},
        outcome: 'The disrespect was noted. Your name was heavily discussed after you left.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Chieftaincy Drama 👑',
    description: 'Your family is involved in a bitter royal dispute over who rightfully inherits a stool.',
    minAge: 30,
    maxAge: 60,
    choices: [
      EventChoice(
        text: 'Throw your money behind a candidate',
        statChanges: {'money': -15, 'connections': 15, 'reputation': 10},
        outcome: 'Your candidate won! You are now a heavily influential "kingmaker".',
      ),
      EventChoice(
        text: 'Refuse to be part of the politics',
        statChanges: {'discipline': 10, 'happiness': 10, 'reputation': -5},
        outcome: 'You stayed clear of the curses and assassinations. A very long, peaceful life awaits you.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Heavy Kente 👘',
    description: 'You are required to wear a massive, heavy, unbearably hot Kente cloth for a 4-hour traditional marriage.',
    minAge: 18,
    maxAge: 55,
    choices: [
      EventChoice(
        text: 'Wear it and sweat with pride',
        statChanges: {'reputation': 15, 'looks': 15, 'health': -5},
        outcome: 'You looked majestic. You sweated through everything underneath, but the pictures were flawless.',
      ),
      EventChoice(
        text: 'Wear a simple polished cotton outfit instead',
        statChanges: {'health': 8, 'happiness': 5, 'reputation': -10},
        outcome: 'You were comfortable, but the elders asked if you were a spectator or family.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Pouring Libation 🥃',
    description: 'An elder suddenly thrusts a bottle of Schnapps into your hand and tells you to pour libation for the ancestors.',
    minAge: 25,
    maxAge: 60,
    choices: [
      EventChoice(
        text: 'Stammer and try to copy what you have seen on TV',
        statChanges: {'streetSense': 5, 'reputation': -5, 'happiness': -8},
        outcome: 'You muttered random words and spilt the drink on your own shoes. Highly awkward.',
      ),
      EventChoice(
        text: 'Decline respectfully citing your Christian faith',
        statChanges: {'discipline': 10, 'reputation': 5, 'connections': -5},
        outcome: 'The elders grumbled, but respected your firm theological stance. Someone else took the bottle.',
      ),
    ],
  ),
];
