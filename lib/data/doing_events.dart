import '../models/event.dart';

final List<LifeEvent> doingEvents = [
  // ── HOUSING EVENTS ────────────────────────────────────────────────────────

  LifeEvent(
    title: 'Landlord Raises Rent 😤',
    description:
        'Your landlord has appeared at your door wearing a new suit. He says the economy is hard and your rent is going up — effective next month. The audacity.',
    minAge: 18,
    maxAge: 60,
    requiredHousingStatus: 'Renting',
    choices: [
      EventChoice(
        text: 'Pay the higher rent (money -3, stay renting)',
        statChanges: {'money': -3},
        outcome:
            'You paid. You smiled. You cried inside. The landlord whistled as he walked away. Such is life.',
      ),
      EventChoice(
        text: 'Move back home to your parents (happiness -10)',
        statChanges: {'happiness': -10},
        outcome:
            'You packed your bags and went back to your parents\' house. Your mother made you soup. Your father said nothing. The silence was louder than words.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Neighbour from Hell Moves In 👿',
    description:
        'A new neighbour has moved in next door. They blast highlife at 2am, fry fish at 6am, and somehow always need to borrow something. Your peace is gone.',
    minAge: 18,
    maxAge: 65,
    requiredHousingStatus: 'Renting',
    choices: [
      EventChoice(
        text: 'Complain to the landlord (happiness +5)',
        statChanges: {'happiness': 5, 'connections': 3},
        outcome:
            'The landlord had a word. Things improved slightly. You and the neighbour now exchange suspicious nods in the corridor. Progress.',
      ),
      EventChoice(
        text: 'Ignore it and suffer in silence (happiness -5)',
        statChanges: {'happiness': -5},
        outcome:
            'You bought earplugs. You learned to sleep through highlife. You are either very disciplined or slowly losing your mind. Hard to tell.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Roof Leaks in Rainy Season 🌧️',
    description:
        'The rains have come and your roof has decided to become a waterfall. Buckets are everywhere. Your ceiling fan is now a sprinkler.',
    minAge: 25,
    maxAge: 80,
    requiredHousingStatus: 'Homeowner',
    choices: [
      EventChoice(
        text: 'Repair it properly (money -4, happiness +5)',
        statChanges: {'money': -4, 'happiness': 5},
        outcome:
            'You hired a proper roofing man. The job is done. Your house is dry. Your wallet is lighter. The bucket is now retired.',
      ),
      EventChoice(
        text: 'Patch it yourself with what you have (money -1, happiness -3)',
        statChanges: {'money': -1, 'happiness': -3},
        outcome:
            'Nails, old zinc, and prayers. The patch held for two weeks before it started leaking in a new spot. The bucket is back on duty.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Someone Wants to Rent Part of Your House 🏠',
    description:
        'A young person is looking for a room to rent and someone sent them your way. Your spare room has been collecting dust for years. Time to make it work?',
    minAge: 28,
    maxAge: 70,
    requiredHousingStatus: 'Homeowner',
    choices: [
      EventChoice(
        text: 'Accept the tenant (money +8, happiness -3)',
        statChanges: {'money': 8, 'happiness': -3},
        outcome:
            'You accepted. The money is good. But now someone is cooking in your kitchen at odd hours and your remote is always missing. Trade-offs.',
      ),
      EventChoice(
        text: 'Decline — your peace is not for sale',
        statChanges: {},
        outcome:
            'You kept your space. Quiet evenings. No unexpected guests. Your spare room remains a storage unit for things you will never use.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Family Member Wants to Move In 👨‍👩‍👧',
    description:
        'A family member has called. They need a place to stay — "just for a few months." You own a home now. In Ghana, that means you have a guesthouse. Permanently.',
    minAge: 28,
    maxAge: 75,
    requiredHousingStatus: 'Homeowner',
    choices: [
      EventChoice(
        text: 'Welcome them with open arms (happiness -5, reputation +10)',
        statChanges: {'happiness': -5, 'reputation': 10},
        outcome:
            'They moved in. The whole extended family now calls you a good person. Your fridge is emptier than before. You are beloved. Congratulations.',
      ),
      EventChoice(
        text: 'Gently say no (happiness +10, reputation -5)',
        statChanges: {'happiness': 10, 'reputation': -5},
        outcome:
            'You said no. You slept well that night. Word spread in the family group chat. Auntie Grace has things to say. She always has things to say.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Utility Bills Shock ⚡',
    description:
        'ECG and Ghana Water have delivered bills that look like phone numbers. You don\'t know how. You don\'t know why. You just know your bank account is scared.',
    minAge: 18,
    maxAge: 70,
    requiredHousingStatus: 'Renting',
    choices: [
      EventChoice(
        text: 'Pay on time like a responsible adult (money -2)',
        statChanges: {'money': -2},
        outcome:
            'Paid. Receipt collected. Filed appropriately. Your light stays on. You are an adult and you hate it.',
      ),
      EventChoice(
        text: 'Delay payment and deal with consequences (happiness -3, reputation -5)',
        statChanges: {'happiness': -3, 'reputation': -5},
        outcome:
            'They disconnected your water. Your neighbour lent you a bucket. The whole compound knows your business now. Very humbling.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Accra Flooding — Your Room is a Swimming Pool 🌊',
    description:
        'The rains came heavier than usual. The gutters couldn\'t handle it. Neither could your ground floor room. Your mattress is now a raft.',
    minAge: 18,
    maxAge: 60,
    requiredHousingStatus: 'Renting',
    choices: [
      EventChoice(
        text: 'Emergency repairs and dehumidifiers (money -5, happiness -5)',
        statChanges: {'money': -5, 'happiness': -5},
        outcome:
            'You salvaged what you could. The repairs cost plenty. Your landlord blames the government. The government blames the people. You blame everyone.',
      ),
      EventChoice(
        text: 'Stay at a friend\'s place until it dries out (happiness -8, connections +5)',
        statChanges: {'happiness': -8, 'connections': 5},
        outcome:
            'Your friend took you in. You slept on a sofa for two weeks. You are grateful and also very tired of their dog. Real friendships are tested by flood season.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Big Offer for Your House 💰',
    description:
        'A developer has knocked on your door with an envelope. Inside is an offer to buy your house at double the value. The area is being redeveloped. This is a lot of money.',
    minAge: 30,
    maxAge: 80,
    requiredHousingStatus: 'Homeowner',
    choices: [
      EventChoice(
        text: 'Sell the house and cash out (money +30)',
        statChanges: {'money': 30},
        outcome:
            'You sold. The money hit your account and you felt briefly like a whole new person. Now you are renting again. Still — that was a great payday.',
      ),
      EventChoice(
        text: 'Keep it — this is your home, not a commodity',
        statChanges: {},
        outcome:
            'You kept your home. The developer built around you. Your house is now surrounded by a mall. The location is actually more valuable now. Good instinct.',
      ),
    ],
  ),

  // ── BUSINESS EVENTS ───────────────────────────────────────────────────────

  LifeEvent(
    title: 'Worker Steals from the Till 😡',
    description:
        'You noticed the books don\'t balance. Then you checked the CCTV. Then you sat down and had a long conversation with yourself about trust.',
    minAge: 18,
    maxAge: 80,
    requiresBusiness: true,
    choices: [
      EventChoice(
        text: 'Fire them immediately (businessHealth -5, discipline +5)',
        statChanges: {'discipline': 5},
        outcome:
            'You fired them on the spot. Word spread among the staff. Everyone now keeps their hands where you can see them. Discipline restored.',
      ),
      EventChoice(
        text: 'Give a final warning and document it (happiness -3)',
        statChanges: {'happiness': -3},
        outcome:
            'You gave them a warning. They looked remorseful. You are either merciful or naive. The money is still missing either way.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Dumsor Kills Your Stock ⚡',
    description:
        'ECG struck again. The power went off for 18 hours. Your freezer items are ruined. Your fridge is warm. Your mood matches.',
    minAge: 18,
    maxAge: 80,
    requiresBusiness: true,
    choices: [
      EventChoice(
        text: 'Invest in a generator (money -5, businessHealth +10)',
        statChanges: {'money': -5},
        outcome:
            'You bought a generator. The noise is considerable. The fuel costs are painful. But your stock is safe and that matters more.',
      ),
      EventChoice(
        text: 'Absorb the loss and carry on (money -3, businessHealth -5)',
        statChanges: {'money': -3},
        outcome:
            'You wrote off the stock, smiled at your customers, and carried on like a true entrepreneur. Dumsor has beaten better people than you. Not today though.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Big Catering Order Lands 🍽️',
    description:
        'A wedding planner has called. They want you to cater for 300 people next weekend. It is more than you\'ve ever done. The money is real. So is the risk.',
    minAge: 18,
    maxAge: 70,
    requiresBusiness: true,
    choices: [
      EventChoice(
        text: 'Take the risk — go big or go home',
        statChanges: {'money': 10, 'reputation': 5},
        outcome:
            'You pulled it off! The food was excellent, the bride cried happy tears, and three more wedding bookings came in the same week. You are now catering royalty.',
      ),
      EventChoice(
        text: 'Decline — too much risk for now',
        statChanges: {},
        outcome:
            'You passed on the order. Responsible decision. Another caterer took it and completely messed it up. You feel both relieved and slightly smug.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Business Goes Viral on TikTok 📱',
    description:
        'Someone recorded your business and posted it online. The video has 200,000 views. People are tagging friends. Your phone has not stopped ringing.',
    minAge: 18,
    maxAge: 60,
    requiresBusiness: true,
    choices: [
      EventChoice(
        text: 'Ride the wave — post more content, engage the crowd (reputation +10)',
        statChanges: {'reputation': 10},
        outcome:
            'You leaned in. More videos, a proper Instagram page, a WhatsApp business line. Sales doubled. You are now an "entrepreneur content creator." Your grandmother doesn\'t understand but she\'s proud.',
      ),
      EventChoice(
        text: 'Ignore the hype and just keep working',
        statChanges: {},
        outcome:
            'You kept your head down. The hype faded in two weeks. But a few loyal customers from that wave still come in regularly. Quiet wins are still wins.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Tax Officer Pays a Visit 🕴️',
    description:
        'A man in a government shirt has appeared at your business. He has a clipboard, a very serious face, and a strong suggestion that things can be "made easier" for a small consideration.',
    minAge: 20,
    maxAge: 75,
    requiresBusiness: true,
    choices: [
      EventChoice(
        text: 'Settle it quietly (money -4, discipline -5)',
        statChanges: {'money': -4, 'discipline': -5},
        outcome:
            'You paid the "consideration." He left smiling. You are now on his regular route. This is Ghana — sometimes the path of least resistance is also the most expensive.',
      ),
      EventChoice(
        text: 'Stand firm and demand a proper process (reputation +10, risk money -8)',
        statChanges: {'reputation': 10, 'money': -8},
        outcome:
            'You stood your ground. He escalated. There were proper audits, proper fines, and a lot of paperwork. But your conscience is clean and your reputation in the business community is solid.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Competitor Opens Right Next Door 😬',
    description:
        'You arrived one Monday morning to find a brand new shop opening literally next door to yours. Same products. Same colours. They are even playing the same music. The audacity.',
    minAge: 18,
    maxAge: 75,
    requiresBusiness: true,
    choices: [
      EventChoice(
        text: 'Lower your prices to win customers back (reputation +5)',
        statChanges: {'reputation': 5},
        outcome:
            'Your prices went down. Customers noticed and appreciated you. The competitor struggled to match you. You are still standing. They may not be for long.',
      ),
      EventChoice(
        text: 'Improve your service — quality over price (money -3)',
        statChanges: {'money': -3},
        outcome:
            'You invested in training, presentation, and customer experience. Your loyal customers stayed loyal. The new shop got the bargain hunters. You got the quality seekers.',
      ),
      EventChoice(
        text: 'Do nothing — let the market decide',
        statChanges: {'reputation': -5},
        outcome:
            'You did nothing. Some customers drifted. Your reputation for being the best in the area took a small knock. The market has spoken. You may need to respond eventually.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Loyal Customer Becomes Your Brand Ambassador 🌟',
    description:
        'Mama Efua has been coming to your business since the first week. Today she posted about you on Facebook. The comments are on fire. She is telling everyone about you unprompted.',
    minAge: 18,
    maxAge: 75,
    requiresBusiness: true,
    choices: [
      EventChoice(
        text: 'Reward her loyalty publicly (money -2, reputation +5)',
        statChanges: {'money': -2, 'reputation': 5},
        outcome:
            'You gave Mama Efua a discount card and a free item. She posted about it too. Now everyone wants to be a loyal customer. Genius marketing. Accidental genius, but still.',
      ),
      EventChoice(
        text: 'Just say thank you and keep it moving',
        statChanges: {'reputation': 3},
        outcome:
            'You thanked her warmly. She appreciated it. She keeps posting. Not every business move needs to be transactional. Sometimes gratitude is enough.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Staff Member Asks for a Loan 🙏',
    description:
        'Your most reliable worker has come to your office. Their child needs school fees. They are asking to borrow from you directly. They will pay back monthly. Probably.',
    minAge: 20,
    maxAge: 75,
    requiresBusiness: true,
    choices: [
      EventChoice(
        text: 'Give the loan — you can afford to help (money -5, reputation +5, discipline -3)',
        statChanges: {'money': -5, 'reputation': 5, 'discipline': -3},
        outcome:
            'You gave the loan. They cried with gratitude. Monthly repayments started strong, then became occasional, then became a topic nobody mentions. But the child is in school. That counts.',
      ),
      EventChoice(
        text: 'Refuse — mixing business and personal is trouble (reputation -3, discipline +5)',
        statChanges: {'reputation': -3, 'discipline': 5},
        outcome:
            'You said no, firmly but respectfully. They understood — or said they did. The working relationship is slightly frostier now. Your accounts are clean though.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Business Equipment Breaks Down 🔧',
    description:
        'The main equipment your business depends on has given up the ghost. Right in the middle of a busy week. The repair man says it is very serious. His face confirms it.',
    minAge: 18,
    maxAge: 75,
    requiresBusiness: true,
    choices: [
      EventChoice(
        text: 'Fix it immediately — no business without equipment (money -4)',
        statChanges: {'money': -4},
        outcome:
            'You called the best repair man in town. He fixed it properly. Business resumed. The downtime cost you but the comeback was smooth. Invest in maintenance next time.',
      ),
      EventChoice(
        text: 'Keep limping along with the broken equipment',
        statChanges: {'reputation': -5},
        outcome:
            'You managed. Customers noticed the slowdowns. Some complained. Some left. The equipment eventually failed completely and cost even more to fix. False economy.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Bad Batch of Stock Arrives 📦',
    description:
        'Your supplier delivered a batch that is clearly substandard. Some customers have already bought and are calling you. Your supplier is not picking up.',
    minAge: 18,
    maxAge: 75,
    requiresBusiness: true,
    choices: [
      EventChoice(
        text: 'Refund every customer and take the loss (money -6, reputation +15)',
        statChanges: {'money': -6, 'reputation': 15},
        outcome:
            'You refunded everyone without question. It hurt your wallet badly. But people talked about your honesty for months. New customers came because of your reputation. Long game won.',
      ),
      EventChoice(
        text: 'Sell it anyway and hope nobody notices (reputation -15, money +3)',
        statChanges: {'reputation': -15, 'money': 3},
        outcome:
            'Three customers complained loudly on social media. Screenshots spread. People said your business had "fallen." You made a small profit and lost a large reputation. Not worth it.',
      ),
    ],
  ),
];
