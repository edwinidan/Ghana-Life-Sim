import '../models/event.dart';

final List<LifeEvent> adultEvents = [
  // EXISTING (3)
  LifeEvent(
    title: 'Health Scare 🏥',
    description:
        'You have not been feeling well for weeks. Something is clearly wrong.',
    minAge: 30,
    maxAge: 49,
    choices: [
      EventChoice(
        text: 'Go to a specialist hospital',
        statChanges: {'health': 15, 'money': -15, 'happiness': 5},
        outcome:
            'The tests were expensive, but they found the issue early and treated it.',
      ),
      EventChoice(
        text: 'Self-medicate with herbal bitters',
        statChanges: {'health': -10, 'money': 2, 'discipline': -5},
        outcome:
            'You drank the bitters. You feel worse, and now your breath smells awful.',
      ),
      EventChoice(
        text: 'Go to a prayer camp',
        statChanges: {'health': -5, 'happiness': 5, 'money': -5},
        outcome:
            'You fasted for three days. You feel spiritually renewed, but physically weaker.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Family Pressure 👨‍👩‍👧‍👦',
    description:
        'Your extended family expects you to pay for your cousin\'s naming ceremony.',
    minAge: 26,
    maxAge: 45,
    choices: [
      EventChoice(
        text: 'Pay for everything',
        statChanges: {'money': -15, 'reputation': 10, 'connections': 10},
        outcome:
            'You sponsored the event. The family sings your praises, but your bank account is crying.',
      ),
      EventChoice(
        text: 'Contribute a small token',
        statChanges: {'money': -5, 'reputation': -5, 'streetSense': 5},
        outcome:
            'You gave what you could. They accepted it with passive-aggressive remarks.',
      ),
      EventChoice(
        text: 'Refuse completely',
        statChanges: {'money': 5, 'reputation': -15, 'connections': -10},
        outcome:
            'You said no. You are now the official villain in the family WhatsApp group.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Unexpected Money 💰',
    description: 'An old investment finally matured, paying out a huge sum.',
    minAge: 35,
    maxAge: 49,
    choices: [
      EventChoice(
        text: 'Reinvest it long-term',
        statChanges: {'money': 8, 'smarts': 5, 'discipline': 10},
        outcome:
            'You locked it away in treasury bills. Pure adulting.',
      ),
      EventChoice(
        text: 'Buy a piece of land',
        statChanges: {'money': -5, 'streetSense': 10, 'reputation': 8},
        outcome:
            'You bought land in Aburi. Now the stress of building begins.',
      ),
      EventChoice(
        text: 'Upgrade your car',
        statChanges: {'money': -10, 'looks': 10, 'happiness': 10},
        outcome:
            'You bought a fresh SUV. You look successful, even if the fuel kills your salary.',
      ),
    ],
  ),

  // CAREER AND WORK (8)
  LifeEvent(
    title: 'Major Promotion 📈',
    description:
        'You have been offered the role of Regional Manager, but it means firing two of your friends.',
    minAge: 30,
    maxAge: 45,
    choices: [
      EventChoice(
        text: 'Take the job and fire them',
        statChanges: {'money': 15, 'reputation': 5, 'connections': -15},
        outcome:
            'You secured the bag. Your former friends blocked you, but the CEO respected your tough call.',
      ),
      EventChoice(
        text: 'Reject the promotion for friendship',
        statChanges: {'money': -10, 'connections': 10, 'reputation': -5},
        outcome:
            'You saved their jobs. A year later, one of them took the promotion and fired you.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Promotion Denied 🛑',
    description:
        'You worked weekends for two years, but the Director gave the promotion to his incompetent nephew.',
    minAge: 28,
    maxAge: 45,
    choices: [
      EventChoice(
        text: 'Resign immediately in protest',
        statChanges: {'money': -15, 'reputation': 10, 'happiness': 5},
        outcome:
            'You dropped the resignation letter. It felt amazing until rent was due.',
      ),
      EventChoice(
        text: 'Stay and plot your exit quietly',
        statChanges: {'discipline': 10, 'smarts': 8, 'happiness': -8},
        outcome:
            'You smiled through the pain while aggressively updating your LinkedIn.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Toxic Boss 😠',
    description:
        'Your new boss screams at employees during meetings and calls you incompetent in front of clients.',
    minAge: 26,
    maxAge: 49,
    choices: [
      EventChoice(
        text: 'Report them to HR',
        statChanges: {'streetSense': -5, 'reputation': 5, 'discipline': 5},
        outcome:
            'HR investigated, but your boss survived. Your work life is now a living hell.',
      ),
      EventChoice(
        text: 'Scream back at them',
        statChanges: {'happiness': 10, 'reputation': -10, 'money': -10},
        outcome:
            'You gave them a piece of your mind! You were fired on the spot, but became a legend.',
      ),
      EventChoice(
        text: 'Endure it and pray',
        statChanges: {'health': -10, 'happiness': -10, 'discipline': 8},
        outcome:
            'You swallowed your pride. Your blood pressure went up, but your salary remained steady.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Retrenchment 📉',
    description:
        'The company is downsizing. You have been handed a redundancy letter with two months severance.',
    minAge: 28,
    maxAge: 49,
    choices: [
      EventChoice(
        text: 'Use the money to start a business',
        statChanges: {'money': -5, 'streetSense': 10, 'discipline': 5},
        outcome:
            'You became an entrepreneur. It is much harder than it looks, but you are trying.',
      ),
      EventChoice(
        text: 'Live on the severance while job hunting',
        statChanges: {'happiness': 5, 'health': 5, 'money': -10},
        outcome:
            'You rested for two months, then panicked when the account hit zero.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Career Switch 🔄',
    description:
        'You are tired of your banking job. You want to switch to tech, but it means starting from the bottom.',
    minAge: 28,
    maxAge: 40,
    choices: [
      EventChoice(
        text: 'Take the bold leap',
        statChanges: {'money': -10, 'smarts': 12, 'happiness': 8},
        outcome:
            'You took a massive pay cut to learn. It is painful now, but the future looks bright.',
      ),
      EventChoice(
        text: 'Stay in the miserable secure job',
        statChanges: {'money': 8, 'happiness': -10, 'health': -5},
        outcome:
            'You wore your suit and went to the bank. Safety won over passion.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Starting a Business 🏢',
    description:
        'You finally registered your own company. The reality of paying bills without a steady salary hits you.',
    minAge: 28,
    maxAge: 49,
    choices: [
      EventChoice(
        text: 'Hustle 24/7 to find clients',
        statChanges: {'health': -10, 'money': 10, 'reputation': 8},
        outcome:
            'You barely slept, but secured your first major contract. You are a CEO now.',
      ),
      EventChoice(
        text: 'Rely on friends and family for patronage',
        statChanges: {'connections': -5, 'money': -5, 'reputation': -5},
        outcome:
            'They asked for discounts and didn\'t pay. Never mix family with early business.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Partner Betrayal 🐍',
    description:
        'You discovered your business partner has been funnelling company funds into a private account.',
    minAge: 30,
    maxAge: 49,
    choices: [
      EventChoice(
        text: 'Involve the police immediately',
        statChanges: {'reputation': 5, 'money': 5, 'connections': -10},
        outcome:
            'They were arrested. The business collapsed during the scandal, but justice was served.',
      ),
      EventChoice(
        text: 'Confront them privately to recover the money',
        statChanges: {'streetSense': 10, 'money': 10, 'reputation': -5},
        outcome:
            'You threatened them and got your share back, then dissolved the company quietly.',
      ),
    ],
  ),
  LifeEvent(
    title: 'First Hire 🤝',
    description:
        'Your business is growing. You need to hire someone to manage operations.',
    minAge: 29,
    maxAge: 49,
    choices: [
      EventChoice(
        text: 'Hire a qualified stranger',
        statChanges: {'smarts': 8, 'money': -5, 'reputation': 5},
        outcome:
            'You hired a professional. They lack emotional investment, but the work gets done perfectly.',
      ),
      EventChoice(
        text: 'Hire your unemployed cousin',
        statChanges: {'connections': 8, 'reputation': -5, 'discipline': -10},
        outcome:
            'Your cousin shows up at 11 AM daily and calls you "Bro" in front of clients.',
      ),
    ],
  ),

  // MARRIAGE AND RELATIONSHIPS (7)
  LifeEvent(
    title: 'The Proposal 💍',
    description:
        'You are ready to propose. Do you do it in public or private?',
    minAge: 26,
    maxAge: 35,
    choices: [
      EventChoice(
        text: 'A flashy restaurant proposal with cameras',
        statChanges: {'reputation': 10, 'money': -8, 'happiness': 5},
        outcome:
            'They said yes! The video went mildly viral on Ghanaian Twitter.',
      ),
      EventChoice(
        text: 'A quiet, intimate proposal at home',
        statChanges: {'happiness': 10, 'connections': 5, 'reputation': -2},
        outcome:
            'It was beautiful and heartfelt. No pressure, just pure love.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Wedding Costs 💒',
    description:
        'The wedding budget has tripled. The in-laws want 500 guests and a live band.',
    minAge: 27,
    maxAge: 38,
    choices: [
      EventChoice(
        text: 'Take a bank loan to fund it',
        statChanges: {'money': -15, 'reputation': 10, 'connections': 8},
        outcome:
            'The wedding was the talk of the town! Now you are starting marriage in severe debt.',
      ),
      EventChoice(
        text: 'Put your foot down: 100 guests only',
        statChanges: {'discipline': 12, 'money': 10, 'connections': -10},
        outcome:
            'You saved your finances, but the extended family called you stingy and wicked.',
      ),
    ],
  ),
  LifeEvent(
    title: 'In-Law Palava 🗣️',
    description:
        'Your mother-in-law visited for a week and has rearranged your entire kitchen and criticized your cooking.',
    minAge: 28,
    maxAge: 45,
    choices: [
      EventChoice(
        text: 'Smile and endure it',
        statChanges: {'discipline': 8, 'happiness': -10, 'connections': 5},
        outcome:
            'You swallowed your pride. She praised your "humility" to the rest of the family.',
      ),
      EventChoice(
        text: 'Tell your spouse to intervene',
        statChanges: {'connections': -5, 'happiness': 5, 'streetSense': 5},
        outcome:
            'Your spouse spoke to her. She packed her bags early, muttering about disrespect.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Communication Breakdown 🔇',
    description:
        'You and your partner have barely spoken to each other for a month outside of logistics.',
    minAge: 30,
    maxAge: 49,
    choices: [
      EventChoice(
        text: 'Suggest couples therapy',
        statChanges: {'smarts': 10, 'happiness': 5, 'money': -5},
        outcome:
            'Therapy was emotionally draining but it saved the marriage.',
      ),
      EventChoice(
        text: 'Ignore it and focus on work',
        statChanges: {'money': 5, 'happiness': -15, 'health': -5},
        outcome:
            'The emotional distance grew wider. You are basically roommates now.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Infidelity Rumor 💔',
    description:
        'A relative claims they saw your spouse at a hotel with someone else.',
    minAge: 30,
    maxAge: 49,
    choices: [
      EventChoice(
        text: 'Confront your spouse immediately',
        statChanges: {'streetSense': 5, 'happiness': -10, 'reputation': -5},
        outcome:
            'It turned out to be a work colleague at a conference. The lack of trust hurt the marriage.',
      ),
      EventChoice(
        text: 'Investigate quietly first',
        statChanges: {'smarts': 10, 'discipline': 5, 'health': -5},
        outcome:
            'You verified it was false before bringing it up. You dodged a massive fight.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The D-Word 📄',
    description:
        'Things have gotten so bad that divorce is officially on the table.',
    minAge: 32,
    maxAge: 49,
    choices: [
      EventChoice(
        text: 'Fight to keep the marriage',
        statChanges: {'discipline': 10, 'happiness': -5, 'health': -8},
        outcome:
            'You both decided to try again. It is difficult work, but progress is happening.',
      ),
      EventChoice(
        text: 'Agree to an amicable split',
        statChanges: {'money': -15, 'happiness': 5, 'reputation': -10},
        outcome:
            'The legal fees destroyed your savings, but the peace of mind is priceless.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Taking Sides ⚖️',
    description:
        'Your best friend is going through a messy divorce. Both parties are calling you to complain.',
    minAge: 28,
    maxAge: 45,
    choices: [
      EventChoice(
        text: 'Support your friend blindly',
        statChanges: {'connections': 10, 'reputation': -5, 'smarts': -5},
        outcome:
            'You cut off their ex. Your loyalty is unquestioned.',
      ),
      EventChoice(
        text: 'Try to remain neutral',
        statChanges: {'reputation': 5, 'connections': -10, 'happiness': -5},
        outcome:
            'Both sides accused you of being a fake friend and blocked you.',
      ),
    ],
  ),

  // CHILDREN AND PARENTING (5)
  LifeEvent(
    title: 'Expecting a Child 🍼',
    description:
        'You just saw two lines on the test. You are going to be a parent.',
    minAge: 26,
    maxAge: 40,
    choices: [
      EventChoice(
        text: 'Celebrate and buy baby gear immediately',
        statChanges: {'happiness': 15, 'money': -10, 'reputation': 5},
        outcome:
            'You spent a ridiculous amount on a fancy crib. The joy is overwhelming.',
      ),
      EventChoice(
        text: 'Panic about the economy and your finances',
        statChanges: {'health': -5, 'smarts': 8, 'happiness': -5},
        outcome:
            'You spent the night creating an enormous excel sheet of projected pediatric costs.',
      ),
    ],
  ),
  LifeEvent(
    title: 'School Failure 📉',
    description:
        'Your 10-year-old brought home a report card with terrible grades in Maths and English.',
    minAge: 35,
    maxAge: 49,
    choices: [
      EventChoice(
        text: 'Get an expensive private tutor',
        statChanges: {'money': -10, 'smarts': 8, 'happiness': 5},
        outcome:
            'The tutor helped immensely. Your child improved, but your wallet suffered.',
      ),
      EventChoice(
        text: 'Yell and threaten them',
        statChanges: {'connections': -10, 'happiness': -8, 'discipline': 5},
        outcome:
            'They passed out of fear next term, but they stopped telling you their problems.',
      ),
      EventChoice(
        text: 'Teach them yourself every evening',
        statChanges: {'connections': 10, 'health': -5, 'money': 5},
        outcome:
            'You lost sleep, but the bonding experience and the eventual improvement were worth it.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Teenage Rebellion 🚪',
    description:
        'Your teenager slammed the door in your face and told you that you "ruined their life".',
    minAge: 38,
    maxAge: 49,
    choices: [
      EventChoice(
        text: 'Kick the door open and assert dominance',
        statChanges: {'reputation': 5, 'connections': -10, 'happiness': -8},
        outcome:
            'You reminded them whose house it is. The tension in the house is now thick enough to cut.',
      ),
      EventChoice(
        text: 'Walk away and let them cool off',
        statChanges: {'discipline': 10, 'smarts': 5, 'connections': 5},
        outcome:
            'They apologized the next morning. Patience won the war.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Work-Life Balance ⚖️',
    description:
        'Your child\'s school play is on the same day as a massive client pitch at work.',
    minAge: 32,
    maxAge: 45,
    choices: [
      EventChoice(
        text: 'Go to the play',
        statChanges: {'happiness': 10, 'connections': 10, 'money': -10},
        outcome:
            'You missed the pitch. You lost the account, but your child\'s smile was priceless.',
      ),
      EventChoice(
        text: 'Go to the pitch',
        statChanges: {'money': 10, 'reputation': 5, 'happiness': -10},
        outcome:
            'You secured the client, but missed the tree costume performance. Guilt is eating you.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Serious Trouble 🚨',
    description:
        'You received a call from the headmaster. Your child was caught stealing at school.',
    minAge: 35,
    maxAge: 49,
    choices: [
      EventChoice(
        text: 'Defend your child aggressively',
        statChanges: {'reputation': -10, 'streetSense': -5, 'connections': 5},
        outcome:
            'You fought the school. Your child escaped punishment, but learned the wrong lesson.',
      ),
      EventChoice(
        text: 'Support the school\'s severe punishment',
        statChanges: {'discipline': 15, 'reputation': 5, 'connections': -10},
        outcome:
            'Your child was suspended. It was a harsh reality check they desperately needed.',
      ),
    ],
  ),

  // MONEY AND FINANCIAL DECISIONS (6)
  LifeEvent(
    title: 'Big Loan 🏦',
    description:
        'You want to take a massive bank loan to start a poultry farm.',
    minAge: 30,
    maxAge: 49,
    choices: [
      EventChoice(
        text: 'Take the loan and risk it all',
        statChanges: {'money': 15, 'streetSense': 10, 'health': -10},
        outcome:
            'The farm succeeded! But the anxiety of loan deductions took years off your life.',
      ),
      EventChoice(
        text: 'Save slowly instead',
        statChanges: {'discipline': 10, 'money': -5, 'happiness': 5},
        outcome:
            'You avoided debt, but inflation ate your savings. The dream is delayed indefinitely.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Ponzi Scheme 📉',
    description:
        'A friend pitches to you: "Invest 5,000 GHS and get 15,000 GHS in two weeks. It is perfectly legal." do you?',
    minAge: 26,
    maxAge: 49,
    choices: [
      EventChoice(
        text: 'Invest your savings',
        statChanges: {'money': -15, 'smarts': -15, 'happiness': -10},
        outcome:
            'The company vanished three days before your payout. The tears were acidic.',
      ),
      EventChoice(
        text: 'Refuse firmly',
        statChanges: {'smarts': 10, 'money': 5, 'discipline': 5},
        outcome:
            'You watched your friend lose everything while your unmultiplied money sat safely in the bank.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Borrowing Request 💸',
    description:
        'Your closest friend begs you for 10,000 GHS for a "medical emergency". You have exactly 12,000 GHS saved.',
    minAge: 28,
    maxAge: 49,
    choices: [
      EventChoice(
        text: 'Lend them the full amount',
        statChanges: {'money': -12, 'connections': 10, 'reputation': 5},
        outcome:
            'You saved their life. They paid it back... three years later in installments.',
      ),
      EventChoice(
        text: 'Lend them 2,000 GHS and say it is a gift',
        statChanges: {'streetSense': 10, 'money': -5, 'connections': 5},
        outcome:
            'You protected your core savings and still helped. Peak financial wisdom.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Buying Land 🏡',
    description:
        'You are buying land in Dodowa. The chief who sold it to you seems slightly shady.',
    minAge: 30,
    maxAge: 49,
    choices: [
      EventChoice(
        text: 'Pay a lawyer to do due diligence',
        statChanges: {'money': -8, 'smarts': 12, 'discipline': 8},
        outcome:
            'The lawyer found out the land was litigated. You lost the lawyer\'s fee, but saved your life savings.',
      ),
      EventChoice(
        text: 'Pay the chief and start building immediately',
        statChanges: {'money': -15, 'streetSense': -10, 'reputation': -10},
        outcome:
            'Land guards demolished your foundation a week later. The chief stopped picking your calls.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Bad Investment 📉',
    description:
        'The cryptocurrency you bought at the peak just crashed by 90%. Your portfolio is bleeding.',
    minAge: 28,
    maxAge: 45,
    choices: [
      EventChoice(
        text: 'Panic sell everything to salvage what is left',
        statChanges: {'money': -10, 'happiness': -5, 'streetSense': -5},
        outcome:
            'You locked in a massive loss. The coin pumped 300% the very next week out of spite.',
      ),
      EventChoice(
        text: 'Hold and pray',
        statChanges: {'discipline': 10, 'health': -5, 'money': 0},
        outcome:
            'You became a "long-term investor" by force. You have stopped looking at the charts.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Life Insurance 📄',
    description:
        'An insurance agent is trying to sell you a life insurance policy. "Just in case," he says cheerfully.',
    minAge: 30,
    maxAge: 49,
    choices: [
      EventChoice(
        text: 'Sign up and pay the premiums',
        statChanges: {'money': -5, 'smarts': 8, 'discipline': 5},
        outcome:
            'You took the policy. You are officially preparing for death, a true adult milestone.',
      ),
      EventChoice(
        text: 'Rebuke him with "God forbid!"',
        statChanges: {'streetSense': 5, 'smarts': -5, 'money': 2},
        outcome:
            'You chased him away. You saved the monthly premium, but the risk remains yours.',
      ),
    ],
  ),

  // FAMILY OBLIGATIONS (6)
  LifeEvent(
    title: 'Sibling\'s Fees 🎓',
    description:
        'Your father retired, and now you must pay your younger sister\'s university fees.',
    minAge: 28,
    maxAge: 40,
    choices: [
      EventChoice(
        text: 'Take on the full responsibility',
        statChanges: {'money': -12, 'reputation': 10, 'connections': 10},
        outcome:
            'You sacrificed your savings. She graduated with Honours and made you proud.',
      ),
      EventChoice(
        text: 'Force her to defer for a year',
        statChanges: {'money': 5, 'connections': -10, 'reputation': -8},
        outcome:
            'She stayed home and lost a year. Your finances stayed intact, but family relations soured.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Aging Parents 👴🏾',
    description:
        'Your mother\'s arthritis is getting worse. She needs regular expensive medication and care.',
    minAge: 35,
    maxAge: 49,
    choices: [
      EventChoice(
        text: 'Move her into your house',
        statChanges: {'connections': 10, 'happiness': -5, 'money': -8},
        outcome:
            'You took her in. The house is crowded and tense, but you know she is well cared for.',
      ),
      EventChoice(
        text: 'Send money for a nurse',
        statChanges: {'money': -12, 'discipline': 5, 'happiness': 2},
        outcome:
            'You outsourced the care. She complains she doesn\'t see you, but the medical care is professional.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Funeral Contributions 🕊️',
    description:
        'Your wealthy uncle died. The family has levied every working adult 5,000 GHS for a massive funeral.',
    minAge: 30,
    maxAge: 49,
    choices: [
      EventChoice(
        text: 'Pay up to save face',
        statChanges: {'money': -10, 'reputation': 8, 'connections': 5},
        outcome:
            'You paid the levy. The funeral was extravagant, and the elders noted your contribution.',
      ),
      EventChoice(
        text: 'Refuse to pay such a ridiculous amount',
        statChanges: {'money': 10, 'reputation': -15, 'connections': -10},
        outcome:
            'You didn\'t pay. They didn\'t mention your name in the brochure. You survived the shame.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Successful One 👑',
    description:
        'You have been labelled the most successful sibling. Now every family problem lands precisely on your desk.',
    minAge: 35,
    maxAge: 49,
    choices: [
      EventChoice(
        text: 'Accept the role of family savior',
        statChanges: {'reputation': 15, 'money': -15, 'health': -10},
        outcome:
            'You fix every problem. They worship you, but the stress is aging you rapidly.',
      ),
      EventChoice(
        text: 'Set brutal financial boundaries',
        statChanges: {'streetSense': 10, 'money': 10, 'reputation': -10},
        outcome:
            'You started saying no. They called you wicked and stingy, but your investments finally grew.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Endless Requests 📱',
    description:
        'Your cousin keeps texting you every Friday asking for "weekend urgent 200 GHS".',
    minAge: 26,
    maxAge: 49,
    choices: [
      EventChoice(
        text: 'Keep sending it to avoid drama',
        statChanges: {'money': -8, 'connections': 5, 'discipline': -5},
        outcome:
            'You became their automatic ATM. You are basically funding their weekend drinking.',
      ),
      EventChoice(
        text: 'Block them temporarily',
        statChanges: {'streetSense': 8, 'happiness': 5, 'reputation': -2},
        outcome:
            'You muted them. Peace reigned supreme in your notifications.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Property Dispute 📜',
    description:
        'Your late father\'s house is being claimed by a random uncle who says he has "papers".',
    minAge: 35,
    maxAge: 49,
    choices: [
      EventChoice(
        text: 'Take the uncle to court',
        statChanges: {'money': -12, 'discipline': 10, 'reputation': 5},
        outcome:
            'The court case lasted four years. You won, but legal fees ate half the property\'s value.',
      ),
      EventChoice(
        text: 'Settle it out of court',
        statChanges: {'streetSense': 10, 'money': -5, 'happiness': 5},
        outcome:
            'You paid him a settlement to go away. Painful, but you kept the house quickly.',
      ),
    ],
  ),

  // COMMUNITY AND REPUTATION (5)
  LifeEvent(
    title: 'Community Leader 👑',
    description:
        'The residents\' association wants you to be their chairman because of your good standing.',
    minAge: 35,
    maxAge: 49,
    choices: [
      EventChoice(
        text: 'Accept the prestigious role',
        statChanges: {'reputation': 15, 'connections': 10, 'health': -8},
        outcome:
            'You accepted. Now people knock on your gate at 2 AM because a street bulb blew out.',
      ),
      EventChoice(
        text: 'Decline citing a busy schedule',
        statChanges: {'happiness': 8, 'discipline': 5, 'reputation': -5},
        outcome:
            'You stayed a regular resident. You sleep well while the leadership fights over garbage collection.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Public Scandal 📰',
    description:
        'A disgruntled ex-employee tweeted a massively exaggerated story about you that went viral.',
    minAge: 35,
    maxAge: 49,
    choices: [
      EventChoice(
        text: 'Release a formal legal statement',
        statChanges: {'reputation': 5, 'smarts': 8, 'money': -5},
        outcome:
            'Your lawyers issued a statement. It stopped the spread, but the whispers remained.',
      ),
      EventChoice(
        text: 'Fight them on Twitter directly',
        statChanges: {'reputation': -15, 'streetSense': -5, 'happiness': -10},
        outcome:
            'You got dragged into a messy internet fight. You became a meme for a week.',
      ),
      EventChoice(
        text: 'Ignore it completely',
        statChanges: {'discipline': 12, 'health': 5, 'reputation': -5},
        outcome:
            'You stayed offline. The internet got bored three days later and moved to a new victim.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Church Politics ⛪',
    description:
        'You have been appointed to the church finance committee, and you just noticed massive irregularities.',
    minAge: 30,
    maxAge: 49,
    choices: [
      EventChoice(
        text: 'Blow the whistle loudly',
        statChanges: {'discipline': 15, 'reputation': -10, 'connections': -15},
        outcome:
            'You exposed the fraud. The Head Pastor asked you to step down for "causing division".',
      ),
      EventChoice(
        text: 'Resign quietly',
        statChanges: {'streetSense': 10, 'happiness': 5, 'discipline': -5},
        outcome:
            'You left the committee citing "personal reasons". Your conscience is heavy but your reputation is safe.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Neighbor Feud 🤺',
    description:
        'Your neighbor\'s dog keeps digging up your garden and barking at 3 AM.',
    minAge: 28,
    maxAge: 49,
    choices: [
      EventChoice(
        text: 'Report to the police',
        statChanges: {'reputation': -5, 'connections': -10, 'streetSense': 5},
        outcome:
            'The police came. The dog issue stopped, but the neighbor now throws trash over your wall.',
      ),
      EventChoice(
        text: 'Talk to them respectfully',
        statChanges: {'connections': 5, 'discipline': 8, 'happiness': 2},
        outcome:
            'You had a mature conversation. They built a better fence. Peace was restored.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Community Award 🏆',
    description:
        'You have been nominated for "Local Entrepreneur of the Year". Voting requires buying massive amounts of credit.',
    minAge: 30,
    maxAge: 45,
    choices: [
      EventChoice(
        text: 'Buy the votes to win the award',
        statChanges: {'reputation': 15, 'money': -15, 'smarts': -5},
        outcome:
            'You bought the plaque. It looks great in your office, even if your account is bleeding.',
      ),
      EventChoice(
        text: 'Refuse to participate in the scam',
        statChanges: {'money': 10, 'reputation': -5, 'discipline': 10},
        outcome:
            'You lost to someone with deep pockets. The award ceremony was a joke anyway.',
      ),
    ],
  ),

  // ADDITIONAL EVENTS (20 events)
  LifeEvent(
    title: 'Midlife Crisis Car 🏎️',
    description:
        'You are stressed about aging. You pass by a dealership selling a sleek, completely impractical sports car.',
    minAge: 38,
    maxAge: 49,
    choices: [
      EventChoice(
        text: 'Buy the car',
        statChanges: {'looks': 15, 'happiness': 10, 'money': -15},
        outcome:
            'You bought it! You look incredible, but changing one tire costs your entire monthly grocery budget.',
      ),
      EventChoice(
        text: 'Walk away responsibly',
        statChanges: {'discipline': 10, 'money': 8, 'happiness': -5},
        outcome:
            'You drove home in your sensible Toyota Corolla. A silent tear fell down your face.',
      ),
    ],
  ),
  LifeEvent(
    title: 'School Reunions 🏫',
    description:
        'It is your 20-year SHS anniversary. The WhatsApp group is demanding 2,000 GHS per head for the party.',
    minAge: 35,
    maxAge: 45,
    choices: [
      EventChoice(
        text: 'Pay and attend to show off',
        statChanges: {'connections': 10, 'reputation': 8, 'money': -10},
        outcome:
            'You attended and lied about how great your life is. Everyone else lied too. It was stressful.',
      ),
      EventChoice(
        text: 'Mute the group and stay home',
        statChanges: {'money': 5, 'happiness': 8, 'connections': -5},
        outcome:
            'You stayed home. You saved your money and avoided comparisons.',
      ),
    ],
  ),
  LifeEvent(
    title: 'High Blood Pressure 🩺',
    description:
        'A routine checkup reveals your blood pressure is dangerously high due to adulting stress.',
    minAge: 35,
    maxAge: 49,
    choices: [
      EventChoice(
        text: 'Overhaul your entire lifestyle',
        statChanges: {'health': 15, 'discipline': 12, 'happiness': -8},
        outcome:
            'You started jogging and eating boiled plantains. You are much healthier, but food is boring now.',
      ),
      EventChoice(
        text: 'Just take the pills and continue stressing',
        statChanges: {'health': -5, 'money': -5, 'discipline': -5},
        outcome:
            'The pills help mildly, but you are a ticking time bomb of corporate stress.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Building Project 🧱',
    description:
        'You started building your house. You visited the site and realized the contractor sold 100 bags of your cement.',
    minAge: 35,
    maxAge: 49,
    choices: [
      EventChoice(
        text: 'Get him arrested',
        statChanges: {'reputation': 5, 'money': -5, 'streetSense': 5},
        outcome:
            'You arrested him, but never got the cement back. The project stalled for months.',
      ),
      EventChoice(
        text: 'Take over the project supervision yourself',
        statChanges: {'discipline': 15, 'health': -10, 'money': 5},
        outcome:
            'You fired him and stood in the sun every weekend. You got tanned, but the walls went up properly.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Housemaid Wahala 🧹',
    description:
        'Your reliable house-help woke up, packed her bags, and left without saying a word. Your house is a mess.',
    minAge: 30,
    maxAge: 49,
    choices: [
      EventChoice(
        text: 'Beg an agency for a quick replacement',
        statChanges: {'money': -10, 'streetSense': -5, 'happiness': 5},
        outcome:
            'The agency brought someone new. The cycle of teaching someone how to use the microwave begins again.',
      ),
      EventChoice(
        text: 'Decide to do all chores yourself',
        statChanges: {'health': -8, 'discipline': 10, 'money': 8},
        outcome:
            'You saved money but became utterly exhausted holding down a career and a mop.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Visa Lottery 🇺🇸',
    description:
        'You checked the US DV Lottery portal. "You have been randomly selected..."',
    minAge: 26,
    maxAge: 49,
    choices: [
      EventChoice(
        text: 'Drop everything and process the visa',
        statChanges: {'money': -15, 'happiness': 15, 'reputation': 10},
        outcome:
            'You spent a fortune on medicals and forms. You got the Green Card! The American dream awaits.',
      ),
      EventChoice(
        text: 'Sell the opportunity (illegally)',
        statChanges: {'money': 15, 'streetSense': -15, 'reputation': -10},
        outcome:
            'You tried to arrange a fake marriage for cash. The embassy caught you and banned you for life.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Sudden Tax Audit 📊',
    description:
        'GRA officials just walked into your business premises demanding three years of tax receipts.',
    minAge: 30,
    maxAge: 49,
    choices: [
      EventChoice(
        text: 'Hand over your perfect records',
        statChanges: {'discipline': 15, 'smarts': 10, 'streetSense': 2},
        outcome:
            'You kept strict records. They found nothing, apologized, and left. A monumental victory.',
      ),
      EventChoice(
        text: 'Panic because you evaded taxes',
        statChanges: {'money': -20, 'health': -10, 'reputation': -10}, // Stat changes are clamped later
        outcome:
            'You were hit with catastrophic fines that wiped out half your business capital.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Traffic Accident 💥',
    description:
        'A trotro mate scraped the side of your car. The driver is refusing to accept fault.',
    minAge: 26,
    maxAge: 49,
    choices: [
      EventChoice(
        text: 'Fight them aggressively on the road',
        statChanges: {'reputation': -5, 'health': -5, 'streetSense': 5},
        outcome:
            'You caused a massive traffic jam. The police came and towed both cars. Disaster.',
      ),
      EventChoice(
        text: 'Let it go to avoid stress',
        statChanges: {'money': -8, 'happiness': 5, 'discipline': 5},
        outcome:
            'You drove away and paid the panel beater yourself. Unfair, but your blood pressure remained stable.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Power Fluctuation ⚡',
    description:
        'The lights went off and came back with high voltage. You smell burning plastic from the kitchen.',
    minAge: 26,
    maxAge: 49,
    choices: [
      EventChoice(
        text: 'Run and unplug everything',
        statChanges: {'streetSense': 8, 'health': 2, 'money': -5},
        outcome:
            'You saved the TV, but the fridge motor was completely fried. Thanks, ECG.',
      ),
      EventChoice(
        text: 'Do nothing and hope for the best',
        statChanges: {'money': -15, 'smarts': -5, 'happiness': -10},
        outcome:
            'Your fridge, TV, and microwave all perished in the electrical surge. Tears.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Sponsoring a Wedding 💸',
    description:
        'Your friend made you the Chairman of their wedding reception. You are expected to launch the appeal for funds.',
    minAge: 35,
    maxAge: 49,
    choices: [
      EventChoice(
        text: 'Pledge a ridiculous amount',
        statChanges: {'money': -15, 'connections': 10, 'reputation': 15},
        outcome:
            'You pledged 10,000 GHS. The crowd cheered! You spent the next three months dodging the couple.',
      ),
      EventChoice(
        text: 'Give a modest but firm amount',
        statChanges: {'money': -5, 'reputation': 5, 'discipline': 5},
        outcome:
            'You gave 1,000 GHS in cash. It was respectable and ended the pressure quickly.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Old Flame 🕯️',
    description:
        'You ran into your first love at the mall. They look incredibly rich and successful.',
    minAge: 30,
    maxAge: 45,
    choices: [
      EventChoice(
        text: 'Lie about your own success',
        statChanges: {'streetSense': 5, 'happiness': -5, 'reputation': -5},
        outcome:
            'You bragged heavily. They later saw you entering a trotro. Embarrassing.',
      ),
      EventChoice(
        text: 'Be genuine and friendly',
        statChanges: {'connections': 8, 'happiness': 5, 'discipline': 5},
        outcome:
            'You had a great catch-up. No regrets, just two adults who moved on peacefully.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Random Weight Gain ⚖️',
    description:
        'You have to go to a funeral, but none of your formal clothes fit anymore.',
    minAge: 30,
    maxAge: 49,
    choices: [
      EventChoice(
        text: 'Squeeze into them forcefully',
        statChanges: {'looks': -5, 'health': -2, 'happiness': -5},
        outcome:
            'You spent the whole event unable to breathe properly. Not a good look.',
      ),
      EventChoice(
        text: 'Accept reality and buy new clothes',
        statChanges: {'money': -8, 'happiness': 5, 'looks': 8},
        outcome:
            'You bought an elegant new outfit that actually fits. Looking good costs money.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Diet Plan 🥗',
    description:
        'You decided to try a strict keto diet to lose the stubborn lower belly fat.',
    minAge: 32,
    maxAge: 49,
    choices: [
      EventChoice(
        text: 'Stick to it for a month',
        statChanges: {'health': 10, 'looks': 10, 'discipline': 15},
        outcome:
            'You lost the weight! But you annoyed everyone around you by refusing to eat banku.',
      ),
      EventChoice(
        text: 'Give up on day three',
        statChanges: {'happiness': 5, 'discipline': -10, 'health': -5},
        outcome:
            'Someone brought hot waakye to the office. The diet died instantly.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Social Media Break 🔇',
    description:
        'You are constantly irritated by political news and people showing off online.',
    minAge: 30,
    maxAge: 49,
    choices: [
      EventChoice(
        text: 'Delete all apps for a month',
        statChanges: {'happiness': 15, 'discipline': 10, 'connections': -5},
        outcome:
            'You experienced true peace. You missed two birthdays, but your mental health is glowing.',
      ),
      EventChoice(
        text: 'Just mute the annoying people',
        statChanges: {'streetSense': 8, 'happiness': 5, 'connections': 2},
        outcome:
            'You curated your feed. You still waste time scrolling, but at least it\'s just funny cats now.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Private School Fees 💸',
    description:
        'Your child\'s school just increased fees by 30%. They say it is because of "exchange rates".',
    minAge: 35,
    maxAge: 49,
    choices: [
      EventChoice(
        text: 'Pay it and complain bitterly',
        statChanges: {'money': -15, 'reputation': 5, 'connections': 5},
        outcome:
            'You paid. You are broke, but the child is getting premium education.',
      ),
      EventChoice(
        text: 'Move them to a cheaper school',
        statChanges: {'money': 15, 'reputation': -8, 'discipline': 5},
        outcome:
            'You made the tough financial call. The new school is decent, and your bank account is breathing.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Jollof War 🍚',
    description:
        'You are at a grand party. They are serving food, but someone cuts the line and takes the last scoop of Jollof.',
    minAge: 26,
    maxAge: 49,
    choices: [
      EventChoice(
        text: 'Fight them for the Jollof',
        statChanges: {'reputation': -10, 'streetSense': -5, 'happiness': 8},
        outcome:
            'You caused a massive scene, but you got that Jollof. It was utterly delicious.',
      ),
      EventChoice(
        text: 'Eat plain white rice in peace',
        statChanges: {'discipline': 8, 'happiness': -5, 'health': 2},
        outcome:
            'You took the high road. The white rice was incredibly dry and depressing.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Buying a Generator 🔌',
    description:
        'Dumsor is back. You cannot sleep in the heat anymore.',
    minAge: 30,
    maxAge: 49,
    choices: [
      EventChoice(
        text: 'Buy a huge diesel plant',
        statChanges: {'money': -15, 'health': 10, 'reputation': 10},
        outcome:
            'You dropped serious cash. Your house sounds like an industrial zone, but you have light!',
      ),
      EventChoice(
        text: 'Buy a cheap rechargeable fan',
        statChanges: {'money': -2, 'health': 2, 'discipline': 5},
        outcome:
            'It blows hot air onto your sweaty face, but it is better than nothing.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Armed Robbery Scare 🔒',
    description:
        'You heard gunshots in your neighborhood last night. Robbers raided two houses away.',
    minAge: 28,
    maxAge: 49,
    choices: [
      EventChoice(
        text: 'Install electric fences and cameras',
        statChanges: {'money': -15, 'streetSense': 10, 'health': 5},
        outcome:
            'You secured your fortress. Expensive, but you finally stopped having nightmares.',
      ),
      EventChoice(
        text: 'Buy a cutlass and pray',
        statChanges: {'money': -2, 'health': -5, 'discipline': 5},
        outcome:
            'Every time a dog barks, you wake up clutching the cutlass. Pure stress.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Attending Funerals Every Saturday 🕊️',
    description:
        'You reached the age where every single Saturday, someone requires you to wear black or red.',
    minAge: 40,
    maxAge: 49,
    choices: [
      EventChoice(
        text: 'Attend all of them dutifully',
        statChanges: {'connections': 15, 'reputation': 15, 'money': -10},
        outcome:
            'You showed up for everyone. Your reputation is flawless, but your weekends are gone.',
      ),
      EventChoice(
        text: 'Start prioritizing and skipping',
        statChanges: {'discipline': 10, 'happiness': 8, 'reputation': -5},
        outcome:
            'You took your Saturdays back. Some people complained, but you finally managed to rest.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Writing a Will 📜',
    description:
        'A health scare made you realize you need to document who gets your property if you die.',
    minAge: 45,
    maxAge: 49,
    choices: [
      EventChoice(
        text: 'Hire a lawyer and draft it properly',
        statChanges: {'smarts': 15, 'discipline': 15, 'happiness': 5},
        outcome:
            'You secured your legacy legally. True adult responsibility achieved.',
      ),
      EventChoice(
        text: 'Procrastinate because "it invites death"',
        statChanges: {'streetSense': -5, 'discipline': -10, 'smarts': -5},
        outcome:
            'You ignored it. If you drop dead tomorrow, your family will fight brutally over your TV.',
      ),
    ],
  ),
  
  // ==========================================
  // MIDDLE AGE EVENTS (AGE 50-64) - 40 EVENTS
  // ==========================================
  
  // HEALTH REALITY CHECK (10)
  LifeEvent(
    title: 'The Eye Doctor 👓',
    description: 'You suddenly realize you have to hold your phone at arm\'s length to read WhatsApp messages.',
    minAge: 50,
    maxAge: 55,
    choices: [
      EventChoice(
        text: 'Buy proper reading glasses',
        statChanges: {'health': 5, 'money': -5, 'looks': -2},
        outcome: 'You can finally read. The glasses make you look dignified, but definitively older.',
      ),
      EventChoice(
        text: 'Just increase the font size to maximum',
        statChanges: {'streetSense': 5, 'looks': -5, 'smarts': -2},
        outcome: 'Your phone looks like an electronic billboard, but you saved money on glasses.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Routine Checkup Shock 🩺',
    description: 'The doctor frowned while looking at your blood test results. Your cholesterol is very high.',
    minAge: 52,
    maxAge: 64,
    choices: [
      EventChoice(
        text: 'Cut out all red meat and oil instantly',
        statChanges: {'health': 15, 'discipline': 10, 'happiness': -10},
        outcome: 'You switched to a diet of boiled chicken and vegetables. Miserable, but you will live longer.',
      ),
      EventChoice(
        text: 'Take the drugs but keep eating fufu',
        statChanges: {'health': -5, 'happiness': 5, 'discipline': -10},
        outcome: 'The medication is struggling against your heavy Sunday afternoon meals.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Knee Pain 🚶🏾‍♂️',
    description: 'You bent down to pick up a remote, and your knees made a loud cracking sound.',
    minAge: 50,
    maxAge: 64,
    choices: [
      EventChoice(
        text: 'Start taking joint supplements',
        statChanges: {'health': 8, 'money': -5, 'discipline': 5},
        outcome: 'The glucosamine smells terrible, but the cracking stopped after a month.',
      ),
      EventChoice(
        text: 'Ignore it and blame the weather',
        statChanges: {'health': -8, 'happiness': -2, 'streetSense': -5},
        outcome: 'You are now limping slightly when it rains. Welcome to your 50s.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Sudden Passing 🕊️',
    description: 'A respected colleague your exact age died of a sudden heart attack this morning.',
    minAge: 52,
    maxAge: 64,
    choices: [
      EventChoice(
        text: 'Book a full medical screening immediately',
        statChanges: {'health': 10, 'smarts': 5, 'money': -8},
        outcome: 'The fear of death prompted a full checkup. You are fine, but the anxiety was real.',
      ),
      EventChoice(
        text: 'Go to church and pray for long life',
        statChanges: {'happiness': 5, 'health': -5, 'connections': 5},
        outcome: 'You spent hours at an all-night service. Spiritual assurance, but you did not see a doctor.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Graying 💇🏾‍♀️',
    description: 'You looked in the mirror and realized half your hair is entirely white.',
    minAge: 50,
    maxAge: 60,
    choices: [
      EventChoice(
        text: 'Dye it black immediately',
        statChanges: {'looks': 8, 'money': -5, 'happiness': 5},
        outcome: 'You look ten years younger, but the dye stains your pillows terribly.',
      ),
      EventChoice(
        text: 'Embrace the "Salt and Pepper"',
        statChanges: {'looks': 5, 'reputation': 8, 'discipline': 5},
        outcome: 'You embraced aging gracefully. People started calling you "Elder" with much more respect.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Metabolism Crash ⚖️',
    description: 'You ate a heavy meal at 8 PM, and woke up feeling uncomfortably full the next morning.',
    minAge: 50,
    maxAge: 64,
    choices: [
      EventChoice(
        text: 'Stop eating after 6 PM',
        statChanges: {'health': 10, 'discipline': 15, 'happiness': -8},
        outcome: 'Your digestion improved massively, though you go to bed hungry sometimes.',
      ),
      EventChoice(
        text: 'Drink bitters to force digestion',
        statChanges: {'health': -5, 'happiness': 2, 'discipline': -5},
        outcome: 'The herbal mixture caused severe heartburn instead. Bad idea.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Forgetting Names 💭',
    description: 'You ran into someone you have known for ten years and completely forgot their name.',
    minAge: 55,
    maxAge: 64,
    choices: [
      EventChoice(
        text: 'Call them "My Brother/Sister"',
        statChanges: {'streetSense': 10, 'connections': 5, 'reputation': 2},
        outcome: 'The classic Ghanaian save. They smiled, totally unaware you blanked entirely.',
      ),
      EventChoice(
        text: 'Apologize and ask for their name',
        statChanges: {'reputation': -5, 'connections': -5, 'happiness': -2},
        outcome: 'It was extremely awkward. They looked disappointed in you.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Long Sleep 🛏️',
    description: 'You used to sleep 5 hours and function perfectly. Now if you don\'t get 8 hours, you are useless.',
    minAge: 52,
    maxAge: 64,
    choices: [
      EventChoice(
        text: 'Adjust your bedtime to 9 PM',
        statChanges: {'health': 10, 'discipline': 8, 'happiness': -5},
        outcome: 'You sleep when the teenagers are just waking up, but you feel incredible.',
      ),
      EventChoice(
        text: 'Force yourself to stay up',
        statChanges: {'health': -10, 'happiness': 5, 'reputation': -5},
        outcome: 'You fell asleep sitting in the armchair with the TV blasting. Classic dad/mom move.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Dental Reality 🦷',
    description: 'The dentist says you need an expensive crown because of a cracked molar.',
    minAge: 50,
    maxAge: 64,
    choices: [
      EventChoice(
        text: 'Pay for the fix',
        statChanges: {'health': 10, 'money': -12, 'looks': 5},
        outcome: 'Your tooth is saved. Your retirement fund took a minor hit.',
      ),
      EventChoice(
        text: 'Tell them to just pull it out',
        statChanges: {'health': -5, 'money': 5, 'looks': -8},
        outcome: 'You have a gap in the back, but you kept your cash. Chewing is weird now.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Menopause / Andropause Talk 🌡️',
    description: 'Hormonal changes are making you moody, tired, and giving you random hot flashes.',
    minAge: 50,
    maxAge: 60,
    choices: [
      EventChoice(
        text: 'See a specialist for therapy',
        statChanges: {'health': 12, 'money': -8, 'happiness': 8},
        outcome: 'Medical intervention balanced you out perfectly.',
      ),
      EventChoice(
        text: 'Just suffer through it angrily',
        statChanges: {'health': -5, 'happiness': -10, 'connections': -8},
        outcome: 'You became extremely irritable. Your family is avoiding you.',
      ),
    ],
  ),

  // CHILDREN GROWN UP (10)
  LifeEvent(
    title: 'Wedding Bill 💒',
    description: 'Your child is getting married. They want an extravagant wedding and look to you to fund it.',
    minAge: 50,
    maxAge: 64,
    choices: [
      EventChoice(
        text: 'Pay for the dream wedding',
        statChanges: {'money': -15, 'reputation': 15, 'happiness': 10},
        outcome: 'It was the wedding of the decade. You are broke, but immensely proud.',
      ),
      EventChoice(
        text: 'Offer a strict, small budget',
        statChanges: {'money': 10, 'discipline': 10, 'connections': -5},
        outcome: 'They complained, but eventually had a beautiful intimate ceremony. You kept your savings.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Child Emigrating ✈️',
    description: 'Your child just got their visa to move permanently to Canada. You are proud but heartbroken.',
    minAge: 50,
    maxAge: 64,
    choices: [
      EventChoice(
        text: 'Throw a massive send-off party',
        statChanges: {'happiness': 8, 'reputation': 10, 'money': -8},
        outcome: 'You celebrated their success openly, hiding your tears until the airport drop-off.',
      ),
      EventChoice(
        text: 'Beg them internally to stay',
        statChanges: {'happiness': -10, 'connections': -5, 'health': -5},
        outcome: 'You were moody their entire last week. They left feeling guilty.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Boomerang Child 🚪',
    description: 'Your 28-year-old child lost their job and asks to move back into their old bedroom.',
    minAge: 52,
    maxAge: 64,
    choices: [
      EventChoice(
        text: 'Welcome them back warmly',
        statChanges: {'connections': 10, 'money': -5, 'happiness': 5},
        outcome: 'The house feels full again. You actually enjoy having them around to cook for.',
      ),
      EventChoice(
        text: 'Say yes but charge them rent',
        statChanges: {'discipline': 10, 'streetSense': 8, 'connections': -5},
        outcome: 'Tough love. They found a new job very quickly to escape your strict rules.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Parenting Clash 👶',
    description: 'Your child is raising your grandchild "the modern way" (no shouting, no spanking). You heavily disagree.',
    minAge: 55,
    maxAge: 64,
    choices: [
      EventChoice(
        text: 'Respect their boundaries',
        statChanges: {'connections': 10, 'discipline': 5, 'happiness': -5},
        outcome: 'You bit your tongue. It is hard watching them "reason" with a toddler, but peaceful.',
      ),
      EventChoice(
        text: 'Correct the grandchild the "old way"',
        statChanges: {'reputation': 5, 'connections': -15, 'happiness': -5},
        outcome: 'You shouted at the child. Your son/daughter packed up and left the house in anger.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Outshined by Your Child 🌟',
    description: 'Your child just bought a house twice the size of yours and bought you a very expensive watch.',
    minAge: 55,
    maxAge: 64,
    choices: [
      EventChoice(
        text: 'Be entirely proud of them',
        statChanges: {'happiness': 15, 'connections': 10, 'health': 5},
        outcome: 'You wore the watch everywhere telling everyone your child bought it. Peak parental joy.',
      ),
      EventChoice(
        text: 'Feel secretly insecure',
        statChanges: {'happiness': -10, 'discipline': -5, 'connections': -5},
        outcome: 'You made passive-aggressive comments about "new money". It sourly affected the celebration.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Empty Nest Syndrome 🪹',
    description: 'Your youngest child finally moved out. The house is completely silent.',
    minAge: 52,
    maxAge: 64,
    choices: [
      EventChoice(
        text: 'Turn their room into a home gym',
        statChanges: {'health': 12, 'happiness': 8, 'discipline': 5},
        outcome: 'You embraced the new era. You are fit, and the house is perfectly clean.',
      ),
      EventChoice(
        text: 'Call them every single day',
        statChanges: {'happiness': -8, 'connections': -8, 'health': -5},
        outcome: 'You became overbearing. They stopped picking up on the first ring.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Unsolicited Career Advice 🗣️',
    description: 'Your adult child wants to quit banking to become an Instagram influencer.',
    minAge: 50,
    maxAge: 64,
    choices: [
      EventChoice(
        text: 'Forbid it forcefully',
        statChanges: {'connections': -12, 'discipline': 8, 'reputation': -5},
        outcome: 'You shouted for an hour. They did it anyway, and stopped trusting you with their plans.',
      ),
      EventChoice(
        text: 'Ask to see their business plan',
        statChanges: {'smarts': 10, 'connections': 8, 'happiness': 5},
        outcome: 'You engaged them maturely. They realized it wasn\'t viable and stayed at the bank.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Foreign Partner 🌍',
    description: 'Your child brought home a fiancé from a completely different continent. Culture shock is imminent.',
    minAge: 55,
    maxAge: 64,
    choices: [
      EventChoice(
        text: 'Embrace them and teach them your culture',
        statChanges: {'connections': 15, 'happiness': 10, 'reputation': 5},
        outcome: 'You taught them how to eat fufu. The family loves them, and the wedding was beautiful.',
      ),
      EventChoice(
        text: 'Display visible disapproval',
        statChanges: {'connections': -15, 'happiness': -10, 'reputation': -10},
        outcome: 'You made everything awkward. They married abroad and you weren\'t invited.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Grandparent Request 👶🏽',
    description: 'Your child is going for a master\'s degree abroad and wants to leave their toddler with you for a year.',
    minAge: 55,
    maxAge: 64,
    choices: [
      EventChoice(
        text: 'Accept the grandchild joyfully',
        statChanges: {'health': -10, 'happiness': 15, 'connections': 15},
        outcome: 'Raising a toddler at 58 is exhausting, but your bond with the grandchild is permanent.',
      ),
      EventChoice(
        text: 'Refuse, you have finished raising kids',
        statChanges: {'health': 10, 'happiness': -5, 'connections': -15},
        outcome: 'You protected your peace and quiet. Your child was deeply hurt and struggled financially.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Spoiling the Grandchild 🍬',
    description: 'Your grandchild wants ice cream. Their mother said "No sugar". They are crying looking at you.',
    minAge: 55,
    maxAge: 64,
    choices: [
      EventChoice(
        text: 'Sneak them the ice cream',
        statChanges: {'happiness': 10, 'connections': -8, 'streetSense': 5},
        outcome: 'The grandchild loves you! The mother caught you and was furious.',
      ),
      EventChoice(
        text: 'Support the mother\'s rules',
        statChanges: {'discipline': 8, 'connections': 5, 'happiness': -5},
        outcome: 'You stood firm. The child cried harder, but the parenting boundary was respected.',
      ),
    ],
  ),

  // LEGACY AND REFLECTION (6)
  LifeEvent(
    title: 'Midlife Reflection 🤔',
    description: 'You are sitting on your porch comparing where you are to where you thought you would be at this age.',
    minAge: 50,
    maxAge: 64,
    choices: [
      EventChoice(
        text: 'Count your blessings',
        statChanges: {'happiness': 15, 'health': 5, 'smarts': 5},
        outcome: 'You realized you survived everything life threw at you. You felt a deep, warm peace.',
      ),
      EventChoice(
        text: 'Focus on your regrets',
        statChanges: {'happiness': -15, 'health': -5, 'discipline': -5},
        outcome: 'You spiraled into mild depression over missed opportunities and bad investments.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Writing the Will 📜',
    description: 'You finally visit the lawyer to draft your final will. The decisions are heavier than you thought.',
    minAge: 55,
    maxAge: 64,
    choices: [
      EventChoice(
        text: 'Divide everything equally',
        statChanges: {'discipline': 10, 'smarts': 8, 'reputation': 5},
        outcome: 'Fair and square. You signed it and locked it away, feeling incredibly responsible.',
      ),
      EventChoice(
        text: 'Give the bulk to the responsible child',
        statChanges: {'streetSense': 10, 'happiness': -5, 'connections': -5},
        outcome: 'You made the strategic choice. If they find out before you die, there will be war.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Young Protégé 🎓',
    description: 'A brilliant 25-year-old in your industry asks if you will officially mentor them.',
    minAge: 50,
    maxAge: 64,
    choices: [
      EventChoice(
        text: 'Take them under your wing',
        statChanges: {'reputation': 15, 'happiness': 10, 'connections': 10},
        outcome: 'You passed on your wisdom. They succeeded massively and constantly credit you.',
      ),
      EventChoice(
        text: 'Decline to protect your secrets',
        statChanges: {'smarts': 5, 'reputation': -5, 'streetSense': 5},
        outcome: 'You kept your network to yourself. They found another mentor and eventually replaced you.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Ancestral Land 🏞️',
    description: 'The family elders want you to take charge of a disputed family land in your hometown because you are "educated".',
    minAge: 55,
    maxAge: 64,
    choices: [
      EventChoice(
        text: 'Take the responsibility',
        statChanges: {'reputation': 15, 'health': -10, 'money': -10},
        outcome: 'You spent years fighting in court and dealing with chiefs. Legendary status achieved, but exhausted.',
      ),
      EventChoice(
        text: 'Politely decline involvement',
        statChanges: {'happiness': 10, 'health': 5, 'reputation': -10},
        outcome: 'You protected your peace. They called you arrogant, but you slept soundly in the city.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Business Succession 🏢',
    description: 'Your business is thriving, but you are getting tired. It is time to think about a successor.',
    minAge: 58,
    maxAge: 64,
    choices: [
      EventChoice(
        text: 'Groom your child to take over',
        statChanges: {'connections': 10, 'reputation': 5, 'money': -5},
        outcome: 'Your child was reluctant at first but eventually stepped up to keep the legacy alive.',
      ),
      EventChoice(
        text: 'Plan to sell it and retire',
        statChanges: {'money': 15, 'happiness': 8, 'discipline': 5},
        outcome: 'You started valuing the company. The massive buyout will fund a brilliant retirement.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Reunion Invite ✉️',
    description: 'Your university year group is planning a major 30th reunion. Some people you haven\'t spoken to in decades will be there.',
    minAge: 50,
    maxAge: 64,
    choices: [
      EventChoice(
        text: 'Go and reconnect',
        statChanges: {'connections': 12, 'happiness': 10, 'reputation': 8},
        outcome: 'You saw old friends. It was beautiful seeing how everyone gracefully aged.',
      ),
      EventChoice(
        text: 'Avoid the comparison trap and stay home',
        statChanges: {'discipline': 5, 'happiness': 5, 'streetSense': 2},
        outcome: 'You stayed home. The pictures showed several people bald or unrecognizable.',
      ),
    ],
  ),

  // RETIREMENT PLANNING (7)
  LifeEvent(
    title: 'SSNIT Reality Check 🏦',
    description: 'You checked your projected pension statements. The monthly amount is laughably small.',
    minAge: 55,
    maxAge: 64,
    choices: [
      EventChoice(
        text: 'Aggressively invest in real estate now',
        statChanges: {'money': -15, 'discipline': 15, 'smarts': 10},
        outcome: 'You squeezed your budget to build rentals. Future you will be eternally grateful.',
      ),
      EventChoice(
        text: 'Pray your children will take care of you',
        statChanges: {'streetSense': -10, 'happiness': -5, 'discipline': -10},
        outcome: 'You left your future to fate. The anxiety wakes you up at 3 AM.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Early Retirement Offer 🚪',
    description: 'Your company is offering a juicy severance package if you agree to retire five years early.',
    minAge: 55,
    maxAge: 60,
    choices: [
      EventChoice(
        text: 'Take the money and run',
        statChanges: {'money': 15, 'happiness': 10, 'health': 8},
        outcome: 'You took the payout! No more alarms. You started a small garden and feel youthful again.',
      ),
      EventChoice(
        text: 'Refuse, you need the steady routine',
        statChanges: {'discipline': 10, 'reputation': 5, 'health': -5},
        outcome: 'You stayed. You are the oldest person in the office, but the security is comforting.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Farm Dream 🚜',
    description: 'Like every Ghanaian your age, you suddenly have an overwhelming urge to start a farm.',
    minAge: 50,
    maxAge: 64,
    choices: [
      EventChoice(
        text: 'Invest in a serious pineapple farm',
        statChanges: {'money': -12, 'health': 5, 'smarts': 8},
        outcome: 'You spent half your time negotiating with laborers, but harvesting your own crops felt majestic.',
      ),
      EventChoice(
        text: 'Just plant some tomatoes in your backyard',
        statChanges: {'happiness': 8, 'money': -2, 'health': 5},
        outcome: 'A much safer hobby. The tomatoes are tiny, but you show them to all your visitors.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Boredom at the Top 🏢',
    description: 'You have reached the director level. The pay is great, but the job is mostly sitting in endless meetings.',
    minAge: 50,
    maxAge: 60,
    choices: [
      EventChoice(
        text: 'Start a challenging side project',
        statChanges: {'smarts': 10, 'happiness': 8, 'discipline': 5},
        outcome: 'You started consulting on the side. Your brain woke up from its corporate coma.',
      ),
      EventChoice(
        text: 'Cruise comfortably until retirement',
        statChanges: {'happiness': -5, 'health': -5, 'money': 8},
        outcome: 'You gained fifteen pounds from rich office lunches and zero movement. But you are rich.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Colleague Retires 🎉',
    description: 'Your longtime work rival is officially retiring. There is a massive send-off party.',
    minAge: 58,
    maxAge: 64,
    choices: [
      EventChoice(
        text: 'Give a glowing heartfelt speech',
        statChanges: {'reputation': 10, 'connections': 10, 'happiness': 5},
        outcome: 'You buried the hatchet. They actually cried, and you both felt genuine mutual respect.',
      ),
      EventChoice(
        text: 'Clap politely from the back',
        statChanges: {'discipline': 5, 'streetSense': 5, 'reputation': -2},
        outcome: 'You kept it professional. The rivalry died a quiet, unremarkable death.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Unfinished House 🧱',
    description: 'The house you started building ten years ago is still uncompleted. Retirement is looming.',
    minAge: 55,
    maxAge: 64,
    choices: [
      EventChoice(
        text: 'Take a final big loan to finish it',
        statChanges: {'money': -15, 'reputation': 10, 'happiness': 8},
        outcome: 'You moved into your own house! The debt is heavy, but the landlord days are officially over.',
      ),
      EventChoice(
        text: 'Sell it as-is and buy something smaller',
        statChanges: {'money': 15, 'smarts': 10, 'streetSense': 8},
        outcome: 'You made the smartest financial decision of your life. Downsizing brought immense peace.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Hobbies after Work 🎣',
    description: 'You realize you have no hobbies outside of working and attending funerals.',
    minAge: 55,
    maxAge: 64,
    choices: [
      EventChoice(
        text: 'Join a prestigious Golf or Tennis club',
        statChanges: {'connections': 15, 'money': -10, 'health': 10},
        outcome: 'You networked with ministers and CEOs while trying not to pull a hamstring.',
      ),
      EventChoice(
        text: 'Start walking every evening',
        statChanges: {'health': 12, 'happiness': 8, 'money': 0},
        outcome: 'You walk the neighborhood daily listening to old highlife music. Simple and healthy.',
      ),
    ],
  ),

  // COMMUNITY ELDER STATUS (7)
  LifeEvent(
    title: 'The Dispute Settler ⚖️',
    description: 'Two younger couples in the extended family are fighting bitterly. They have come to you to mediate.',
    minAge: 55,
    maxAge: 64,
    choices: [
      EventChoice(
        text: 'Listen deeply and offer wise counsel',
        statChanges: {'reputation': 15, 'connections': 12, 'smarts': 8},
        outcome: 'You settled the matter brilliantly. You are officially recognized as a true family elder.',
      ),
      EventChoice(
        text: 'Scold both of them to grow up',
        statChanges: {'discipline': 10, 'reputation': 5, 'connections': -5},
        outcome: 'You chased them out. They stopped fighting just to unite in annoyance at you.',
      ),
    ],
  ),
  LifeEvent(
    title: 'School Speech Invited 🎙️',
    description: 'Your old SHS has invited you as the Guest Speaker for their Speech and Prize-giving Day.',
    minAge: 50,
    maxAge: 64,
    choices: [
      EventChoice(
        text: 'Prepare an inspiring, honest speech',
        statChanges: {'reputation': 15, 'happiness': 10, 'smarts': 8},
        outcome: 'The students gave you a standing ovation. You donated laptops and left a legend.',
      ),
      EventChoice(
        text: 'Give a generic boring lecture on hard work',
        statChanges: {'reputation': 5, 'happiness': -2, 'discipline': 5},
        outcome: 'Half the hall fell asleep. You did your duty, but left zero impact.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Neighborhood Chairman 🏘️',
    description: 'The residents automatically elected you Chairman of the association because of your age and status.',
    minAge: 50,
    maxAge: 64,
    choices: [
      EventChoice(
        text: 'Rule with an iron fist over security',
        statChanges: {'reputation': 10, 'discipline': 15, 'connections': -5},
        outcome: 'Crime dropped to zero, but nobody is allowed to play loud music after 8 PM anymore.',
      ),
      EventChoice(
        text: 'Use the position for communal parties',
        statChanges: {'happiness': 15, 'connections': 10, 'reputation': 5},
        outcome: 'You threw epic neighborhood street jams. The youth absolutely love you.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Political Appointment Hint 🎩',
    description: 'A politician friend hints that if their party wins, they want to make you a board chairman.',
    minAge: 55,
    maxAge: 64,
    choices: [
      EventChoice(
        text: 'Fund their campaign quietly',
        statChanges: {'money': -15, 'connections': 15, 'streetSense': 10},
        outcome: 'They won! You got the appointment. The perks are incredible, but the stress is high.',
      ),
      EventChoice(
        text: 'Smile and decline politely',
        statChanges: {'reputation': 5, 'discipline': 10, 'happiness': 5},
        outcome: 'You avoided the turbulent waters of Ghanaian politics. Your reputation remains spotless.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Unsolicited Opinion 🗣️',
    description: 'A younger relative is buying a car and didn\'t ask for your opinion. You think they are making a mistake.',
    minAge: 50,
    maxAge: 64,
    choices: [
      EventChoice(
        text: 'Give them the unsolicited lecture',
        statChanges: {'streetSense': 5, 'connections': -8, 'reputation': -2},
        outcome: 'They bought it anyway, but now they actively avoid your calls.',
      ),
      EventChoice(
        text: 'Mind your own business',
        statChanges: {'discipline': 10, 'happiness': 5, 'smarts': 5},
        outcome: 'They bought the bad car and it broke down. They came to you for help, and you graciously assisted.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Loss of a Peer 🕊️',
    description: 'A close friend from your youth suddenly passed away. It reminds you of your mortality.',
    minAge: 55,
    maxAge: 64,
    choices: [
      EventChoice(
        text: 'Fund the funeral arrangements heavily',
        statChanges: {'money': -12, 'reputation': 15, 'connections': 10},
        outcome: 'You gave them a dignified send-off. The family was deeply grateful to you.',
      ),
      EventChoice(
        text: 'Mourn quietly and change your lifestyle',
        statChanges: {'health': 12, 'happiness': -5, 'discipline': 10},
        outcome: 'The grief forced you to quit drinking and start exercising. A tragic wake-up call.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Honorary Title 🎖️',
    description: 'Your church wants to give you a special honorary title for your years of service and tithing.',
    minAge: 55,
    maxAge: 64,
    choices: [
      EventChoice(
        text: 'Accept with a massive thanksgiving donation',
        statChanges: {'reputation': 15, 'connections': 10, 'money': -15},
        outcome: 'You are now officially addressed by your title everywhere you go.',
      ),
      EventChoice(
        text: 'Accept humbly with no showmanship',
        statChanges: {'happiness': 8, 'discipline': 8, 'reputation': 5},
        outcome: 'You took the plaque quietly. People respected your profound humility.',
      ),
    ],
  ),
];

