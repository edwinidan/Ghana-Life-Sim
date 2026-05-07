import 'package:flutter/material.dart';
import '../models/character.dart';
import '../data/careers.dart';
import '../data/side_gigs.dart';
import '../services/career_service.dart';
import '../services/job_service.dart';

class JobScreen extends StatelessWidget {
  final Character character;
  final VoidCallback onCharacterUpdated;

  const JobScreen({
    super.key,
    required this.character,
    required this.onCharacterUpdated,
  });

  @override
  Widget build(BuildContext context) {
    final availableJobs = JobService.getAvailableJobs(character);
    final availableGigs = JobService.getAvailableSideGigs(character);

    return Scaffold(
      backgroundColor: const Color(0xFFFCFAFF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'Career & Gigs 💼',
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
          // Section 1 — Current Job
          _buildSectionHeader('Current Job'),
          const SizedBox(height: 10.8),
          _buildCurrentJobCard(context),
          const SizedBox(height: 21.6),

          // Section 2 — Job Listings (only when unemployed)
          if (character.careerPath == 'None') ...[
            _buildSectionHeader('Job Listings'),
            const SizedBox(height: 10.8),
            if (availableJobs.isEmpty)
              _buildInfoCard(
                'No listings right now',
                'No job listings match your qualifications right now. Study more or build your stats.',
              )
            else
              ...availableJobs.map((job) => _buildJobCard(context, job)),
            const SizedBox(height: 21.6),
          ],

          // Section 3 — Side Gigs
          _buildSectionHeader('Side Gigs'),
          const SizedBox(height: 10.8),
          if (character.sideGigs.isNotEmpty) ...[
            _buildActiveSideGigs(context),
            const SizedBox(height: 10.8),
          ],
          if (availableGigs.isEmpty)
            _buildInfoCard('No new gigs available', 'No new gigs available right now.')
          else
            ...availableGigs.map((gig) => _buildSideGigCard(context, gig)),

          const SizedBox(height: 72),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 14.4,
        fontWeight: FontWeight.w900,
        color: Color(0xFF424242),
      ),
    );
  }

