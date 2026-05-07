import '../models/event.dart';

/// 20 relationship events for Phase 5.
/// Events are split across Dating, Married, Divorced, and Single statuses.
final List<LifeEvent> relationshipEvents = [

  // ═══════════════════ DATING EVENTS (8) ═══════════════════

  LifeEvent(
    title: 'Meet the Family 👨‍👩‍👧',
    description:
        'Your partner says it is time. They want to meet your family. Your mother has already started asking questions every Sunday. Your father has said nothing, which is worse.',
    minAge: 18,
    maxAge: 40,
    requiredRelationshipStatus: 'Dating',
    choices: [
      EventChoice(
        text: 'Arrange the family meeting',
        statChanges: {'relationshipScore': 10, 'happiness': 5},
        outcome:
            'The meeting happened. Your mother interrogated them for two hours about career plans and religious denomination. Your partner survived. Everyone is cautiously pleased.',
      ),
      EventChoice(
        text: 'Say "not yet, let\'s wait a bit"',
        statChanges: {'relationshipScore': -5, 'happiness': -5},
        outcome:
            'Your partner understood but their eyes said something else. Your mother called later asking why you are hiding somebody. She has already found out. She always finds out.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Partner Needs Money 💸',
    description:
        'Your partner calls. Their rent is due. Their phone bill is past due. Their sister\'s school fees are also somehow your problem now. They say they will pay you back. You have heard this before.',
    minAge: 18,
    maxAge: 45,
    requiredRelationshipStatus: 'Dating',
    choices: [
      EventChoice(
        text: 'Give the money',
        statChanges: {'money': -3, 'happiness': -5, 'relationshipScore': 5},
        outcome:
            'You sent the money. They thanked you warmly. The payback date came and went without discussion. You are choosing love. It is expensive.',
      ),
      EventChoice(
        text: 'Refuse — you have your own bills',
        statChanges: {'relationshipScore': -15, 'money': 3},
        outcome:
            'You said no firmly. They called you stingy. The conversation has been weird ever since. Your wallet is fine. Your relationship is not.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Romantic Getaway 🌴',
    description:
        'Your partner suggests a weekend trip to Volta Region. Boats, waterfalls, quiet guesthouses, no family drama. It will cost money you were saving for something responsible. That something responsible can wait.',
    minAge: 18,
    maxAge: 45,
    requiredRelationshipStatus: 'Dating',
    choices: [
      EventChoice(
        text: 'Book the trip — you only live once',
        statChanges: {'happiness': 10, 'money': -5, 'relationshipScore': 10},
        outcome:
            'The trip was wonderful. You took photos at the waterfall. Your partner held your hand on the boat. You have not felt this light in months. Worth every pesewa.',
      ),
      EventChoice(
        text: 'Skip it — money is tight',
        statChanges: {'relationshipScore': -5, 'money': 3},
        outcome:
            'You stayed home. You saved money. You watched your partner\'s mood drop by several degrees. Sometimes the responsible choice has a cost nobody shows on the spreadsheet.',
      ),
    ],
  ),

  LifeEvent(
    title: 'The Ex Shows Up 😬',
    description:
        'Your partner\'s ex has reappeared. They texted first, then showed up at a gathering you both attended. Your partner is polite. Too polite. Their ex is very attractive. You are watching everything.',
    minAge: 18,
    maxAge: 40,
    requiredRelationshipStatus: 'Dating',
    choices: [
      EventChoice(
        text: 'Stay calm and trust your partner',
        statChanges: {'relationshipScore': 10, 'happiness': 5, 'discipline': 5},
        outcome:
            'You kept it together. Later your partner told you they appreciated how secure you seemed. They chose you. They are still choosing you. Trust is underrated.',
      ),
      EventChoice(
        text: 'Get visibly jealous and make a scene',
        statChanges: {'relationshipScore': -10, 'happiness': -5, 'reputation': -5},
        outcome:
            'It escalated quickly. Your partner was embarrassed. The ex left looking smug. You drove home in silence. The incident was referenced in every argument for the next three months.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Long Distance 📱',
    description:
        'Your partner has taken a job in another region. They will be away for months. The calls are shorter now. The time zones are different. You are both trying but trying looks different from two different cities.',
    minAge: 20,
    maxAge: 45,
    requiredRelationshipStatus: 'Dating',
    choices: [
      EventChoice(
        text: 'Stay faithful and keep the communication strong',
        statChanges: {'relationshipScore': 5, 'happiness': -5, 'discipline': 10},
        outcome:
            'It was hard but you stayed committed. You called when it was inconvenient. You sent voice notes. When they returned, they said you were the only stable thing in a difficult period.',
      ),
      EventChoice(
        text: 'Drift — let the distance do its work',
        statChanges: {'relationshipScore': -15, 'happiness': -5},
        outcome:
            'The calls became weekly. Then fortnightly. Then a long message neither of you knew how to answer. Distance did not break you. Silence did.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Engagement Pressure 💍',
    description:
        'Your partner is asking about the future. Not in a vague way. They have started saying things like "by next year" and "the pastor mentioned a good date in December." Your family is also asking. Your mother specifically.',
    minAge: 22,
    maxAge: 38,
    requiredRelationshipStatus: 'Dating',
    choices: [
      EventChoice(
        text: 'Agree — you feel ready enough',
        statChanges: {'relationshipScore': 5, 'happiness': 5},
        outcome:
            'You told them you are ready. Their face lit up. Your mother has already started compiling a guest list in her head. The country has just decided your next two years for you.',
      ),
      EventChoice(
        text: 'Push back — you are not ready',
        statChanges: {'relationshipScore': -10, 'happiness': -5},
        outcome:
            'You said you need more time. A very long silence followed. The relationship is still intact but there is a new tension. They are waiting. Everyone is waiting.',
      ),
    ],
  ),

  LifeEvent(
    title: 'A Friend\'s Warning 🗣️',
    description:
        'Your closest friend pulls you aside at a gathering. They say they have heard things about your partner. Nothing specific. Just "be careful." Your partner has been nothing but good to you. Your friend looks serious.',
    minAge: 18,
    maxAge: 40,
    requiredRelationshipStatus: 'Dating',
    choices: [
      EventChoice(
        text: 'Take the warning seriously — start asking questions',
        statChanges: {'relationshipScore': -10, 'reputation': 5, 'smarts': 5},
        outcome:
            'You raised it with your partner. They were hurt. Some things were explained. Some were not. Your friend may have saved you from something. Or they may have planted a seed that ruins a good thing. You will never fully know.',
      ),
      EventChoice(
        text: 'Ignore it — you trust your partner',
        statChanges: {'happiness': 5},
        outcome:
            'You chose trust. Nothing happened. Maybe your friend was wrong. Maybe they were right and you got lucky. Life does not always give you the answer.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Valentine\'s Day in Ghana 🌹',
    description:
        'It is February 14th. The entire city is selling roses at triple price. Your partner has said "we don\'t need to do anything" in the tone that means the opposite. You have approximately four hours.',
    minAge: 16,
    maxAge: 45,
    requiredRelationshipStatus: 'Dating',
    choices: [
      EventChoice(
        text: 'Plan something special — dinner, roses, the works',
        statChanges: {'happiness': 10, 'money': -3, 'relationshipScore': 10},
        outcome:
            'You made the effort. The restaurant was crowded and overpriced. Your partner cried a little — the good kind. They said nobody had ever done that for them. You did not mention how much it cost.',
      ),
      EventChoice(
        text: 'Forget entirely — it\'s a commercial holiday anyway',
        statChanges: {'relationshipScore': -15, 'happiness': -5},
        outcome:
            'You remembered at 11pm when their phone was off. You sent a voice note that said "sorry, love." It was not received well. The philosophy about commercialisation did not help your case at all.',
      ),
    ],
  ),

  // ═══════════════════ MARRIED EVENTS (8) ═══════════════════

  LifeEvent(
    title: 'In-Laws Move In 🏠',
    description:
        'Your partner\'s parents are moving in. It was presented as temporary. Temporary in Ghana is a flexible concept. They have already identified which room they want and have opinions about your kitchen organisation.',
    minAge: 24,
    maxAge: 55,
    requiredRelationshipStatus: 'Married',
    choices: [
      EventChoice(
        text: 'Accept it — family is family',
        statChanges: {'reputation': 5, 'happiness': -10, 'relationshipScore': 5},
        outcome:
            'You welcomed them. Your mother-in-law rearranged your kitchen within a week. Your father-in-law watches the news at maximum volume. Your reputation in the extended family is immaculate. Your happiness is not.',
      ),
      EventChoice(
        text: 'Refuse — this is your home',
        statChanges: {'relationshipScore': -15, 'reputation': -10, 'happiness': 5},
        outcome:
            'The refusal became the family\'s main topic for six months. Your partner was caught between two fires. You won the argument. You lost several things that are harder to measure.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Spouse Loses Their Job 😟',
    description:
        'Your spouse has been laid off. The company called it "restructuring." The mortgage, the children\'s school fees, and the generator fuel bill do not restructure. They are quiet and ashamed. You choose your next words carefully.',
    minAge: 26,
    maxAge: 55,
    requiredRelationshipStatus: 'Married',
    choices: [
      EventChoice(
        text: 'Support them fully — you will figure it out together',
        statChanges: {'relationshipScore': 10, 'money': -5, 'happiness': 5},
        outcome:
            'You told them you were a team. They cried. You sorted the finances with discipline and some sacrifice. They found something new within months. They have not forgotten how you showed up.',
      ),
      EventChoice(
        text: 'Show frustration — this is a serious problem',
        statChanges: {'relationshipScore': -20, 'happiness': -10},
        outcome:
            'You said things that were true but not kind. The damage took longer to repair than the job situation. They found new work. The words lingered longer.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Marriage Counselling 🛋️',
    description:
        'A pastor friend has suggested marriage counselling after noticing some tension between you two at a church event. Your spouse thinks it is a good idea. You are less sure. You do not enjoy discussing your feelings in front of a stranger with a notepad.',
    minAge: 26,
    maxAge: 60,
    requiredRelationshipStatus: 'Married',
    choices: [
      EventChoice(
        text: 'Go — it cannot hurt',
        statChanges: {'relationshipScore': 15, 'money': -3, 'happiness': 5},
        outcome:
            'Three sessions in, you both admitted things you had been holding for years. It was uncomfortable and useful. You drive home quieter now but in a better way.',
      ),
      EventChoice(
        text: 'Ignore the suggestion — you are fine',
        statChanges: {},
        outcome:
            'You did not go. Nothing changed. Nothing changed for better or worse. The tension that prompted the suggestion is still there, unfiled.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Wedding Anniversary 🎂',
    description:
        'Your anniversary arrived. Your spouse remembered. You also remembered — but only because their message came through first. There is still time to do something meaningful. The question is whether you will.',
    minAge: 24,
    maxAge: 65,
    requiredRelationshipStatus: 'Married',
    choices: [
      EventChoice(
        text: 'Plan a proper celebration — dinner and a gift',
        statChanges: {'money': -3, 'happiness': 15, 'relationshipScore': 10},
        outcome:
            'You took them somewhere nice. They dressed up. You remembered why you married them. The children asked why you were both laughing so much at dinner. A good evening.',
      ),
      EventChoice(
        text: 'Forget it — you were busy',
        statChanges: {'relationshipScore': -10, 'happiness': -5},
        outcome:
            'You forgot. They pretended not to notice. Then they said goodnight at 8pm and went to bed. The silence was its own kind of message.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Another Child? 👶',
    description:
        'Your spouse wants another child. You have one already. The house is manageable. The school fees are manageable. Another child makes the math considerably less manageable. But your spouse is looking at you with that look.',
    minAge: 24,
    maxAge: 40,
    requiredRelationshipStatus: 'Married',
    choices: [
      EventChoice(
        text: 'Agree — family grows, love grows',
        statChanges: {'happiness': 5, 'relationshipScore': 10, 'numberOfChildren': 1},
        outcome:
            'You agreed. Nine months later, the house was louder. The money was tighter. Your heart was somehow bigger. You do not fully understand the math but you accept the outcome.',
      ),
      EventChoice(
        text: 'Not yet — you need more time and money',
        statChanges: {'relationshipScore': -10},
        outcome:
            'You said not yet. They nodded slowly. The topic was not closed — just set aside. It will come back.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Family Pressure About Children 👨‍👩‍👦',
    description:
        'You have been married two years. Every family gathering now includes the question: "So when are the children coming?" Your aunts ask it directly. Your mother asks it through prayer. Your father simply stares at your spouse.',
    minAge: 24,
    maxAge: 42,
    requiredRelationshipStatus: 'Married',
    choices: [
      EventChoice(
        text: 'Handle it gracefully — deflect and move on',
        statChanges: {'happiness': -5, 'discipline': 5},
        outcome:
            'You smiled and gave a non-answer at every gathering. Your spouse was grateful. The aunties were not satisfied but they have moved on to someone else\'s marriage for now.',
      ),
      EventChoice(
        text: 'Snap — it is none of their business',
        statChanges: {'relationshipScore': -10, 'happiness': -10, 'reputation': -5},
        outcome:
            'You said clearly that it is a private matter. The table went quiet. Your uncle called it disrespectful. Your spouse pulled you outside. The journey home was a long one.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Spouse Gets a Big Promotion 🏆',
    description:
        'Your spouse just got promoted to a senior position with a significant pay rise. They came home glowing. Their new title is longer than your entire job description. You are happy for them. Mostly.',
    minAge: 26,
    maxAge: 55,
    requiredRelationshipStatus: 'Married',
    choices: [
      EventChoice(
        text: 'Celebrate fully — this is a win for both of you',
        statChanges: {'happiness': 5, 'money': 3, 'relationshipScore': 5},
        outcome:
            'You took them to their favourite restaurant. You told everyone proudly. They felt genuinely supported. When you support your partner\'s success, it tends to come back around.',
      ),
      EventChoice(
        text: 'Feel quietly jealous — why not you?',
        statChanges: {'relationshipScore': -10, 'happiness': -5},
        outcome:
            'You smiled but the smile did not reach your eyes. They noticed. You said you were fine. They did not believe you. Competitiveness inside a marriage is a slow, quiet leak.',
      ),
    ],
  ),

  LifeEvent(
    title: 'An Old Flame Returns 🔥',
    description:
        'Someone from your past has reappeared. They sent a message. They look better than you remembered. They are asking to "catch up over coffee." You are married. You are also human. You pause before responding.',
    minAge: 26,
    maxAge: 55,
    requiredRelationshipStatus: 'Married',
    choices: [
      EventChoice(
        text: 'Stay loyal — leave the message on read',
        statChanges: {'relationshipScore': 10, 'discipline': 10, 'happiness': 5},
        outcome:
            'You did not reply. You told your spouse about the message that evening instead. They laughed and kissed your forehead. Loyalty is boring. It is also everything.',
      ),
      EventChoice(
        text: 'Meet them — just coffee, nothing more',
        statChanges: {'happiness': 5, 'discipline': -10},
        outcome:
            'You met them. The coffee was one hour. Then two. Then you were texting daily. You told yourself it was nothing. It became something. God is watching. You can make it official from the Social tab.',
      ),
    ],
  ),

  // ═══════════════════ DIVORCED / SINGLE EVENTS (4) ═══════════════════

  LifeEvent(
    title: 'Friends Want to Set You Up 💌',
    description:
        'Your friends have had enough of watching you be single after the divorce. They have someone in mind. They say this person is "exactly your type" and "very responsible." Your friends said the same thing about your ex.',
    minAge: 25,
    maxAge: 55,
    requiredRelationshipStatus: 'Divorced',
    choices: [
      EventChoice(
        text: 'Accept the setup — you are ready to try again',
        statChanges: {'happiness': 5, 'connections': 5},
        outcome:
            'You went on the date. It was not terrible. There was actual conversation and nobody cried. Your friends are insufferably pleased with themselves. A small possibility has opened.',
      ),
      EventChoice(
        text: 'Decline — you are not ready',
        statChanges: {'happiness': 5},
        outcome:
            'You said not yet. Your friends respected it after a short argument. You sat with your own company that evening and it was fine. Healing is not a race.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Going Back to the Ex? 💔',
    description:
        'Your ex has reached out. They say they have changed. They say they miss you. They said very specific things that they knew would land. You have thought about it more than you would admit to anyone.',
    minAge: 25,
    maxAge: 55,
    requiredRelationshipStatus: 'Divorced',
    choices: [
      EventChoice(
        text: 'Give it another chance',
        statChanges: {'relationshipScore': 40, 'happiness': -5},
        outcome:
            'You went back. The first month was good. Some things have genuinely changed. Other things have not changed at all. Time will tell if the math works this time.',
      ),
      EventChoice(
        text: 'Respect yourself — move forward',
        statChanges: {'happiness': 10, 'discipline': 10},
        outcome:
            'You said no, kindly and firmly. They seemed surprised. You deleted the message chain. Something heavy left your chest that afternoon and you felt lighter for weeks.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Bitter Divorce Aftermath ⚖️',
    description:
        'The lawyers are involved now. Your ex wants more than was agreed. Their family is making statements. Your family is also making statements. A dispute over property has consumed three months of your life.',
    minAge: 25,
    maxAge: 60,
    requiredRelationshipStatus: 'Divorced',
    choices: [
      EventChoice(
        text: 'Fight it legally — you will not be cheated',
        statChanges: {'money': -5, 'happiness': -10, 'reputation': 5},
        outcome:
            'You fought. It took another four months. You won most of what you wanted. The legal fees made it debatable whether winning was the right word. Your lawyer bought a new car.',
      ),
      EventChoice(
        text: 'Let it go — peace is worth the loss',
        statChanges: {'happiness': 5, 'money': -2},
        outcome:
            'You conceded more than you should have. You also stopped losing sleep the week after. There is a version of losing that feels like freedom. You found it.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Single Life Feels Good 😎',
    description:
        'You woke up this morning, made exactly what you wanted for breakfast, watched what you wanted on TV, and made zero decisions based on another person\'s preference. It occurred to you that this is actually quite pleasant.',
    minAge: 16,
    maxAge: 60,
    requiredRelationshipStatus: 'Single',
    choices: [
      EventChoice(
        text: 'Embrace it — this season is yours',
        statChanges: {'happiness': 10, 'discipline': 5},
        outcome:
            'You invested the time in yourself. You picked up old hobbies. You called friends you had neglected. You grew in ways that require no audience. When you are ready, you will be better.',
      ),
      EventChoice(
        text: 'Feel the loneliness creeping in',
        statChanges: {'happiness': -5},
        outcome:
            'The quiet was nice at first. Then it was just quiet. You scrolled through your phone looking for someone to talk to. Being alone and being lonely are different things. Tonight, the line was thin.',
      ),
    ],
  ),
];
