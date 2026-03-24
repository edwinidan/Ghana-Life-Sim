import 'dart:math';

const List<String> ghanaianMaleNames = [
  'Kwame', 'Kofi', 'Kweku', 'Yaw', 'Kwabena', 'Kojo', 'Fiifi', 'Nana',
  'Ebo', 'Mensah', 'Agyei', 'Boateng', 'Asante', 'Darko', 'Amponsah',
  'Osei', 'Frimpong', 'Acheampong', 'Baffour', 'Gyasi'
];

const List<String> ghanaianFemaleNames = [
  'Akosua', 'Abena', 'Akua', 'Yaa', 'Adwoa', 'Afia', 'Efua', 'Ama',
  'Adjoa', 'Serwa', 'Adoma', 'Maame', 'Awura',
  'Nana', 'Fafa', 'Esiba', 'Araba'
];

const List<String> partnerPersonalities = [
  'Ambitious', 'Clingy', 'Funny', 'Jealous', 'Calm', 'Spiritual',
  'Hardworking', 'Dramatic', 'Caring', 'Stubborn', 'Adventurous', 'Traditional'
];

const List<String> partnerJobs = [
  'Teacher', 'Nurse', 'Trader', 'Civil Servant', 'Driver', 'Engineer',
  'Accountant', 'Farmer', 'Pastor', 'Police Officer', 'Hair Dresser',
  'Journalist', 'Pharmacist', 'Tailor', 'Banker'
];

final _random = Random();

String generatePartnerName(String playerGender) {
  if (playerGender == 'Male') {
    return ghanaianFemaleNames[_random.nextInt(ghanaianFemaleNames.length)];
  } else {
    return ghanaianMaleNames[_random.nextInt(ghanaianMaleNames.length)];
  }
}

String generatePersonality() {
  return partnerPersonalities[_random.nextInt(partnerPersonalities.length)];
}

String generatePartnerJob() {
  return partnerJobs[_random.nextInt(partnerJobs.length)];
}
