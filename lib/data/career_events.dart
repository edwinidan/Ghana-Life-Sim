import '../models/event.dart';

// Career entry events have been removed — career entry now happens through the Job tab.
// The List below is kept as an empty list for any code that still references it.
final List<LifeEvent> careerEntryEvents = [];


/// 35 career-specific events — 5 per career path — age range 22-55.
final List<LifeEvent> careerSpecificEvents = [

  // ═══════════════════ CIVIL SERVICE (5) ═══════════════════

  LifeEvent(
    title: 'The Impossible Boss 😤',
    description:
        'Your District Director has called you into his office to question, at length, why a report you submitted was one page shorter than he expected. The report met every requirement. He has highlighted random sentences in green for unknown reasons.',
    minAge: 22,
    maxAge: 55,
    requiredCareer: 'Civil Service',
    choices: [
      EventChoice(
        text: 'Defend your work calmly and professionally',
        statChanges: {'discipline': 15, 'happiness': -10, 'reputation': 10},
        outcome:
            'You defended the report politely and precisely. He backed down and called it "acceptable." You have not been called good but you will not be called wrong again in this building.',
      ),
      EventChoice(
        text: 'Add five more pages of filler and resubmit',
        statChanges: {'streetSense': 15, 'smarts': -5, 'happiness': 5},
        outcome:
            'You resubmitted a 20-page document that says the same thing more slowly. He read page one and stamped it approved. This is the government. You are learning.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Promotion Selection Process 🏛️',
    description:
        'The annual promotion list is out and your name is on it as a candidate. You can work overtime and impress the panel, or let your seniority speak for itself. What is the move?',
    minAge: 25,
    maxAge: 55,
    requiredCareer: 'Civil Service',
    choices: [
      EventChoice(
        text: 'Work overtime and submit additional reports',
        statChanges: {'discipline': 20, 'health': -10, 'reputation': 15},
        outcome:
            'You worked harder than anyone else. The panel noticed. The promotion came through with a salary increase. Your family celebrated. You slept for twelve hours.',
      ),
      EventChoice(
        text: 'Rely on your record and stay calm',
        statChanges: {'happiness': 10, 'discipline': 5},
        outcome:
            'You let the record speak. The promotion was slower but it came. You did not compromise your health. You also did not make enemies by being too visible. Balance.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Office Leakage Drama 🚰',
    description:
        'Someone has leaked a confidential memo from your department to the press. The Director is furious. Everyone is looking at everyone. You happen to know who did it — a colleague you eat lunch with every day.',
    minAge: 22,
    maxAge: 55,
    requiredCareer: 'Civil Service',
    choices: [
      EventChoice(
        text: 'Report your colleague to management',
        statChanges: {'reputation': 15, 'connections': -15, 'discipline': 10},
        outcome:
            'You reported it. Your colleague was dismissed. The Director thanked you privately. The office never fully forgave you. Government morality is complicated.',
      ),
      EventChoice(
        text: 'Say nothing and let it blow over',
        statChanges: {'streetSense': 20, 'discipline': -10, 'happiness': -5},
        outcome:
            'You said nothing. The matter faded. Your colleague bought you a drink after. You both pretend nothing happened. The office has moved on to a new drama this month.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Private Sector Poaching 💼',
    description:
        'A bank has approached you with a salary three times your current pay. Long hours, no pension, high pressure — but you could change your life financially. Your supervisor would be heartbroken. Should you jump?',
    minAge: 25,
    maxAge: 50,
    requiredCareer: 'Civil Service',
    choices: [
      EventChoice(
        text: 'Take the private sector offer',
        statChanges: {'money': 30, 'discipline': 10, 'connections': 10, 'happiness': -5},
        outcome:
            'You jumped. The salary is real and the work is intense. You miss the quiet government pace sometimes but your bank account does not miss it at all.',
      ),
      EventChoice(
        text: 'Stay — security matters more',
        statChanges: {'discipline': 15, 'happiness': 10, 'reputation': 5},
        outcome:
            'You stayed. You told yourself pension and stability matter. They do. You are the most dependable person in this office and everyone knows it.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Constituency Office Opened 🤝',
    description:
        'The MP has opened a new constituency office and needs a senior officer to manage it. It comes with a vehicle allowance and visibility. It also comes with constituents who will call you at 6am about potholes.',
    minAge: 30,
    maxAge: 55,
    requiredCareer: 'Civil Service',
    choices: [
      EventChoice(
        text: 'Accept the posting — visibility is good',
        statChanges: {'reputation': 25, 'connections': 20, 'happiness': -10},
        outcome:
            'You took it. The 6am calls are real. So is the vehicle allowance. You have met three ministers. The potholes remain unfilled but your network is expanding.',
      ),
      EventChoice(
        text: 'Decline — stay in your lane',
        statChanges: {'discipline': 10, 'happiness': 10},
        outcome:
            'You declined. Smart. The officer who took it has aged four years in six months and now answers calls during funerals. Your peace is worth more.',
      ),
    ],
  ),

  // ═══════════════════ HEALTHCARE (5) ═══════════════════

  LifeEvent(
    title: 'The Senior Doctor From Hell 🏥',
    description:
        'The Chief Medical Officer at your facility has publicly corrected you in front of the entire ward for a decision that, by every standard, was correct. She did not explain her correction. She simply moved on. The nurses saw everything.',
    minAge: 22,
    maxAge: 55,
    requiredCareer: 'Healthcare',
    choices: [
      EventChoice(
        text: 'Request a private meeting to discuss it',
        statChanges: {'smarts': 10, 'reputation': 10, 'discipline': 10},
        outcome:
            'You requested the meeting. She grudgingly acknowledged your decision was defensible. She respects people who push back professionally. Slightly. You can work with slightly.',
      ),
      EventChoice(
        text: 'Let it go and move forward',
        statChanges: {'happiness': -10, 'discipline': 15, 'health': -5},
        outcome:
            'You absorbed it and kept moving. The nurses respected you for not making a scene. You filed it in the part of your brain marked "costs of professionalism."',
      ),
    ],
  ),

  LifeEvent(
    title: 'Extra Shift Every Weekend 📋',
    description:
        'Staffing is critically low and your department head has asked you — personally — to cover weekend shifts for the next two months. You are already tired. The patients need you. Being a human being is also important though.',
    minAge: 22,
    maxAge: 55,
    requiredCareer: 'Healthcare',
    choices: [
      EventChoice(
        text: 'Say yes — the patients come first',
        statChanges: {'reputation': 20, 'health': -20, 'happiness': -15},
        outcome:
            'You covered every shift. The department head praised you. Your body submitted a formal complaint. You need a proper rest before you become the one in the hospital bed.',
      ),
      EventChoice(
        text: 'Set a boundary — you will cover some, not all',
        statChanges: {'happiness': 10, 'health': 5, 'discipline': 10},
        outcome:
            'You negotiated. Two weekends in a row, then rest. The department accepted. A well-rested healthcare worker is more valuable than a burned-out one. Everyone knows this in theory.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Colleague Faking Sick Leave 😷',
    description:
        'Your colleague has been on medical leave for three weeks. You have seen their Instagram. They are at a beach resort. The rest of the staff is covering their shifts. What do you do?',
    minAge: 22,
    maxAge: 55,
    requiredCareer: 'Healthcare',
    choices: [
      EventChoice(
        text: 'Report it to HR',
        statChanges: {'reputation': 10, 'connections': -15, 'discipline': 15},
        outcome:
            'You reported it. An investigation began. The colleague returned immediately and has not looked at you since. HR sent an email nobody read. The ward breathes easier now.',
      ),
      EventChoice(
        text: 'Screenshot and send to the group chat',
        statChanges: {'streetSense': 15, 'reputation': -10, 'happiness': 10},
        outcome:
            'The screenshot went everywhere in twenty minutes. Management got involved whether they wanted to or not. Your colleague returned the next day. You are both pretending it was nothing.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Private Clinic Offer 🩺',
    description:
        'A private clinic in a wealthy neighbourhood has offered you a position that pays twice your salary. It means leaving public service and serving premium clients. Your current patients are much poorer. You feel the tension.',
    minAge: 25,
    maxAge: 50,
    requiredCareer: 'Healthcare',
    choices: [
      EventChoice(
        text: 'Take the private clinic job',
        statChanges: {'money': 30, 'happiness': 5, 'reputation': 10},
        outcome:
            'You moved. The pay is real and the facilities are excellent. The guilt faded slowly. You donate time to a free clinic on Saturdays to keep your conscience tidy.',
      ),
      EventChoice(
        text: 'Stay in public service',
        statChanges: {'reputation': 25, 'happiness': -5, 'health': -5},
        outcome:
            'You stayed. Colleagues respect you deeply. The pay remains difficult. You are doing something important and everyone except the government seems to know it.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Patient Brought a Live Chicken 🐔',
    description:
        'A grateful patient from the village has arrived at your office with a live chicken and a large yam as payment for your care. Meanwhile the queue outside has 40 people in it. The chicken appears calm.',
    minAge: 22,
    maxAge: 55,
    requiredCareer: 'Healthcare',
    choices: [
      EventChoice(
        text: 'Accept gratefully and share with colleagues',
        statChanges: {'happiness': 20, 'connections': 15, 'reputation': 10},
        outcome:
            'You accepted with a full heart. Your colleagues ate well that Friday. The story became legend. You are now the doctor they tell stories about in that village.',
      ),
      EventChoice(
        text: 'Politely decline and explain hospital policy',
        statChanges: {'discipline': 15, 'reputation': 5, 'happiness': -5},
        outcome:
            'You declined kindly. The patient was embarrassed. A nurse quietly took the yam. The chicken was released near the hospital gate and became a fixture of the parking lot.',
      ),
    ],
  ),

  // ═══════════════════ EDUCATION (5) ═══════════════════

  LifeEvent(
    title: 'The Principal Hates You 📚',
    description:
        'Your headmaster has written a weak performance review for you despite your class passing BECE at the highest rate in the school\'s history. The reason is unknown. The unfairness is undeniable.',
    minAge: 22,
    maxAge: 55,
    requiredCareer: 'Education',
    choices: [
      EventChoice(
        text: 'Appeal formally to the Ghana Education Service',
        statChanges: {'reputation': 15, 'discipline': 15, 'connections': -5},
        outcome:
            'You filed the appeal. GES took four months to respond and upheld your record. The principal never forgave you. The students started a WhatsApp group to support you.',
      ),
      EventChoice(
        text: 'Document everything and wait',
        statChanges: {'smarts': 15, 'discipline': 10, 'happiness': -10},
        outcome:
            'You documented every result, every class, every commendation. When your transfer opportunity came, your file was spotless. You left on your own terms.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Promotion to HOD 📐',
    description:
        'The Head of Department position is open and you are the strongest candidate. It means more admin, more meetings, less actual teaching. Do you want it?',
    minAge: 25,
    maxAge: 50,
    requiredCareer: 'Education',
    choices: [
      EventChoice(
        text: 'Apply — leadership is the next step',
        statChanges: {'reputation': 20, 'smarts': 10, 'happiness': -5},
        outcome:
            'You got it. You run the department now. You miss teaching but you have shaped how twelve other teachers teach. That multiplier effect is something.',
      ),
      EventChoice(
        text: 'Decline — you love being in the classroom',
        statChanges: {'happiness': 20, 'discipline': 10},
        outcome:
            'You stayed in the classroom. Your students are consistently the highest performers. Some teachers lead with admin. You lead with results.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Parent Threatens to Report You 😡',
    description:
        'A parent is furious because their child failed a test. They are threatening to go to the Ghana Education Service. You graded the paper correctly. The child did not answer three of the four questions.',
    minAge: 22,
    maxAge: 55,
    requiredCareer: 'Education',
    choices: [
      EventChoice(
        text: 'Show the evidence and stand your ground',
        statChanges: {'reputation': 15, 'discipline': 15, 'connections': -5},
        outcome:
            'You showed them the script. The parent saw the blank answers. There was a long silence. They apologised quietly and walked out. The principal gave you a nod of acknowledgment.',
      ),
      EventChoice(
        text: 'Offer a re-mark to keep the peace',
        statChanges: {'streetSense': 10, 'reputation': -5, 'happiness': -5},
        outcome:
            'You re-marked it. Nothing changed. The parent accepted the same score once it felt official. Teaching requires this kind of energy management.',
      ),
    ],
  ),

  LifeEvent(
    title: 'NGO Offers Better Pay 🌍',
    description:
        'An international NGO wants you as a Training Officer. Same work, different context, three times the pay, and a travel allowance. The government school will be down one teacher. The choice is real.',
    minAge: 25,
    maxAge: 50,
    requiredCareer: 'Education',
    choices: [
      EventChoice(
        text: 'Take the NGO position',
        statChanges: {'money': 25, 'connections': 20, 'reputation': 10},
        outcome:
            'You took it. You now train teachers instead of students. Your reach multiplied. The pay changed your life. You still volunteer at your old school once a term.',
      ),
      EventChoice(
        text: 'Stay in teaching',
        statChanges: {'happiness': 15, 'reputation': 20},
        outcome:
            'You stayed. The NGO filled the position. You are still the best teacher in the school. Your students still come back years later to find you. That is not nothing.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Student Corrects You in Front of Class 🎓',
    description:
        'A student in your class has just corrected something you said — in front of 42 other students — and they were completely right. The class is watching your face very carefully.',
    minAge: 22,
    maxAge: 55,
    requiredCareer: 'Education',
    choices: [
      EventChoice(
        text: 'Acknowledge the correction and thank them',
        statChanges: {'reputation': 20, 'smarts': 5, 'happiness': 10},
        outcome:
            'You said "You are correct, well done." The class relaxed. The student looked shocked. You earned more respect in that moment than any lesson you had ever taught.',
      ),
      EventChoice(
        text: 'Deflect and move on quickly',
        statChanges: {'streetSense': 5, 'reputation': -10},
        outcome:
            'You changed the subject fast. The class noticed. The student wrote it in their journal. Children remember these moments far longer than teachers do.',
      ),
    ],
  ),

  // ═══════════════════ TECH (5) ═══════════════════

  LifeEvent(
    title: 'The Tech Bro Boss 💻',
    description:
        'Your manager has just described a task as "low-hanging fruit" and "synergistic." He wants a "pivot" on the "roadmap" in two days. You are not sure what he means. He is not sure either. He is the boss though.',
    minAge: 22,
    maxAge: 55,
    requiredCareer: 'Tech',
    choices: [
      EventChoice(
        text: 'Ask for a clearer brief and push back',
        statChanges: {'smarts': 15, 'discipline': 10, 'reputation': 5},
        outcome:
            'You asked for clarity. He was briefly annoyed. Then he actually explained it. The feature shipped properly. He started giving you better briefs. You unlocked a new relationship mode.',
      ),
      EventChoice(
        text: 'Build what you think he means and hope',
        statChanges: {'smarts': 10, 'streetSense': 15, 'happiness': -5},
        outcome:
            'You built something reasonable. He loved it. He called it exactly what he originally did not describe. Tech is like this sometimes. You are developing a very particular skill set.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Pull Request Rejected Again 🔧',
    description:
        'You spent a week building a feature. Senior dev rejected your pull request with one comment: "nah." You need this merged. You also need to not lose your mind.',
    minAge: 22,
    maxAge: 50,
    requiredCareer: 'Tech',
    choices: [
      EventChoice(
        text: 'Request a detailed code review session',
        statChanges: {'smarts': 20, 'discipline': 10, 'happy': 5},
        outcome:
            'You requested the session. The senior dev explained properly. Your next PR was approved first time. The friction produced a better engineer. You.',
      ),
      EventChoice(
        text: 'Rewrite it overnight and resubmit',
        statChanges: {'discipline': 20, 'health': -10, 'smarts': 10},
        outcome:
            'You rewrote the whole thing in one night running on Star Malt and stubbornness. It was significantly better. Merged. Sometimes spite is a valid engineering tool.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Startup Funding Drama 💰',
    description:
        'Your company has failed to secure the Series A round it needed. Salaries are delayed. Management is holding emergency Zoom calls with many slides. You have two job offers sitting in your inbox.',
    minAge: 25,
    maxAge: 50,
    requiredCareer: 'Tech',
    choices: [
      EventChoice(
        text: 'Jump ship — accept one of the offers',
        statChanges: {'money': 20, 'connections': 10, 'happiness': 10},
        outcome:
            'You left. The startup collapsed two months later. You were at your new job collecting a full salary when it happened. Your former colleagues still talking about it in a group chat you were removed from.',
      ),
      EventChoice(
        text: 'Stay and help them survive',
        statChanges: {'reputation': 25, 'discipline': 20, 'money': -10},
        outcome:
            'You stayed. It was difficult. The company survived on a bridge loan. The CEO never forgot who stayed. When the next opportunity came, you were the first person he called.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Big Tech Comes Calling 🌐',
    description:
        'A recruiter from a major international tech company has found your LinkedIn and wants to talk. The role is remote-first with dollar salary. Ghana Tech Twitter is obsessed with this kind of story. You are living it.',
    minAge: 25,
    maxAge: 50,
    requiredCareer: 'Tech',
    choices: [
      EventChoice(
        text: 'Interview and push for it',
        statChanges: {'money': 40, 'smarts': 10, 'connections': 20},
        outcome:
            'You interviewed four rounds and got the offer. The dollar salary changed your life. You work from home. You have opinions about time zones now. Ghana Tech Twitter followed your story.',
      ),
      EventChoice(
        text: 'Decline — you want to build here',
        statChanges: {'reputation': 25, 'connections': 15, 'happiness': 15},
        outcome:
            'You declined and posted about it. The tech community celebrated you. Three local startups reached out the same week. You are building something Ghanaian. That has its own value.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Production Is Down at 2am 🔥',
    description:
        'Your phone is ringing. It is 2am. The company\'s main system has crashed and you are the only engineer who understands the problematic service. The CTO sounds very awake. You are not.',
    minAge: 22,
    maxAge: 50,
    requiredCareer: 'Tech',
    choices: [
      EventChoice(
        text: 'Fix it right now — you know what to do',
        statChanges: {'reputation': 25, 'health': -10, 'discipline': 15},
        outcome:
            'You fixed it in ninety minutes. The CTO sent a company-wide message praising you by name. You went back to sleep at 4am. The next morning the office treated you differently. You earned that.',
      ),
      EventChoice(
        text: 'Walk them through it remotely and coach the on-call',
        statChanges: {'smarts': 15, 'reputation': 15, 'connections': 10},
        outcome:
            'You guided the on-call engineer through the fix over a call. It took longer but they learned it. You slept. They respected you even more for trusting them. Good engineering culture.',
      ),
    ],
  ),

  // ═══════════════════ TRADE (5) ═══════════════════

  LifeEvent(
    title: 'Supplier Delivered Fake Goods 📦',
    description:
        'Your main supplier sent a container of goods that are clearly not what you ordered. Sub-standard materials. Your customers are already expecting delivery. The supplier is "looking into it."',
    minAge: 22,
    maxAge: 55,
    requiredCareer: 'Trade',
    choices: [
      EventChoice(
        text: 'Refuse delivery and demand replacements',
        statChanges: {'reputation': 20, 'money': -10, 'discipline': 15},
        outcome:
            'You refused everything. The supplier argued but eventually replaced the goods. Your customers received a delay and an honest explanation. Most of them respected that. Business reputations are built in exactly these moments.',
      ),
      EventChoice(
        text: 'Sell them at a reduced price and be transparent',
        statChanges: {'streetSense': 20, 'money': 5, 'reputation': -5},
        outcome:
            'You disclosed the situation and reduced the price. Some customers bought anyway. The supplier was surprised by your response. Not a proud day, but not a dishonest one either.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Customs Drama at the Port 🚢',
    description:
        'Your goods have been held at the port for three weeks. Customs wants a "filing fee" that is not official and not documented. Your goods are losing value daily. This is Ghana trade.',
    minAge: 22,
    maxAge: 55,
    requiredCareer: 'Trade',
    choices: [
      EventChoice(
        text: 'Pay the fee and get your goods',
        statChanges: {'money': -15, 'goods': 10, 'streetSense': 10},
        outcome:
            'You paid. The goods arrived the next day. You hate that you paid. You understand the system a little better now. You price it into future imports as "logistics smoothing."',
      ),
      EventChoice(
        text: 'Escalate to the GRA and fight it properly',
        statChanges: {'discipline': 20, 'reputation': 10, 'money': -20},
        outcome:
            'You filed with the Ghana Revenue Authority. It took two more weeks but the goods were released without the unofficial fee. You lost more in delays than the fee. The principle, however, is intact.',
      ),
    ],
  ),

  LifeEvent(
    title: 'A Bigger Trader Wants Your Customers 👀',
    description:
        'A much larger competitor has started operating on your street and is undercutting your prices. Your loyal customers are wavering. They respect you but money talks.',
    minAge: 22,
    maxAge: 55,
    requiredCareer: 'Trade',
    choices: [
      EventChoice(
        text: 'Compete on quality and relationships',
        statChanges: {'reputation': 20, 'connections': 15, 'money': -5},
        outcome:
            'You doubled down on service. You remembered birthdays, offered credit to trusted regulars, sourced exactly what they needed. The bigger trader had scale. You had loyalty. You survived.',
      ),
      EventChoice(
        text: 'Find a niche product they cannot offer',
        statChanges: {'smarts': 15, 'money': 10, 'streetSense': 15},
        outcome:
            'You spotted a gap. A product they did not carry that your best customers needed. You became the only option for that item. A small monopoly is still a monopoly.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Partner Wants Out 🤝',
    description:
        'Your trading partner of four years wants to dissolve the arrangement and start independently. The business has been doing well. The split could be messy or clean. Your choice of approach matters.',
    minAge: 25,
    maxAge: 55,
    requiredCareer: 'Trade',
    choices: [
      EventChoice(
        text: 'Split assets fairly and part as friends',
        statChanges: {'connections': 10, 'reputation': 15, 'happiness': 5},
        outcome:
            'You split cleanly. They went their way. You went yours. You still greet each other at the market. In Ghanaian trade, a good separation is as valuable as a good partnership.',
      ),
      EventChoice(
        text: 'Fight to keep the business together',
        statChanges: {'money': 10, 'connections': -20, 'discipline': 10},
        outcome:
            'You resisted and it got complicated. Eventually they left anyway. The split was worse. The business recovered but the relationship did not.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Market Queen Wants a Cut 👑',
    description:
        'The unofficial "market queen" — the woman who has run this market\'s informal leadership for fifteen years — has approached you. She wants a monthly contribution in exchange for "market protection and goodwill."',
    minAge: 22,
    maxAge: 55,
    requiredCareer: 'Trade',
    choices: [
      EventChoice(
        text: 'Pay it — she runs this market',
        statChanges: {'streetSense': 20, 'money': -10, 'connections': 15},
        outcome:
            'You paid. She gave you a better stall location the following month. Three new wholesale customers came through her recommendation. The market has its own operating system. You are part of it now.',
      ),
      EventChoice(
        text: 'Decline respectfully but firmly',
        statChanges: {'discipline': 15, 'connections': -10, 'reputation': -5},
        outcome:
            'You declined. She nodded slowly and walked away. Three weeks later your best supplier said they were "too busy" to deliver to you. The market has a long memory. You are adjusting.',
      ),
    ],
  ),

  // ═══════════════════ ENTERTAINMENT (5) ═══════════════════

  LifeEvent(
    title: 'Bad Manager, Good Opportunity 🎤',
    description:
        'Your manager has booked you a huge show — the biggest of your career — without telling you until 48 hours before. You have no material prepared and he sees nothing wrong with this.',
    minAge: 22,
    maxAge: 50,
    requiredCareer: 'Entertainment',
    choices: [
      EventChoice(
        text: 'Perform anyway — pressure makes diamonds',
        statChanges: {'reputation': 20, 'happiness': 10, 'health': -10},
        outcome:
            'You pulled it off. The crowd did not know you were improvising. Some of the best material you have ever done came from panic. You were nervous until the first laugh. Then you were fine.',
      ),
      EventChoice(
        text: 'Fire the manager after the show',
        statChanges: {'reputation': 10, 'connections': -15, 'discipline': 15},
        outcome:
            'You performed, got paid, and let the manager go the next morning. He talked about you everywhere. Half of what he said was untrue. The industry is small. You handled it by having another great show.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Label Deal on the Table 📋',
    description:
        'A record label has offered you a deal. The advance is real. The contract is sixty-three pages and nobody in your family has ever read a contract of this length. The lawyer they recommend is their own lawyer.',
    minAge: 22,
    maxAge: 50,
    requiredCareer: 'Entertainment',
    choices: [
      EventChoice(
        text: 'Get an independent lawyer and negotiate',
        statChanges: {'smarts': 15, 'money': 15, 'connections': 10},
        outcome:
            'You hired your own lawyer. Several clauses were removed. The label respected the professionalism. You signed a deal that actually serves you. This is rare enough to celebrate.',
      ),
      EventChoice(
        text: 'Sign immediately — the advance is life-changing',
        statChanges: {'money': 20, 'happiness': 10, 'reputation': 10},
        outcome:
            'You signed. The advance was real and so were the restrictions. Three albums in the label controls a lot. It was not the worst deal in the industry but it was not the best either. You have learned what to avoid next time.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Beef on Social Media 🔥',
    description:
        'A fellow entertainer has posted something about you online. It is vague enough to deny but everyone knows it is about you. Your fans are waiting. Ghana Entertainment Twitter is very awake.',
    minAge: 22,
    maxAge: 50,
    requiredCareer: 'Entertainment',
    choices: [
      EventChoice(
        text: 'Respond publicly and own it',
        statChanges: {'reputation': 20, 'connections': -10, 'happiness': 10},
        outcome:
            'You responded. It was clean, pointed, and quotable. The internet sided with you. The other entertainer went quiet. Sales increased. Sometimes the beef is the marketing.',
      ),
      EventChoice(
        text: 'Stay silent and release new music instead',
        statChanges: {'reputation': 15, 'discipline': 15, 'happiness': 5},
        outcome:
            'You dropped a song three days later. It was your best one yet. The beef was forgotten within a week. You never addressed it directly. The music addressed it for you.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Brand Deal Compromise 💼',
    description:
        'A large brand wants to sponsor you at a fee that would change your monthly income. The product is one you have never used and does not fit your image. Integrity vs income.',
    minAge: 25,
    maxAge: 50,
    requiredCareer: 'Entertainment',
    choices: [
      EventChoice(
        text: 'Take the deal — bills are real',
        statChanges: {'money': 25, 'reputation': -10, 'happiness': -5},
        outcome:
            'You took it. The money was good. Some fans noticed the mismatch. You told yourself everyone compromises sometimes. That is true. It does not always feel fine.',
      ),
      EventChoice(
        text: 'Decline and hold out for the right brand',
        statChanges: {'reputation': 20, 'happiness': 15, 'money': -5},
        outcome:
            'You declined. A brand that actually fits your image reached out two months later at a lower fee. You took it. It felt right. The audience noticed and rewarded you with engagement.',
      ),
    ],
  ),

  LifeEvent(
    title: 'You Were Asked to Perform at a Funeral 🎺',
    description:
        'A very important man\'s family has contacted you to perform at his state funeral. The coverage will be national. The fee is low. The exposure, however, is extremely real.',
    minAge: 22,
    maxAge: 55,
    requiredCareer: 'Entertainment',
    choices: [
      EventChoice(
        text: 'Accept — funerals are the best networking in Ghana',
        statChanges: {'reputation': 20, 'connections': 25, 'money': 5},
        outcome:
            'You performed. Every important person in the country was in that room. Three bookings came through by the end of the week. Ghana funerals are legitimately career-defining events.',
      ),
      EventChoice(
        text: 'Decline — low fee is disrespectful',
        statChanges: {'discipline': 10, 'reputation': -5},
        outcome:
            'You declined politely. They found someone else. That person\'s career jumped significantly. You stand by your worth. But you now quote a lower "funeral rate" in your revised pricing guide.',
      ),
    ],
  ),

  // ═══════════════════ HUSTLE (5) ═══════════════════

  LifeEvent(
    title: 'The Police Know Your Corner 🚔',
    description:
        'The police at the checkpoint near your main operation know you by name. One of them has pulled you aside. He is not arresting you. He wants a "contribution" to "ignore" certain activities. Ghana hustle taxation.',
    minAge: 22,
    maxAge: 55,
    requiredCareer: 'Hustle',
    choices: [
      EventChoice(
        text: 'Pay him — it is part of the operating cost',
        statChanges: {'money': -10, 'streetSense': 15, 'connections': 5},
        outcome:
            'You paid. He nodded. The checkpoint was clear from then on. The amount went up slightly after three months. You expected this. You priced it in already.',
      ),
      EventChoice(
        text: 'Relocate operations to a safer area',
        statChanges: {'smarts': 15, 'money': -5, 'streetSense': 20},
        outcome:
            'You moved. The new spot was quieter and cheaper to operate. You learned to never get too comfortable in one location. The hustle needs to stay mobile.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Big Order, Big Risk 📦',
    description:
        'A contact wants to move a very large volume of goods through your network. The commission would set you up for six months. The goods are legal but the speed and volume will attract attention. Are you in?',
    minAge: 22,
    maxAge: 55,
    requiredCareer: 'Hustle',
    choices: [
      EventChoice(
        text: 'Take the order — calculated risk',
        statChanges: {'money': 35, 'streetSense': 10, 'health': -5},
        outcome:
            'It went through. The commission was everything they promised. You operated at a pace that was hard to sustain but you survived it. The contact sent two more orders. The risk became routine.',
      ),
      EventChoice(
        text: 'Pass it to a bigger operator',
        statChanges: {'connections': 20, 'money': 5, 'streetSense': 10},
        outcome:
            'You passed it up the chain and took a referral cut. Less money but no exposure. The bigger operator owed you a favour. Favours in this business are a form of currency.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Partner Ran Off With the Money 💨',
    description:
        'You fronted cash for a joint operation. Your partner was supposed to return yesterday. He has not returned. His phone is off. His mother says he is "traveling." The money is gone.',
    minAge: 22,
    maxAge: 55,
    requiredCareer: 'Hustle',
    choices: [
      EventChoice(
        text: 'Use your network to find him',
        statChanges: {'streetSense': 20, 'connections': 10, 'money': 10},
        outcome:
            'You activated three people. He was found at his cousin\'s place in Tamale within 72 hours. Most of the money came back. You do not front cash to anyone without collateral now. Lesson cost.',
      ),
      EventChoice(
        text: 'Write it off and move forward',
        statChanges: {'discipline': 20, 'money': -20, 'happiness': -10},
        outcome:
            'You absorbed the loss. It hurt. You restructured how you operate — smaller partnerships, faster turnover, less exposure per deal. The system that replaced your trust was tighter and better.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Legitimate Business Opportunity 📈',
    description:
        'Someone who has watched your hustle for years wants to formalise it — help you register a business, open a bank account, do it properly. It would limit some activities but open up others.',
    minAge: 25,
    maxAge: 55,
    requiredCareer: 'Hustle',
    choices: [
      EventChoice(
        text: 'Go legitimate — register the business',
        statChanges: {'money': 10, 'reputation': 25, 'connections': 20, 'discipline': 10},
        outcome:
            'You registered. Taxes are real now. But so are bank loans, contracts, and a level of respect that informal operators cannot access. The game changed. You changed with it.',
      ),
      EventChoice(
        text: 'Stay informal — flexibility is the edge',
        statChanges: {'streetSense': 20, 'money': 5},
        outcome:
            'You declined. Your flexibility is worth more than a certificate. You operate faster than any registered business. You keep moving and the money keeps coming.',
      ),
    ],
  ),

  LifeEvent(
    title: 'Everyone Wants a Loan From You 💸',
    description:
        'You have had a good run recently and the whole neighbourhood knows it. Your phone has not stopped ringing. Three cousins, two childhood friends, and someone you have not seen since primary school all need "a small help."',
    minAge: 22,
    maxAge: 55,
    requiredCareer: 'Hustle',
    choices: [
      EventChoice(
        text: 'Lend to close family only with clear terms',
        statChanges: {'connections': 15, 'money': -15, 'happiness': 5},
        outcome:
            'You lent to two people with clear repayment terms written down. One repaid on time. The other is "sorting it out." You have learned the difference between a loan and a gift. If you cannot afford to lose it, it was never a loan.',
      ),
      EventChoice(
        text: 'Decline everyone — protect your capital',
        statChanges: {'money': 15, 'connections': -15, 'discipline': 15},
        outcome:
            'You declined all of them. Some were upset. The money stayed intact. You used it for your next deal. The hustle cannot absorb sentiment. You made the correct business decision. The relationships will recover or they will not.',
      ),
    ],
  ),
];
