import 'package:flutter/material.dart';
import '../models/character.dart';
import '../data/education.dart';
import '../services/school_service.dart';

class SchoolScreen extends StatelessWidget {
  final Character character;
  final VoidCallback onCharacterUpdated;

  const SchoolScreen({
    super.key,
    required this.character,
    required this.onCharacterUpdated,
  });

  @override
  Widget build(BuildContext context) {
    final currentProgram = SchoolService.getCurrentProgram(character);
    final availablePrograms = SchoolService.getAvailablePrograms(character);

    return Scaffold(
      backgroundColor: const Color(0xFFFCFAFF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'Education 📚',
          style: TextStyle(
            color: Color(0xFF5E35B1),
            fontSize: 18,
            fontWeight: FontWeight.w900,
          ),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 0.9, color: Color(0x22B39DDB)),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          // Current enrollment card
          if (character.isEnrolled && currentProgram != null) ...[
            _buildEnrolledCard(currentProgram),
            const SizedBox(height: 14.4),
          ],

          // Education level badge
          _buildLevelBadge(),
          const SizedBox(height: 21.6),

          // Available programs section
          const Text(
            'Available Programs',
            style: TextStyle(
              fontSize: 14.4,
              fontWeight: FontWeight.w900,
              color: Color(0xFF424242),
            ),
          ),
          const SizedBox(height: 10.8),

          if (character.isEnrolled)
            _buildInfoCard('Focus on your studies 📖', 'You are already enrolled. Come back after you graduate.')
          else if (availablePrograms.isEmpty)
            _buildInfoCard(
              'No programs available',
              'You\'ve completed all available education, or you don\'t qualify yet.',
            )
          else
            ...availablePrograms.map((p) => _buildProgramCard(context, p)),

          const SizedBox(height: 72),
        ],
      ),
    );
  }

  Widget _buildEnrolledCard(EducationProgram program) {
    final progress = 1.0 - (character.yearsLeftInSchool / program.durationYears);

    return Container(
      padding: const EdgeInsets.all(14.4),
      decoration: BoxDecoration(
        color: const Color(0xFFB2DFDB).withOpacity(0.15),
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: const Color(0xFFB2DFDB)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFB2DFDB).withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7.2, vertical: 3.6),
                decoration: BoxDecoration(
                  color: const Color(0xFFB2DFDB),
                  borderRadius: BorderRadius.circular(6.5),
                ),
                child: const Text(
                  'ENROLLED',
                  style: TextStyle(
                    color: Color(0xFF00695C),
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 9),
          Text(
            program.name,
            style: const TextStyle(
              fontSize: 16.2,
              fontWeight: FontWeight.w900,
              color: Color(0xFF424242),
            ),
          ),
          const SizedBox(height: 3.6),
          Text(
            '${character.yearsLeftInSchool} year${character.yearsLeftInSchool == 1 ? '' : 's'} remaining',
            style: const TextStyle(
              fontSize: 11.7,
              color: Color(0xFF757575),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10.8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4.9),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.white.withOpacity(0.6),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF009688)),
              minHeight: 7.2,
            ),
          ),
          const SizedBox(height: 5.4),
          if (program.costPerYear > 0)
            Text(
              'Cost: ${program.costPerYear} money/year',
              style: const TextStyle(fontSize: 10.8, color: Color(0xFF9E9E9E)),
            ),
        ],
      ),
    );
  }

  Widget _buildLevelBadge() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.6, vertical: 7.2),
          decoration: BoxDecoration(
            color: const Color(0xFFB39DDB).withOpacity(0.12),
            borderRadius: BorderRadius.circular(9.7),
            border: Border.all(color: const Color(0xFFB39DDB).withOpacity(0.3)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.school, size: 14.4, color: Color(0xFF5E35B1)),
              const SizedBox(width: 7.2),
              Text(
                'Current Level: ${character.educationLevel} ✅',
                style: const TextStyle(
                  color: Color(0xFF5E35B1),
                  fontSize: 11.7,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard(String title, String body) {
    return Container(
      padding: const EdgeInsets.all(14.4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9.7),
        border: Border.all(color: const Color(0x0DB39DDB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12.6, color: Color(0xFF424242))),
          const SizedBox(height: 3.6),
          Text(body, style: const TextStyle(fontSize: 11.7, color: Color(0xFF9E9E9E))),
        ],
      ),
    );
  }

  Widget _buildProgramCard(BuildContext context, EducationProgram program) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.8),
      child: Container(
        padding: const EdgeInsets.all(14.4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
          border: Border.all(color: const Color(0x0DB39DDB)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              program.name,
              style: const TextStyle(
                fontSize: 14.4,
                fontWeight: FontWeight.w900,
                color: Color(0xFF424242),
              ),
            ),
            const SizedBox(height: 7.2),
            Row(
              children: [
                _buildDetail('⏱ Duration', '${program.durationYears} years'),
                const SizedBox(width: 14.4),
                _buildDetail(
                  '💰 Cost/year',
                  program.costPerYear == 0 ? 'Free' : '${program.costPerYear} money',
                ),
              ],
            ),
            const SizedBox(height: 3.6),
            Row(
              children: [
                _buildDetail('🎯 Min Age', '${program.minAge}'),
                const SizedBox(width: 14.4),
                _buildDetail('🧠 Smarts', '${program.smartsRequired}+'),
              ],
            ),
            const SizedBox(height: 12.6),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  SchoolService.enroll(character, program);
                  onCharacterUpdated();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Enrolled in ${program.name}! Good luck. 📖'),
                      backgroundColor: const Color(0xFF5E35B1),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.1)),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB39DDB),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 12.6),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9.7)),
                ),
                child: const Text(
                  'Enroll',
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12.6),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetail(String label, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$label: ',
          style: const TextStyle(fontSize: 10.8, color: Color(0xFF9E9E9E)),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 10.8, fontWeight: FontWeight.w700, color: Color(0xFF616161)),
        ),
      ],
    );
  }
}
