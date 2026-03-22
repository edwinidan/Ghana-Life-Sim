import '../models/event.dart';

final List<LifeEvent> teenEvents = [
  // EXISTING (3)
  LifeEvent(
    title: 'Exam Season 😰',
    description:
        'BECE exams are coming and your mother has banned TV, phone, and everything fun. What do you do?',
    minAge: 13,
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
    maxAge: 17,
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

  // ACADEMIC PRESSURE (5 MORE = 8 TOTAL)
  LifeEvent(
    title: 'BECE Preparation 📖',
    description:
        'The BECE is three weeks away. The school wants to organize extra classes from 6am to 6pm.',
    minAge: 14,
    maxAge: 15,
    choices: [
      EventChoice(
        text: 'Attend all the extra classes',
        statChanges: {'smarts': 12, 'health': -5, 'happiness': -8},
        outcome:
            'You attended every single class. You are exhausted, but fully prepared.',
      ),
      EventChoice(
        text: 'Skip afternoon sessions to sleep',
        statChanges: {'health': 5, 'happiness': 5, 'smarts': -5},
        outcome:
            'You rested well. Missing those past questions might haunt you later though.',
      ),
    ],
  ),
  LifeEvent(
    title: 'WASSCE Stress 🤯',
    description:
        'WASSCE timetable is out. You have Physics and Core Maths on the same day.',
    minAge: 16,
    maxAge: 17,
    choices: [
      EventChoice(
        text: 'Create a strict study timetable',
        statChanges: {'discipline': 15, 'smarts': 8, 'happiness': -10},
        outcome:
            'You lived in the library. Your social life died but your brain grew.',
      ),
      EventChoice(
        text: 'Panic and drink energy drinks',
        statChanges: {'health': -8, 'streetSense': 5, 'smarts': 2},
        outcome:
            'You drank three cans of Rush energy drink. You couldn\'t sleep for two days.',
      ),
      EventChoice(
        text: 'Rely on "Apor" (Leaked papers)',
        statChanges: {'streetSense': 15, 'discipline': -15, 'reputation': -5},
        outcome:
            'You paid money for leaked papers. If they change the questions, it\'s over for you.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Failing a Subject 📉',
    description:
        'You got an F9 in Chemistry. Your father is reviewing the report cards tonight.',
    minAge: 15,
    maxAge: 17,
    choices: [
      EventChoice(
        text: 'Confess before he sees it',
        statChanges: {'reputation': 5, 'discipline': 5, 'happiness': -5},
        outcome:
            'You confessed. The disappointment in his eyes hurt more than a cane.',
      ),
      EventChoice(
        text: 'Blame the wicked teacher',
        statChanges: {'streetSense': 5, 'discipline': -8, 'reputation': -2},
        outcome:
            'He didn\'t believe that "the teacher hates you." Nobody does.',
      ),
    ],
  ),
  LifeEvent(
    title: 'First in Class 🥇',
    description:
        'Results are out. You came first in the class, beating the class genius by one mark.',
    minAge: 13,
    maxAge: 15,
    choices: [
      EventChoice(
        text: 'Brag about it to everyone',
        statChanges: {'reputation': 10, 'connections': -5, 'happiness': 8},
        outcome:
            'You rubbed it in their faces. You gained respect but lost a few friends.',
      ),
      EventChoice(
        text: 'Stay humble',
        statChanges: {'connections': 8, 'discipline': 5, 'reputation': 5},
        outcome:
            'You were gracious about your victory. The genius respected you even more.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Forced Extra Classes 📚',
    description:
        'Your parents enrolled you in Saturday morning vacation classes. Your friends are going to play football.',
    minAge: 13,
    maxAge: 16,
    choices: [
      EventChoice(
        text: 'Go to the classes obediently',
        statChanges: {'smarts': 8, 'discipline': 5, 'happiness': -8},
        outcome:
            'You learned simultaneous equations while your friends learned new skills on the pitch.',
      ),
      EventChoice(
        text: 'Dodge classes and go play',
        statChanges: {'happiness': 10, 'health': 5, 'discipline': -10},
        outcome:
            'You scored two goals. When you got home, your dusty legs betrayed you.',
      ),
    ],
  ),

  // SHS BOARDING HOUSE LIFE (7)
  LifeEvent(
    title: 'Senior\'s Errand 🪣',
    description:
        'It is 5:00 AM. A final year student wakes you up and tells you to fetch him two buckets of water.',
    minAge: 14,
    maxAge: 15,
    choices: [
      EventChoice(
        text: 'Fetch the water without complaining',
        statChanges: {'discipline': 8, 'health': -5, 'connections': 5},
        outcome:
            'You fetched it. The senior was pleased and promised to protect you from other bullies.',
      ),
      EventChoice(
        text: 'Pretend to be seriously ill',
        statChanges: {'streetSense': 8, 'reputation': -5, 'discipline': -5},
        outcome:
            'You faked a massive stomach ache. He told someone else to do it, but glared at you.',
      ),
      EventChoice(
        text: 'Flat out refuse',
        statChanges: {'reputation': 10, 'health': -10, 'discipline': -10},
        outcome:
            'You refused. He made you kneel down with your hands up for two hours. Legend.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Lights Out 🔦',
    description:
        'It is 10 PM in the dormitory. Lights out has been sounded, but you are pressing your phone under the covers.',
    minAge: 15,
    maxAge: 17,
    choices: [
      EventChoice(
        text: 'Keep texting your crush',
        statChanges: {'happiness': 8, 'streetSense': 5, 'discipline': -5},
        outcome:
            'The housemaster walked right past your bed. You nearly died holding your breath.',
      ),
      EventChoice(
        text: 'Turn it off and sleep',
        statChanges: {'health': 5, 'discipline': 5, 'happiness': -2},
        outcome:
            'You slept peacefully. At midnight, the housemaster seized three phones. You were safe.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Dining Hall Protocol 🍽️',
    description:
        'The dining hall prefect announces that the food is waakye. You get to the table, and it is just white rice with red coloring.',
    minAge: 14,
    maxAge: 17,
    choices: [
      EventChoice(
        text: 'Eat it quietly to survive',
        statChanges: {'health': 5, 'happiness': -5, 'discipline': 5},
        outcome:
            'It tasted like sadness and water, but it filled the hole in your stomach.',
      ),
      EventChoice(
        text: 'Start a protest chant "We want Waakye!"',
        statChanges: {'reputation': 10, 'discipline': -10, 'streetSense': 5},
        outcome:
            'The whole hall joined in. The food didn\'t change, but the solidarity was beautiful.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Homesickness 😢',
    description:
        'It is your first week in boarding house. You miss your mother\'s food and your own comfortable bed.',
    minAge: 14,
    maxAge: 15,
    choices: [
      EventChoice(
        text: 'Cry quietly in the bathroom',
        statChanges: {'happiness': -8, 'health': -2, 'reputation': -2},
        outcome:
            'You had a good cry. Another form one boy saw you, and you both cried together.',
      ),
      EventChoice(
        text: 'Open your provisions early to feel better',
        statChanges: {'happiness': 8, 'money': -5, 'discipline': -5},
        outcome:
            'You ate half a tin of Milo dry. You felt much better, but your supplies are dropping.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Making a Best Friend 👯',
    description:
        'The guy next to your bed asks if he can borrow some of your shito. Being stingy early on sets a bad tone.',
    minAge: 14,
    maxAge: 16,
    choices: [
      EventChoice(
        text: 'Give him a generous spoonful',
        statChanges: {'connections': 10, 'reputation': 5, 'money': -2},
        outcome:
            'You shared the shito. You just secured your first real boarding house alliance.',
      ),
      EventChoice(
        text: 'Say your mother counted it',
        statChanges: {'money': 5, 'connections': -8, 'reputation': -5},
        outcome:
            'He nodded and walked away. Nobody asked you for anything ever again.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Exeat Request 📝',
    description:
        'You desperately want to go home for the weekend. The housemaster only signs exeats for emergencies.',
    minAge: 15,
    maxAge: 17,
    choices: [
      EventChoice(
        text: 'Forge a letter from your parents',
        statChanges: {'streetSense': 10, 'discipline': -10, 'reputation': -5},
        outcome:
            'He looked at the handwriting, looked at you, and tore the paper. Close call.',
      ),
      EventChoice(
        text: 'Stay in school and suffer',
        statChanges: {'discipline': 8, 'happiness': -8, 'health': -2},
        outcome:
            'You stayed. The weekend actually wasn\'t too bad once you washed your clothes.',
      ),
      EventChoice(
        text: 'Say you have a terrible toothache',
        statChanges: {'streetSense': 8, 'happiness': 5, 'discipline': -5},
        outcome:
            'He signed it! You had to pretend your jaw was swollen all the way to the gate.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Dormitory Gossip 🗣️',
    description:
        'Someone just brought a wild rumor about the strict chemistry tutor to the dorm. Everyone is discussing it.',
    minAge: 14,
    maxAge: 17,
    choices: [
      EventChoice(
        text: 'Add your own exaggerated details',
        statChanges: {'connections': 5, 'reputation': 5, 'streetSense': 2},
        outcome:
            'You made the story even better. Unverifiable, but entertaining.',
      ),
      EventChoice(
        text: 'Tell them to focus on their books',
        statChanges: {'discipline': 8, 'reputation': -5, 'connections': -3},
        outcome:
            'They called you "Too Know" and stopped including you in late-night talks.',
      ),
    ],
  ),

  // SOCIAL LIFE AND IDENTITY (7)
  LifeEvent(
    title: 'First Crush 💌',
    description:
        'You have developed a massive crush on a student in the other class. You decide to write a love letter.',
    minAge: 14,
    maxAge: 16,
    choices: [
      EventChoice(
        text: 'Spray perfume on it and send',
        statChanges: {'happiness': 5, 'reputation': 5, 'looks': 2},
        outcome:
            'The delivery was smooth. The perfume was a bit too strong, but the intention was clear.',
      ),
      EventChoice(
        text: 'Write big English words to impress',
        statChanges: {'smarts': 5, 'connections': -2, 'happiness': 2},
        outcome:
            'You used words like "ubiquitous" and "pulchritude". They were mostly confused.',
      ),
      EventChoice(
        text: 'Tear it up, fear is too much',
        statChanges: {'discipline': 5, 'happiness': -5, 'streetSense': -2},
        outcome:
            'You destroyed the evidence. Your secret is safe, but so is your loneliness.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Rejection 💔',
    description:
        'Your crush read your note, laughed out loud with their friends, and threw it away. The whole class saw.',
    minAge: 14,
    maxAge: 17,
    choices: [
      EventChoice(
        text: 'Act like you don\'t care',
        statChanges: {'reputation': 5, 'discipline': 5, 'happiness': -10},
        outcome:
            'You played it cool on the outside. Inside, you were listening to sad Akwaboah songs.',
      ),
      EventChoice(
        text: 'Change schools entirely',
        statChanges: {'streetSense': -5, 'discipline': -8, 'happiness': -8},
        outcome:
            'Your parents refused to transfer you. You had to sit in that class every single day.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Peer Pressure 🚭',
    description:
        'The cool kids in your class are sneaking behind the science block to do things they shouldn\'t. They invite you.',
    minAge: 15,
    maxAge: 17,
    choices: [
      EventChoice(
        text: 'Join them to look cool',
        statChanges: {'connections': 10, 'reputation': 5, 'discipline': -15},
        outcome:
            'You joined the "bad boys/girls" club. The clout is high, but the danger is real.',
      ),
      EventChoice(
        text: 'Refuse firmly and walk away',
        statChanges: {'discipline': 12, 'reputation': -5, 'connections': -5},
        outcome:
            'You walked away. They called you a coward, but your record remained clean.',
      ),
      EventChoice(
        text: 'Report them to the authorities',
        statChanges: {'discipline': 10, 'reputation': -15, 'streetSense': -10},
        outcome:
            'You snitched. They were suspended. You became the most hated student in your year.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Social Media Clout 📸',
    description:
        'You posed next to a teacher\'s fancy car and posted it with the caption "God did it". People think it\'s yours.',
    minAge: 16,
    maxAge: 17,
    choices: [
      EventChoice(
        text: 'Keep the lie going',
        statChanges: {'reputation': 10, 'streetSense': 5, 'discipline': -5},
        outcome:
            'The likes kept pouring in. You are living a dangerous digital double life.',
      ),
      EventChoice(
        text: 'Admit it in the comments',
        statChanges: {'reputation': -8, 'discipline': 5, 'happiness': -5},
        outcome:
            'You confessed. The ridicule in the group chat lasted for three solid days.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Fashion Pressure 👗',
    description:
        'It is Mufti day on Friday. Everyone is bringing their best clothes, but yours are outdated.',
    minAge: 14,
    maxAge: 17,
    choices: [
      EventChoice(
        text: 'Borrow clothes from a rich friend',
        statChanges: {'looks': 8, 'connections': 5, 'streetSense': 5},
        outcome:
            'You looked amazing. Let\'s hope you didn\'t sweat too much in their designer shirt.',
      ),
      EventChoice(
        text: 'Wear your faded clothes with confidence',
        statChanges: {'discipline': 5, 'reputation': 5, 'looks': -5},
        outcome:
            'You rocked the vintage look. Confidence really is the best accessory.',
      ),
      EventChoice(
        text: 'Fake an illness and stay home',
        statChanges: {'happiness': -5, 'streetSense': 2, 'discipline': -2},
        outcome:
            'You missed all the fun, but your pride was entirely protected.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Superlatives 🏆',
    description:
        'The yearbook committee is taking votes. You have been nominated for two categories: "Most Likely to Succeed" and "Class Clown".',
    minAge: 16,
    maxAge: 17,
    choices: [
      EventChoice(
        text: 'Campaign for Class Clown',
        statChanges: {'reputation': 8, 'happiness': 5, 'discipline': -5},
        outcome:
            'You won! People love your energy, though teachers take you less seriously now.',
      ),
      EventChoice(
        text: 'Campaign to Succeed',
        statChanges: {'smarts': 5, 'discipline': 5, 'reputation': 2},
        outcome:
            'You won the serious award. The nerdy kids applauded respectfully.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Passing By the Dorm 🚶🏽‍♂️',
    description:
        'You have to walk past the girls/boys dormitory block. Everyone is sitting on the balconies watching.',
    minAge: 15,
    maxAge: 17,
    choices: [
      EventChoice(
        text: 'Put on your best swagger walk',
        statChanges: {'looks': 5, 'reputation': 5, 'streetSense': 2},
        outcome:
            'You walked with the rhythm of an afrobeat star. Someone definitely noticed you.',
      ),
      EventChoice(
        text: 'Look straight down and walk fast',
        statChanges: {'discipline': 5, 'happiness': -2, 'reputation': -2},
        outcome:
            'You zoomed past. Invisible, safe, and entirely uninteresting.',
      ),
      EventChoice(
        text: 'Trip over a stone while swaggaring',
        statChanges: {'reputation': -10, 'happiness': -10, 'looks': -5},
        outcome:
            'You fell spectacularly. The entire block erupted in laughter. Devastating.',
      ),
    ],
  ),

  // SCHOOL EVENTS AND ACTIVITIES (6)
  LifeEvent(
    title: 'Inter-Colleges 🏃🏾‍♂️',
    description:
        'The biggest sports competition of the year. Your school is competing against your longtime rivals.',
    minAge: 14,
    maxAge: 17,
    choices: [
      EventChoice(
        text: 'Join the cheering squad',
        statChanges: {'connections': 8, 'reputation': 5, 'happiness': 5},
        outcome:
            'You sang the "jama" songs until your throat went hoarse. True school spirit.',
      ),
      EventChoice(
        text: 'Try out for the athletics team',
        statChanges: {'health': 10, 'discipline': 5, 'reputation': 5},
        outcome:
            'You made the relay team! The training was brutal but running on the track felt amazing.',
      ),
      EventChoice(
        text: 'Use the distraction to sneak out',
        statChanges: {'streetSense': 10, 'discipline': -10, 'happiness': 8},
        outcome:
            'While everyone was at the stadium, you went to the mall. High risk, high reward.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Speech and Prize 🏅',
    description:
        'It is Speech and Prize-giving day. You didn\'t win any academic awards this year.',
    minAge: 14,
    maxAge: 17,
    choices: [
      EventChoice(
        text: 'Clap for your friends genuinely',
        statChanges: {'connections': 5, 'discipline': 5, 'happiness': 2},
        outcome:
            'You supported your mates. True friendship is celebrating others\' success.',
      ),
      EventChoice(
        text: 'Vow to win everything next year',
        statChanges: {'discipline': 10, 'smarts': 5, 'happiness': -2},
        outcome:
            'The jealousy fueled your academic drive. Next year, the stage is yours.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Prefect Elections 👔',
    description:
        'It is time to elect new school prefects. You are considering running for a position.',
    minAge: 16,
    maxAge: 17,
    choices: [
      EventChoice(
        text: 'Run for Senior/Head Prefect',
        statChanges: {'reputation': 10, 'discipline': 8, 'connections': 5},
        outcome:
            'You ran a bold campaign. You didn\'t win Head, but they made you Assistant.',
      ),
      EventChoice(
        text: 'Run for Dining Hall Prefect',
        statChanges: {'streetSense': 8, 'reputation': 5, 'money': 2},
        outcome:
            'You won! You now control the most important resource in the boarding house: Food.',
      ),
      EventChoice(
        text: 'Stay out of school politics',
        statChanges: {'happiness': 5, 'discipline': -2, 'reputation': -2},
        outcome:
            'You avoided the stress of manifestos and teacher scrutiny. Peaceful life.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Debate Club 🗣️',
    description:
        'You joined the debate club. Today\'s motion is "Farmers are better than Doctors". You have to defend the farmers.',
    minAge: 14,
    maxAge: 17,
    choices: [
      EventChoice(
        text: 'Argue with passion and big words',
        statChanges: {'smarts': 8, 'reputation': 5, 'connections': 2},
        outcome:
            'You dropped facts about food security. The judges were highly impressed.',
      ),
      EventChoice(
        text: 'Make jokes to win the crowd',
        statChanges: {'reputation': 8, 'happiness': 5, 'smarts': -2},
        outcome:
            'You had the whole hall laughing. You lost the debate, but won the people.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The School Trip 🚌',
    description:
        'The school organized a trip to Kakum National Park. The bus breaks down in a random village.',
    minAge: 14,
    maxAge: 16,
    choices: [
      EventChoice(
        text: 'Explore the village with friends',
        statChanges: {'streetSense': 8, 'connections': 5, 'happiness': 5},
        outcome:
            'You bought local snacks and took cool pictures. A broken bus turned into an adventure.',
      ),
      EventChoice(
        text: 'Sit in the hot bus and complain',
        statChanges: {'happiness': -5, 'health': -2, 'discipline': -2},
        outcome:
            'You sweated heavily for three hours while the driver fixed the radiator.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Scripture Union ⛪',
    description:
        'You are attending Friday evening SU fellowship. Warning: The prayer session is getting very intense.',
    minAge: 14,
    maxAge: 17,
    choices: [
      EventChoice(
        text: 'Join the intense prayers',
        statChanges: {'happiness': 5, 'discipline': 8, 'connections': 5},
        outcome:
            'You prayed until your voice went hoarse. You felt spiritually recharged.',
      ),
      EventChoice(
        text: 'Open your eyes to see who is faking',
        statChanges: {'streetSense': 5, 'discipline': -5, 'happiness': 2},
        outcome:
            'You caught the SU president checking his phone. Scandalous!',
      ),
    ],
  ),

  // FAMILY AND HOME (7)
  LifeEvent(
    title: 'The Cousin Comparison 📊',
    description:
        'Your cousin just got 8 As in WASSCE. Your parents sit you down in the living room for a "talk".',
    minAge: 16,
    maxAge: 17,
    choices: [
      EventChoice(
        text: 'Look down and accept the lecture',
        statChanges: {'discipline': 8, 'happiness': -8, 'reputation': 2},
        outcome:
            'You absorbed three hours of motivational abuse. You survived.',
      ),
      EventChoice(
        text: 'Point out your cousin\'s flaws',
        statChanges: {'streetSense': 5, 'reputation': -10, 'discipline': -10},
        outcome:
            'You mentioned the cousin snuck out to club once. The slap you received reset your jaw.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Teaching Sibling 📖',
    description:
        'Your father ordered you to teach your younger sibling maths. They are refusing to understand fractions.',
    minAge: 14,
    maxAge: 17,
    choices: [
      EventChoice(
        text: 'Be patient and explain it again',
        statChanges: {'discipline': 10, 'smarts': 5, 'connections': 5},
        outcome:
            'You found a way to make it make sense using pieces of bread. Teacher material!',
      ),
      EventChoice(
        text: 'Shout at them like a typical teacher',
        statChanges: {'streetSense': 2, 'happiness': -5, 'connections': -5},
        outcome:
            'They started crying, and your parents came to shout at YOU for making them cry.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Coming Home Late 🕰️',
    description:
        'You went to the mall with friends and lost track of time. It is 9 PM and curfew was 6 PM.',
    minAge: 15,
    maxAge: 17,
    choices: [
      EventChoice(
        text: 'Walk in with a fake confident story',
        statChanges: {'streetSense': 8, 'discipline': -5, 'reputation': -5},
        outcome:
            'You blamed "terrible traffic" and a "broken trotro". Unconvincing, but they were too tired to argue.',
      ),
      EventChoice(
        text: 'Beg for mercy at the gate',
        statChanges: {'discipline': 5, 'happiness': -5, 'reputation': -2},
        outcome:
            'You were grounded for a month, but no physical damage was done.',
      ),
    ],
  ),
  LifeEvent(
    title: 'First Phone 📱',
    description:
        'You finally got a smartphone! But your parents say they will check your messages every Friday.',
    minAge: 14,
    maxAge: 16,
    choices: [
      EventChoice(
        text: 'Accept the conditions',
        statChanges: {'connections': 10, 'happiness': 5, 'discipline': 5},
        outcome:
            'You are finally on WhatsApp! You just have to text very boring things.',
      ),
      EventChoice(
        text: 'Download a hidden vault app',
        statChanges: {'streetSense': 15, 'discipline': -10, 'smarts': 5},
        outcome:
            'You hid your real chats in a calculator app. A technological mastermind.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Secret Relationship 🤫',
    description:
        'Your mother was using your phone to make a call when a message popped up: "I miss u bb 🥰".',
    minAge: 15,
    maxAge: 17,
    choices: [
      EventChoice(
        text: 'Say it\'s a wrong number',
        statChanges: {'streetSense': 5, 'reputation': -5, 'discipline': -8},
        outcome:
            'She dialed the number immediately. The voice on the other end ruined you.',
      ),
      EventChoice(
        text: 'Confess it is just a friend',
        statChanges: {'discipline': 5, 'happiness': -10, 'health': -5},
        outcome:
            'The phone was confiscated for three months, and you got a two-hour lecture on purity.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Weekend Chores 🧹',
    description:
        'It is Saturday morning. The house needs cleaning, but you woke up late.',
    minAge: 13,
    maxAge: 17,
    choices: [
      EventChoice(
        text: 'Rush and clean the whole house',
        statChanges: {'discipline': 8, 'health': -2, 'happiness': -2},
        outcome:
            'You scrubbed everything at 2x speed. Sweating profusely, but task accomplished.',
      ),
      EventChoice(
        text: 'Only clean visible surfaces',
        statChanges: {'streetSense': 5, 'discipline': -5, 'smarts': 2},
        outcome:
            'You pushed the dirt under the carpet. Your mother found it a week later.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The TV Remote 📺',
    description:
        'You are watching MTV Base, and your father walks in demanding to watch Al Jazeera news.',
    minAge: 14,
    maxAge: 17,
    choices: [
      EventChoice(
        text: 'Hand it over instantly',
        statChanges: {'discipline': 5, 'happiness': -5, 'reputation': 2},
        outcome:
            'You surrendered the remote. Now you are watching war coverage in a language you barely understand.',
      ),
      EventChoice(
        text: 'Ask if you can just finish this one song',
        statChanges: {'connections': 2, 'discipline': -2, 'streetSense': -5},
        outcome:
            'He gave you a withering look. The remote was taken from you forcefully.',
      ),
    ],
  ),

  // HUSTLE AND MONEY (5)
  LifeEvent(
    title: 'Selling Provisions 🍫',
    description:
        'You realized students in the dorm are hungry at night. You have a huge box of biscuits.',
    minAge: 15,
    maxAge: 17,
    choices: [
      EventChoice(
        text: 'Sell them at double the price',
        statChanges: {'money': 15, 'streetSense': 10, 'reputation': -5},
        outcome:
            'You made massive profit. The boys called you an extortionist, but you are rich.',
      ),
      EventChoice(
        text: 'Share them for free to make friends',
        statChanges: {'connections': 15, 'money': -10, 'happiness': 5},
        outcome:
            'You ran out of biscuits in two days, but everyone loves you now.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Debtor 💸',
    description:
        'A senior borrowed 20 cedis from you last week. Every time you ask, he says "tomorrow".',
    minAge: 14,
    maxAge: 16,
    choices: [
      EventChoice(
        text: 'Report him to the housemaster',
        statChanges: {'discipline': 5, 'reputation': -10, 'money': 5},
        outcome:
            'You got your money back, but breaking the unwritten seniors\' code made you deeply unpopular.',
      ),
      EventChoice(
        text: 'Corner him in public and demand it',
        statChanges: {'streetSense': 10, 'reputation': 5, 'health': -2},
        outcome:
            'You embarrassed him in front of his peers. He paid up to save face.',
      ),
      EventChoice(
        text: 'Write it off as a loss',
        statChanges: {'happiness': -5, 'money': -5, 'discipline': 5},
        outcome:
            'You lost the money, but learned a valuable lesson about lending in school.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Found Money 💵',
    description:
        'You found a crisp 50 cedi note on the assembly ground during break time.',
    minAge: 13,
    maxAge: 17,
    choices: [
      EventChoice(
        text: 'Take it to the headmaster',
        statChanges: {'discipline': 15, 'reputation': 10, 'money': 0},
        outcome:
            'You handed it in. They announced your honesty at assembly. A legend.',
      ),
      EventChoice(
        text: 'Pocket it quietly',
        statChanges: {'money': 15, 'streetSense': 5, 'discipline': -10},
        outcome:
            'You bought waakye for yourself and three friends. Nobody ever asked about the money.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Chop Money Deficit 📉',
    description:
        'It is week 5 of the term, and you only have 10 cedis left. Vacation is in 4 weeks.',
    minAge: 15,
    maxAge: 17,
    choices: [
      EventChoice(
        text: 'Start a laundry business',
        statChanges: {'money': 10, 'streetSense': 8, 'discipline': 5},
        outcome:
            'You washed seniors\' uniforms for cash. Humbling, but you survived the term.',
      ),
      EventChoice(
        text: 'Drink gari soakings every day',
        statChanges: {'health': -8, 'money': 0, 'happiness': -5},
        outcome:
            'You survived on gari and tap water. Your collarbones are now very visible.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Homework for Cash ✍🏾',
    description:
        'The lazy rich kid in your class offered to pay you to do his Geography assignment.',
    minAge: 14,
    maxAge: 16,
    choices: [
      EventChoice(
        text: 'Do it for the money',
        statChanges: {'money': 10, 'streetSense': 5, 'discipline': -5},
        outcome:
            'You forged his handwriting and took the cash. Hustling 101.',
      ),
      EventChoice(
        text: 'Refuse on moral grounds',
        statChanges: {'discipline': 8, 'reputation': 5, 'money': 0},
        outcome:
            'You refused. He failed the assignment, and you kept your integrity.',
      ),
    ],
  ),

  // THE REST TO HIT 50 TOTAL (10 REVEALED IN PLAN)
  LifeEvent(
    title: 'Boarding House Hunger 🥫',
    description:
        'Your provisions are finished, and prep time just ended. The hunger is physically painful.',
    minAge: 14,
    maxAge: 17,
    choices: [
      EventChoice(
        text: 'Beg a friend for gari',
        statChanges: {'connections': 5, 'happiness': 2, 'reputation': -2},
        outcome:
            'A true friend set you up with some dry gari. You slept peacefully.',
      ),
      EventChoice(
        text: 'Drink water and sleep',
        statChanges: {'health': -5, 'discipline': 5, 'happiness': -5},
        outcome:
            'You disciplined your stomach to ignore the pain. Tough times.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Unannounced Test 📝',
    description:
        'Your strictest teacher just walked in and shouted "Tear a piece of paper!"',
    minAge: 13,
    maxAge: 17,
    choices: [
      EventChoice(
        text: 'Panic and tear a rough edge',
        statChanges: {'happiness': -5, 'smarts': -2, 'discipline': -2},
        outcome:
            'The teacher seized your paper for not having a straight edge. Zero marks.',
      ),
      EventChoice(
        text: 'Write confidently',
        statChanges: {'smarts': 8, 'discipline': 5, 'reputation': 2},
        outcome:
            'You actually remembered the old notes and aced the surprise test.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Nickname Origins 🏷️',
    description:
        'A senior jokingly called you "Big Head" in front of the whole dormitory, and everyone laughed.',
    minAge: 14,
    maxAge: 16,
    choices: [
      EventChoice(
        text: 'Get angry and fight',
        statChanges: {'reputation': -5, 'health': -5, 'discipline': -5},
        outcome:
            'You got angry. That sealed it; you will be "Big Head" until you graduate.',
      ),
      EventChoice(
        text: 'Laugh along with them',
        statChanges: {'streetSense': 8, 'connections': 5, 'happiness': -2},
        outcome:
            'You laughed it off. They got bored and forgot the name within a week.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Barber 💈',
    description:
        'The school disciplinary master caught you with hair he considers "too long". He has a rusty pair of scissors.',
    minAge: 15,
    maxAge: 17,
    choices: [
      EventChoice(
        text: 'Let him give you a bald patch',
        statChanges: {'looks': -15, 'happiness': -10, 'discipline': 5},
        outcome:
            'He cut a runway down the middle of your head. You had to shave it all off later.',
      ),
      EventChoice(
        text: 'Run away into the crowd',
        statChanges: {'streetSense': 10, 'discipline': -10, 'reputation': 5},
        outcome:
            'You dashed. You avoided the bad haircut but now you have to dodge him all term.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Visiting Day 👨‍👩‍👦',
    description:
        'It is visiting day! Your parents arrived with Jollof rice, chicken, and fresh provisions.',
    minAge: 14,
    maxAge: 17,
    choices: [
      EventChoice(
        text: 'Eat everything immediately',
        statChanges: {'health': 10, 'happiness': 15, 'discipline': -5},
        outcome:
            'You gorged yourself. Best meal of the term, but it\'s all gone now.',
      ),
      EventChoice(
        text: 'Hide the food and eat slowly over a week',
        statChanges: {'discipline': 10, 'streetSense': 5, 'health': 5},
        outcome:
            'You rationed it properly. A smart move against the boarding house famine.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Sneaking Food into Class 🍱',
    description:
        'You saved a piece of meat from dining hall and wrapped it in paper. You are eating it at the back of the math class.',
    minAge: 14,
    maxAge: 16,
    choices: [
      EventChoice(
        text: 'Chew slowly and silently',
        statChanges: {'streetSense': 8, 'happiness': 5, 'smarts': -2},
        outcome:
            'You successfully digested contraband meat during algebra. A triumph of stealth.',
      ),
      EventChoice(
        text: 'Share a piece with your deskmate',
        statChanges: {'connections': 8, 'reputation': 5, 'streetSense': -5},
        outcome:
            'Your deskmate crunched a bone loudly. The teacher caught you both.',
      ),
    ],
  ),
  LifeEvent(
    title: 'The Strict Teacher 👨🏾‍🏫',
    description:
        'The science teacher is infamous for caning. He asks a difficult question and points his stick at you.',
    minAge: 14,
    maxAge: 17,
    choices: [
      EventChoice(
        text: 'Stammer and guess the answer',
        statChanges: {'smarts': -5, 'happiness': -5, 'health': -5},
        outcome:
            'Wrong answer. The cane descended on your shoulders with terrifying speed.',
      ),
      EventChoice(
        text: 'Confidently say "I don\'t know, Sir"',
        statChanges: {'reputation': 5, 'discipline': 5, 'streetSense': 2},
        outcome:
            'He respected your honesty, called you a fool, and moved to the next trembling victim.',
      ),
    ],
  ),
  LifeEvent(
    title: 'First Dance at the Jams 💃',
    description:
        'It is the school leavers\' jam. The DJ is playing the hottest song. Your crush is standing nearby.',
    minAge: 16,
    maxAge: 17,
    choices: [
      EventChoice(
        text: 'Step up and dance wildly',
        statChanges: {'looks': 5, 'reputation': 10, 'happiness': 8},
        outcome:
            'You busted out moves you didn\'t know you had. The crowd went crazy.',
      ),
      EventChoice(
        text: 'Stand awkwardly at the back',
        statChanges: {'discipline': 5, 'happiness': -5, 'connections': -2},
        outcome:
            'You wallflowered the whole night. Safe from embarrassment, but boring.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Graduation Day 🎓',
    description:
        'You have written your last WASSCE paper. You are wearing your school uniform and holding a marker for signatures.',
    minAge: 17,
    maxAge: 17,
    choices: [
      EventChoice(
        text: 'Get everyone to sign your shirt',
        statChanges: {'connections': 15, 'happiness': 10, 'reputation': 5},
        outcome:
            'Your shirt is covered in ink, nicknames, and memories. A perfect end to SHS.',
      ),
      EventChoice(
        text: 'Hurry home to sleep',
        statChanges: {'health': 10, 'happiness': 5, 'connections': -5},
        outcome:
            'You slipped away. Three years of stress washed away in a twelve-hour nap.',
      ),
    ],
  ),
  LifeEvent(
    title: 'Confiscated Item 📦',
    description:
        'The housemaster seized your expensive mp3 player during inspection.',
    minAge: 15,
    maxAge: 17,
    choices: [
      EventChoice(
        text: 'Go to his office and beg',
        statChanges: {'connections': 5, 'discipline': -5, 'happiness': -2},
        outcome:
            'You knelt and begged. He gave it back with a last warning.',
      ),
      EventChoice(
        text: 'Plan a stealth mission to steal it back',
        statChanges: {'streetSense': 15, 'discipline': -15, 'reputation': 5},
        outcome:
            'You retrieved it from his desk while he was teaching. If he ever checks, you are dead.',
      ),
    ],
  ),
];
