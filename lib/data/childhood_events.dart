import '../models/event.dart';

final List<LifeEvent> childhoodEvents = [
  LifeEvent(
    title: 'Naming Ceremony 🎉',
    description:
        'Your family has gathered for your outdooring. Aunties are singing, elders are advising your parents, and everyone wants to carry you.',
    minAge: 1,
    maxAge: 1,
    baseWeight: 80,
    choices: [
      EventChoice(
        text: 'Smile at everyone',
        statChanges: {'happiness': 5, 'reputation': 4},
        familyBondChange: 5,
        cashChange: 80,
        outcome:
            'You smiled at the perfect moment. Someone pressed small money into your blanket and the whole family said you are blessed.',
      ),
      EventChoice(
        text: 'Cry until your mother rescues you',
        statChanges: {'health': 2, 'happiness': -2, 'reputation': -2},
        familyBondChange: 2,
        outcome:
            'You cried through the speeches. Your mother rescued you while the aunties debated who you resemble.',
      ),
      EventChoice(
        text: 'Sleep through the whole thing',
        statChanges: {'health': 4, 'discipline': 1},
        familyBondChange: 3,
        outcome:
            'You slept like a tiny elder. Everyone agreed you are peaceful. For now.',
      ),
    ],
  ),
  LifeEvent(
    title: 'First Steps 👣',
    description:
        'You wobble across the hall while your family freezes. Your father is holding his phone, trying to record history.',
    minAge: 1,
    maxAge: 2,
    baseWeight: 70,
    choices: [
      EventChoice(
        text: 'Walk straight to your mother',
        statChanges: {'health': 4, 'happiness': 4},
        familyBondChange: 5,
        outcome:
            'You made it! The room exploded with cheers and your mother lifted you like a trophy.',
      ),
      EventChoice(
        text: 'Fall, then try again',
        statChanges: {'health': -1, 'discipline': 4, 'happiness': 2},
        familyBondChange: 3,
        outcome:
            'You landed on your backside, frowned, and tried again. The family says you have fighting spirit.',
      ),
      EventChoice(
        text: 'Refuse to perform',
        statChanges: {'discipline': -2, 'streetSense': 3},
        outcome:
            'You sat down immediately. No free entertainment today. Your father still claims the camera scared you.',
      ),
    ],
  ),
  LifeEvent(
    title: 'First Words 🗣️',
    description:
        'Everyone is waiting to hear your first proper word. Your parents are campaigning hard for "mama" and "dada".',
    minAge: 1,
    maxAge: 3,
    baseWeight: 65,
    choices: [
      EventChoice(
        text: 'Say "mama"',
        statChanges: {'smarts': 3, 'happiness': 3},
        familyBondChange: 4,
        outcome:
            'Your mother shouted like Ghana had scored. Your father pretended not to be jealous.',
      ),
      EventChoice(
        text: 'Say "dada"',
        statChanges: {'smarts': 3, 'reputation': 2},
        familyBondChange: 4,
        outcome:
            'Your father lifted you proudly. Your mother says she taught you the word anyway.',
      ),
      EventChoice(
        text: 'Say something nobody understands',
        statChanges: {'smarts': 2, 'streetSense': 2},
        outcome:
            'You produced a mysterious syllable. The family has decided it means you are deep.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Refusing Food 🍲',
    description:
        'Your mother is trying to feed you porridge. You have decided this spoon is your enemy.',
    minAge: 1,
    maxAge: 3,
    baseWeight: 55,
    choices: [
      EventChoice(
        text: 'Eat after small begging',
        statChanges: {'health': 4, 'discipline': 2},
        familyBondChange: 2,
        outcome:
            'You finally ate. Your mother looked relieved like she had completed a national assignment.',
      ),
      EventChoice(
        text: 'Turn your head dramatically',
        statChanges: {'happiness': 2, 'discipline': -3, 'health': -2},
        outcome:
            'You dodged the spoon like a professional. Unfortunately, hunger caught up with you later.',
      ),
      EventChoice(
        text: 'Spit it on your shirt',
        statChanges: {'happiness': 3, 'reputation': -2, 'discipline': -4},
        familyBondChange: -1,
        outcome:
            'The porridge landed everywhere. Your mother sighed the sigh of someone rethinking parenthood.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Carried To Church ⛪',
    description:
        'Your parent carries you to church. The service is loud, warm, and full of aunties trying to pinch your cheeks.',
    minAge: 1,
    maxAge: 4,
    baseWeight: 50,
    choices: [
      EventChoice(
        text: 'Clap along to the singing',
        statChanges: {'happiness': 5, 'reputation': 3},
        familyBondChange: 3,
        outcome:
            'You clapped off beat but with confidence. The aunties declared you a church child.',
      ),
      EventChoice(
        text: 'Sleep through the sermon',
        statChanges: {'health': 4, 'discipline': 1},
        outcome:
            'You slept through everything, including the offertory. A peaceful victory.',
      ),
      EventChoice(
        text: 'Cry during prayer',
        statChanges: {'happiness': -3, 'reputation': -2},
        familyBondChange: -1,
        outcome:
            'You cried during a very serious prayer point. Your parent bounced you outside quickly.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Baby Fever 🤒',
    description:
        'You wake up hot and weak. Your parents rush around the house deciding whether to go to the clinic immediately.',
    minAge: 1,
    maxAge: 4,
    baseWeight: 55,
    choices: [
      EventChoice(
        text: 'Go quietly to the clinic',
        statChanges: {'health': 6, 'happiness': -2},
        familyBondChange: 2,
        debtChange: 120,
        outcome:
            'The clinic visit helped. Your parents added a small bill, but everyone slept better.',
      ),
      EventChoice(
        text: 'Fight the thermometer',
        statChanges: {'health': -2, 'discipline': -2, 'streetSense': 2},
        outcome:
            'You resisted every check. The adults eventually won, because adults always have backup.',
      ),
      EventChoice(
        text: 'Rest after medicine',
        statChanges: {'health': 4, 'discipline': 2},
        familyBondChange: 2,
        outcome:
            'You took the medicine with only moderate betrayal in your eyes. Recovery began.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Daycare Drama 🧸',
    description:
        'At daycare, another child grabs your toy and crawls away like a tiny criminal.',
    minAge: 2,
    maxAge: 4,
    baseWeight: 55,
    choices: [
      EventChoice(
        text: 'Cry for the caregiver',
        statChanges: {'happiness': -2, 'reputation': -1, 'discipline': 2},
        outcome:
            'The caregiver returned the toy. Justice arrived, wearing rubber slippers.',
      ),
      EventChoice(
        text: 'Take it back yourself',
        statChanges: {'streetSense': 4, 'reputation': 2, 'discipline': -2},
        outcome:
            'You reclaimed the toy with surprising confidence. The daycare has noticed you.',
      ),
      EventChoice(
        text: 'Find another toy',
        statChanges: {'smarts': 3, 'happiness': 2, 'discipline': 2},
        outcome:
            'You moved on quickly. Adaptability is a life skill, even with plastic blocks.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Sibling Jealousy 😤',
    description:
        'An older sibling says everyone only cares about you now. They are staring at your baby blanket with dangerous energy.',
    minAge: 1,
    maxAge: 5,
    baseWeight: 45,
    choices: [
      EventChoice(
        text: 'Offer a toy',
        statChanges: {'happiness': 3, 'connections': 2},
        familyBondChange: 5,
        outcome:
            'You shared a toy. Your sibling softened immediately, though they still think you get too much attention.',
      ),
      EventChoice(
        text: 'Cry louder than them',
        statChanges: {'happiness': -2, 'streetSense': 3},
        familyBondChange: -2,
        outcome:
            'You won the noise battle. Your parents looked exhausted and nobody was truly happy.',
      ),
      EventChoice(
        text: 'Ignore them completely',
        statChanges: {'discipline': 2, 'reputation': -1},
        outcome:
            'You ignored the tension and played with your toes. A peaceful but politically risky move.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Breaking Something At Home 🏺',
    description:
        'You bump into a small table and a decorative bowl crashes to the floor. Everyone turns at once.',
    minAge: 2,
    maxAge: 5,
    baseWeight: 50,
    choices: [
      EventChoice(
        text: 'Point at someone else',
        statChanges: {'streetSense': 4, 'discipline': -4, 'reputation': -3},
        familyBondChange: -2,
        outcome:
            'Your accusation made no sense, but the instinct was there. Your family is worried and impressed.',
      ),
      EventChoice(
        text: 'Start crying immediately',
        statChanges: {'happiness': -3, 'health': 1},
        familyBondChange: 1,
        debtChange: 60,
        outcome:
            'The crying reduced the punishment, but the bowl still had to be replaced.',
      ),
      EventChoice(
        text: 'Try to sweep the pieces',
        statChanges: {'discipline': 4, 'health': -1, 'reputation': 2},
        familyBondChange: 2,
        outcome:
            'You tried to help. An adult quickly moved you away from the sharp pieces, but the effort counted.',
      ),
    ],
  ),
  LifeEvent(
    title: 'First School Day 🎒',
    description:
        'You arrive for your first school day. Your bag is almost bigger than you and your parent is trying not to look emotional.',
    minAge: 4,
    maxAge: 5,
    baseWeight: 85,
    choices: [
      EventChoice(
        text: 'Walk in bravely',
        statChanges: {'discipline': 4, 'smarts': 3, 'reputation': 3},
        familyBondChange: 2,
        outcome:
            'You walked in with a serious face. Your teacher smiled and your parent bragged about you later.',
      ),
      EventChoice(
        text: 'Hold your parent tightly',
        statChanges: {'happiness': -2, 'health': 1},
        familyBondChange: 4,
        outcome:
            'You needed extra hugs before entering. It was hard, but you made it inside.',
      ),
      EventChoice(
        text: 'Run toward the toys',
        statChanges: {'happiness': 5, 'streetSense': 2, 'discipline': -1},
        outcome:
            'You forgot the goodbye immediately. The toy corner had your full attention.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Class Rhyme Moment 🎶',
    description:
        'Your teacher asks the class to sing a rhyme. Somehow, everyone is looking at you to lead.',
    minAge: 4,
    maxAge: 6,
    baseWeight: 55,
    choices: [
      EventChoice(
        text: 'Sing loudly',
        statChanges: {'happiness': 4, 'reputation': 4, 'connections': 2},
        outcome:
            'You sang with volume, if not accuracy. The class followed your energy.',
      ),
      EventChoice(
        text: 'Mumble and hide',
        statChanges: {'happiness': -2, 'reputation': -2, 'smarts': 1},
        outcome:
            'You mumbled into your collar. Nobody judged you for long; children move on quickly.',
      ),
      EventChoice(
        text: 'Make up your own words',
        statChanges: {'smarts': 3, 'streetSense': 3, 'discipline': -2},
        outcome:
            'The words were wrong but catchy. Half the class copied your remix.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Grandmother Spoils You 🍬',
    description:
        'Your grandmother visits and secretly gives you sweets before dinner. Your parent has warned her about this before.',
    minAge: 3,
    maxAge: 6,
    baseWeight: 50,
    choices: [
      EventChoice(
        text: 'Eat them quietly',
        statChanges: {'happiness': 5, 'streetSense': 3, 'health': -1},
        familyBondChange: 2,
        outcome:
            'You enjoyed every sweet in silence. Grandmother winked like you are co-conspirators.',
      ),
      EventChoice(
        text: 'Tell your parent',
        statChanges: {'discipline': 4, 'happiness': -2, 'reputation': 2},
        familyBondChange: 1,
        outcome:
            'You reported honestly. Grandmother called you too serious, but your parent was pleased.',
      ),
      EventChoice(
        text: 'Ask for money instead',
        statChanges: {'streetSense': 4, 'reputation': -1},
        cashChange: 20,
        outcome:
            'Grandmother laughed and gave you a small note. A negotiator is born.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Discipline Moment 🧹',
    description:
        'You pour powder all over the floor while playing. Your parent enters the room and becomes very quiet.',
    minAge: 3,
    maxAge: 5,
    baseWeight: 50,
    choices: [
      EventChoice(
        text: 'Help clean it',
        statChanges: {'discipline': 5, 'happiness': -1, 'reputation': 2},
        familyBondChange: 2,
        outcome:
            'You helped with a tiny cloth. It took forever, but your parent saw the effort.',
      ),
      EventChoice(
        text: 'Laugh because it looks like snow',
        statChanges: {'happiness': 4, 'discipline': -4, 'reputation': -2},
        familyBondChange: -2,
        outcome:
            'You laughed. Your parent did not. The cleanup became a moral lesson.',
      ),
      EventChoice(
        text: 'Hide behind the sofa',
        statChanges: {'streetSense': 3, 'discipline': -2, 'happiness': -1},
        outcome:
            'You hid badly. Your toes were visible. Still, the survival instinct was developing.',
      ),
    ],
  ),

  // EXISTING ONES (2)
  LifeEvent(
    title: 'A Childhood Fight 👊',
    description:
        'A boy in your class has been disturbing you for weeks. Today he pushed you in front of everyone.',
    minAge: 8,
    maxAge: 14,
    choices: [
      EventChoice(
        text: 'Fight back immediately',
        statChanges: {'reputation': 8, 'health': -10, 'discipline': -5},
        outcome:
            'You fought. You both got sent to the headmaster. Your mother is on her way.',
      ),
      EventChoice(
        text: 'Report to the teacher',
        statChanges: {'reputation': -5, 'happiness': -5, 'smarts': 3},
        outcome: 'The teacher warned him but now everyone calls you a snitch.',
      ),
      EventChoice(
        text: 'Walk away and ignore him',
        statChanges: {'discipline': 8, 'happiness': -8, 'reputation': -3},
        outcome:
            'You walked away. It was hard but your discipline grew stronger.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Family Visitor 👴',
    description:
        'A rich uncle from abroad has visited. He is giving out money to the children.',
    minAge: 5,
    maxAge: 12,
    choices: [
      EventChoice(
        text: 'Be polite and greet everyone properly',
        statChanges: {'money': 10, 'reputation': 5, 'connections': 5},
        outcome:
            'Your uncle was impressed. He gave you extra and told your parents you have good manners.',
      ),
      EventChoice(
        text: 'Hang back shyly',
        statChanges: {'money': 3, 'happiness': -3},
        outcome: 'You got a small amount. Should have greeted him properly.',
      ),
      EventChoice(
        text: 'Ask him directly for more money',
        statChanges: {'money': -5, 'reputation': -8, 'happiness': 5},
        outcome:
            'Your mother nearly fainted from embarrassment. The lecture lasted two hours.',
      ),
    ],
  ),

  // FIRST DAY OF PRIMARY SCHOOL (2)
  LifeEvent(
    title: 'First Day Nerves 🎒',
    description:
        'It is your very first day of primary school. Your mother leaves you at the gate and you feel like crying.',
    minAge: 5,
    maxAge: 7,
    choices: [
      EventChoice(
        text: 'Cry uncontrollably',
        statChanges: {'happiness': -5, 'reputation': -3, 'health': -2},
        outcome:
            'You cried until your eyes were red. A teacher had to bribe you with a biscuit.',
      ),
      EventChoice(
        text: 'Wipe your tears and walk in boldly',
        statChanges: {'discipline': 5, 'reputation': 5, 'smarts': 2},
        outcome:
            'You walked in like a boss. The other kids respected your bravery instantly.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Oversized Uniform 👔',
    description:
        'Your parents bought your school uniform four sizes too big so "you can grow into it".',
    minAge: 6,
    maxAge: 9,
    choices: [
      EventChoice(
        text: 'Complain bitterly',
        statChanges: {'happiness': -5, 'discipline': -3, 'streetSense': 2},
        outcome:
            'You complained, and got a lecture about how money doesn\'t grow on trees.',
      ),
      EventChoice(
        text: 'Tuck it in and pretend it fits',
        statChanges: {'discipline': 5, 'reputation': -2, 'smarts': 2},
        outcome:
            'You wore it proudly. You looked like a flying parachute in the wind, but you survived.',
      ),
    ],
  ),

  // REPORT CARD DAY (3)
  LifeEvent(
    title: 'Report Card Day 📜',
    description:
        'School has vacated and you have your report card. You placed 2nd in class. Your father is looking at it.',
    minAge: 7,
    maxAge: 12,
    choices: [
      EventChoice(
        text: 'Wait for the praise',
        statChanges: {'happiness': -5, 'discipline': 5, 'smarts': 2},
        outcome:
            'He looked at you and asked, "The person who came 1st, does he have two heads?"',
      ),
      EventChoice(
        text: 'Pre-emptively apologize for not being 1st',
        statChanges: {'streetSense': 5, 'reputation': 5, 'happiness': 2},
        outcome:
            'You apologized first. He nodded, impressed by your drive for excellence.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Red Pen 🛑',
    description:
        'Your exam results are out, and your paper has more red ink than blue. It is a disaster.',
    minAge: 8,
    maxAge: 12,
    choices: [
      EventChoice(
        text: 'Hide the report card under the mattress',
        statChanges: {'streetSense': 8, 'discipline': -8, 'happiness': -10},
        outcome:
            'You hid it. The anxiety of being found out is destroying your peace of mind.',
      ),
      EventChoice(
        text: 'Present it to your parents and cry preemptively',
        statChanges: {'health': -5, 'happiness': -5, 'smarts': 5},
        outcome:
            'The crying softened the blow slightly, but the talking-to still lasted three hours.',
      ),
      EventChoice(
        text: 'Try to forge the grades',
        statChanges: {'streetSense': 10, 'reputation': -10, 'discipline': -10},
        outcome:
            'You changed a 3 to an 8. Your mother noticed immediately. The discipline was legendary.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Class Genius 🤓',
    description:
        'The smartest kid in class just got 100% again, and your mother is asking why you cannot be like him.',
    minAge: 8,
    maxAge: 12,
    choices: [
      EventChoice(
        text: 'Say he has no social life',
        statChanges: {'reputation': 5, 'discipline': -5, 'streetSense': 5},
        outcome: 'Your mother slapped your mouth for talking back. Bad idea.',
      ),
      EventChoice(
        text: 'Promise to study with him',
        statChanges: {'smarts': 5, 'connections': 5, 'discipline': 5},
        outcome:
            'You started studying with him. Turns out, he actually just reads the textbook.',
      ),
    ],
  ),

  // BEING SENT ON ERRANDS (3)
  LifeEvent(
    title: 'The Market Run 🍅',
    description:
        'Your mother sent you to the market to buy tomatoes, pepper, and onion. You forgot the onion.',
    minAge: 8,
    maxAge: 12,
    choices: [
      EventChoice(
        text: 'Go back to the market quietly',
        statChanges: {'discipline': 8, 'health': -2, 'streetSense': 3},
        outcome:
            'You ran back and bought it before she noticed. Exhausting, but safe.',
      ),
      EventChoice(
        text: 'Lie that the onion seller did not come today',
        statChanges: {'streetSense': -5, 'reputation': -5, 'happiness': -5},
        outcome:
            'She knew you were lying. You were sent back with strict warnings.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Debt Collector 💰',
    description:
        'Your mother sends you to Auntie Esi\'s house to collect the money she owes her. Auntie Esi says she has no money.',
    minAge: 9,
    maxAge: 12,
    choices: [
      EventChoice(
        text: 'Go back and tell your mother',
        statChanges: {'discipline': 2, 'connections': -2, 'happiness': -2},
        outcome:
            'Your mother marched there herself. You had to witness the resulting shouting match.',
      ),
      EventChoice(
        text: 'Stand there and refuse to leave until she pays',
        statChanges: {'streetSense': 8, 'reputation': 5, 'discipline': 5},
        outcome:
            'Auntie Esi grumbled but produced the money. Your mother called you a strict businessman.',
      ),
      EventChoice(
        text: 'Accept a loaf of bread instead',
        statChanges: {'streetSense': -8, 'happiness': 5, 'money': -5},
        outcome:
            'You brought bread instead of cash. The scolding you received was biblical.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Lost Change 💸',
    description:
        'You were sent to buy bread. You dropped the change in the sand and cannot find it.',
    minAge: 6,
    maxAge: 11,
    choices: [
      EventChoice(
        text: 'Search until it gets dark',
        statChanges: {'discipline': 8, 'health': -5, 'happiness': -5},
        outcome:
            'You searched the sand with a stick for two hours. You finally found the coins!',
      ),
      EventChoice(
        text: 'Go home and cry',
        statChanges: {'happiness': -8, 'streetSense': -3, 'reputation': -2},
        outcome:
            'You went home crying. Your mother was not sympathetic to your tears.',
      ),
    ],
  ),

  // SIBLING RIVALRY (3)
  LifeEvent(
    title: 'The Remote Control War 📺',
    description:
        'You want to watch cartoons, but your older sibling is watching a Nigerian movie and refuses to change the channel.',
    minAge: 6,
    maxAge: 12,
    choices: [
      EventChoice(
        text: 'Scream for your mother',
        statChanges: {'reputation': -5, 'connections': -5, 'happiness': -2},
        outcome:
            'Your mother came and switched off the TV entirely. Now nobody is watching anything.',
      ),
      EventChoice(
        text: 'Hide the remote when they go to the bathroom',
        statChanges: {'streetSense': 8, 'discipline': -3, 'happiness': 5},
        outcome:
            'You hid it perfectly. They spent an hour looking for it while you watched Tom and Jerry.',
      ),
      EventChoice(
        text: 'Just watch the movie with them',
        statChanges: {'discipline': 5, 'happiness': 2, 'connections': 5},
        outcome:
            'You sat and watched. It actually wasn\'t a bad movie, just very dramatic.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Last Piece of Meat 🍗',
    description:
        'You saved your best piece of meat for last. You went to drink water, and your sibling ate it.',
    minAge: 5,
    maxAge: 12,
    choices: [
      EventChoice(
        text: 'Start a physical fight',
        statChanges: {'health': -5, 'reputation': -5, 'discipline': -8},
        outcome:
            'You threw hands. Parents intervened and both of you were punished.',
      ),
      EventChoice(
        text: 'Cry loudly until a parent replaces it',
        statChanges: {'happiness': 5, 'streetSense': 5, 'reputation': -5},
        outcome:
            'It worked! Your mother gave you a piece of fish from the pot to stop the tears.',
      ),
      EventChoice(
        text: 'Plot silent revenge',
        statChanges: {'smarts': 5, 'discipline': 5, 'streetSense': 8},
        outcome:
            'You said nothing. But tomorrow, their favorite pen is going missing.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Jumping on the Bed 🛏️',
    description:
        'Your sibling is jumping on the bed, which is strictly forbidden. The bed frame creaks dangerously.',
    minAge: 5,
    maxAge: 10,
    choices: [
      EventChoice(
        text: 'Join them immediately',
        statChanges: {'happiness': 10, 'discipline': -8, 'health': -5},
        outcome:
            'You joined in. The bed broke. The punishment you both received is still spoken of today.',
      ),
      EventChoice(
        text: 'Report them to authorities (Parents)',
        statChanges: {'discipline': 5, 'connections': -8, 'streetSense': 2},
        outcome:
            'You snitched. They were grounded, and they called you a traitor for a week.',
      ),
    ],
  ),

  // CHURCH OR MOSQUE EVENTS (3)
  LifeEvent(
    title: 'The Endless Sermon ⛪',
    description:
        'The pastor has been preaching for three hours. The heat is unbearable and your eyes are heavy.',
    minAge: 6,
    maxAge: 12,
    choices: [
      EventChoice(
        text: 'Rest your head on your mother\'s lap',
        statChanges: {'happiness': 5, 'health': 5, 'discipline': -2},
        outcome:
            'She pinched you awake immediately. "We are in the presence of God!"',
      ),
      EventChoice(
        text: 'Fight the sleep like a warrior',
        statChanges: {'discipline': 10, 'smarts': 2, 'health': -2},
        outcome:
            'You stayed awake staring blankly. Your discipline is forged in iron.',
      ),
      EventChoice(
        text: 'Ask to go to the toilet and wander outside',
        statChanges: {'streetSense': 8, 'happiness': 5, 'reputation': -5},
        outcome:
            'You spent 30 minutes outside watching older kids play. A solid escape strategy.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Offering Money 🪙',
    description:
        'Your parents gave you money for Sunday School offering. A seller outside is selling your favorite sweets.',
    minAge: 6,
    maxAge: 11,
    choices: [
      EventChoice(
        text: 'Give the offering exactly as intended',
        statChanges: {'discipline': 8, 'reputation': 5, 'happiness': -2},
        outcome:
            'You dropped the money in the bowl. A clean conscience is better than sugar.',
      ),
      EventChoice(
        text: 'Buy the sweets with the money',
        statChanges: {'streetSense': -10, 'happiness': 8, 'discipline': -10},
        outcome:
            'You bought the sweets. God knows, your Sunday School teacher knows, and soon your parents will know.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Memory Verse Drama 📖',
    description:
        'You have to recite a memory verse in front of the whole congregation. You suddenly forget the words.',
    minAge: 7,
    maxAge: 12,
    choices: [
      EventChoice(
        text: 'Freeze and cry',
        statChanges: {'reputation': -8, 'happiness': -8, 'connections': 3},
        outcome:
            'You cried. Everyone went "Awww", and someone helped you finish it.',
      ),
      EventChoice(
        text: 'Confidently quote "Jesus wept"',
        statChanges: {'streetSense': 10, 'smarts': 5, 'reputation': 5},
        outcome:
            'Shortest verse in the book. The congregation clapped for your resourcefulness.',
      ),
    ],
  ),

  // HOMETOWN HOLIDAY VISITS (2)
  LifeEvent(
    title: 'The Village Trip 🚌',
    description:
        'You are traveling to your hometown for Christmas. The trotro breaks down in the middle of nowhere.',
    minAge: 5,
    maxAge: 12,
    choices: [
      EventChoice(
        text: 'Complain about the heat continuously',
        statChanges: {'happiness': -5, 'reputation': -5, 'discipline': -5},
        outcome:
            'Your parents gave you that look that means "Wait till we get home". You stayed quiet after.',
      ),
      EventChoice(
        text: 'Play in the red dirt nearby',
        statChanges: {'happiness': 8, 'health': -2, 'streetSense': 5},
        outcome:
            'You got your nice clothes completely dirty, but it was incredibly fun.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Heavy Morning Fufu 🍲',
    description:
        'You are in the village, and your grandaunt has prepared a massive bowl of fufu and light soup for you... at 7:00 AM.',
    minAge: 6,
    maxAge: 12,
    choices: [
      EventChoice(
        text: 'Eat it all to show respect',
        statChanges: {'health': 5, 'discipline': 8, 'connections': 10},
        outcome:
            'You ate it. You couldn\'t move for the rest of the day, but she loves you now.',
      ),
      EventChoice(
        text: 'Say you only eat cornflakes',
        statChanges: {'reputation': -10, 'connections': -8, 'happiness': -5},
        outcome:
            'She was deeply offended and complained about "these city children".',
      ),
      EventChoice(
        text: 'Hide the meat and pretend finished',
        statChanges: {'streetSense': 8, 'discipline': -5, 'smarts': 5},
        outcome: 'You performed a magic trick with the meat. Nobody noticed.',
      ),
    ],
  ),

  // LEARNING A SKILL FROM A PARENT (2)
  LifeEvent(
    title: 'Pounding Fufu 🥣',
    description:
        'Your mother decides you are old enough to learn how to pound fufu. It is much harder than it looks.',
    minAge: 9,
    maxAge: 12,
    choices: [
      EventChoice(
        text: 'Pound with all your strength',
        statChanges: {'health': 5, 'discipline': 8, 'happiness': -3},
        outcome:
            'You pounded until your arms felt like jelly. Hard work, but it was a perfect fufu.',
      ),
      EventChoice(
        text: 'Complain your hands are hurting',
        statChanges: {'reputation': -5, 'discipline': -5, 'health': 2},
        outcome:
            'She took the pestle from you and muttered about the lazy youth of today.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Washing Your Own Clothes 🧼',
    description:
        'Saturday morning. Your parent hands you a bucket, pure water sachets of Omo, and tells you to wash your school uniform.',
    minAge: 8,
    maxAge: 12,
    choices: [
      EventChoice(
        text: 'Scrub until your knuckles hurt',
        statChanges: {'discipline': 10, 'reputation': 5, 'health': -2},
        outcome:
            'The uniform was brilliantly white. You gained practical survival skills.',
      ),
      EventChoice(
        text: 'Just soak it and rinse it fast',
        statChanges: {'streetSense': 5, 'discipline': -10, 'reputation': -8},
        outcome:
            'You were caught immediately. The collar was still brown. You had to do it all over again.',
      ),
    ],
  ),

  // BEING BULLIED AT SCHOOL (2) (1 existing was Fight, plus this one)
  LifeEvent(
    title: 'The Lunch Money Bully 🥪',
    description:
        'An older boy cornered you by the school toilet and demanded your lunch money.',
    minAge: 7,
    maxAge: 12,
    choices: [
      EventChoice(
        text: 'Hand over the money',
        statChanges: {'money': -5, 'happiness': -8, 'health': 2},
        outcome:
            'You gave him the money. You went hungry that day, but at least you were safe.',
      ),
      EventChoice(
        text: 'Tell him your father is a soldier',
        statChanges: {'streetSense': 10, 'reputation': 5, 'health': -2},
        outcome:
            'He hesitated and walked away. A brilliant bluff that paid off.',
      ),
      EventChoice(
        text: 'Shout for the teachers',
        statChanges: {'discipline': 5, 'reputation': -5, 'happiness': 2},
        outcome:
            'A teacher came running. The boy fled, but now he knows you are a snitch.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Defending a Junior 🛡️',
    description:
        'You see some classmates teasing a younger kid because his shoes are torn.',
    minAge: 9,
    maxAge: 12,
    choices: [
      EventChoice(
        text: 'Stand up for the younger kid',
        statChanges: {'reputation': 10, 'connections': 5, 'health': -2},
        outcome:
            'You stepped in. The bullies backed off and the younger kid looked at you like a hero.',
      ),
      EventChoice(
        text: 'Mind your own business',
        statChanges: {'streetSense': 2, 'happiness': -2, 'reputation': -2},
        outcome:
            'You kept walking. It is a tough world, better to stay out of trouble.',
      ),
    ],
  ),

  // PRIMARY SCHOOL PRIZE-GIVING DAY (2)
  LifeEvent(
    title: 'The Spelling Bee 🐝',
    description:
        'It is the speech and prize-giving day. The headmaster announces the Best Student award, and it goes to your rival.',
    minAge: 8,
    maxAge: 12,
    choices: [
      EventChoice(
        text: 'Clap politely',
        statChanges: {'discipline': 8, 'reputation': 5, 'happiness': -5},
        outcome:
            'You clapped and smiled. Everyone respected your sportsmanship.',
      ),
      EventChoice(
        text: 'Tell everyone they cheated',
        statChanges: {'reputation': -10, 'discipline': -8, 'streetSense': 2},
        outcome:
            'You caused a scene. Your parents had to apologize on your behalf.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Loudest Applause 👏',
    description:
        'You won an award! As you walk to the stage, your parents start screaming and dancing wildly in the crowd.',
    minAge: 7,
    maxAge: 12,
    choices: [
      EventChoice(
        text: 'Hide your face in embarrassment',
        statChanges: {'happiness': -5, 'reputation': -3, 'streetSense': 2},
        outcome: 'You power-walked to the stage, grab the book, and run off.',
      ),
      EventChoice(
        text: 'Smile and wave at them proudly',
        statChanges: {'happiness': 10, 'connections': 5, 'reputation': 5},
        outcome:
            'You waved back. Everyone thought it was cute. A proud family moment.',
      ),
    ],
  ),

  // PLAYING OUTSIDE (2)
  LifeEvent(
    title: 'Gutter Football ⚽',
    description:
        'You are playing gutter-to-gutter football. The ball falls deep into the dirty gutter water.',
    minAge: 7,
    maxAge: 12,
    choices: [
      EventChoice(
        text: 'Use a stick to fish it out',
        statChanges: {'smarts': 5, 'streetSense': 5, 'health': 2},
        outcome:
            'You smartly used a long branch. The ball was saved without getting muddy.',
      ),
      EventChoice(
        text: 'Reach in with your hand',
        statChanges: {'health': -8, 'reputation': 5, 'discipline': -2},
        outcome:
            'You grabbed it like a hero. The boys cheered, but you smelled terrible all day.',
      ),
    ],
  ),
  LifeEvent(
    title: 'After Dark 🌙',
    description:
        'You were playing outside and forgot the time. It is completely dark, and you know your mother is waiting.',
    minAge: 8,
    maxAge: 12,
    choices: [
      EventChoice(
        text: 'Sneak through the back door',
        statChanges: {'streetSense': 10, 'discipline': -5, 'happiness': 5},
        outcome:
            'You managed to slip in unnoticed and pre-emptively jumped into bed.',
      ),
      EventChoice(
        text: 'Walk in normally and apologize',
        statChanges: {'discipline': 8, 'health': -5, 'happiness': -5},
        outcome:
            'You walked in. She was pacing. The lecture started immediately.',
      ),
    ],
  ),

  // FOOD AND CHOP BAR MOMENTS (3)
  LifeEvent(
    title: 'The Stray Goat 🐐',
    description:
        'You bought a hot pie from a vendor. You turned around, and a stray goat snatched it from your hand.',
    minAge: 6,
    maxAge: 12,
    choices: [
      EventChoice(
        text: 'Chase the goat',
        statChanges: {'health': -5, 'reputation': -5, 'streetSense': 2},
        outcome:
            'You chased it down the street crying. People laughed. The goat won.',
      ),
      EventChoice(
        text: 'Cry to the vendor for another one',
        statChanges: {'happiness': 5, 'money': 5, 'reputation': -2},
        outcome:
            'The vendor felt sorry for you and gave you a small bofrot for free.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Waakye Math 🧮',
    description:
        'You are buying waakye. You have only 5 cedis but you want egg, meat, and wele.',
    minAge: 8,
    maxAge: 12,
    choices: [
      EventChoice(
        text: 'Calculate perfectly in your head',
        statChanges: {'smarts': 8, 'money': -5, 'happiness': 5},
        outcome:
            'You got the exact combination. The portions were small, but it was balanced.',
      ),
      EventChoice(
        text: 'Ask the seller to just "do it 5 cedis"',
        statChanges: {'streetSense': 8, 'connections': 5, 'money': -5},
        outcome:
            'The seller liked you and gave you a generous scoop of everything.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Empty Lunchbox 🍱',
    description:
        'It is break time. Your best friend forgot their lunch money and is looking at your food hungrily.',
    minAge: 6,
    maxAge: 11,
    choices: [
      EventChoice(
        text: 'Share half of your food',
        statChanges: {'connections': 10, 'reputation': 5, 'health': -2},
        outcome:
            'You split it evenly. You were still a bit hungry, but your friend won\'t forget it.',
      ),
      EventChoice(
        text: 'Eat quickly while looking away',
        statChanges: {'health': 5, 'happiness': -5, 'connections': -8},
        outcome: 'You ate it all. Your stomach is full but the guilt is heavy.',
      ),
    ],
  ),

  // LYING TO PARENTS (2)
  LifeEvent(
    title: 'The Broken Bowl 🥣',
    description:
        'You accidentally dropped your mother\'s favorite Pyrex glass bowl. It shattered into fifty pieces.',
    minAge: 7,
    maxAge: 12,
    choices: [
      EventChoice(
        text: 'Sweep it up and throw it over the wall',
        statChanges: {'streetSense': 10, 'discipline': -10, 'happiness': 5},
        outcome:
            'You hid the evidence. She won\'t notice until Christmas, buying you precious time.',
      ),
      EventChoice(
        text: 'Go confess immediately',
        statChanges: {'discipline': 12, 'health': -8, 'happiness': -5},
        outcome:
            'You confessed. The punishment was severe, but at least your conscience is clear.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Missing Homework 📚',
    description:
        'Your father is asking to see your homework. You completely forgot to do it.',
    minAge: 6,
    maxAge: 11,
    choices: [
      EventChoice(
        text: 'Say the teacher didn\'t give any',
        statChanges: {'streetSense': 5, 'reputation': -5, 'discipline': -5},
        outcome:
            'He believed you... this time. You better do it early tomorrow morning.',
      ),
      EventChoice(
        text: 'Say you left the book at school',
        statChanges: {'smarts': 2, 'discipline': -8, 'happiness': -2},
        outcome:
            'He scolded you for being careless, which is better than being lazy.',
      ),
    ],
  ),

  // EARLY TALENT DISCOVERY (2)
  LifeEvent(
    title: 'Inter-Houses Athletics 🏃🏿',
    description:
        'It is sports day. Your house needs someone for the 100m sprint, but you have never run before.',
    minAge: 9,
    maxAge: 12,
    choices: [
      EventChoice(
        text: 'Volunteer to run',
        statChanges: {'health': 8, 'reputation': 10, 'happiness': 10},
        outcome:
            'You ran like a cheetah! You actually won 2nd place. Who knew?',
      ),
      EventChoice(
        text: 'Hide in the classrooms',
        statChanges: {'streetSense': 5, 'discipline': -5, 'reputation': -3},
        outcome:
            'You spent the day eating stolen snacks in an empty classroom.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Class Artist 🎨',
    description:
        'The teacher catches you drawing a funny caricature of the headmaster in your maths book.',
    minAge: 8,
    maxAge: 12,
    choices: [
      EventChoice(
        text: 'Try to pass it off as abstract maths',
        statChanges: {'streetSense': 5, 'smarts': -5, 'discipline': -8},
        outcome:
            'The teacher didn\'t buy it. You had to kneel down for 30 minutes.',
      ),
      EventChoice(
        text: 'Apologize and accept the punishment',
        statChanges: {'discipline': 8, 'reputation': 2, 'happiness': -2},
        outcome:
            'You survived the punishment. Later, friends paid you biscuits to draw them.',
      ),
    ],
  ),

  // VISITING A SICK RELATIVE (2)
  LifeEvent(
    title: 'The Hospital Visit 🏥',
    description:
        'You went with your mother to visit a sick aunt in the hospital. The smell of medicine is making you dizzy.',
    minAge: 6,
    maxAge: 11,
    choices: [
      EventChoice(
        text: 'Hold your breath and stay strong',
        statChanges: {'discipline': 8, 'connections': 5, 'health': 2},
        outcome: 'You stayed by the bed. Your aunt was very happy to see you.',
      ),
      EventChoice(
        text: 'Complain and wait outside',
        statChanges: {'happiness': 5, 'connections': -5, 'discipline': -5},
        outcome: 'You waited outside playing in the dirt. Much better.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Bitter Medicine 🌿',
    description:
        'You have a minor stomach ache. Your grandmother has prepared a dark green, foul-smelling herbal mixture.',
    minAge: 5,
    maxAge: 12,
    choices: [
      EventChoice(
        text: 'Drink it in one gulp',
        statChanges: {'health': 15, 'discipline': 10, 'happiness': -8},
        outcome:
            'It tasted like mud and regrets, but your stomach ache vanished instantly.',
      ),
      EventChoice(
        text: 'Spit it out when she looks away',
        statChanges: {'streetSense': 10, 'health': -5, 'discipline': -8},
        outcome:
            'You threw it in the sink. You still have a stomach ache, but your tastebuds survived.',
      ),
    ],
  ),

  // MAKING YOUR FIRST FRIEND (2)
  LifeEvent(
    title: 'The Blood Oath 🤝',
    description:
        'You and your new best friend have decided to be friends forever. You are about to seal it with blue ballpoint pen ink on your thumbs.',
    minAge: 7,
    maxAge: 10,
    choices: [
      EventChoice(
        text: 'Press your thumbs together solemnly',
        statChanges: {'connections': 12, 'happiness': 8, 'discipline': -2},
        outcome:
            'You are now blood-ink brothers. You feel unconditionally supported.',
      ),
      EventChoice(
        text: 'Back out because ink is toxic',
        statChanges: {'smarts': 8, 'connections': -5, 'health': 2},
        outcome:
            'You decided against it. They called you a coward, but you live another day.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Sharing the FanYogo 🍦',
    description:
        'The bell has rung for break. You bought a FanYogo, and a quiet kid is looking at it longingly.',
    minAge: 6,
    maxAge: 11,
    choices: [
      EventChoice(
        text: 'Bite the corner and share it',
        statChanges: {'connections': 10, 'reputation': 8, 'happiness': 5},
        outcome:
            'You shared it. You just made a best friend for the rest of primary school.',
      ),
      EventChoice(
        text: 'Eat it quickly by yourself',
        statChanges: {'health': 2, 'connections': -5, 'happiness': 2},
        outcome:
            'It was delicious, but eating in front of hungry people never feels completely right.',
      ),
    ],
  ),

  // ADDITIONAL EVENTS (2)
  LifeEvent(
    title: 'Sleeping Beauty 😴',
    description:
        'You hear your parents\' car pull into the driveway. It is past your bedtime and the TV is still hot.',
    minAge: 6,
    maxAge: 12,
    choices: [
      EventChoice(
        text: 'Dive into bed and fake sleep',
        statChanges: {'streetSense': 10, 'discipline': -5, 'happiness': 5},
        outcome:
            'Your mother touched the TV, felt it was hot, but you were snoring so loudly she let it slide.',
      ),
      EventChoice(
        text: 'Sit there and face the consequences',
        statChanges: {'discipline': 8, 'reputation': -5, 'happiness': -8},
        outcome: 'You faced the music. The music was loud and involved a belt.',
      ),
    ],
  ),
  LifeEvent(
    title: 'My Father is Stronger 💪',
    description:
        'A boy at school claims his father is stronger and richer than yours.',
    minAge: 7,
    maxAge: 11,
    choices: [
      EventChoice(
        text: 'Argue back passionately',
        statChanges: {'connections': 5, 'reputation': 5, 'discipline': -2},
        outcome:
            'You defended your family honor proudly. You made up some wild lies to win the argument.',
      ),
      EventChoice(
        text: 'Admit his dad is probably richer',
        statChanges: {'smarts': 5, 'happiness': -2, 'reputation': -2},
        outcome:
            'You accepted reality. His dad literally drives a Land Cruiser, yours drives a Matrix.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Sunday Shoes 👞',
    description:
        'You wore your new shiny Sunday shoes to church, but your friends are playing football outside after service.',
    minAge: 6,
    maxAge: 12,
    choices: [
      EventChoice(
        text: 'Play football in the shoes',
        statChanges: {'health': -2, 'happiness': 8, 'reputation': 5},
        outcome:
            'You scored a hat-trick but destroyed the shoes. The beating at home was legendary.',
      ),
      EventChoice(
        text: 'Take them off and play barefoot',
        statChanges: {'streetSense': 8, 'health': -5, 'discipline': -5},
        outcome:
            'You played barefoot on sharp stones. Your feet are destroyed but the shoes survived.',
      ),
      EventChoice(
        text: 'Sit down and watch them play',
        statChanges: {'discipline': 8, 'happiness': -8, 'reputation': -3},
        outcome:
            'You kept your shoes pristine. It was a boring afternoon but your mother praised you.',
      ),
    ],
  ),
];
