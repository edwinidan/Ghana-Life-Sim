import '../models/event.dart';

final List<LifeEvent> youngAdultEvents = [
  // EXISTING (3)
  LifeEvent(
    title: 'University or Not? 🎓',
    description:
        'After SHS you must decide your next move. University, vocational school, or straight to hustle?',
    minAge: 18,
    maxAge: 20,
    choices: [
      EventChoice(
        text: 'Apply for University',
        statChanges: {'smarts': 10, 'money': -15, 'reputation': 5},
        outcome:
            'You got admission! The fees drained the family account, but you are an undergrad now.',
      ),
      EventChoice(
        text: 'Learn a trade/vocation',
        statChanges: {'streetSense': 10, 'money': 5, 'happiness': 5},
        outcome:
            'You started an apprenticeship. Practical skills mean practical money sooner.',
      ),
      EventChoice(
        text: 'Start hustling immediately',
        statChanges: {'money': 10, 'streetSense': 15, 'smarts': -5},
        outcome:
            'You hit the streets. Life comes at you fast, but you are learning the real world.',
      ),
    ],
  ),
  LifeEvent(
    title: 'First Job Offer 💼',
    description:
        'You have been offered your first proper job. The pay is low, but it is experience.',
    minAge: 21,
    maxAge: 25,
    choices: [
      EventChoice(
        text: 'Accept the low pay',
        statChanges: {'money': 5, 'connections': 8, 'reputation': 5},
        outcome:
            'You took the job. It pays peanuts, but you are networking and learning.',
      ),
      EventChoice(
        text: 'Negotiate aggressively',
        statChanges: {'streetSense': 10, 'money': 8, 'reputation': -2},
        outcome:
            'You argued for more. They eventually agreed, but the boss is watching you closely now.',
      ),
      EventChoice(
        text: 'Reject it to find better',
        statChanges: {'happiness': 5, 'money': -5, 'streetSense': -5},
        outcome:
            'You walked away. Three months later and you are still eating your parents\' food.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Business Idea 💡',
    description:
        'You have a brilliant idea for a start-up. You need capital to start.',
    minAge: 19,
    maxAge: 25,
    choices: [
      EventChoice(
        text: 'Pitch to family members',
        statChanges: {'money': 10, 'reputation': -5, 'connections': -5},
        outcome:
            'Uncle Yaw gave you the money, but he now reminds you of it at every family gathering.',
      ),
      EventChoice(
        text: 'Start very small with savings',
        statChanges: {'discipline': 10, 'money': -5, 'streetSense': 5},
        outcome:
            'You started small. Progress is slow, but you own 100% of your business.',
      ),
      EventChoice(
        text: 'Take a high-interest loan',
        statChanges: {'money': 15, 'streetSense': -10, 'happiness': -10},
        outcome:
            'You got the cash! But the interest rate is destroying your sleep and your profit.',
      ),
    ],
  ),

  // UNIVERSITY LIFE (7)
  LifeEvent(
    title: 'Admission List Anxiety 📃',
    description:
        'University admission lists are dropping today. You keep refreshing the portal but the site is crashing.',
    minAge: 18,
    maxAge: 19,
    choices: [
      EventChoice(
        text: 'Keep refreshing all night',
        statChanges: {'health': -5, 'happiness': -5, 'discipline': 5},
        outcome:
            'You didn\'t sleep. At 4 AM, the portal loaded. You got your first choice!',
      ),
      EventChoice(
        text: 'Go to sleep and check tomorrow',
        statChanges: {'health': 5, 'discipline': 5, 'happiness': -2},
        outcome:
            'You woke up fresh, checked, and found out you were offered a completely different course.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Bad Roommate 🛏️',
    description:
        'You arrived at your campus hostel to meet your new roommate. They have brought an entire sound system and do not wash their plates.',
    minAge: 18,
    maxAge: 22,
    choices: [
      EventChoice(
        text: 'Confront them immediately',
        statChanges: {'streetSense': 8, 'reputation': 5, 'connections': -5},
        outcome:
            'You set strict ground rules early. They think you are difficult, but the room is clean.',
      ),
      EventChoice(
        text: 'Clean up after them quietly',
        statChanges: {'discipline': 8, 'happiness': -8, 'health': -2},
        outcome:
            'You became their unpaid cleaner. Resentment is building inside you.',
      ),
      EventChoice(
        text: 'Retaliate by being just as messy',
        statChanges: {'reputation': -5, 'health': -5, 'streetSense': 5},
        outcome:
            'The room quickly turned into a biological hazard zone. Nobody visits you anymore.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Strict Lecturer 👨🏾‍🏫',
    description:
        'Your lecturer for a 3-credit course locks the door exactly at 7:00 AM. It is 6:58 AM and you are jogging towards the block.',
    minAge: 19,
    maxAge: 23,
    choices: [
      EventChoice(
        text: 'Sprint like Usain Bolt',
        statChanges: {'health': 5, 'discipline': 8, 'looks': -5},
        outcome:
            'You slid in at 6:59, sweating through your shirt. You survived, but look terrible.',
      ),
      EventChoice(
        text: 'Walk away and sleep',
        statChanges: {'health': 5, 'happiness': 5, 'smarts': -8},
        outcome:
            'You went back to bed. You missed the pop quiz that constituted 10% of your grade.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Submission Deadline ⏰',
    description:
        'The term paper is due at midnight. It is 10 PM, the campus Wi-Fi just died, and you still have two pages to write.',
    minAge: 19,
    maxAge: 24,
    choices: [
      EventChoice(
        text: 'Tether to your phone and buy data',
        statChanges: {'money': -5, 'smarts': 5, 'discipline': 8},
        outcome:
            'You bought an expensive data bundle and finished it. Submission successful.',
      ),
      EventChoice(
        text: 'Beg the lecturer for an extension',
        statChanges: {'reputation': -5, 'streetSense': 5, 'connections': -2},
        outcome:
            'The lecturer laughed in your face and deducted 5 marks for late submission.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Failing a Major Course 📉',
    description:
        'The results are pasted on the notice board. You scored an F in a prerequisite course. Your parents expect all A\'s.',
    minAge: 19,
    maxAge: 23,
    choices: [
      EventChoice(
        text: 'Hide it and plan to resit',
        statChanges: {'streetSense': 8, 'discipline': -5, 'happiness': -5},
        outcome:
            'You lied and said the lecturer hasn\'t released yours. Now you have to pay resit fees secretly.',
      ),
      EventChoice(
        text: 'Tell them the painful truth',
        statChanges: {'discipline': 8, 'reputation': 5, 'connections': -5},
        outcome:
            'You confessed. The disappointment was heavy, but the anxiety of hiding it is gone.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Campus Romance 💕',
    description:
        'You started dating someone in your department. Now they want you to sit together in the front row every lecture.',
    minAge: 19,
    maxAge: 24,
    choices: [
      EventChoice(
        text: 'Agree and become the power couple',
        statChanges: {'connections': 8, 'happiness': 5, 'reputation': 5},
        outcome:
            'You sat in front. Everyone knew your business, but the joint study sessions paid off.',
      ),
      EventChoice(
        text: 'Refuse to focus on studies',
        statChanges: {'smarts': 8, 'discipline': 5, 'happiness': -8},
        outcome:
            'You chose your GPA over romance. They broke up with you immediately after mid-sems.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Graduation Day Finally 🎓',
    description:
        'You are graduating! Your whole family rented a trotro to come to your campus.',
    minAge: 21,
    maxAge: 25,
    choices: [
      EventChoice(
        text: 'Take a million pictures and celebrate',
        statChanges: {'happiness': 15, 'reputation': 10, 'money': -10},
        outcome:
            'You hired a photographer and lived your best life. You are broke now, but the pictures are pure fire.',
      ),
      EventChoice(
        text: 'Hustle them away to save money',
        statChanges: {'money': 10, 'happiness': -5, 'connections': -5},
        outcome:
            'You rushed the celebration to save cash. It was practical but slightly anti-climactic.',
      ),
    ],
  ),

  // NATIONAL SERVICE (5)
  LifeEvent(
    title: 'NSS Posting Panic 📍',
    description:
        'National Service postings are out. You have been posted to a junior high school in a village you cannot even pronounce.',
    minAge: 21,
    maxAge: 25,
    choices: [
      EventChoice(
        text: 'Accept the posting bravely',
        statChanges: {'discipline': 15, 'streetSense': 10, 'happiness': -5},
        outcome:
            'You moved there. The lack of internet is tough, but you are learning real resilience.',
      ),
      EventChoice(
        text: 'Pay a "connection man" to change it',
        statChanges: {'money': -15, 'streetSense': 5, 'discipline': -10},
        outcome:
            'You paid a middleman to repost you to a bank in Accra. Corrupt, but comfortable.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Great Posting 🏢',
    description:
        'Miracle! You actually got posted to a huge multinational company for your National Service.',
    minAge: 21,
    maxAge: 25,
    choices: [
      EventChoice(
        text: 'Work like a regular employee',
        statChanges: {'smarts': 10, 'reputation': 10, 'discipline': 8},
        outcome:
            'You arrived early and left late. The managers definitely noticed your hard work.',
      ),
      EventChoice(
        text: 'Relax, you are just an NSS personnel',
        statChanges: {'happiness': 8, 'health': 5, 'reputation': -10},
        outcome:
            'You coasted through the year. Zero stress, but zero chance of being retained.',
      ),
    ],
  ),
  LifeEvent(
    title: 'NSS Allowance Delayed 💸',
    description:
        'It is the 10th of the next month and your "Allawa" has still not dropped. The hunger is real.',
    minAge: 21,
    maxAge: 25,
    choices: [
      EventChoice(
        text: 'Call your parents for a bailout',
        statChanges: {'money': 8, 'reputation': -5, 'discipline': -2},
        outcome:
            'They sent the money, but accompanied it with a long lecture about saving.',
      ),
      EventChoice(
        text: 'Borrow from a colleague',
        statChanges: {'connections': 5, 'reputation': -2, 'streetSense': 5},
        outcome:
            'You took a loan to eat waakye. The debt cycle has officially begun.',
      ),
      EventChoice(
        text: 'Fast and pray for the alert',
        statChanges: {'health': -8, 'discipline': 10, 'money': 0},
        outcome:
            'You survived on gari and tap water until the portal finally turned green.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Absentee NSS Personnel 👻',
    description:
        'The girl sharing a desk with you only comes to work once a week, but expects you to cover for her.',
    minAge: 21,
    maxAge: 25,
    choices: [
      EventChoice(
        text: 'Cover for her quietly',
        statChanges: {'connections': 10, 'discipline': -5, 'streetSense': -2},
        outcome:
            'She bought you lunch on the days she showed up, but you did double the workload.',
      ),
      EventChoice(
        text: 'Report her to the supervisor',
        statChanges: {'discipline': 10, 'reputation': 5, 'connections': -15},
        outcome:
            'You snitched. She got queried and hated you forever, but your workload halved.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Making NSS Friends 🤝',
    description:
        'You meet a group of service personnel from other universities. They want to hang out after work every Friday.',
    minAge: 21,
    maxAge: 25,
    choices: [
      EventChoice(
        text: 'Join the Friday night crew',
        statChanges: {'connections': 15, 'happiness': 10, 'money': -10},
        outcome:
            'You built an amazing network across the country, but your wallet suffered severe damages.',
      ),
      EventChoice(
        text: 'Save your money and go home early',
        statChanges: {'money': 10, 'discipline': 8, 'connections': -5},
        outcome:
            'You saved your allowance and invested it. You missed the fun, but achieved financial goals.',
      ),
    ],
  ),

  // FIRST JOB AND MONEY (7)
  LifeEvent(
    title: 'First Real Salary! 💰',
    description:
        'Your first real post-NSS paycheck just hit your account. It looks huge until you remember your expenses.',
    minAge: 22,
    maxAge: 25,
    choices: [
      EventChoice(
        text: 'Spoil yourself with online shopping',
        statChanges: {'happiness': 15, 'looks': 10, 'money': -15},
        outcome:
            'You bought new clothes and shoes. You look like a CEO but your account balance looks like a student\'s.',
      ),
      EventChoice(
        text: 'Invest a large chunk immediately',
        statChanges: {'money': 10, 'discipline': 12, 'happiness': -5},
        outcome:
            'You put it in a mutual fund. Very responsible, very boring.',
      ),
      EventChoice(
        text: 'Give some to your parents',
        statChanges: {'reputation': 15, 'connections': 10, 'money': -10},
        outcome:
            'You handed over the "first fruit". The prayers they showered on you felt good.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Unreasonable Boss 😤',
    description:
        'Your boss texted you at 9 PM on a Saturday asking for a report by Sunday morning.',
    minAge: 22,
    maxAge: 25,
    choices: [
      EventChoice(
        text: 'Stay up late and do it',
        statChanges: {'reputation': 8, 'health': -8, 'happiness': -10},
        outcome:
            'You delivered the report. He didn\'t even open it until Tuesday anyway.',
      ),
      EventChoice(
        text: 'Ignore the message until Monday',
        statChanges: {'health': 8, 'reputation': -10, 'discipline': 5},
        outcome:
            'You protected your peace. Monday morning was a battlefield, but you were well rested.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Office Politics 👔',
    description:
        'A colleague wants to gossip with you about the head of your department in the breakroom.',
    minAge: 22,
    maxAge: 25,
    choices: [
      EventChoice(
        text: 'Join the gossip session',
        statChanges: {'connections': 8, 'streetSense': 5, 'reputation': -5},
        outcome:
            'You learned all the office secrets, but now they probably gossip about you too.',
      ),
      EventChoice(
        text: 'Nod and excuse yourself',
        statChanges: {'discipline': 8, 'reputation': 5, 'connections': -2},
        outcome:
            'You stayed out of the drama. You are considered aloof, but professional.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Stolen Credit 🐍',
    description:
        'You stayed up late preparing a presentation. Your team member presents it to the boss and takes all the credit.',
    minAge: 22,
    maxAge: 25,
    choices: [
      EventChoice(
        text: 'Call them out in front of the boss',
        statChanges: {'streetSense': 10, 'reputation': -5, 'connections': -10},
        outcome:
            'You exposed them! It made the meeting very awkward, but the boss noted your contribution.',
      ),
      EventChoice(
        text: 'Stay quiet but stop helping them',
        statChanges: {'discipline': 8, 'happiness': -8, 'streetSense': 5},
        outcome:
            'You suffered in silence. Next time they asked for help, you hit them with "I\'m busy".',
      ),
    ],
  ),
  LifeEvent(
    title: 'Connection Job 🤝',
    description:
        'Your uncle secured you an interview at a prestigious firm where he is a director.',
    minAge: 23,
    maxAge: 25,
    choices: [
      EventChoice(
        text: 'Use the advantage fully',
        statChanges: {'money': 12, 'connections': 10, 'reputation': -5},
        outcome:
            'You got the job easily. Half the office knows you are a "connection boy/girl" though.',
      ),
      EventChoice(
        text: 'Refuse it to prove a point',
        statChanges: {'discipline': 15, 'reputation': 10, 'money': -10},
        outcome:
            'You wanted to earn it yourself. You are unemployed for another six months, preserving your pride.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Black Tax 💸',
    description:
        'You started earning barely enough to survive, and suddenly three different aunties need money for funerals.',
    minAge: 23,
    maxAge: 25,
    choices: [
      EventChoice(
        text: 'Send the money out of duty',
        statChanges: {'connections': 10, 'reputation': 8, 'money': -15},
        outcome:
            'You sent it. You are eating instant noodles for two weeks to survive.',
      ),
      EventChoice(
        text: 'Lie that you are totally broke',
        statChanges: {'streetSense': 10, 'money': 8, 'connections': -8},
        outcome:
            'You dodged the tax. Your aunties now believe your job is a scam.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Salary Negotiation 🗣️',
    description:
        'It has been a year. You are doing the work of three people and want a raise.',
    minAge: 24,
    maxAge: 25,
    choices: [
      EventChoice(
        text: 'Demand a 50% raise confidently',
        statChanges: {'streetSense': 10, 'reputation': 5, 'money': 8},
        outcome:
            'They laughed, but gave you a 20% bump. Boldness pays off slightly.',
      ),
      EventChoice(
        text: 'Write a polite, timid email',
        statChanges: {'discipline': 5, 'money': 2, 'happiness': -5},
        outcome:
            'They praised your "excellent work ethic" and gave you a 5% raise. Tragic.',
      ),
    ],
  ),

  // MOVING OUT AND INDEPENDENCE (7)
  LifeEvent(
    title: 'Apartment Hunting 🏠',
    description:
        'You are looking for your first place. The agent shows you a room in Accra for 1,500 GHS a month... with the toilet outside.',
    minAge: 23,
    maxAge: 25,
    choices: [
      EventChoice(
        text: 'Pay two years advance for it',
        statChanges: {'money': -15, 'streetSense': -5, 'health': -5},
        outcome:
            'You paid the massive advance. Welcome to adulthood and outdoor plumbing.',
      ),
      EventChoice(
        text: 'Insult the agent and leave',
        statChanges: {'streetSense': 8, 'happiness': 5, 'reputation': -2},
        outcome:
            'You walked away. It felt good, but you are still sleeping on your friend\'s couch.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Landlord Wahala 🚪',
    description:
        'Your new landlord knocked on your door at 6 AM to complain that you keep the outside light on too late.',
    minAge: 23,
    maxAge: 25,
    choices: [
      EventChoice(
        text: 'Apologize and switch it off',
        statChanges: {'discipline': 8, 'reputation': 5, 'happiness': -5},
        outcome:
            'You humbled yourself. Peace was maintained, but now he complains about everything.',
      ),
      EventChoice(
        text: 'Argue that you pay for electricity',
        statChanges: {'streetSense': 10, 'reputation': -5, 'connections': -10},
        outcome:
            'You stood your ground! He threatened to evict you when your rent expires next year.',
      ),
    ],
  ),
  LifeEvent(
    title: 'First Solo Cooking 🔥',
    description:
        'You have moved out and decided to cook Jollof rice for the first time without your mother guiding you.',
    minAge: 22,
    maxAge: 25,
    choices: [
      EventChoice(
        text: 'Follow a YouTube tutorial exactly',
        statChanges: {'smarts': 8, 'health': 5, 'happiness': 5},
        outcome:
            'It actually tasted edible! A bit mushy, but a solid first attempt.',
      ),
      EventChoice(
        text: 'Trust your ancestral instincts',
        statChanges: {'streetSense': 5, 'health': -8, 'happiness': -5},
        outcome:
            'You burnt the rice and undercooked the tomato stew. You ordered pizza in defeat.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Managing Expenses 🧾',
    description:
        'It is the middle of the month and you have spent 80% of your money. Electricity tokens are running low.',
    minAge: 23,
    maxAge: 25,
    choices: [
      EventChoice(
        text: 'Create a strict starvation budget',
        statChanges: {'discipline': 12, 'health': -5, 'happiness': -8},
        outcome:
            'You ate eggs and bread for ten days straight, but the lights stayed on.',
      ),
      EventChoice(
        text: 'Borrow money to maintain lifestyle',
        statChanges: {'money': 5, 'streetSense': -5, 'reputation': -5},
        outcome:
            'You borrowed cash to go out on Friday. Next month will be even worse.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Couch Surfer 🛋️',
    description:
        'Your university friend wants to "squat" in your new apartment for two weeks while they job hunt.',
    minAge: 23,
    maxAge: 25,
    choices: [
      EventChoice(
        text: 'Let them stay for free',
        statChanges: {'connections': 12, 'money': -5, 'happiness': -5},
        outcome:
            'They stayed for three months and ate all your food. True friendship.',
      ),
      EventChoice(
        text: 'Tell them no with a fake excuse',
        statChanges: {'streetSense': 10, 'connections': -10, 'happiness': 5},
        outcome:
            'You claimed your sibling was visiting. You saved your peace and your groceries.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Buying Furniture 🛋️',
    description:
        'Your room is empty. You need a bed, but good mattresses are expensive.',
    minAge: 23,
    maxAge: 25,
    choices: [
      EventChoice(
        text: 'Buy a cheap local mattress',
        statChanges: {'money': 5, 'health': -8, 'happiness': -5},
        outcome:
            'You saved money, but woke up every morning with severe back pain.',
      ),
      EventChoice(
        text: 'Invest in a premium orthopedic bed',
        statChanges: {'health': 10, 'money': -12, 'happiness': 8},
        outcome:
            'You are broke, but sleeping like royalty on a cloud.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Living Alone Loneliness 🌧️',
    description:
        'It is raining heavily on a Saturday. You are sitting in your apartment completely alone for the first time.',
    minAge: 23,
    maxAge: 25,
    choices: [
      EventChoice(
        text: 'Enjoy the peace and quiet',
        statChanges: {'happiness': 8, 'health': 5, 'discipline': 5},
        outcome:
            'You read a book and drank tea. Adulthood tranquility unlocked.',
      ),
      EventChoice(
        text: 'Call everyone you know',
        statChanges: {'connections': 8, 'money': -2, 'happiness': 5},
        outcome:
            'You spent three hours on the phone curing your boredom through gossip.',
      ),
    ],
  ),

  // RELATIONSHIPS AND SOCIAL LIFE (7)
  LifeEvent(
    title: 'First Serious Relationship 💍',
    description:
        'You have been dating for a year. They want to officially introduce you to their strict parents this weekend.',
    minAge: 23,
    maxAge: 25,
    choices: [
      EventChoice(
        text: 'Dress formally and buy gifts',
        statChanges: {'money': -8, 'connections': 10, 'reputation': 10},
        outcome:
            'You bought an expensive wine and dressed like a banker. The parents loved you.',
      ),
      EventChoice(
        text: 'Go as your authentic self',
        statChanges: {'happiness': 5, 'reputation': -5, 'connections': -5},
        outcome:
            'You showed up in jeans. The father grilled you on your life plans for two hours.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Long Distance Drama 🌍',
    description:
        'Your partner traveled out of the country for a master\'s degree. The time zone difference is straining things.',
    minAge: 23,
    maxAge: 25,
    choices: [
      EventChoice(
        text: 'Stay awake until 3 AM to call them',
        statChanges: {'health': -10, 'connections': 10, 'happiness': -2},
        outcome:
            'You sacrificed sleep for love. Your performance at work is dropping fast.',
      ),
      EventChoice(
        text: 'Suggest taking a break',
        statChanges: {'discipline': 8, 'happiness': -10, 'connections': -12},
        outcome:
            'You initiated "the break". It hurt deeply, but your sleeping schedule improved.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Wedding Pressure 💒',
    description:
        'Three of your university friends got married this year. Your mother keeps asking when it is your turn.',
    minAge: 24,
    maxAge: 25,
    choices: [
      EventChoice(
        text: 'Laugh it off and change the topic',
        statChanges: {'streetSense': 8, 'happiness': 5, 'reputation': -2},
        outcome:
            'You smoothly dodged the question. She noticed, but let it go... for now.',
      ),
      EventChoice(
        text: 'Argue that you need to be financially stable',
        statChanges: {'discipline': 5, 'smarts': 5, 'happiness': -5},
        outcome:
            'You gave a logical explanation. She replied with "God will provide". Match drawn.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Groomsman / Bridesmaid Duty 👰',
    description:
        'Your friend asked you to be in their bridal party. The required fabric and shoes will cost almost your entire salary.',
    minAge: 23,
    maxAge: 25,
    choices: [
      EventChoice(
        text: 'Pay up and support them',
        statChanges: {'money': -15, 'connections': 15, 'reputation': 8},
        outcome:
            'You went broke buying the suit/dress, but you looked amazing in the photos.',
      ),
      EventChoice(
        text: 'Politely decline the role',
        statChanges: {'money': 10, 'connections': -10, 'reputation': -5},
        outcome:
            'You attended as a regular guest. Your bank account is safe, but your friend acted distant.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Social Media Envy 📱',
    description:
        'You opened Instagram. Your former classmate just bought a Benz and is vacationing in Dubai.',
    minAge: 22,
    maxAge: 25,
    choices: [
      EventChoice(
        text: 'Mute them for your peace of mind',
        statChanges: {'discipline': 8, 'happiness': 5, 'streetSense': 2},
        outcome:
            'You guarded your mental health. Out of sight, out of mind.',
      ),
      EventChoice(
        text: 'Make a fake "blessed" post',
        statChanges: {'looks': 5, 'reputation': 5, 'happiness': -8},
        outcome:
            'You posted an old picture at an expensive restaurant to keep up appearances. Exhausting.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Heartbreak Returns 💔',
    description:
        'The person who broke your heart in university just texted you "Hey stranger, I miss us".',
    minAge: 23,
    maxAge: 25,
    choices: [
      EventChoice(
        text: 'Ignore and block immediately',
        statChanges: {'discipline': 12, 'happiness': 5, 'health': 2},
        outcome:
            'You chose peace! Toxic cycles remain unbroken in your vicinity.',
      ),
      EventChoice(
        text: 'Reply with "Who is this?"',
        statChanges: {'streetSense': 10, 'reputation': 5, 'connections': -5},
        outcome:
            'You hit them with the ultimate disrespect. It felt incredibly satisfying.',
      ),
      EventChoice(
        text: 'Hear what they have to say',
        statChanges: {'happiness': -10, 'discipline': -10, 'health': -5},
        outcome:
            'You fell for it again. Two months later you are crying to the same playlist.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Weekend Turn Up 🍾',
    description:
        'It is Friday night. Your friends want to buy a VIP table at a new club in Osu.',
    minAge: 22,
    maxAge: 25,
    choices: [
      EventChoice(
        text: 'Go and split the bill',
        statChanges: {'money': -12, 'connections': 10, 'happiness': 8},
        outcome:
            'You partied like a rockstar. The next morning, looking at your bank app caused physical pain.',
      ),
      EventChoice(
        text: 'Say you have stomach issues and sleep',
        statChanges: {'money': 10, 'health': 5, 'streetSense': 5},
        outcome:
            'You slept effectively. You saw their stories the next day and had slight FOMO, but zero debt.',
      ),
    ],
  ),

  // HUSTLE AND AMBITION (7)
  LifeEvent(
    title: 'The Side Hustle 💼',
    description:
        'Your salary is not enough. You want to start selling perfumes or sneakers online.',
    minAge: 23,
    maxAge: 25,
    choices: [
      EventChoice(
        text: 'Create a page and start marketing',
        statChanges: {'discipline': 10, 'money': 5, 'streetSense': 8},
        outcome:
            'You became an Instagram vendor. It is stressful managing customers, but the extra cash helps.',
      ),
      EventChoice(
        text: 'Give up before starting',
        statChanges: {'happiness': -5, 'streetSense': -5, 'reputation': -2},
        outcome:
            'You decided the market was "too saturated". You remain broke but stress-free.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Pyramid Scheme 📉',
    description:
        'A sharp-looking guy from university invites you to a "wealth creation seminar" at a hotel.',
    minAge: 21,
    maxAge: 25,
    choices: [
      EventChoice(
        text: 'Invest your savings',
        statChanges: {'money': -15, 'smarts': -10, 'happiness': -12},
        outcome:
            'You bought the supplements. The company collapsed two months later. A harsh lesson.',
      ),
      EventChoice(
        text: 'Eat the free snacks and leave completely',
        statChanges: {'streetSense': 10, 'health': 2, 'money': 0},
        outcome:
            'You ate the meat pie, drank the malt, and blocked his number. Brilliant.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Visa Application ✈️',
    description:
        'You gathered your documents and applied for a work visa abroad. The process cost a fortune.',
    minAge: 24,
    maxAge: 25,
    choices: [
      EventChoice(
        text: 'Pray and wait anxiously', // We don't guarantee acceptance in the outcome without stat risk
        statChanges: {'money': -12, 'happiness': 15, 'reputation': 10},
        outcome:
            'Your visa was approved! The "I am relocating" photoshoot was legendary.',
      ),
      EventChoice(
        text: 'It got rejected unjustly',
        statChanges: {'money': -15, 'happiness': -15, 'health': -5},
        outcome:
            'Denied! They stamped your passport with rejection. You cried heavily into your pillow.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Master\'s Degree vs Work 📚',
    description:
        'You have been working for two years. Do you go back for your Master\'s or keep hustling?',
    minAge: 24,
    maxAge: 25,
    choices: [
      EventChoice(
        text: 'Resign and go to school full-time',
        statChanges: {'smarts': 15, 'money': -10, 'reputation': 5},
        outcome:
            'You are a student again. No salary, but you are building advanced knowledge.',
      ),
      EventChoice(
        text: 'Do a stressful evening/weekend program',
        statChanges: {'smarts': 10, 'health': -10, 'discipline': 15},
        outcome:
            'You work 9-5 and study 6-9. You have aged five years in two semesters.',
      ),
      EventChoice(
        text: 'Keep working, degrees are expensive',
        statChanges: {'money': 10, 'smarts': -5, 'streetSense': 5},
        outcome:
            'You stuck to the job. You gained more work experience while saving money.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Successful Peer 🚀',
    description:
        'Your mate from university just got featured on Forbes Africa 30 under 30.',
    minAge: 24,
    maxAge: 25,
    choices: [
      EventChoice(
        text: 'Congratulate them genuinely',
        statChanges: {'connections': 10, 'discipline': 5, 'happiness': 5},
        outcome:
            'You cheered them on. They appreciated it and even offered you some business advice.',
      ),
      EventChoice(
        text: 'Say "It\'s all connections"',
        statChanges: {'reputation': -8, 'streetSense': -5, 'happiness': -5},
        outcome:
            'You sounded extremely bitter. People noticed your jealousy and avoided you.',
      ),
    ],
  ),
  LifeEvent(
    title: 'First Car Dreams 🚗',
    description:
        'You saved up some money. It is enough for a very old, problematic car, or half a good one.',
    minAge: 24,
    maxAge: 25,
    choices: [
      EventChoice(
        text: 'Buy the old "Home Use" car',
        statChanges: {'money': -10, 'reputation': 8, 'happiness': -5},
        outcome:
            'You have a car! But you visit the mechanic more often than you visit your parents.',
      ),
      EventChoice(
        text: 'Keep using Uber/Trotro and save',
        statChanges: {'discipline': 10, 'money': 5, 'streetSense': 5},
        outcome:
            'You endured the public transport struggle. Your cash is safe, but the heat in trotros is real.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Family Expectation Meeting 👨‍👩‍👦',
    description:
        'Your family called a formal meeting. They want you to help pay your younger sibling\'s university fees.',
    minAge: 24,
    maxAge: 25,
    choices: [
      EventChoice(
        text: 'Agree to pay half',
        statChanges: {'money': -12, 'connections': 15, 'reputation': 10},
        outcome:
            'You took on the responsibility. Your budget is tight, but you are the family hero.',
      ),
      EventChoice(
        text: 'Tell them honestly you cannot afford it',
        statChanges: {'money': 5, 'reputation': -10, 'connections': -10},
        outcome:
            'You protected your savings, but family gatherings are extremely awkward now.',
      ),
    ],
  ),

  // ADDITIONAL EVENTS TO HIT FULL 50 QUOTA (Needs ~7 more)
  LifeEvent(
    title: 'Lost Trotro Fare 🚌',
    description:
        'You are in a trotro from Circle to Madina. The mate asks for money, and you realize your pocket is completely empty.',
    minAge: 22,
    maxAge: 25,
    choices: [
      EventChoice(
        text: 'Beg the mate for forgiveness',
        statChanges: {'reputation': -15, 'happiness': -10, 'streetSense': -5},
        outcome:
            'The mate insulted you thoroughly in front of everyone. You walked the rest of the way.',
      ),
      EventChoice(
        text: 'Ask the person next to you to pay',
        statChanges: {'connections': 5, 'reputation': -5, 'streetSense': 8},
        outcome:
            'A kind stranger paid for you. Ghanaian hospitality saved the day.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Gym Resolution 💪',
    description:
        'You paid for a 3-month gym subscription to get a "summer body".',
    minAge: 22,
    maxAge: 25,
    choices: [
      EventChoice(
        text: 'Go consistently at 5 AM',
        statChanges: {'health': 15, 'looks': 10, 'discipline': 15},
        outcome:
            'You got ripped. Clothes fit better and confidence is through the roof.',
      ),
      EventChoice(
        text: 'Go twice and never return',
        statChanges: {'money': -8, 'health': -5, 'discipline': -10},
        outcome:
            'You wasted the money. You convinced yourself that "dad bods" are in fashion now.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Tech Bro Pivot 💻',
    description:
        'Everyone in Accra is learning to code. You decided to try learning Python from YouTube.',
    minAge: 23,
    maxAge: 25,
    choices: [
      EventChoice(
        text: 'Stick with it through the bugs',
        statChanges: {'smarts': 12, 'discipline': 10, 'streetSense': 5},
        outcome:
            'You successfully wrote a basic app. Your brain hurts, but the tech journey has begun!',
      ),
      EventChoice(
        text: 'Quit after seeing "Syntax Error"',
        statChanges: {'happiness': 5, 'smarts': -5, 'discipline': -5},
        outcome:
            'You closed VS Code forever and went back to watching Netflix. Coding is not for everyone.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Pastor\'s Prophecy ⛪',
    description:
        'A visiting pastor pointed at you during service and said you need to sow a "seed of breakthrough".',
    minAge: 22,
    maxAge: 25,
    choices: [
      EventChoice(
        text: 'Give your last 200 GHS',
        statChanges: {'money': -10, 'reputation': 5, 'discipline': 5},
        outcome:
            'You sowed the seed in faith. You had to walk to work for a week though.',
      ),
      EventChoice(
        text: 'Hide in the crowd',
        statChanges: {'money': 5, 'streetSense': 8, 'reputation': -5},
        outcome:
            'You ducked your head and dodged the offering bowl. Your money was saved.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Wardrobe Malfunction at Work 👖',
    description:
        'You bent down to pick up a pen in the office and heard a massive TEAR. Your trousers just split.',
    minAge: 23,
    maxAge: 25,
    choices: [
      EventChoice(
        text: 'Walk weirdly like a crab all day',
        statChanges: {'looks': -10, 'reputation': -5, 'happiness': -8},
        outcome:
            'You crab-walked backward for 8 hours. Everyone thought you were having a medical episode.',
      ),
      EventChoice(
        text: 'Staple it in the washroom',
        statChanges: {'streetSense': 15, 'looks': -5, 'discipline': 5},
        outcome:
            'MacGyver skills! The staples held all day, though sitting down was quite dangerous.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Police Checkpoint 👮',
    description:
        'You are in an Uber late at night. The police stop the car and ask the driver for papers, then look at you suspiciously.',
    minAge: 23,
    maxAge: 25,
    choices: [
      EventChoice(
        text: 'Show your work ID confidently',
        statChanges: {'streetSense': 8, 'reputation': 5, 'connections': 2},
        outcome:
            'You flashed the corporate badge. They saluted you and let the car go. Status matters.',
      ),
      EventChoice(
        text: 'Argue about your constitutional rights',
        statChanges: {'discipline': -10, 'streetSense': -10, 'happiness': -15},
        outcome:
            'They ordered you out of the car and searched your bag for an hour out of spite.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Running into an Ex 😬',
    description:
        'You are looking terrible, buying waakye on a Saturday morning, and your ex pulls up in a nice car.',
    minAge: 23,
    maxAge: 25,
    choices: [
      EventChoice(
        text: 'Hide behind the waakye seller',
        statChanges: {'reputation': -10, 'looks': -5, 'streetSense': 5},
        outcome:
            'You crouched behind the massive pot. They didn\'t see you, but you lost all your dignity.',
      ),
      EventChoice(
        text: 'Say hello confidently with your rubber bag',
        statChanges: {'reputation': 8, 'discipline': 5, 'happiness': 2},
        outcome:
            'You owned your struggle look. They actually seemed happy and impressed to see you.',
      ),
    ],
  ),
];
