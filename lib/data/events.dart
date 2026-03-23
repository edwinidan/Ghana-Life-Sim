import 'childhood_events.dart';
import 'teen_events.dart';
import 'young_adult_events.dart';
import 'adult_events.dart';
import 'ghana_events.dart';
import 'rare_events.dart';
import 'senior_events.dart';
import 'career_events.dart';
import '../models/event.dart';

final List<LifeEvent> allEvents = [
  ...childhoodEvents,
  ...teenEvents,
  ...youngAdultEvents,
  ...adultEvents,
  ...seniorEvents,
  ...ghanaEvents,
  ...rareEvents,
  ...careerEntryEvents,
  ...careerSpecificEvents,
  LifeEvent(
    title: 'Struck by Lightning ⚡',
    description:
        'You were standing under a mango tree during a rainstorm. Everyone told you not to. You did it anyway. A bolt of lightning struck the tree — and you felt it.',
    minAge: 5,
    maxAge: 90,
    choices: [
      EventChoice(
        text: 'Survive and tell everyone',
        statChanges: {'health': -30, 'reputation': 20, 'happiness': 10},
        outcome:
            'You survived. Your hair never sat flat again. People now call you "Blazeman." You hate it but also kind of love it.',
      ),
      EventChoice(
        text: 'Stay quiet and recover alone',
        statChanges: {'health': -20, 'happiness': -10},
        outcome:
            'You recovered quietly. Your left eyebrow twitches whenever it rains. Doctors say you\'re fine. You\'re not sure.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Jollof Rice Competition 🍛',
    description:
        'A neighbourhood jollof cook-off has broken out and somehow you\'ve been entered. Ghana vs Nigeria energy is in the air. The whole street is watching. Your pot is on fire — literally.',
    minAge: 12,
    maxAge: 60,
    choices: [
      EventChoice(
        text: 'Cook with everything you have',
        statChanges: {'reputation': 25, 'happiness': 20, 'connections': 10},
        outcome:
            'Your jollof won by a landslide. A Nigerian visitor quietly admitted it was better than theirs. You screenshot nothing — you didn\'t need to. The street remembers.',
      ),
      EventChoice(
        text: 'Sabotage a competitor\'s pot',
        statChanges: {'reputation': -20, 'happiness': 15, 'streetSense': 10},
        outcome:
            'Someone saw you. The whole neighbourhood talked about it for six months. You still maintain you added salt "by accident."',
      ),
      EventChoice(
        text: 'Withdraw and eat someone else\'s food',
        statChanges: {'happiness': 10, 'reputation': -5},
        outcome:
            'You sat in the corner eating jollof from three different pots "for research." Nobody was fooled. Still a good evening.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Prophesy at Church 🕊️',
    description:
        'The visiting prophet pointed directly at you during service and said, "This one! God says great things are coming — but there is a delay." The whole church turned to look at you.',
    minAge: 10,
    maxAge: 70,
    choices: [
      EventChoice(
        text: 'Stand up and shout "Amen!"',
        statChanges: {'reputation': 15, 'happiness': 10, 'connections': 5},
        outcome:
            'The congregation erupted. Three aunties fainted from the Holy Spirit. You became the most talked-about person in church that month.',
      ),
      EventChoice(
        text: 'Sit still and look unbothered',
        statChanges: {'discipline': 10, 'reputation': -5},
        outcome:
            'The prophet looked confused. Your mum pinched you on the arm after service. She is still praying about your "hardened heart."',
      ),
      EventChoice(
        text: 'Ask what the delay is about',
        statChanges: {'smarts': 5, 'reputation': -10},
        outcome:
            'The prophet did not expect a follow-up question. Neither did anyone else. Service ran 45 minutes longer than usual.',
      ),
    ],
  ),

  LifeEvent(
    title: 'You Went Viral 📱',
    description:
        'A video of you doing something completely ordinary — buying waakye, arguing with a trotro mate, or just standing — has gone viral on Twitter and TikTok. 2 million views overnight.',
    minAge: 15,
    maxAge: 45,
    choices: [
      EventChoice(
        text: 'Lean into the fame immediately',
        statChanges: {'reputation': 40, 'connections': 20, 'happiness': 15},
        outcome:
            'You posted a follow-up. Brands DMed you. A radio station called. For three weeks you were Ghana\'s main character. It was chaotic and wonderful.',
      ),
      EventChoice(
        text: 'Hide and wait for it to pass',
        statChanges: {'happiness': -15, 'discipline': 10},
        outcome:
            'You deleted all your social media and stayed indoors. It passed in two weeks. You emerged like nothing happened. No one believed you.',
      ),
      EventChoice(
        text: 'Use it to promote your hustle',
        statChanges: {'money': 30, 'reputation': 20, 'connections': 15},
        outcome:
            'You redirected every comment to your business page. Sales tripled in a week. Smart move. Ghana Twitter respects the grind.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Armed Robbers at 3am 🔦',
    description:
        'You wake up to voices outside your window. Your phone screen gives you away. Three men with torches and something metal are moving through the compound.',
    minAge: 15,
    maxAge: 75,
    choices: [
      EventChoice(
        text: 'Stay still and silent',
        statChanges: {'health': 5, 'happiness': -20, 'streetSense': 15},
        outcome:
            'They left without incident. You didn\'t sleep properly for a month. You now know exactly which floorboards creak in your house.',
      ),
      EventChoice(
        text: 'Shout "THIEF!" and wake the neighbourhood',
        statChanges: {'health': -15, 'reputation': 20, 'streetSense': 10},
        outcome:
            'They ran. The neighbours came out. One chased them with a cutlass. You became a local hero but also received a slap from your mum for waking her.',
      ),
      EventChoice(
        text: 'Negotiate from your window',
        statChanges: {'money': -20, 'health': 10, 'streetSense': 20},
        outcome:
            'You talked them down to just taking the old TV and some frozen chicken. It was an insane decision that somehow worked perfectly.',
      ),
    ],
  ),

  LifeEvent(
    title: 'ECG Cuts Power for 3 Days 💡',
    description:
        'Dumsor has returned. ECG gave zero warning. Your food is spoiling, your phone is dead, and your neighbour\'s generator is running — but only for himself.',
    minAge: 10,
    maxAge: 80,
    choices: [
      EventChoice(
        text: 'Beg the neighbour to share his generator',
        statChanges: {'happiness': 5, 'reputation': -10, 'connections': 5},
        outcome:
            'He let you charge your phone for exactly 30 minutes. You owe him a favour now. He will collect at the worst possible time.',
      ),
      EventChoice(
        text: 'Buy a power bank and adapt',
        statChanges: {'money': -10, 'smarts': 5, 'discipline': 10},
        outcome:
            'You survived. You read three books and discovered you enjoy silence. You are now slightly insufferable about "screen-free living."',
      ),
      EventChoice(
        text: 'Go to ECG office and complain loudly',
        statChanges: {'reputation': 10, 'happiness': -10, 'streetSense': 5},
        outcome:
            'Nothing changed. But people recorded your speech outside the ECG office and shared it. You made a valid point. No one at ECG cared.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Nana Dropped Money at Your Feet 💰',
    description:
        'You\'re walking in the market and a very old woman — clearly someone\'s grandmother — accidentally drops an envelope stuffed with cash. She hasn\'t noticed. Nobody is watching.',
    minAge: 8,
    maxAge: 50,
    choices: [
      EventChoice(
        text: 'Return it immediately',
        statChanges: {'reputation': 30, 'happiness': 15, 'connections': 10},
        outcome:
            'She wept and blessed you seven times. Turns out it was her entire funeral contribution money. You became a legend in that market.',
      ),
      EventChoice(
        text: 'Take it and walk fast',
        statChanges: {'money': 40, 'happiness': -25, 'reputation': -20},
        outcome:
            'You took it. You spent it. It never felt good. Every time you see an old woman in the market you cross the street.',
      ),
      EventChoice(
        text: 'Take half and return half',
        statChanges: {'money': 20, 'happiness': -10, 'streetSense': 10},
        outcome:
            'An absolutely deranged moral compromise. You\'ve told yourself it was a "finder\'s fee." Nobody else would understand this reasoning.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Government Scholarship Letter 🎓',
    description:
        'A letter arrives. You\'ve been selected for a government scholarship to study abroad. But your family is pressuring you to stay and take care of them. The deadline is in 48 hours.',
    minAge: 17,
    maxAge: 25,
    choices: [
      EventChoice(
        text: 'Accept and go abroad',
        statChanges: {
          'smarts': 30,
          'money': 20,
          'happiness': 10,
          'connections': 20,
        },
        outcome:
            'You went. It was hard. You cried in an airport bathroom in January. But you came back three years later speaking two languages and wearing a coat.',
      ),
      EventChoice(
        text: 'Decline for family',
        statChanges: {'happiness': -20, 'reputation': 10, 'discipline': 15},
        outcome:
            'You stayed. Your family was grateful. You never fully stopped wondering what would have happened. You became the responsible one forever.',
      ),
      EventChoice(
        text: 'Defer and try to negotiate',
        statChanges: {'smarts': 10, 'happiness': -5, 'streetSense': 10},
        outcome:
            'They said no deferrals. The opportunity closed. You spent two years preparing a better application. The second time, you got something even better.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Your Photo Ended Up on a Campaign Poster 📸',
    description:
        'Someone used your photo — taken without permission — as the background image on a political campaign poster. It\'s plastered across three regions. You look very serious in it.',
    minAge: 18,
    maxAge: 50,
    choices: [
      EventChoice(
        text: 'Demand they take it down',
        statChanges: {'reputation': 15, 'connections': -5, 'discipline': 10},
        outcome:
            'They apologised and removed it. A human rights organisation contacted you. You became briefly famous for standing up. Worth it.',
      ),
      EventChoice(
        text: 'Embrace it and act like you approved it',
        statChanges: {'reputation': 20, 'streetSense': 15, 'connections': 10},
        outcome:
            'You told nobody the truth. People assumed you were politically connected. Doors opened. You smiled and said nothing for months.',
      ),
      EventChoice(
        text: 'Ignore it and hope nobody notices',
        statChanges: {'happiness': -10, 'streetSense': 5},
        outcome:
            'Your aunty in Kumasi called to ask when you joined NDC. Your mum called to ask when you joined NPP. Same poster. Two regions. Different parties.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Goat Ate Your Documents 🐐',
    description:
        'A neighbour\'s goat broke into your room and ate your WASSCE certificate, your birth certificate, and — somehow — your bank statement. The goat looks completely unbothered.',
    minAge: 16,
    maxAge: 40,
    choices: [
      EventChoice(
        text: 'Chase the goat and demand compensation',
        statChanges: {'streetSense': 10, 'money': 10, 'happiness': -5},
        outcome:
            'You chased the goat for 20 minutes. The neighbour gave you GHS 50 and an apology. Replacing the documents cost GHS 200. At least you have a story.',
      ),
      EventChoice(
        text: 'Report it to the district office',
        statChanges: {'smarts': 5, 'discipline': 10, 'happiness': -15},
        outcome:
            'The district office was confused. There is no official form for "goat ate my papers." You spent a week in queues getting replacements.',
      ),
      EventChoice(
        text: 'Cook the goat',
        statChanges: {'happiness': 20, 'reputation': -15, 'streetSense': 10},
        outcome:
            'You cooked the goat. It was delicious. Your neighbour never forgave you. The neighbourhood is divided. Worth it.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Pyramid Scheme Meeting 💸',
    description:
        'Your cousin invited you to a "business opportunity meeting." The room is full of excited people, a whiteboard, and someone in a very expensive suit talking about passive income.',
    minAge: 18,
    maxAge: 45,
    choices: [
      EventChoice(
        text: 'Invest everything you have',
        statChanges: {'money': -50, 'happiness': -30, 'smarts': 15},
        outcome:
            'It collapsed in four months. You lost everything you put in. You now warn everyone you meet about schemes. You are the most financially educated person you know.',
      ),
      EventChoice(
        text: 'Invest a small test amount',
        statChanges: {'money': -10, 'smarts': 10, 'streetSense': 15},
        outcome:
            'You lost the test amount but learned exactly how these work. Cheap tuition. You spotted two more schemes the following year without even trying.',
      ),
      EventChoice(
        text: 'Walk out immediately',
        statChanges: {'smarts': 10, 'discipline': 10, 'happiness': 5},
        outcome:
            'You walked out, told your cousin it was a scam, and went home. Your cousin didn\'t speak to you for three months. Then they lost everything. Then they called.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Trotro Driver Argument Goes National 🚌',
    description:
        'A heated argument between you and a trotro mate over change — you gave GHS 5, the fare is GHS 3.50 — was filmed by a passenger and uploaded online. Ghana is taking sides.',
    minAge: 15,
    maxAge: 60,
    choices: [
      EventChoice(
        text: 'Double down — you were right',
        statChanges: {'reputation': 15, 'happiness': 10, 'streetSense': 10},
        outcome:
            'Ghana agreed with you. The trotro mate became a meme. You received the exact GHS 1.50 change three days later via mobile money from a stranger.',
      ),
      EventChoice(
        text: 'Apologise publicly',
        statChanges: {'reputation': -10, 'happiness': -10, 'connections': 5},
        outcome:
            'You apologised. Ghana did not forgive you easily. Someone made a YouTube video about "soft people who can\'t handle trotro culture." It was about you.',
      ),
      EventChoice(
        text: 'Say nothing and disappear from social media',
        statChanges: {'discipline': 10, 'happiness': -5},
        outcome:
            'Smart. The internet moved on in a week. You returned quietly. You now always carry exact change.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Witch Doctor Recommendation 🌿',
    description:
        'Your family has decided something is spiritually wrong with your finances. An uncle has arranged for a "powerful man" from the village to perform a cleansing. Everyone expects you to cooperate.',
    minAge: 18,
    maxAge: 55,
    choices: [
      EventChoice(
        text: 'Go along with the ceremony',
        statChanges: {'connections': 15, 'happiness': -5, 'reputation': 5},
        outcome:
            'You went. It involved eggs, white powder, and a very early morning. You felt nothing spiritual. Your family felt better. Relationships improved. Arguably worth it.',
      ),
      EventChoice(
        text: 'Refuse and cause a family scene',
        statChanges: {'discipline': 15, 'connections': -20, 'happiness': -15},
        outcome:
            'Three aunties haven\'t spoken to you since. Your mum keeps sighing heavily every time she sees you. You stand by your decision. It is lonely.',
      ),
      EventChoice(
        text: 'Pretend to go, then sneak off',
        statChanges: {'streetSense': 15, 'happiness': 10, 'connections': -5},
        outcome:
            'You paid a cousin to cover for you. You went to KFC instead. The family believes the cleansing worked. You are spiritually uncleansed and fully satisfied.',
      ),
    ],
  ),

  LifeEvent(
    title: 'You Accidentally Became a Pastor\'s Favourite 🙌',
    description:
        'After helping the church move chairs three Sundays in a row, Pastor has publicly declared you a "pillar of this ministry" and put your name in the bulletin. You just wanted to leave early.',
    minAge: 16,
    maxAge: 50,
    choices: [
      EventChoice(
        text: 'Lean into it and join the inner circle',
        statChanges: {'reputation': 20, 'connections': 25, 'happiness': 5},
        outcome:
            'You became an usher, then a deacon, then somehow the head of the welfare committee. It is a lot. The connections are real though.',
      ),
      EventChoice(
        text: 'Stop showing up to avoid more responsibility',
        statChanges: {'reputation': -10, 'happiness': 15, 'discipline': 5},
        outcome:
            'You ghosted the church for a month. When you returned, they gave you an even bigger assignment. There is no escaping.',
      ),
      EventChoice(
        text: 'Accept gracefully and do the minimum',
        statChanges: {'reputation': 10, 'connections': 10, 'smarts': 5},
        outcome:
            'You mastered the art of looking busy during church events. Nobody questioned you. You found your ideal church-life balance.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Mobile Money Fraud Attempt 📲',
    description:
        'A text says you\'ve won GHS 10,000 from MTN. All you need to do is send GHS 50 to "verify your number." The message has three spelling errors.',
    minAge: 16,
    maxAge: 80,
    choices: [
      EventChoice(
        text: 'Send the GHS 50',
        statChanges: {'money': -50, 'smarts': -10, 'streetSense': 20},
        outcome:
            'Gone. All of it. You called the number back and a child answered. You reported it to MTN. Nothing happened. You now read every text three times.',
      ),
      EventChoice(
        text: 'Delete and block',
        statChanges: {'smarts': 10, 'streetSense': 10},
        outcome:
            'Correct. You told your grandma about this scam. She had received the same message. You saved her GHS 50. She gave you GHS 20 as thanks.',
      ),
      EventChoice(
        text: 'Try to scam the scammer back',
        statChanges: {'streetSense': 20, 'happiness': 15, 'smarts': 10},
        outcome:
            'You wasted 45 minutes of their time pretending to process the payment. You won nothing financially but you feel incredible about it.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Celebrity Spotted at Your Junction 🌟',
    description:
        'You\'re at the roadside chop bar and you notice Stonebwoy — or someone who looks exactly like him — eating banku at the table next to you. Your hands are shaking.',
    minAge: 13,
    maxAge: 50,
    choices: [
      EventChoice(
        text: 'Walk over and introduce yourself boldly',
        statChanges: {'reputation': 20, 'connections': 15, 'happiness': 20},
        outcome:
            'It was him. He was warm and took a photo. You posted it. 3,000 likes in an hour. You will talk about this forever.',
      ),
      EventChoice(
        text: 'Take a sneaky photo and post it',
        statChanges: {'reputation': 10, 'happiness': 15, 'connections': -5},
        outcome:
            'He noticed. He was polite but clearly not impressed. You deleted the post within the hour. The screenshot lives on.',
      ),
      EventChoice(
        text: 'Respect his privacy and keep eating',
        statChanges: {'discipline': 15, 'happiness': 10, 'reputation': 5},
        outcome:
            'He noticed your restraint. On his way out he bought your food. You locked eyes. He nodded. It was the coolest moment of your life.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Bank Credited You by Mistake 🏦',
    description:
        'You check your account and GHS 50,000 has appeared overnight. Your balance was GHS 340 yesterday. The bank hasn\'t contacted you yet.',
    minAge: 20,
    maxAge: 60,
    choices: [
      EventChoice(
        text: 'Spend it immediately before they notice',
        statChanges: {
          'money': 30,
          'happiness': 10,
          'smarts': -20,
          'reputation': -20,
        },
        outcome:
            'You spent GHS 15,000. The bank noticed. They reversed the full amount and froze your account pending investigation. You paid a lawyer GHS 8,000 to resolve it.',
      ),
      EventChoice(
        text: 'Report it to the bank right away',
        statChanges: {'reputation': 25, 'connections': 10, 'discipline': 15},
        outcome:
            'The bank manager personally thanked you. Two months later you applied for a business loan. It was approved faster than anyone expected. Integrity compounds.',
      ),
      EventChoice(
        text: 'Wait and see what happens',
        statChanges: {'streetSense': 10, 'happiness': -10, 'discipline': 5},
        outcome:
            'They reversed it after 72 hours with no explanation. You spent three days unable to eat properly. Your heart rate finally returned to normal on day four.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Your Side Hustle Went Crazy 🔥',
    description:
        'The small thing you started selling from home — food, clothes, phone accessories, anything — suddenly got a huge order. Way bigger than you can handle alone.',
    minAge: 18,
    maxAge: 50,
    choices: [
      EventChoice(
        text: 'Accept the order and figure it out',
        statChanges: {
          'money': 40,
          'discipline': 20,
          'health': -10,
          'smarts': 10,
        },
        outcome:
            'You didn\'t sleep for four days. You delivered. The client came back with a bigger order. You hired your first helper. The hustle became a business.',
      ),
      EventChoice(
        text: 'Decline — too risky',
        statChanges: {'happiness': -15, 'discipline': 5},
        outcome:
            'They went elsewhere. You regretted it for months. But you learned exactly what capacity you need to build before the next opportunity. It will come.',
      ),
      EventChoice(
        text: 'Partner with a friend to split the work',
        statChanges: {'money': 20, 'connections': 15, 'happiness': 15},
        outcome:
            'You and your friend delivered together. You split the profit fairly. The friendship deepened. You now have a real business partner.',
      ),
    ],
  ),

  LifeEvent(
    title: 'You Were Mistaken for a Big Man 👔',
    description:
        'You borrowed a friend\'s car and stopped at a fuel station. The attendants are treating you like a VIP, calling you "Boss" and "Sir." Someone is already wiping the windscreen unbothered.',
    minAge: 20,
    maxAge: 55,
    choices: [
      EventChoice(
        text: 'Play along completely',
        statChanges: {'happiness': 20, 'streetSense': 10, 'money': -5},
        outcome:
            'You played the role perfectly. Tipped them GHS 10. Drove away like a CEO. You had GHS 80 in your account. Peak Ghanaian confidence.',
      ),
      EventChoice(
        text: 'Explain the car isn\'t yours',
        statChanges: {'reputation': 5, 'discipline': 10, 'happiness': -5},
        outcome:
            'They treated you normally after that. Honestly fine. You respect honesty. The windscreen wipe was still free.',
      ),
      EventChoice(
        text: 'Use the moment to network aggressively',
        statChanges: {'connections': 20, 'smarts': 10, 'reputation': 15},
        outcome:
            'You exchanged contacts with two businessmen who also stopped. One became a useful connection. You still have the car for another hour — use it.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Market Fire 🔥',
    description:
        'A fire breaks out in the market where you do business. Your stall is in the affected section. Smoke is rising and people are running.',
    minAge: 18,
    maxAge: 65,
    choices: [
      EventChoice(
        text: 'Run back to save your goods',
        statChanges: {'money': 20, 'health': -25, 'discipline': 10},
        outcome:
            'You saved most of it. You also inhaled a lot of smoke and burned your left hand. The goods were worth it. Your lungs are a different conversation.',
      ),
      EventChoice(
        text: 'Leave everything and run',
        statChanges: {'health': 10, 'money': -30, 'happiness': -20},
        outcome:
            'You lost your stock. You survived unharmed. You rebuilt slowly. Some things cannot be replaced. You are not one of them.',
      ),
      EventChoice(
        text: 'Help others evacuate first',
        statChanges: {
          'reputation': 30,
          'connections': 20,
          'health': -10,
          'money': -20,
        },
        outcome:
            'You helped an old woman and two children out. You lost your goods. The community fundraised for you afterward. You came out ahead in every way that matters.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Chieftaincy Dispute in the Family 👑',
    description:
        'A distant elder has died and somehow your family name is in the middle of a chieftaincy dispute. Relatives you\'ve never met are calling. There\'s a durbar next month.',
    minAge: 18,
    maxAge: 70,
    choices: [
      EventChoice(
        text: 'Get involved and represent your lineage',
        statChanges: {
          'reputation': 25,
          'connections': 30,
          'money': -20,
          'happiness': -10,
        },
        outcome:
            'Extremely complicated. There were three separate funerals, a palace meeting, and one relative who still won\'t speak to anyone. You are now deeply embedded in family politics.',
      ),
      EventChoice(
        text: 'Stay completely out of it',
        statChanges: {'happiness': 15, 'discipline': 10, 'connections': -10},
        outcome:
            'You sent a brief apology and muted the family WhatsApp group. They resolved it without you. You were mentioned unfavourably at the durbar. You were eating jollof in Accra.',
      ),
      EventChoice(
        text: 'Mediate between the factions',
        statChanges: {
          'smarts': 15,
          'reputation': 20,
          'connections': 15,
          'happiness': -5,
        },
        outcome:
            'You spent two months going back and forth. A fragile peace was achieved. Both sides are slightly annoyed at you. Both sides also respect you.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Your Photo Ended Up in a Textbook 📚',
    description:
        'A photographer once took your photo "for a project." That project turned out to be a primary school textbook used nationwide. You are now the face of Chapter 4: Community Life.',
    minAge: 10,
    maxAge: 40,
    choices: [
      EventChoice(
        text: 'Demand royalties',
        statChanges: {'money': 10, 'reputation': 15, 'connections': -5},
        outcome:
            'They paid you a small amount to avoid legal trouble. Children across Ghana now learn about community life from your face. It is surreal every time you think about it.',
      ),
      EventChoice(
        text: 'Embrace being a national icon',
        statChanges: {'reputation': 25, 'happiness': 20},
        outcome:
            'You found it hilarious and wholesome. You posted about it. It went viral. You visited a school and the children recognised you immediately. Best day of your life.',
      ),
      EventChoice(
        text: 'Ignore it entirely',
        statChanges: {'discipline': 10, 'happiness': 5},
        outcome:
            'You carry on with your life. Occasionally a child on the street looks at you for too long. You know why. You say nothing.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Flood Swept Through Your Neighbourhood 🌊',
    description:
        'After three days of heavy rain the drains gave up. Water is knee-deep in the street. Your ground floor is compromised. The whole neighbourhood is scrambling.',
    minAge: 8,
    maxAge: 80,
    choices: [
      EventChoice(
        text: 'Move valuables upstairs and wait it out',
        statChanges: {'discipline': 15, 'health': 5, 'money': -10},
        outcome:
            'You lost some furniture and a lot of food. The house survived. You now know exactly what to move first in an emergency. This knowledge will save you again.',
      ),
      EventChoice(
        text: 'Evacuate to a relative\'s house',
        statChanges: {'health': 10, 'happiness': -10, 'connections': 10},
        outcome:
            'You stayed with your uncle for two weeks. It was uncomfortable. You helped his family with expenses. The relationship improved more than you expected.',
      ),
      EventChoice(
        text: 'Stay and help neighbours',
        statChanges: {'reputation': 25, 'health': -10, 'connections': 20},
        outcome:
            'You spent two days helping elderly neighbours move furniture. You got sick after. The neighbourhood respect you earned was real and lasting.',
      ),
    ],
  ),

  LifeEvent(
    title: 'WAEC Leakage Drama 📝',
    description:
        'The night before your WASSCE exam, a classmate slides you what claims to be the leaked paper. Your phone is hot with messages. You don\'t know if it\'s real.',
    minAge: 16,
    maxAge: 18,
    choices: [
      EventChoice(
        text: 'Study it — better safe than sorry',
        statChanges: {'smarts': 15, 'discipline': -10, 'happiness': -5},
        outcome:
            'Half of it was real. Half was wrong. You passed. You spent years wondering if you would have passed anyway. Probably yes. Definitely yes.',
      ),
      EventChoice(
        text: 'Delete it and report it to your teacher',
        statChanges: {'reputation': 20, 'discipline': 20, 'smarts': 5},
        outcome:
            'Your teacher was proud of you. WAEC was informed. You passed on your own merit. It felt clean. You still remember that feeling.',
      ),
      EventChoice(
        text: 'Share it with the whole class',
        statChanges: {'connections': 10, 'discipline': -20, 'reputation': -10},
        outcome:
            'It spread everywhere. WAEC cancelled that paper and set a new one. You panicked. You passed, barely. A lesson in unintended consequences.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Your Mum Joined WhatsApp 📱',
    description:
        'Your mother has discovered WhatsApp. She has added you to seven family groups, sends you good morning messages with flowers at 4:45am, and has discovered voice notes.',
    minAge: 15,
    maxAge: 40,
    choices: [
      EventChoice(
        text: 'Embrace it — teach her everything',
        statChanges: {'connections': 20, 'happiness': 15},
        outcome:
            'She now sends voice notes of up to 4 minutes. You listen to all of them. Your relationship with her deepened in an unexpected and beautiful way.',
      ),
      EventChoice(
        text: 'Mute all the groups silently',
        statChanges: {'happiness': 10, 'discipline': 5, 'connections': -5},
        outcome:
            'You muted everything. You check manually once a day. She thinks you\'re active. This is sustainable and you feel zero guilt.',
      ),
      EventChoice(
        text: 'Teach her voice notes immediately — full send',
        statChanges: {'happiness': 20, 'connections': 15, 'health': -5},
        outcome:
            'She sent your grandmother a 7-minute voice note. Your grandmother has a basic phone with no data. Your mum called to report the delivery failure. Twice.',
      ),
    ],
  ),

  LifeEvent(
    title: 'You Were Offered a Bribe 💼',
    description:
        'A government official slides an envelope across the desk toward you. Your application has been pending for six months. He says nothing. He just looks at the envelope and then at you.',
    minAge: 20,
    maxAge: 65,
    choices: [
      EventChoice(
        text: 'Take it — the system works this way',
        statChanges: {
          'money': 20,
          'happiness': -15,
          'discipline': -15,
          'streetSense': 10,
        },
        outcome:
            'The application was processed the next day. You felt sick about it for weeks. Then it faded. You understand the system now in a way that costs something.',
      ),
      EventChoice(
        text: 'Refuse and report it formally',
        statChanges: {
          'discipline': 20,
          'reputation': 15,
          'happiness': -10,
          'money': -10,
        },
        outcome:
            'Nothing happened to him. Your application took three more months. But you slept well. And you\'ll sleep well about this for the rest of your life.',
      ),
      EventChoice(
        text: 'Refuse but say nothing — just leave',
        statChanges: {'discipline': 10, 'happiness': -5, 'streetSense': 10},
        outcome:
            'You walked out. You reapplied through a different office. It worked eventually. You never talked about this moment but it shaped how you move.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Accidental Business Partner 🤝',
    description:
        'You lent your contact a small amount to cover a business order. They returned three times the amount and called you an investor. You are now apparently a co-owner of something.',
    minAge: 20,
    maxAge: 50,
    choices: [
      EventChoice(
        text: 'Accept the partnership formally',
        statChanges: {
          'money': 30,
          'connections': 20,
          'happiness': 10,
          'discipline': 10,
        },
        outcome:
            'The business grew. You formalised it properly with a lawyer. Your passive income started small and became meaningful. The best mistake you ever made.',
      ),
      EventChoice(
        text: 'Take your money back and exit',
        statChanges: {'money': 15, 'happiness': 5, 'connections': -5},
        outcome:
            'You took the profit and walked away cleanly. You still wonder what would have happened. Sometimes clean exits are the right call. Sometimes.',
      ),
      EventChoice(
        text: 'Invest more aggressively',
        statChanges: {'money': -20, 'connections': 10, 'smarts': 15},
        outcome:
            'The business hit turbulence six months later. You lost your additional investment. The original came back. Net zero. Strong lesson in scaling slowly.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Funeral That Turned Into a Party 🎶',
    description:
        'Your relative\'s one-week funeral has transformed by evening. The highlife is loud, people are dancing, the food is flowing. Someone hired a DJ. The deceased would have approved.',
    minAge: 10,
    maxAge: 80,
    choices: [
      EventChoice(
        text: 'Dance your grief out completely',
        statChanges: {'happiness': 25, 'connections': 15, 'health': 5},
        outcome:
            'You danced until your feet hurt. You reconnected with relatives you hadn\'t seen in years. Grief and joy moved through you at the same time. That\'s Ghanaian.',
      ),
      EventChoice(
        text: 'Sit with the elders and talk',
        statChanges: {'smarts': 10, 'connections': 20, 'reputation': 10},
        outcome:
            'The elders told stories about the deceased you\'d never heard. You learned things about your own family history. Irreplaceable.',
      ),
      EventChoice(
        text: 'Leave early — funerals are not parties',
        statChanges: {'discipline': 10, 'happiness': -10, 'connections': -5},
        outcome:
            'You left. They talked about you leaving early for the next three family gatherings. The food was apparently incredible after midnight.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Internet Goes Down During an Important Submission 💻',
    description:
        'Your internet has cut out with 12 minutes left to submit your application — job, university, contract, doesn\'t matter. Your phone data is also somehow exhausted.',
    minAge: 16,
    maxAge: 50,
    choices: [
      EventChoice(
        text: 'Sprint to the nearest cafe',
        statChanges: {'discipline': 15, 'health': -5, 'smarts': 5},
        outcome:
            'You made it with 3 minutes to spare. Your submission went through. You sat in the cafe panting and victorious. The operator charged you double for the urgency. Fair.',
      ),
      EventChoice(
        text: 'Beg a neighbour for their hotspot',
        statChanges: {'connections': 10, 'streetSense': 10, 'happiness': 5},
        outcome:
            'They gave it without hesitation. You submitted with 6 minutes left. You bought them airtime the next day. Ghana networking at its finest.',
      ),
      EventChoice(
        text: 'Email to explain and ask for an extension',
        statChanges: {'smarts': 15, 'discipline': 10, 'happiness': -10},
        outcome:
            'They granted 24 hours. You submitted perfectly. You learned that a well-written explanation email is a life skill worth practising.',
      ),
    ],
  ),

  LifeEvent(
    title: 'You Won a Radio Call-In 📻',
    description:
        'You called into a radio competition on a whim — name the 5th president of Ghana — and you were the first correct caller. You\'ve won something but you don\'t know what yet.',
    minAge: 12,
    maxAge: 70,
    choices: [
      EventChoice(
        text: 'Go collect the prize excitedly',
        statChanges: {'happiness': 25, 'money': 15, 'reputation': 10},
        outcome:
            'The prize was a hamper, GHS 500 in airtime, and a branded umbrella. Not bad. You were on air for 3 minutes. Your street heard it. You are famous for one week.',
      ),
      EventChoice(
        text: 'Send someone else to collect',
        statChanges: {'streetSense': 10, 'happiness': 10, 'money': 10},
        outcome:
            'Your cousin collected it. He kept the airtime "for delivery fees." You got the hamper and the umbrella. The umbrella is actually very good quality.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Landlord Drama 🏠',
    description:
        'Your landlord has arrived unannounced and is demanding two years\' advance rent immediately — or you move out in 30 days. Your current lease says nothing about this.',
    minAge: 18,
    maxAge: 60,
    choices: [
      EventChoice(
        text: 'Consult a lawyer and push back',
        statChanges: {
          'smarts': 15,
          'money': -10,
          'discipline': 15,
          'happiness': -10,
        },
        outcome:
            'The lawyer confirmed your rights. The landlord backed down. He is now cold toward you but the lease holds. You know your rights now in a way you didn\'t before.',
      ),
      EventChoice(
        text: 'Start looking for a new place immediately',
        statChanges: {'streetSense': 15, 'happiness': -15, 'discipline': 10},
        outcome:
            'You found somewhere better within three weeks. The move was stressful. The new place has better water pressure and a more reasonable landlord.',
      ),
      EventChoice(
        text: 'Negotiate and pay what you can',
        statChanges: {'money': -25, 'connections': 5, 'happiness': -5},
        outcome:
            'You paid six months extra to keep peace. It hurt financially. But you stayed, and the landlord became slightly human after the negotiation.',
      ),
    ],
  ),

  LifeEvent(
    title: 'You Were Chosen for a TED-Style Talk 🎤',
    description:
        'A conference organiser found your social media posts and wants you to give a 12-minute talk on "Resilience and the Ghanaian Spirit." You have two weeks to prepare.',
    minAge: 22,
    maxAge: 60,
    choices: [
      EventChoice(
        text: 'Accept and prepare seriously',
        statChanges: {
          'smarts': 15,
          'reputation': 30,
          'connections': 25,
          'discipline': 10,
        },
        outcome:
            'Your talk went well. Not perfect — but real. People connected with it. Three business contacts came from the audience. You\'ve been invited to two more events.',
      ),
      EventChoice(
        text: 'Accept but wing it on the day',
        statChanges: {'reputation': 5, 'happiness': -10, 'streetSense': 10},
        outcome:
            'It was scattered but passionate. The audience was polite. One person said it was "raw and authentic." You think they were being kind.',
      ),
      EventChoice(
        text: 'Decline — not ready yet',
        statChanges: {'discipline': 10, 'happiness': -5},
        outcome:
            'You recommended someone else who was better prepared. They did well. You spent the next six months preparing for the next opportunity. It came.',
      ),
    ],
  ),

  LifeEvent(
    title: 'A Distant Relative Arrived With Luggage 🧳',
    description:
        'Your second cousin from the village has arrived at your door with a large bag, a small child, and the information that they will be staying "for a short time." It\'s been three weeks.',
    minAge: 20,
    maxAge: 55,
    choices: [
      EventChoice(
        text: 'Welcome them fully — family is family',
        statChanges: {
          'connections': 15,
          'money': -20,
          'happiness': -10,
          'reputation': 10,
        },
        outcome:
            'Three weeks became two months. They helped with cooking and cleaning. You paid for almost everything. They left with a job lead you gave them. Complicated and good.',
      ),
      EventChoice(
        text: 'Set a clear end date immediately',
        statChanges: {'discipline': 20, 'connections': -10, 'happiness': 10},
        outcome:
            'Two more weeks, then they had to go. They were annoyed. Your wallet survived. You had a conversation with yourself about what family means. No clear answer.',
      ),
      EventChoice(
        text: 'Help them find their own place nearby',
        statChanges: {
          'connections': 10,
          'money': -10,
          'smarts': 10,
          'happiness': 5,
        },
        outcome:
            'You found them affordable shared accommodation and helped cover the first month. They thrived. You maintained the relationship from a healthy distance. Best outcome.',
      ),
    ],
  ),

  LifeEvent(
    title: 'The Family Meeting Has Been Called 📢',
    description:
        'A family meeting has been called. Nobody knows why. The senior uncle called it with three days\' notice. Everyone is speculating. You\'ve done nothing wrong. Probably.',
    minAge: 15,
    maxAge: 70,
    choices: [
      EventChoice(
        text: 'Attend and participate actively',
        statChanges: {'connections': 15, 'reputation': 10, 'happiness': -5},
        outcome:
            'It was about land. Inheritance. And surprisingly, your aunt\'s missing cookware from 2019. You were not involved in any of it. It still took four hours.',
      ),
      EventChoice(
        text: 'Send an excuse and don\'t attend',
        statChanges: {'happiness': 15, 'connections': -15, 'discipline': 5},
        outcome:
            'You missed it. Decisions were made. You were blamed for one of them despite not being there. This is how family works.',
      ),
      EventChoice(
        text: 'Attend but say absolutely nothing',
        statChanges: {'discipline': 15, 'streetSense': 10, 'connections': 5},
        outcome:
            'You said nothing for four hours. You nodded strategically. You were praised afterward for your "wisdom and restraint." You had simply been afraid to speak.',
      ),
    ],
  ),

  LifeEvent(
    title: 'You Accidentally Joined a Susu 🏦',
    description:
        'You agreed to contribute GHS 100 to what you thought was a birthday collection. Turns out it was a rotating savings group and you\'re now a member with monthly obligations.',
    minAge: 20,
    maxAge: 55,
    choices: [
      EventChoice(
        text: 'Stay in — it\'s actually a good system',
        statChanges: {'money': 20, 'discipline': 15, 'connections': 15},
        outcome:
            'When your turn came you received GHS 1,200. You used it for something meaningful. You stayed in the susu for three more years. Best accidental decision.',
      ),
      EventChoice(
        text: 'Pay one month then quietly exit',
        statChanges: {'money': -10, 'connections': -10, 'streetSense': 10},
        outcome:
            'They noticed. It was awkward. You lost the GHS 100 and two friendships. You now read the fine print of every "collection."',
      ),
      EventChoice(
        text: 'Commit fully and take it seriously',
        statChanges: {'discipline': 20, 'money': 25, 'connections': 20},
        outcome:
            'You became the most reliable member. When you received your payout you invested it properly. The susu members became a real support network.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Your Boss Asked You to Work on Saturday 😤',
    description:
        'It\'s Friday evening. Your boss just called to say there\'s an emergency and you need to come in tomorrow. You have wedding plans. Family plans. Rest plans.',
    minAge: 20,
    maxAge: 55,
    choices: [
      EventChoice(
        text: 'Come in — job security first',
        statChanges: {
          'money': 10,
          'happiness': -20,
          'discipline': 10,
          'reputation': 10,
        },
        outcome:
            'You came in. The emergency was real. You solved it. Your boss noticed. But you missed the wedding and the couple is still slightly cold about it.',
      ),
      EventChoice(
        text: 'Decline firmly — your time has value',
        statChanges: {'happiness': 15, 'discipline': 15, 'reputation': -10},
        outcome:
            'You declined. Your boss was irritated. Nothing formal happened. But your name was not mentioned when the next opportunity came up. Trade-offs are real.',
      ),
      EventChoice(
        text: 'Negotiate — half day in the morning',
        statChanges: {
          'smarts': 15,
          'happiness': 5,
          'reputation': 5,
          'discipline': 10,
        },
        outcome:
            'Your boss agreed. You handled the urgent part by noon. You made the wedding reception. Your boss respected your pushback more than if you\'d simply complied.',
      ),
    ],
  ),

  LifeEvent(
    title: 'You Found an Old Stash of Your Grandfather\'s Money 💵',
    description:
        'While clearing out your late grandfather\'s room you find old Ghana cedi notes — large amounts, but the old denomination that was demonetized years ago. Nobody else has seen this yet.',
    minAge: 16,
    maxAge: 60,
    choices: [
      EventChoice(
        text: 'Tell the whole family immediately',
        statChanges: {'reputation': 20, 'connections': 10, 'happiness': 10},
        outcome:
            'The family gathered around. The notes are worthless as currency but historically interesting. An uncle cried. You kept one as a family relic. The rest were framed.',
      ),
      EventChoice(
        text: 'Research if they\'re worth anything',
        statChanges: {'smarts': 15, 'money': 10, 'discipline': 10},
        outcome:
            'A currency collector paid you for two rare denominations. Not a fortune, but meaningful. You gave half to the family and kept the rest for your grandfather\'s memorial fund.',
      ),
      EventChoice(
        text: 'Keep quiet and research secretly',
        statChanges: {'streetSense': 10, 'money': 15, 'connections': -10},
        outcome:
            'You pocketed the profit. You felt guilty at the family gathering. You donated to your grandfather\'s church in his name. Your conscience is partially settled.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Your Business Was Featured on TV 📺',
    description:
        'A journalist doing a story on young entrepreneurs in Ghana has featured your business on a national channel. The segment airs tonight. Your phone starts ringing before it\'s even over.',
    minAge: 20,
    maxAge: 50,
    choices: [
      EventChoice(
        text: 'Ride the wave — respond to everything',
        statChanges: {
          'money': 30,
          'reputation': 35,
          'connections': 25,
          'health': -10,
        },
        outcome:
            'You responded to 200+ messages in three days. Orders tripled. You hired two people. You didn\'t sleep properly for a week. The business never looked back.',
      ),
      EventChoice(
        text: 'Let the business page handle it',
        statChanges: {'money': 20, 'reputation': 20, 'connections': 15},
        outcome:
            'Managed but not maximised. You maintained quality while scaling carefully. Slower growth, but sustainable. The right call for where you were.',
      ),
      EventChoice(
        text: 'Use the moment to raise prices',
        statChanges: {'money': 25, 'reputation': -5, 'connections': 10},
        outcome:
            'Some customers left. Others stayed and accepted it. Net revenue increased. Ghana Twitter said you got "bigheaded after the TV thing." You made peace with that.',
      ),
    ],
  ),
];
