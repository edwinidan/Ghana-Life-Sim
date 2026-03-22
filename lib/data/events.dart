import '../models/event.dart';

final List<LifeEvent> allEvents = [
  // CHILDHOOD EVENTS
  LifeEvent(
    title: 'Exam Season 😰',
    description:
        'BECE exams are coming and your mother has banned TV, phone, and everything fun. What do you do?',
    minAge: 12,
    maxAge: 15,
    choices: [
      EventChoice(
        text: 'Study hard every night',
        statChanges: {'smarts': 10, 'happiness': -5, 'discipline': 8},
        outcome:
            'You studied like your life depended on it. Your smarts improved significantly.',
      ),
      EventChoice(
        text: 'Study small small and pray',
        statChanges: {'smarts': 3, 'happiness': 2, 'discipline': -3},
        outcome: 'You left the rest to God. Hopefully He was paying attention.',
      ),
      EventChoice(
        text: 'Sneak phone under the covers',
        statChanges: {'smarts': -5, 'happiness': 5, 'streetSense': 5},
        outcome:
            'Your mother caught you at 2am. The slippers came out immediately.',
      ),
    ],
  ),

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

  // TEENAGE EVENTS
  LifeEvent(
    title: 'Senior High School Choice 🏫',
    description:
        'You have been placed for SHS. Your results determine where you go. What is your approach to secondary school?',
    minAge: 15,
    maxAge: 16,
    choices: [
      EventChoice(
        text: 'Focus on academics completely',
        statChanges: {
          'smarts': 15,
          'discipline': 10,
          'happiness': -8,
          'connections': -5,
        },
        outcome:
            'You became one of the top students. No social life, but the grades are serious.',
      ),
      EventChoice(
        text: 'Balance studies and social life',
        statChanges: {
          'smarts': 7,
          'happiness': 10,
          'connections': 8,
          'discipline': 3,
        },
        outcome:
            'You did well enough and made great friends. A balanced SHS experience.',
      ),
      EventChoice(
        text: 'Enjoy school life, study later',
        statChanges: {
          'happiness': 15,
          'streetSense': 8,
          'smarts': -5,
          'discipline': -8,
        },
        outcome:
            'SHS was the time of your life. The results though... we move.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Caught Cheating in Exams 📝',
    description:
        'Your friend passed you answers during the final exams. The invigilator is looking suspicious.',
    minAge: 15,
    maxAge: 18,
    choices: [
      EventChoice(
        text: 'Hide the paper immediately',
        statChanges: {'streetSense': 8, 'discipline': -5, 'happiness': -5},
        outcome: 'You hid it just in time. Heart was beating like a drum.',
      ),
      EventChoice(
        text: 'Submit what you have honestly',
        statChanges: {'discipline': 10, 'reputation': 5, 'smarts': -5},
        outcome:
            'You submitted your own work. Integrity intact, marks not so much.',
      ),
      EventChoice(
        text: 'Get caught using the answers',
        statChanges: {'smarts': -10, 'reputation': -15, 'health': -5},
        outcome:
            'You were caught. Results cancelled. Your parents\' reaction was biblical.',
      ),
    ],
  ),

  // YOUNG ADULT EVENTS
  LifeEvent(
    title: 'University or Not? 🎓',
    description:
        'After SHS you must decide your next move. University, vocational school, or straight to hustle?',
    minAge: 18,
    maxAge: 19,
    choices: [
      EventChoice(
        text: 'Apply to university',
        statChanges: {
          'smarts': 10,
          'money': -15,
          'connections': 10,
          'discipline': 5,
        },
        outcome:
            'You gained admission. Fees are painful but the opportunity is real.',
      ),
      EventChoice(
        text: 'Go to vocational/technical school',
        statChanges: {
          'discipline': 10,
          'money': -5,
          'streetSense': 8,
          'smarts': 5,
        },
        outcome:
            'You learned a solid trade. Practical skills that will pay off.',
      ),
      EventChoice(
        text: 'Start hustling immediately',
        statChanges: {
          'streetSense': 15,
          'money': 5,
          'smarts': -5,
          'connections': 5,
        },
        outcome:
            'No school fees, straight to the streets. High risk, high reward.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Job Opportunity 💼',
    description:
        'A connection has offered you a job. The pay is okay but the boss has a reputation for being difficult.',
    minAge: 20,
    maxAge: 35,
    choices: [
      EventChoice(
        text: 'Take the job gratefully',
        statChanges: {
          'money': 15,
          'happiness': -5,
          'connections': 5,
          'discipline': 5,
        },
        outcome:
            'You took it. The boss is indeed difficult but the money is real.',
      ),
      EventChoice(
        text: 'Negotiate for better pay first',
        statChanges: {'money': 20, 'connections': -5, 'reputation': 5},
        outcome:
            'They respected your boldness and gave you a small raise. Nice.',
      ),
      EventChoice(
        text: 'Decline and keep searching',
        statChanges: {'money': -10, 'happiness': -5, 'discipline': 8},
        outcome:
            'You held out for something better. The rent is not holding out with you.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Business Idea 💡',
    description:
        'You have an idea for a small business. Your friend says it will work. Your mother says pray first.',
    minAge: 22,
    maxAge: 50,
    choices: [
      EventChoice(
        text: 'Start the business now',
        statChanges: {
          'money': -10,
          'reputation': 5,
          'streetSense': 10,
          'discipline': 8,
        },
        outcome:
            'You started it. Early days are rough but you are building something.',
      ),
      EventChoice(
        text: 'Plan more before starting',
        statChanges: {'smarts': 5, 'discipline': 5, 'money': 0},
        outcome:
            'You spent three months planning. Still not started but the plan is beautiful.',
      ),
      EventChoice(
        text: 'Ignore the idea and stay safe',
        statChanges: {'happiness': -8, 'money': 5, 'discipline': -3},
        outcome: 'You played it safe. The idea still haunts you at night.',
      ),
    ],
  ),

  // ADULT EVENTS
  LifeEvent(
    title: 'Health Scare 🏥',
    description:
        'You have not been feeling well for weeks. Something is clearly wrong.',
    minAge: 30,
    maxAge: 80,
    choices: [
      EventChoice(
        text: 'Go to the hospital immediately',
        statChanges: {'health': 15, 'money': -10, 'happiness': 5},
        outcome: 'Early treatment. The doctor said you came just in time.',
      ),
      EventChoice(
        text: 'Try local remedies first',
        statChanges: {'health': -5, 'money': -3, 'streetSense': 3},
        outcome: 'The herbs helped a little but the real issue is still there.',
      ),
      EventChoice(
        text: 'Ignore it and push through',
        statChanges: {'health': -20, 'discipline': 5, 'happiness': -10},
        outcome: 'You pushed through. Your body is keeping score though.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Family Pressure 👨‍👩‍👧',
    description:
        'Your family keeps asking when you are getting married. Every gathering is an interview now.',
    minAge: 25,
    maxAge: 45,
    choices: [
      EventChoice(
        text: 'Laugh it off and change subject',
        statChanges: {'happiness': 5, 'streetSense': 5, 'connections': -3},
        outcome:
            'You dodged it again. You are getting very good at topic changes.',
      ),
      EventChoice(
        text: 'Tell them you are focused on your career',
        statChanges: {'reputation': 5, 'happiness': -5, 'discipline': 5},
        outcome: 'They accepted it but your aunties are not fully convinced.',
      ),
      EventChoice(
        text: 'Let the pressure get to you',
        statChanges: {'happiness': -15, 'health': -5, 'discipline': -5},
        outcome: 'The pressure is real. It is affecting your sleep and mood.',
      ),
    ],
  ),

  // GENERAL EVENTS
  LifeEvent(
    title: 'Light Out Again 🕯️',
    description:
        'Dumsor has struck again. You had important work to finish tonight.',
    minAge: 10,
    maxAge: 90,
    choices: [
      EventChoice(
        text: 'Use your phone torch and push through',
        statChanges: {'discipline': 8, 'health': -3, 'happiness': -5},
        outcome:
            'You finished the work by phone light. Eyes are paying the price.',
      ),
      EventChoice(
        text: 'Give up and sleep early',
        statChanges: {'happiness': 5, 'health': 5, 'discipline': -5},
        outcome: 'Best sleep in weeks honestly. The work can wait.',
      ),
      EventChoice(
        text: 'Go to a neighbour with generator',
        statChanges: {'connections': 5, 'money': -3, 'discipline': 5},
        outcome:
            'Your neighbour welcomed you. Work done, new friendship strengthened.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Unexpected Money 💰',
    description:
        'Someone sent you mobile money by mistake. A significant amount.',
    minAge: 18,
    maxAge: 90,
    choices: [
      EventChoice(
        text: 'Return it immediately',
        statChanges: {'reputation': 15, 'happiness': 5, 'money': 0},
        outcome:
            'You returned it. The person was so relieved they sent you a thank you gift.',
      ),
      EventChoice(
        text: 'Keep it and act like you never saw it',
        statChanges: {'money': 20, 'reputation': -10, 'happiness': -8},
        outcome: 'You kept it. Your conscience is working overtime.',
      ),
      EventChoice(
        text: 'Return half, keep half',
        statChanges: {'money': 10, 'reputation': -5, 'streetSense': 8},
        outcome:
            'A compromise. You are going to need to confess this one eventually.',
      ),
    ],
  ),
];
