import 'package:flutter/material.dart';
import '../models/character.dart';
import '../services/housing_service.dart';

class HousingScreen extends StatefulWidget {
  final Character character;
  final VoidCallback onCharacterUpdated;

  const HousingScreen({
    super.key,
    required this.character,
    required this.onCharacterUpdated,
  });

  @override
  State<HousingScreen> createState() => _HousingScreenState();
}

class _HousingScreenState extends State<HousingScreen> {
  void _refresh() {
    setState(() {});
    widget.onCharacterUpdated();
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.1)),
      ),
    );
  }

  Widget _buildStatusCard() {
    final status = widget.character.housingStatus;

    Color cardColor;
    String emoji;
    String subtitle;

    if (status == 'Homeowner') {
      cardColor = const Color(0xFFFFF8E1);
      emoji = '🏡';
      subtitle = 'You own this. Your mother is proud.';
    } else if (status == 'Renting') {
      cardColor = const Color(0xFFE0F2F1);
      emoji = '🏠';
      subtitle =
          'Paying ${widget.character.rentExpensePerYear} money units/year in rent. The landlord is always watching.';
    } else {
      cardColor = const Color(0xFFF5F5F5);
      emoji = '🏘️';
      subtitle = 'Living with your parents. Rent free. Dignity: optional.';
    }

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: Colors.black.withOpacity(0.06)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 36)),
          const SizedBox(width: 14.4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  status,
                  style: const TextStyle(
                    fontSize: 16.2,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF424242),
                  ),
                ),
                const SizedBox(height: 5.4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 11.7,
                    color: Color(0xFF757575),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActions() {
    final c = widget.character;
    final canMoveOut = HousingService.canMoveOut(c);
    final canBuyHome = HousingService.canBuyHome(c);

    if (canMoveOut) {
      return _actionButton(
        label: 'Move Out 🏠',
        subtitle: 'Costs 5 money units (deposit)',
        color: const Color(0xFFB39DDB),
        onTap: () {
          HousingService.moveOut(c);
          _refresh();
          _showSnack('You moved out! Freedom and rent — together at last.');
        },
      );
    } else if (canBuyHome) {
      return _actionButton(
        label: 'Buy a Home 🏡',
        subtitle: 'Costs 20 money units (down payment)',
        color: const Color(0xFFFFB300),
        onTap: () {
          HousingService.buyHome(c);
          _refresh();
          _showSnack(
              'Congratulations! You are now a homeowner. Your mother is already planning her room.');
        },
      );
    } else {
      // Show why not
      String reason;
      if (c.housingStatus == 'With Parents') {
        if (c.age < 18) {
          reason = 'You need to be at least 18 to move out.';
        } else if (c.money < 15) {
          reason =
              'You need at least 15 money units to cover the deposit. Keep saving.';
        } else {
          reason = 'You are already living independently.';
        }
      } else if (c.housingStatus == 'Renting') {
        if (c.age < 28) {
          reason =
              'You need to be at least 28 to buy a home. (Age ${c.age} now)';
        } else if (c.money < 60) {
          reason =
              'You need at least 60 money units for the down payment. (You have ${c.money})';
        } else {
          reason = 'Keep saving — homeownership is within reach.';
        }
      } else {
        reason = 'You already own your home. Well done. 🏡';
      }

      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14.4),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(9.7),
          border: Border.all(color: Colors.black.withOpacity(0.05)),
        ),
        child: Text(
          reason,
          style: const TextStyle(
            fontSize: 11.7,
            color: Color(0xFF9E9E9E),
            fontStyle: FontStyle.italic,
            height: 1.4,
          ),
        ),
      );
    }
  }

  Widget _actionButton({
    required String label,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.2),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(11.3),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.4),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 14.4,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 3.6),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 10.8,
                color: Colors.white.withOpacity(0.85),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCFAFF),
      appBar: AppBar(
        title: const Text(
          'Housing 🏠',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 16.2,
            color: Color(0xFF424242),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFFB39DDB)),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 0.9, color: const Color(0x33B39DDB)),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Current Status',
              style: TextStyle(
                fontSize: 11.7,
                fontWeight: FontWeight.w900,
                color: Color(0xFF9E9E9E),
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 10.8),
            _buildStatusCard(),
            const SizedBox(height: 21.6),
            const Text(
              'Actions',
              style: TextStyle(
                fontSize: 11.7,
                fontWeight: FontWeight.w900,
                color: Color(0xFF9E9E9E),
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 10.8),
            _buildActions(),
          ],
        ),
      ),
    );
  }
}