  Widget _buildCurrentJobCard(BuildContext context) {
    if (character.careerPath == 'None') {
      return _buildInfoCard('Unemployed 😬', 'You are currently unemployed. Check the job listings below.');
    }

    final careerData = CareerService.getCareerData(character);
    final levelTitle = (careerData != null && character.careerLevel >= 1 && character.careerLevel <= careerData.levels.length)
        ? careerData.levels[character.careerLevel - 1].title
        : '';
    final levelNames = ['', 'Entry', 'Mid', 'Senior'];
    final levelLabel = character.careerLevel < levelNames.length ? levelNames[character.careerLevel] : '';

    return Container(
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
          Row(
            children: [
              const Text('💼', style: TextStyle(fontSize: 18)),
              const SizedBox(width: 9),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      levelTitle.isNotEmpty ? levelTitle : character.careerPath,
                      style: const TextStyle(
                        fontSize: 14.4,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF424242),
                      ),
                    ),
                    Text(
                      '${character.careerPath}${levelLabel.isNotEmpty ? ' · $levelLabel Level' : ''}',
                      style: const TextStyle(fontSize: 10.8, color: Color(0xFF9E9E9E)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 9),
          Text(
            'GHS ${_formatNumber(character.monthlyIncome)} / month',
            style: const TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
              color: Color(0xFF009688),
            ),
          ),
          const SizedBox(height: 12.6),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => _confirmQuitJob(context),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
                side: const BorderSide(color: Colors.red),
                padding: const EdgeInsets.symmetric(vertical: 10.8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9.7)),
              ),
              child: const Text(
                'Quit Job',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _confirmQuitJob(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        title: const Text('Quit your job?', style: TextStyle(fontWeight: FontWeight.w900)),
        content: Text('Are you sure you want to leave ${character.careerPath}? This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              JobService.quitJob(character);
              onCharacterUpdated();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('You quit your job. Bold move. 🚪'),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: const Text('Quit', style: TextStyle(color: Colors.red, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  Widget _buildJobCard(BuildContext context, CareerData career) {
    final entry = career.levels[0];
    final topReq = entry.statRequirements.isNotEmpty
        ? entry.statRequirements.entries.reduce((a, b) => a.value >= b.value ? a : b)
        : null;

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
              entry.title,
              style: const TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.w900,
                color: Color(0xFF424242),
              ),
            ),
            const SizedBox(height: 1.8),
            Text(
              career.name,
              style: const TextStyle(fontSize: 10.8, color: Color(0xFF9E9E9E)),
            ),
            const SizedBox(height: 7.2),
            Row(
              children: [
                Text(
                  'Starting: GHS ${_formatNumber(entry.salary)}/mo',
                  style: const TextStyle(
                    fontSize: 11.7,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF009688),
                  ),
                ),
                if (topReq != null) ...[
                  const SizedBox(width: 14.4),
                  Text(
                    '${_capitalise(topReq.key)}: ${topReq.value}+',
                    style: const TextStyle(fontSize: 10.8, color: Color(0xFF757575)),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 12.6),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final success = JobService.applyForJob(character, career);
                  onCharacterUpdated();
                  final msg = success
                      ? 'You got the job! Welcome to ${career.name}. 🎉'
                      : 'They said no. Ghana is hard. 😔';
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(msg),
                      backgroundColor: success ? const Color(0xFF009688) : Colors.grey[700],
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
                  'Apply',
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12.6),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveSideGigs(BuildContext context) {
    final totalIncome = character.sideGigIncome;

    return Container(
      padding: const EdgeInsets.all(14.4),
      decoration: BoxDecoration(
        color: const Color(0xFFB2DFDB).withOpacity(0.1),
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: const Color(0xFFB2DFDB).withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Side gig income: GHS ${_formatNumber(totalIncome)}/month',
            style: const TextStyle(
              fontSize: 11.7,
              fontWeight: FontWeight.w700,
              color: Color(0xFF009688),
            ),
          ),
          const SizedBox(height: 9),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: character.sideGigs.map((gigName) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.8, vertical: 5.4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.2),
                  border: Border.all(color: const Color(0xFFB2DFDB)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      gigName,
                      style: const TextStyle(
                        fontSize: 10.8,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF424242),
                      ),
                    ),
                    const SizedBox(width: 5.4),
                    GestureDetector(
                      onTap: () {
                        try {
                          final gig = allSideGigs.firstWhere((g) => g.name == gigName);
                          JobService.quitSideGig(character, gig);
                          onCharacterUpdated();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Quit $gigName. One less hustle. 😤'),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.1)),
                            ),
                          );
                        } catch (_) {}
                      },
                      child: const Icon(Icons.close, size: 12.6, color: Color(0xFF9E9E9E)),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSideGigCard(BuildContext context, SideGig gig) {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  gig.name,
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF424242),
                  ),
                ),
                Text(
                  'GHS ${_formatNumber(gig.monthlyIncome)}/mo',
                  style: const TextStyle(
                    fontSize: 11.7,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF009688),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5.4),
            Text(
              gig.description,
              style: const TextStyle(
                fontSize: 11.7,
                color: Color(0xFF757575),
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 12.6),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  JobService.takeSideGig(character, gig);
                  onCharacterUpdated();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Started ${gig.name}! Extra money, extra stress. 💪'),
                      backgroundColor: const Color(0xFF009688),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.1)),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB2DFDB),
                  foregroundColor: const Color(0xFF004D40),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 12.6),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9.7)),
                ),
                child: const Text(
                  'Take Gig',
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12.6),
                ),
              ),
            ),
          ],
        ),
      ),
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

  String _formatNumber(int n) =>
      n.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},');

  String _capitalise(String s) => s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);
}
