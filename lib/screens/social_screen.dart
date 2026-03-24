import 'package:flutter/material.dart';
import '../models/character.dart';
import '../services/relationship_service.dart';

class SocialScreen extends StatefulWidget {
  final Character character;
  final VoidCallback onCharacterUpdated;

  const SocialScreen({
    super.key,
    required this.character,
    required this.onCharacterUpdated,
  });

  @override
  State<SocialScreen> createState() => _SocialScreenState();
}

class _SocialScreenState extends State<SocialScreen> {
  Character get c => widget.character;

  // ── Relationship status badge colour ──────────────────────────────────────
  Color _statusColor(String status) {
    switch (status) {
      case 'Dating':
        return const Color(0xFFF06292);
      case 'Engaged':
        return const Color(0xFF9C27B0);
      case 'Married':
        return const Color(0xFFFFB300);
      case 'Divorced':
        return const Color(0xFFFF7043);
      case 'Widowed':
        return const Color(0xFF616161);
      default:
        return const Color(0xFF9E9E9E);
    }
  }

  Color _scoreColor(int score) {
    if (score >= 60) return const Color(0xFF43A047);
    if (score >= 30) return const Color(0xFFFFB300);
    return const Color(0xFFE53935);
  }

  // ── Snackbar helper ───────────────────────────────────────────────────────
  void _snack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: const Color(0xFF5E35B1),
      ),
    );
  }

  // ── Meet Someone bottom sheet ─────────────────────────────────────────────
  void _showMeetSomeoneSheet() {
    final name = RelationshipService.generatePotentialPartner(c);
    setState(() {});
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      backgroundColor: Colors.white,
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Someone Caught Your Eye 💕',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF424242),
                ),
              ),
              const SizedBox(height: 16),
              _infoRow('Name', name),
              const SizedBox(height: 8),
              _infoRow('Job', c.partnerJob),
              const SizedBox(height: 8),
              _infoRow('Vibe', c.partnerPersonality),
              const SizedBox(height: 28),
              Row(
                children: [
                  Expanded(
                    child: _pinkButton(
                      label: 'Ask Out 💕',
                      onTap: () {
                        Navigator.pop(ctx);
                        final success = RelationshipService.askOut(c);
                        setState(() {});
                        widget.onCharacterUpdated();
                        _snack(
                          success
                              ? '${c.partnerName} said yes! Your mother will be pleased. 💕'
                              : 'They said no. Very painful. 😔',
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        // Clear the generated partner and close
                        c.partnerName = '';
                        c.partnerJob = '';
                        c.partnerPersonality = '';
                        c.save();
                        setState(() {});
                        Navigator.pop(ctx);
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        side: const BorderSide(color: Color(0xFFE0E0E0)),
                      ),
                      child: const Text(
                        'Not Interested',
                        style: TextStyle(
                          color: Color(0xFF9E9E9E),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  // ── Divorce confirmation dialog ───────────────────────────────────────────
  void _showDivorceDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Are you sure?', style: TextStyle(fontWeight: FontWeight.w900)),
        content: const Text(
          'Divorce is final. The lawyer will eat. Your happiness will not be the same.',
          style: TextStyle(height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel', style: TextStyle(color: Color(0xFF9E9E9E))),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              RelationshipService.divorce(c);
              setState(() {});
              widget.onCharacterUpdated();
              _snack('You are now divorced. The lawyer got rich. 📄');
            },
            child: const Text('Divorce', style: TextStyle(color: Color(0xFFE53935))),
          ),
        ],
      ),
    );
  }

  // ── UI helpers ────────────────────────────────────────────────────────────
  Widget _infoRow(String label, String value) {
    return Row(
      children: [
        Text(
          '$label: ',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color(0xFF757575),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF424242),
          ),
        ),
      ],
    );
  }

  Widget _pinkButton({required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFFF8BBD0),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              color: Color(0xFFC2185B),
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }

  Widget _redOutlinedButton({required String label, required VoidCallback onTap}) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        side: const BorderSide(color: Color(0xFFE53935)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFFE53935),
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0x0DB39DDB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(5),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }

  // ── Section 1 — Status ────────────────────────────────────────────────────
  Widget _buildStatusSection() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Relationship Status',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF9E9E9E),
                  letterSpacing: 1,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _statusColor(c.relationshipStatus).withAlpha(30),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  c.relationshipStatus,
                  style: TextStyle(
                    color: _statusColor(c.relationshipStatus),
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          if (c.relationshipStatus == 'Dating' ||
              c.relationshipStatus == 'Engaged' ||
              c.relationshipStatus == 'Married') ...[
            const SizedBox(height: 16),
            const Divider(height: 1, color: Color(0xFFF5F5F5)),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8BBD0).withAlpha(80),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Center(
                    child: Text('💕', style: TextStyle(fontSize: 22)),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        c.partnerName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF424242),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        c.partnerJob,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF9E9E9E),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEDE7F6),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          c.partnerPersonality,
                          style: const TextStyle(
                            color: Color(0xFF7E57C2),
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                const Text(
                  'Bond',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF9E9E9E),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: LinearProgressIndicator(
                      value: c.relationshipScore / 100,
                      minHeight: 8,
                      backgroundColor: const Color(0xFFF5F5F5),
                      color: _scoreColor(c.relationshipScore),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  '${c.relationshipScore}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: _scoreColor(c.relationshipScore),
                  ),
                ),
              ],
            ),
            if (c.relationshipStatus == 'Married') ...[
              const SizedBox(height: 10),
              Text(
                'Children: ${c.numberOfChildren}',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF757575),
                ),
              ),
            ],
            if (c.isCheating) ...[
              const SizedBox(height: 8),
              Text(
                '👀 You are seeing ${c.sidePartnerName} on the side. God is watching.',
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFFE53935),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }

  // ── Section 2 — Actions ───────────────────────────────────────────────────
  Widget _buildActionsSection() {
    final status = c.relationshipStatus;

    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Actions',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w900,
              color: Color(0xFF9E9E9E),
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 16),

          // Single
          if (status == 'Single' && c.age >= 16) ...[
            _pinkButton(
              label: 'Meet Someone 💕',
              onTap: _showMeetSomeoneSheet,
            ),
          ],

          // Dating
          if (status == 'Dating') ...[
            if (c.age >= 22 && c.relationshipScore >= 65) ...[
              _pinkButton(
                label: 'Propose 💍',
                onTap: () {
                  final success = RelationshipService.propose(c);
                  setState(() {});
                  widget.onCharacterUpdated();
                  _snack(
                    success
                        ? '${c.partnerName} said yes! Now comes the family meeting. 💍'
                        : 'Not quite ready yet — keep building the relationship.',
                  );
                },
              ),
              const SizedBox(height: 10),
            ],
            _redOutlinedButton(
              label: 'Cheat 👀',
              onTap: () {
                RelationshipService.startCheating(c);
                setState(() {});
                widget.onCharacterUpdated();
                _snack('You started seeing someone on the side. God is watching. 👀');
              },
            ),
            const SizedBox(height: 10),
            _redOutlinedButton(
              label: 'Break Up 💔',
              onTap: () {
                RelationshipService.divorce(c);
                setState(() {});
                widget.onCharacterUpdated();
                _snack('You broke up. It hurts but you will survive. 💔');
              },
            ),
          ],

          // Engaged
          if (status == 'Engaged') ...[
            _pinkButton(
              label: 'Get Married 💒',
              onTap: () {
                RelationshipService.marry(c);
                setState(() {});
                widget.onCharacterUpdated();
                _snack('You are married! The jollof was excellent. 💒');
              },
            ),
            const SizedBox(height: 10),
            _redOutlinedButton(
              label: 'Call Off Engagement',
              onTap: () {
                RelationshipService.divorce(c);
                setState(() {});
                widget.onCharacterUpdated();
                _snack('The engagement is off. The family will be talking for months.');
              },
            ),
          ],

          // Married
          if (status == 'Married') ...[
            if (c.age <= 45) ...[
              _pinkButton(
                label: 'Have a Child 👶',
                onTap: () {
                  RelationshipService.haveChild(c);
                  setState(() {});
                  widget.onCharacterUpdated();
                  _snack('A new life has arrived. The house will never be quiet again. 👶');
                },
              ),
              const SizedBox(height: 10),
            ],
            _redOutlinedButton(
              label: 'Cheat 👀',
              onTap: () {
                RelationshipService.startCheating(c);
                setState(() {});
                widget.onCharacterUpdated();
                _snack('You started seeing someone on the side. God is watching. 👀');
              },
            ),
            const SizedBox(height: 10),
            _redOutlinedButton(
              label: 'Divorce',
              onTap: _showDivorceDialog,
            ),
          ],

          // Divorced — option to look for someone new
          if (status == 'Divorced' && c.age >= 18) ...[
            _pinkButton(
              label: 'Meet Someone New 💕',
              onTap: _showMeetSomeoneSheet,
            ),
          ],

          // No actions available
          if (status == 'Widowed') ...[
            const Text(
              'Take your time. There is no rush.',
              style: TextStyle(
                color: Color(0xFF9E9E9E),
                fontSize: 14,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ── Section 3 — Social Stats ──────────────────────────────────────────────
  Widget _buildStatsSection() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Social Stats',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w900,
              color: Color(0xFF9E9E9E),
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 14),
          _statRow('Reputation', Icons.star, c.reputation, const Color(0xFF7C4DFF)),
          const SizedBox(height: 10),
          _statRow('Happiness', Icons.sentiment_satisfied, c.happiness, const Color(0xFFF06292)),
        ],
      ),
    );
  }

  Widget _statRow(String label, IconData icon, int value, Color color) {
    return Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF757575),
          ),
        ),
        const Spacer(),
        Text(
          '$value',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w800,
            color: color,
          ),
        ),
      ],
    );
  }

  // ── Build ─────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCFAFF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: const Text(
          'Social Life 💕',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: Color(0xFF424242),
            letterSpacing: -0.3,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: const Color(0x1AB39DDB)),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
        children: [
          _buildStatusSection(),
          const SizedBox(height: 16),
          _buildActionsSection(),
          const SizedBox(height: 16),
          _buildStatsSection(),
        ],
      ),
    );
  }
}
