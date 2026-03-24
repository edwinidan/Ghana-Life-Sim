// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CharacterAdapter extends TypeAdapter<Character> {
  @override
  final int typeId = 0;

  @override
  Character read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Character(
      name: fields[0] as String,
      gender: fields[1] as String,
    )
      ..age = fields[2] as int
      ..isAlive = fields[3] as bool
      ..health = fields[4] as int
      ..happiness = fields[5] as int
      ..smarts = fields[6] as int
      ..looks = fields[7] as int
      ..money = fields[8] as int
      ..reputation = fields[9] as int
      ..discipline = fields[10] as int
      ..streetSense = fields[11] as int
      ..connections = fields[12] as int
      ..job = fields[13] as String
      ..education = fields[14] as String
      ..lifeLog = (fields[15] as List).cast<String>()
      ..careerPath = fields[16] as String
      ..careerLevel = fields[17] as int
      ..monthlyIncome = fields[18] as int
      ..educationLevel = fields[19] as String
      ..isEnrolled = fields[20] as bool
      ..enrolledIn = fields[21] as String
      ..yearsLeftInSchool = fields[22] as int
      ..sideGigs = (fields[23] as List).cast<String>()
      ..sideGigIncome = fields[24] as int
      ..relationshipStatus = fields[25] as String
      ..partnerName = fields[26] as String
      ..partnerJob = fields[27] as String
      ..partnerPersonality = fields[28] as String
      ..relationshipScore = fields[29] as int
      ..numberOfChildren = fields[30] as int
      ..isCheating = fields[31] as bool
      ..sidePartnerName = fields[32] as String;
  }

  @override
  void write(BinaryWriter writer, Character obj) {
    writer
      ..writeByte(33)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.gender)
      ..writeByte(2)
      ..write(obj.age)
      ..writeByte(3)
      ..write(obj.isAlive)
      ..writeByte(4)
      ..write(obj.health)
      ..writeByte(5)
      ..write(obj.happiness)
      ..writeByte(6)
      ..write(obj.smarts)
      ..writeByte(7)
      ..write(obj.looks)
      ..writeByte(8)
      ..write(obj.money)
      ..writeByte(9)
      ..write(obj.reputation)
      ..writeByte(10)
      ..write(obj.discipline)
      ..writeByte(11)
      ..write(obj.streetSense)
      ..writeByte(12)
      ..write(obj.connections)
      ..writeByte(13)
      ..write(obj.job)
      ..writeByte(14)
      ..write(obj.education)
      ..writeByte(15)
      ..write(obj.lifeLog)
      ..writeByte(16)
      ..write(obj.careerPath)
      ..writeByte(17)
      ..write(obj.careerLevel)
      ..writeByte(18)
      ..write(obj.monthlyIncome)
      ..writeByte(19)
      ..write(obj.educationLevel)
      ..writeByte(20)
      ..write(obj.isEnrolled)
      ..writeByte(21)
      ..write(obj.enrolledIn)
      ..writeByte(22)
      ..write(obj.yearsLeftInSchool)
      ..writeByte(23)
      ..write(obj.sideGigs)
      ..writeByte(24)
      ..write(obj.sideGigIncome)
      ..writeByte(25)
      ..write(obj.relationshipStatus)
      ..writeByte(26)
      ..write(obj.partnerName)
      ..writeByte(27)
      ..write(obj.partnerJob)
      ..writeByte(28)
      ..write(obj.partnerPersonality)
      ..writeByte(29)
      ..write(obj.relationshipScore)
      ..writeByte(30)
      ..write(obj.numberOfChildren)
      ..writeByte(31)
      ..write(obj.isCheating)
      ..writeByte(32)
      ..write(obj.sidePartnerName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CharacterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
