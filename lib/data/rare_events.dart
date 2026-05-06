import '../models/event.dart';

final List<LifeEvent> rareEvents = [
  LifeEvent(
    title: 'Discovered Ancient Gold Weight 🪙',
    description: 'While digging in your family compound, you unearth a brass Akan gold weight (sika dwabiri) dating back centuries. It looks incredibly valuable.',
    minAge: 10,
    maxAge: 80,
    choices: [
      EventChoice(
        text: 'Sell it to a collector',
        statChanges: {'money': 50, 'happiness': 10, 'reputation': -5},
        outcome: 'You made a small fortune, but the elders in your family are disappointed you sold a piece of history.',
      ),
      EventChoice(
        text: 'Donate it to the National Museum',
        statChanges: {'reputation': 30, 'happiness': 20, 'money': 0},
        outcome: 'Your name is on a plaque in the museum. You didn\'t make money, but you feel a deep sense of pride.',
      ),
      EventChoice(
        text: 'Keep it as a family heirloom',
        statChanges: {'happiness': 15, 'connections': 10},
        outcome: 'You clean it up and keep it safe. It becomes a symbol of luck and heritage for your family.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Won the NLA Lottery 🎟️',
    description: 'You played two numbers you saw in a dream. Against all odds, the National Lottery Authority draws your exact numbers. You\'ve hit a major jackpot.',
    minAge: 18,
    maxAge: 90,
    choices: [
      EventChoice(
        text: 'Invest it quietly',
        statChanges: {'money': 80, 'smarts': 15, 'discipline': 20},
        outcome: 'Nobody knows you won. You invest the money into treasury bills and land. Your financial future is secure.',
      ),
      EventChoice(
        text: 'Throw a massive party for your street',
        statChanges: {'money': 30, 'reputation': 40, 'happiness': 30, 'connections': 25},
        outcome: 'You spent half the money celebrating, but you are now a local legend. Everyone loves you.',
      ),
      EventChoice(
        text: 'Quit your job immediately',
        statChanges: {'money': 40, 'happiness': 20, 'discipline': -15},
        outcome: 'You quit in a dramatic fashion. It felt amazing, but now you have no income and the money is slowly draining.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Befriended a Wild Monkey 🐒',
    description: 'While visiting Mole National Park (or a monkey sanctuary), a wild monkey takes a special liking to you, refusing to leave your shoulder.',
    minAge: 5,
    maxAge: 70,
    choices: [
      EventChoice(
        text: 'Try to take it home',
        statChanges: {'happiness': -10, 'health': -15, 'discipline': -10},
        outcome: 'Disaster. It bit you when you tried to put it in the car. The park rangers gave you a stern warning.',
      ),
      EventChoice(
        text: 'Take amazing photos and let it be',
        statChanges: {'happiness': 25, 'reputation': 15},
        outcome: 'The photos go viral on Instagram. You are spiritually bonded with this monkey forever.',
      ),
      EventChoice(
        text: 'Feed it all your snacks',
        statChanges: {'happiness': 15, 'money': -5},
        outcome: 'It ate all your plantain chips and then immediately abandoned you for another tourist with better snacks. Betrayal.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Unexpected Land Inheritance 🗺️',
    description: 'A distant uncle you met only once has passed away and left you two plots of land in a rapidly developing area outside Accra.',
    minAge: 21,
    maxAge: 60,
    choices: [
      EventChoice(
        text: 'Sell immediately for cash',
        statChanges: {'money': 60, 'smarts': -10, 'happiness': 10},
        outcome: 'You get a massive lump sum, but five years later the land is worth ten times what you sold it for. Pain.',
      ),
      EventChoice(
        text: 'Hold onto it and pay for documents',
        statChanges: {'money': -15, 'discipline': 20, 'smarts': 15},
        outcome: 'It takes stressful years to secure the indenture and title, but you now own prime real estate.',
      ),
      EventChoice(
        text: 'Start building a small structure',
        statChanges: {'money': -30, 'discipline': 25, 'happiness': 15},
        outcome: 'You pour the foundation and build a single room to secure the land. It’s a slow process, but it’s yours.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Discovered a Hidden Waterfall 🌊',
    description: 'While exploring a rural area in the Eastern Region, you stumble upon a breathtaking, undocumented waterfall hidden in the forest.',
    minAge: 16,
    maxAge: 50,
    choices: [
      EventChoice(
        text: 'Share the location online',
        statChanges: {'reputation': 25, 'happiness': 10, 'connections': 10},
        outcome: 'You become known as an explorer. Tourists flock there, but unfortunately, they start littering the beautiful spot.',
      ),
      EventChoice(
        text: 'Keep it a secret just for yourself',
        statChanges: {'happiness': 30, 'smarts': 10},
        outcome: 'It becomes your personal sanctuary. You go there whenever life gets too loud. Perfect peace.',
      ),
      EventChoice(
        text: 'Tell the local chief to develop it',
        statChanges: {'connections': 25, 'reputation': 20, 'happiness': 15},
        outcome: 'The community develops it into an eco-tourism site. You receive free entry for life and a cut of the profits.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Trotro Breaks Down in the Middle of Nowhere 🚐',
    description: 'Your trotro breaks down at 11 PM on a dark stretch of the Kumasi-Accra highway. The driver has disappeared into the bushes to "find a mechanic." It is pitch black.',
    minAge: 18,
    maxAge: 70,
    choices: [
      EventChoice(
        text: 'Organise the passengers to flag down help',
        statChanges: {'reputation': 15, 'connections': 10, 'discipline': 10},
        outcome: 'You took charge. A passing VIP bus stopped and picked you all up. You are a natural leader.',
      ),
      EventChoice(
        text: 'Sleep in the bus and hope for the best',
        statChanges: {'health': -10, 'happiness': -15, 'discipline': 5},
        outcome: 'You survived an incredibly uncomfortable and mosquito-filled night. The driver returned at 6 AM with a fan belt and a suspicious smile.',
      ),
      EventChoice(
        text: 'Walk to the nearest town in the dark',
        statChanges: {'health': -15, 'streetSense': 20, 'happiness': -10},
        outcome: 'Terrifying, exhausting, but you made it to a town by 3 AM and found a guesthouse. You have a wild story to tell.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Saved a Prominent Chief\'s Life 👑',
    description: 'You notice an elderly man choking at a high-end restaurant. You perform the Heimlich maneuver, saving him. It turns out he is an extremely powerful paramount chief.',
    minAge: 20,
    maxAge: 65,
    choices: [
      EventChoice(
        text: 'Refuse any reward',
        statChanges: {'reputation': 40, 'connections': 30, 'happiness': 20},
        outcome: 'He respects your humility so much that he makes you an honorary member of his royal court. Invaluable connections.',
      ),
      EventChoice(
        text: 'Ask for a business favor',
        statChanges: {'money': 40, 'connections': 20, 'smarts': 15},
        outcome: 'He makes a single phone call that completely changes the trajectory of your career. An incredible opportunity.',
      ),
      EventChoice(
        text: 'Ask for a piece of land',
        statChanges: {'money': 50, 'reputation': 10, 'happiness': 15},
        outcome: 'He gifts you a prime plot of land in his traditional area. The paperwork is flawless.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Invented a New Street Food Fad 🍳',
    description: 'You haphazardly mixed waakye, indomie, and kelewele in a single bowl at a chop bar. Someone recorded you eating it, and now everyone in Accra wants "The Special."',
    minAge: 16,
    maxAge: 40,
    choices: [
      EventChoice(
        text: 'Partner with the chop bar and trademark it',
        statChanges: {'money': 35, 'smarts': 20, 'reputation': 15},
        outcome: 'You get a 10% royalty on every bowl sold. It’s a massive hit for six months before the hype dies, but the money was great.',
      ),
      EventChoice(
        text: 'Keep it as an internet joke',
        statChanges: {'reputation': 25, 'happiness': 15},
        outcome: 'You become a meme for a few weeks. It’s funny, but you made absolutely zero money from the phenomenon.',
      ),
      EventChoice(
        text: 'Claim the recipe is a secret family tradition',
        statChanges: {'reputation': 10, 'streetSense': 15, 'happiness': 10},
        outcome: 'People believe you and find you very mysterious. You enjoy the clout, even though it\'s a complete lie.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Madam High Heels Encounter 👻',
    description: 'Walking past a boarding school at midnight, you hear the distinctive "click-clack" of high heels behind you. The legendary ghost, Madam High Heels, is approaching.',
    minAge: 12,
    maxAge: 30,
    choices: [
      EventChoice(
        text: 'Don\'t look back and run for your life',
        statChanges: {'health': -5, 'streetSense': 15, 'discipline': 10},
        outcome: 'You sprinted faster than Usain Bolt. You survived, but you will never walk that road again after sunset.',
      ),
      EventChoice(
        text: 'Turn around to face her bravely',
        statChanges: {'health': -15, 'happiness': -20, 'smarts': -10},
        outcome: 'It wasn\'t a ghost, just a teacher walking late. But you tripped backwards into a gutter in terror and broke your arm.',
      ),
      EventChoice(
        text: 'Start singing loud gospel songs',
        statChanges: {'reputation': 10, 'streetSense': 10, 'happiness': 5},
        outcome: 'The clicking stopped. Either the ghost hated your singing, or the teacher decided to take another route. Either way, victory.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Anonymous Grocery Angel 🛒',
    description: 'You are at the mall counter and your card declines. Before you can drop items, a wealthy-looking stranger taps their card and pays for your entire overflowing cart.',
    minAge: 18,
    maxAge: 60,
    choices: [
      EventChoice(
        text: 'Express profound gratitude and get their number',
        statChanges: {'connections': 15, 'happiness': 20, 'money': 20},
        outcome: 'They become a mentor figure in your life. You eventually pay the kindness forward years later.',
      ),
      EventChoice(
        text: 'Take the groceries and vanish quickly',
        statChanges: {'money': 20, 'reputation': -10, 'happiness': 5},
        outcome: 'You felt incredibly awkward and basically ran away. You got free food but feel strange about it whenever you eat it.',
      ),
      EventChoice(
        text: 'Insist on MoMo-ing them back later',
        statChanges: {'discipline': 15, 'money': 0, 'reputation': 10},
        outcome: 'They appreciated your pride. You paid them back two days later. You kept your dignity and made a respectful acquaintance.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Mistaken for a Celebrity 🕶️',
    description: 'Wearing dark sunglasses at Kotoka Airport, a crowd suddenly surrounds you, convinced you are a famous Afrobeats star. Security escorts you to the VIP lounge.',
    minAge: 16,
    maxAge: 40,
    choices: [
      EventChoice(
        text: 'Play along and enjoy the VIP lounge',
        statChanges: {'happiness': 25, 'streetSense': 15, 'money': 10},
        outcome: 'You ate free jollof and drank premium juice for two hours before taking your economy flight. A massive win.',
      ),
      EventChoice(
        text: 'Correct them immediately',
        statChanges: {'reputation': 10, 'discipline': 10, 'happiness': -5},
        outcome: 'They were visibly disappointed. Security escorted you back to the chaotic departure hall. You are an honest, but bored, person.',
      ),
      EventChoice(
        text: 'Sign autographs with a fake name',
        statChanges: {'reputation': -10, 'streetSense': 20, 'happiness': 15},
        outcome: 'Someone tweeted a photo of your signature. The actual celebrity responded "Who is this?" You are an internet legend for a day.',
      ),
    ],
  ),

  LifeEvent(
    title: 'The Briefcase of Cash 💼',
    description: 'You find a heavy briefcase left behind in a taxi. You open it. It is stacked with bundles of US Dollars. No ID, no name, just cash.',
    minAge: 20,
    maxAge: 65,
    choices: [
      EventChoice(
        text: 'Take the money and stay quiet',
        statChanges: {'money': 100, 'happiness': -20, 'health': -15, 'streetSense': -10},
        outcome: 'You kept it. However, you spend the next five years looking over your shoulder, terrified the owners will find you. Extreme paranoia.',
      ),
      EventChoice(
        text: 'Hand it over to the police',
        statChanges: {'reputation': 30, 'discipline': 25, 'happiness': 10},
        outcome: 'It makes the national news. You are hailed as Ghana\'s most honest citizen. You receive a national award, but zero money.',
      ),
      EventChoice(
        text: 'Leave it in the taxi and walk away',
        statChanges: {'discipline': 15, 'streetSense': 15, 'happiness': 5},
        outcome: 'You decided peace of mind is worth more than dirty money. The taxi driver probably kept it. You sleep like a baby.',
      ),
    ],
  ),

  LifeEvent(
    title: 'The Falling Baobab Tree 🌳',
    description: 'You stop to tie your shoelace. Two seconds later, a massive ancient baobab tree crashes down precisely where you would have been walking. You are completely unharmed.',
    minAge: 10,
    maxAge: 80,
    choices: [
      EventChoice(
        text: 'Go to church and give thanksgiving',
        statChanges: {'happiness': 20, 'discipline': 10, 'reputation': 10},
        outcome: 'Your testimony on Sunday moved the congregation to tears. You officially believe you have a guardian angel.',
      ),
      EventChoice(
        text: 'Buy a lottery ticket immediately',
        statChanges: {'money': -5, 'happiness': -5, 'streetSense': 5},
        outcome: 'You lost. Your luck was used entirely on not getting crushed by a tree. Do not be greedy.',
      ),
      EventChoice(
        text: 'Sit quietly and reevaluate your life',
        statChanges: {'smarts': 15, 'discipline': 15, 'happiness': 10},
        outcome: 'You have a profound spiritual awakening. You stop worrying about small things and start living more intentionally.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Chosen by a Stray Dog 🐕',
    description: 'A scruffy street dog follows you home from the market. It refuses to leave your gate and growls affectionately only at you.',
    minAge: 8,
    maxAge: 70,
    choices: [
      EventChoice(
        text: 'Adopt, bathe, and feed it',
        statChanges: {'happiness': 25, 'money': -10, 'reputation': 10},
        outcome: 'You name him "Bingo." Three months later, Bingo scares off a thief trying to steal your car battery. Best investment ever.',
      ),
      EventChoice(
        text: 'Chase it away aggressively',
        statChanges: {'happiness': -10, 'reputation': -5},
        outcome: 'It leaves, looking heartbroken. For some reason, you feel a lingering sense of guilt for weeks.',
      ),
      EventChoice(
        text: 'Just leave food outside occasionally',
        statChanges: {'happiness': 10, 'money': -5},
        outcome: 'It guards your house from the street but never comes inside. A mutually beneficial, no-strings-attached relationship.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Offered a Chieftaincy Title 🪑',
    description: 'Elders from your hometown visit you in Accra. Due to your "character and achievements," they want to enstool you as a Development Chief (Nkosuohene).',
    minAge: 35,
    maxAge: 75,
    choices: [
      EventChoice(
        text: 'Accept the honour with pride',
        statChanges: {'reputation': 40, 'connections': 30, 'money': -30, 'discipline': 15},
        outcome: 'You are now Nana. It comes with immense respect but heavy financial responsibilities for the hometown\'s development.',
      ),
      EventChoice(
        text: 'Politely decline due to busy schedule',
        statChanges: {'discipline': 10, 'reputation': -10, 'connections': -15},
        outcome: 'The elders are profoundly offended. They leave without eating the food you offered. You saved money, but lost your roots.',
      ),
      EventChoice(
        text: 'Ask for time to think about it',
        statChanges: {'smarts': 10, 'discipline': 10},
        outcome: 'You string them along for a year until they find someone else. A diplomatic, albeit cowardly, escape.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Won a Nationwide Promo ✈️',
    description: 'You texted a code from a malt drink bottle cap. You actually won the grand prize: A fully paid luxury trip to Dubai for two.',
    minAge: 18,
    maxAge: 60,
    choices: [
      EventChoice(
        text: 'Take your best friend',
        statChanges: {'happiness': 40, 'connections': 20, 'health': 10},
        outcome: 'You two have the time of your lives riding camels and taking aesthetic photos. A core memory is forged.',
      ),
      EventChoice(
        text: 'Take your mother',
        statChanges: {'happiness': 30, 'reputation': 25, 'discipline': 10},
        outcome: 'She complains about the food but absolutely loves the experience. The entire extended family praises you as the ultimate child.',
      ),
      EventChoice(
        text: 'Ask the company for the cash equivalent',
        statChanges: {'money': 50, 'happiness': 10, 'smarts': 20},
        outcome: 'They agree, but deduct 20% tax. You don\'t get the trip, but you significantly boost your savings account.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Quote-Tweeted by the President 🇬🇭',
    description: 'You made an insightful (or funny) tweet about Ghanaian infrastructure. The President’s official account quote-tweets it with "I agree. We must do better."',
    minAge: 15,
    maxAge: 40,
    choices: [
      EventChoice(
        text: 'Pin the tweet and put it in your bio',
        statChanges: {'reputation': 30, 'connections': 20, 'happiness': 15},
        outcome: 'You become momentarily famous. News sites write articles about you. You get a verified badge.',
      ),
      EventChoice(
        text: 'Reply arguing with him',
        statChanges: {'reputation': 15, 'streetSense': 20, 'discipline': -10, 'happiness': -10},
        outcome: 'You start a massive political Twitter war. Half the country loves you, the other half insults you relentlessly. High stress.',
      ),
      EventChoice(
        text: 'Panic and delete your account',
        statChanges: {'happiness': -15, 'discipline': 5, 'smarts': -5},
        outcome: 'The notifications were too overwhelming. You vanished into obscurity, leaving everyone confused about the mysterious deleted user.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Survive a Major Road Crash Intact 🚑',
    description: 'Your long-distance bus loses its brakes and rolls into a ditch. It’s a horrific scene, but miraculously, you crawl out without a single scratch.',
    minAge: 10,
    maxAge: 80,
    choices: [
      EventChoice(
        text: 'Help pull others from the wreckage',
        statChanges: {'reputation': 40, 'connections': 25, 'health': -10, 'happiness': 10},
        outcome: 'You saved three lives before emergency services arrived. You receive a citizen’s bravery award. Trauma binds you to the survivors.',
      ),
      EventChoice(
        text: 'Sit by the road in immense shock',
        statChanges: {'health': -20, 'happiness': -30, 'discipline': -10},
        outcome: 'You develop a severe phobia of long-distance buses. It takes years of therapy to travel outside your city again.',
      ),
      EventChoice(
        text: 'Call your family immediately',
        statChanges: {'connections': 15, 'happiness': 10, 'health': -5},
        outcome: 'Your family comes to pick you up. They mandate a thanksgiving service the next weekend. You appreciate life so much more.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Discovered a Rare Market Antique 🏺',
    description: 'Looking through a dusty stall at Makola, you find a weirdly shaped bead. You buy it for GHS 10. Later, an appraiser tells you it’s an authentic 18th-century Venetian trade bead.',
    minAge: 15,
    maxAge: 70,
    choices: [
      EventChoice(
        text: 'Sell it to a foreign collector',
        statChanges: {'money': 60, 'smarts': 15, 'happiness': 10},
        outcome: 'You make a staggering profit. You take the market woman who sold it to you some extra cash out of guilt.',
      ),
      EventChoice(
        text: 'Turn it into a custom necklace',
        statChanges: {'happiness': 20, 'reputation': 15, 'money': -5},
        outcome: 'You wear history around your neck. It’s the ultimate conversation starter at parties.',
      ),
      EventChoice(
        text: 'Return to the market and tell the seller the truth',
        statChanges: {'reputation': 25, 'discipline': 20, 'connections': 15},
        outcome: 'She is shocked by your honesty. You split the profit with her. She treats you like royalty every time you visit Makola.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Accidental Movie Extra 🎬',
    description: 'You walk into a cafe not realizing they are filming a major Netflix movie. The director loves your "vibe" and asks you to sit in the background and look natural.',
    minAge: 18,
    maxAge: 40,
    choices: [
      EventChoice(
        text: 'Act very naturally',
        statChanges: {'reputation': 20, 'happiness': 25, 'money': 10},
        outcome: 'You make the final cut! Your face is clearly visible on Netflix globally for exactly 4 seconds. Your friends never let you rest.',
      ),
      EventChoice(
        text: 'Try to sneak a glance at the camera',
        statChanges: {'reputation': -5, 'happiness': -10},
        outcome: 'You ruined the shot. The director yelled "Cut!" and an assistant politely asked you to leave. Missed opportunity.',
      ),
      EventChoice(
        text: 'Demand a speaking role',
        statChanges: {'streetSense': 15, 'discipline': -15, 'reputation': -10},
        outcome: 'You were escorted off the set by security for being disruptive. You tell everyone you "turned down" a role in a movie.',
      ),
    ],
  ),

  LifeEvent(
    title: 'East Legon Secret Party Invitation 🥂',
    description: 'A wealthy acquaintance slips you a massive, heavy black envelope. It’s an invite to an exclusive, ultra-secret party in East Legon where billionaires hang out.',
    minAge: 21,
    maxAge: 45,
    choices: [
      EventChoice(
        text: 'Rent a luxury car and attend',
        statChanges: {'money': -20, 'connections': 40, 'reputation': 25, 'happiness': 15},
        outcome: 'You fit right in. You network with CEOs and politicians. Nobody knows the car is rented. Huge upward mobility unlocked.',
      ),
      EventChoice(
        text: 'Go in an Uber realistically',
        statChanges: {'discipline': 15, 'connections': 10, 'happiness': 10},
        outcome: 'Security makes you walk the long driveway. You feel out of place, but you still secure one solid business card.',
      ),
      EventChoice(
        text: 'Sell the invitation to someone thirsty for clout',
        statChanges: {'money': 30, 'streetSense': 20, 'connections': -15},
        outcome: 'You sold it for GHS 5,000 to a desperate influencer. You enjoyed the cash, though the acquaintance never spoke to you again.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Predicted the Rain Perfectly 🌧️',
    description: 'Look at the sky, you confidently tell your outdoor wedding party to move everything inside now. Five minutes later, the heaviest storm of the year hits.',
    minAge: 15,
    maxAge: 80,
    choices: [
      EventChoice(
        text: 'Act like it was a spiritual gift',
        statChanges: {'reputation': 25, 'streetSense': 15, 'happiness': 10},
        outcome: 'People actually start believing you have a weather-calling gift from God. Your uncle asks you for lottery numbers.',
      ),
      EventChoice(
        text: 'Explain it was just changes in air pressure',
        statChanges: {'smarts': 20, 'reputation': 10, 'happiness': 5},
        outcome: 'Nobody cares about the science, but they respect you saved the wedding cake. You are a hero.',
      ),
      EventChoice(
        text: 'Demand a thank-you plate of jollof',
        statChanges: {'happiness': 20, 'money': 5, 'connections': 10},
        outcome: 'You ate the best, most well-deserved plate of party jollof in human history while watching the rain outside.',
      ),
    ],
  ),

  LifeEvent(
    title: 'The Mimicking Parrot 🦜',
    description: 'An African Grey parrot flies into your compound and refuses to leave. You realize it perfectly mimics the sound of your ringtone and your landlord\'s voice.',
    minAge: 10,
    maxAge: 70,
    choices: [
      EventChoice(
        text: 'Keep it and teach it to insult people',
        statChanges: {'happiness': 25, 'reputation': -10, 'streetSense': 15},
        outcome: 'It insults the meter reader perfectly in Twi. You find it hilarious. The meter reader does not.',
      ),
      EventChoice(
        text: 'Try to find the original owner',
        statChanges: {'discipline': 15, 'reputation': 10, 'money': 20},
        outcome: 'The owner was a wealthy expat who gives you a handsome cash reward for its safe return.',
      ),
      EventChoice(
        text: 'Release it back into the wild',
        statChanges: {'happiness': 5, 'discipline': 10},
        outcome: 'It flew to the neighbor\'s tree and stayed there for weeks, confusing everyone with phantom phone ringing.',
      ),
    ],
  ),

  LifeEvent(
    title: 'You Gained Immunity to Food Poisoning 🌶️',
    description: 'You ate extremely sketchy roadside food that put all your friends in the hospital. You, however, felt absolutely nothing. You have an iron stomach.',
    minAge: 16,
    maxAge: 50,
    choices: [
      EventChoice(
        text: 'Brag about it endlessly',
        statChanges: {'reputation': 10, 'happiness': 15, 'connections': -5},
        outcome: 'Your friends are irritated by you while they suffer on IV drips, but they respect your genetic superiority.',
      ),
      EventChoice(
        text: 'Use it to eat everywhere fearlessly',
        statChanges: {'happiness': 20, 'money': 10, 'streetSense': 15},
        outcome: 'You save massive amounts of money buying cheap street food. Your immune system is unstoppable.',
      ),
      EventChoice(
        text: 'Buy medicine for your friends out of pity',
        statChanges: {'money': -15, 'connections': 25, 'reputation': 15},
        outcome: 'You play the role of the caring nurse. They owe you their lives. You are a good friend.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Found an Undiscovered Beach 🏖️',
    description: 'While lost driving in the Western Region, your car breaks through the brush and reveals the most pristine, untouched white sand beach you’ve ever seen.',
    minAge: 20,
    maxAge: 60,
    choices: [
      EventChoice(
        text: 'Try to buy the land immediately',
        statChanges: {'money': -40, 'smarts': 30, 'discipline': 20},
        outcome: 'You spend all your savings negotiating with the local chief. Ten years later, it’s a premier eco-resort. You are wealthy.',
      ),
      EventChoice(
        text: 'Camp there for the weekend',
        statChanges: {'happiness': 35, 'health': 10, 'smarts': 5},
        outcome: 'You had a spiritual retreat by yourself. The sound of the waves reset your soul completely.',
      ),
      EventChoice(
        text: 'Tell a real estate developer for a finder\'s fee',
        statChanges: {'money': 40, 'connections': 15, 'happiness': -10},
        outcome: 'You got paid well, but returning years later, the beach is ruined by concrete blocks. You regret it slightly.',
      ),
    ],
  ),

  LifeEvent(
    title: 'The Prophetic Dream Came True 👁️',
    description: 'You had a highly specific, vivid dream about a family envelope containing bad news. Two days later, an identical envelope arrives at your door.',
    minAge: 15,
    maxAge: 70,
    choices: [
      EventChoice(
        text: 'Refuse to open it — burn it',
        statChanges: {'health': -5, 'streetSense': 15, 'discipline': -10},
        outcome: 'You destroyed it. Whatever it was, it never reached you. Was it magic or just ignoring your problems? We will never know.',
      ),
      EventChoice(
        text: 'Open it calmly, preparing for the worst',
        statChanges: {'discipline': 25, 'smarts': 10, 'happiness': -10},
        outcome: 'It was a major family tax issue. Because you mentally prepared, you handled it stoically without breaking down.',
      ),
      EventChoice(
        text: 'Take it to a pastor immediately',
        statChanges: {'connections': 10, 'happiness': 5, 'money': -10},
        outcome: 'The pastor prayed over it for an hour before opening it. The bad news was mitigated by faith and peace of mind.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Stuck in an Elevator with a Billionaire 🏢',
    description: 'The power goes out in a Ridge office building. You are stuck in the elevator for two hours with one of Ghana’s richest, most reclusive business moguls.',
    minAge: 22,
    maxAge: 55,
    choices: [
      EventChoice(
        text: 'Pitch your business idea relentlessly',
        statChanges: {'money': 30, 'connections': 25, 'reputation': 10, 'smarts': 15},
        outcome: 'They were annoyed at first, but your passion won them over. They agree to fund your startup when the power returns.',
      ),
      EventChoice(
        text: 'Keep quiet and give them peace',
        statChanges: {'discipline': 15, 'happiness': 10, 'connections': 5},
        outcome: 'They actually thank you for not badgering them. They give you a business card and tell you to call if you ever need a job.',
      ),
      EventChoice(
        text: 'Panic about the lack of air',
        statChanges: {'health': -15, 'happiness': -20, 'reputation': -10},
        outcome: 'You spent two hours sweating and hyperventilating. They ignored you and played Sudoku on their phone.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Accidentally Bought a Stolen Phone 📱',
    description: 'You bought a cheap iPhone at Circle. Two days later, it rings, and a very angry man on the other end says he tracked you and is coming with the police.',
    minAge: 16,
    maxAge: 35,
    choices: [
      EventChoice(
        text: 'Drop the phone in a gutter and vanish',
        statChanges: {'money': -20, 'streetSense': 20, 'happiness': -10},
        outcome: 'You lost your money, but you avoided a criminal charge and police harassment. A painful street tax.',
      ),
      EventChoice(
        text: 'Wait for them and explain you bought it',
        statChanges: {'reputation': 10, 'discipline': 15, 'money': -20, 'happiness': -15},
        outcome: 'The police seized the phone. The owner realized you were a victim too. You didn\'t get your money back, but you stayed entirely out of jail.',
      ),
      EventChoice(
        text: 'Take it back to the guy at Circle',
        statChanges: {'health': -10, 'streetSense': 15, 'discipline': -10},
        outcome: 'A massive fight breaks out at Circle. The guy denies everything. You lost the phone and your money, but fought bravely.',
      ),
    ],
  ),

  LifeEvent(
    title: 'The Ancestral Sword 🗡️',
    description: 'Your grandmother calls you into her room. From under her bed, she pulls out a heavy, wrapped ceremonial sword and says, "It is your turn to guard this."',
    minAge: 25,
    maxAge: 50,
    choices: [
      EventChoice(
        text: 'Accept the responsibility with honour',
        statChanges: {'reputation': 35, 'connections': 20, 'discipline': 20},
        outcome: 'You are now the keeper of the family\'s spirit. You feel a heavy, undeniable sense of purpose every time you look at it.',
      ),
      EventChoice(
        text: 'Refuse it — it’s too traditional for you',
        statChanges: {'reputation': -20, 'connections': -15, 'discipline': 10},
        outcome: 'She is heartbroken. She gives it to your cousin instead. You feel modern, but completely disconnected from your lineage.',
      ),
      EventChoice(
        text: 'Take it but hide it away and forget it',
        statChanges: {'happiness': -5, 'discipline': -10},
        outcome: 'You wrap it in a plastic bag and throw it in your closet. You occasionally have weird dreams, but life goes on normally.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Featured in a Viral Documentary 🎥',
    description: 'A foreign YouTuber stopped you on the street to ask "What is the meaning of life?" Your incredibly profound, off-the-cuff answer gets 50 million views.',
    minAge: 18,
    maxAge: 70,
    choices: [
      EventChoice(
        text: 'Start a motivational speaking career',
        statChanges: {'money': 40, 'reputation': 30, 'connections': 25, 'smarts': 15},
        outcome: 'You leverage the 15 minutes of fame perfectly. You write an ebook and get booked for seminars. You are the "Street Philosopher."',
      ),
      EventChoice(
        text: 'Ignore the messages and stay humble',
        statChanges: {'discipline': 20, 'happiness': 25, 'reputation': 15},
        outcome: 'The internet respects your mysterious disappearance. You become an enigma. Your peace of mind remains intact.',
      ),
      EventChoice(
        text: 'Ask the YouTuber for a cut of the ad revenue',
        statChanges: {'money': 25, 'smarts': 20, 'reputation': -5},
        outcome: 'They wire you \\\$5,000 to keep you happy. You buy a car. The internet hates you for "selling out," but you are driving a car.',
      ),
    ],
  ),
];
