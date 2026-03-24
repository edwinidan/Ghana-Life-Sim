import 'package:flutter/material.dart';
import '../models/character.dart';
import '../data/businesses.dart';
import '../services/business_service.dart';

class BusinessScreen extends StatefulWidget {
  final Character character;
  final VoidCallback onCharacterUpdated;

  const BusinessScreen({
    super.key,
    required this.character,
    required this.onCharacterUpdated,
  });

  @override
  State<BusinessScreen> createState() => _BusinessScreenState();
}

class _BusinessScreenState extends State<BusinessScreen> {
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

  String _fmt(int n) => n.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (m) => '${m[1]},',
      );

  String _emojiForType(String typeName) {
    switch (typeName) {
      case 'Chop Bar':
        return '🍲';
      case 'Barbershop / Salon':
        return '✂️';
      case 'Poultry Farm':
        return '🐔';
      case 'Clothing / Fashion':
        return '👗';
      case 'Provisions Shop':
        return '🛒';
      case 'Transport (Trotro/Taxi)':
        return '🚐';
      default:
        return '💼';
    }
  }

  // ── My Businesses ─────────────────────────────────────────────────────────

  Widget _buildMyBusinesses() {
    final c = widget.character;
    final businesses = c.businessNames;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'MY BUSINESSES',
          style: TextStyle(
            fontSize: 11.7,
            fontWeight: FontWeight.w900,
            color: Color(0xFF9E9E9E),
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 10.8),
        if (businesses.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(11.3),
              border: Border.all(color: Colors.black.withOpacity(0.05)),
            ),
            child: const Text(
              "You don't own any businesses yet. Start one below.",
              style: TextStyle(
                fontSize: 11.7,
                color: Color(0xFF9E9E9E),
                fontStyle: FontStyle.italic,
              ),
            ),
          )
        else ...[
          ...List.generate(businesses.length, (i) => _buildBusinessCard(i)),
          const SizedBox(height: 3.6),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14.4, vertical: 10.8),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(8.1),
            ),
            child: Text(
              'Total income: GHS ${_fmt(c.totalBusinessIncome)}/month',
              style: const TextStyle(
                fontSize: 12.6,
                fontWeight: FontWeight.w900,
                color: Color(0xFF2E7D32),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildBusinessCard(int index) {
    final c = widget.character;
    final name = c.businessNames[index];
    final type = c.businessTypes[index];
    final health = c.businessHealthList[index];
    final income = c.businessIncomeList[index];

    Color healthColor;
    if (health >= 60) {
      healthColor = const Color(0xFF4CAF50);
    } else if (health >= 30) {
      healthColor = const Color(0xFFFF9800);
    } else {
      healthColor = const Color(0xFFF44336);
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.6),
      child: Container(
        padding: const EdgeInsets.all(14.4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(11.3),
          border: Border.all(color: const Color(0x0DB39DDB)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(_emojiForType(type),
                    style: const TextStyle(fontSize: 21.6)),
                const SizedBox(width: 9),
                Expanded(
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF424242),
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7.2, vertical: 2.7),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(4.9),
                  ),
                  child: Text(
                    type,
                    style: const TextStyle(
                        fontSize: 9, color: Color(0xFF9E9E9E)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.8),
            Row(
              children: [
                const Text(
                  'Health  ',
                  style: TextStyle(fontSize: 10.8, color: Color(0xFF757575)),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        height: 7.2,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(6.5),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: health / 100,
                        child: Container(
                          height: 7.2,
                          decoration: BoxDecoration(
                            color: healthColor,
                            borderRadius: BorderRadius.circular(6.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 7.2),
                Text(
                  '$health%',
                  style: TextStyle(
                    fontSize: 10.8,
                    fontWeight: FontWeight.w700,
                    color: healthColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 7.2),
            Text(
              'Income: GHS ${_fmt(income)}/month',
              style: const TextStyle(
                fontSize: 11.7,
                color: Color(0xFF009688),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10.8),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 7.2),
                      side: const BorderSide(color: Color(0xFFB2DFDB)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.5)),
                    ),
                    onPressed: () {
                      if (widget.character.money < 3) {
                        _showSnack('Not enough money. Need 3 units.');
                        return;
                      }
                      BusinessService.investInBusiness(
                          widget.character, index, 1);
                      _refresh();
                      _showSnack('Small investment made in $name. 💰');
                    },
                    child: const Text(
                      'Invest Small 💰 (-3)',
                      style:
                          TextStyle(fontSize: 10.8, color: Color(0xFF009688)),
                    ),
                  ),
                ),
                const SizedBox(width: 7.2),
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 7.2),
                      side: const BorderSide(color: Color(0xFFB39DDB)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.5)),
                    ),
                    onPressed: () {
                      if (widget.character.money < 8) {
                        _showSnack('Not enough money. Need 8 units.');
                        return;
                      }
                      BusinessService.investInBusiness(
                          widget.character, index, 2);
                      _refresh();
                      _showSnack('Big investment in $name! 💰💰');
                    },
                    child: const Text(
                      'Invest Big 💰💰 (-8)',
                      style:
                          TextStyle(fontSize: 10.8, color: Color(0xFF7E57C2)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 7.2),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 7.2),
                  side: BorderSide(color: Colors.red.shade300),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.5)),
                ),
                onPressed: () => _confirmClose(index, name),
                child: Text(
                  'Close Business',
                  style: TextStyle(fontSize: 10.8, color: Colors.red.shade400),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmClose(int index, String name) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        title: const Text('Close Business?'),
        content: Text(
          'Are you sure you want to close $name? You\'ll get a small refund of 5 money units but your hustle ends here.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade400,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.5)),
            ),
            onPressed: () {
              Navigator.of(ctx).pop();
              BusinessService.closeBusiness(widget.character, index);
              _refresh();
              _showSnack('$name has been closed. A chapter ends. 🏳️');
            },
            child: const Text('Close It'),
          ),
        ],
      ),
    );
  }

  // ── Start a Business ──────────────────────────────────────────────────────

  Widget _buildStartBusiness() {
    final available =
        BusinessService.getAvailableBusinessTypes(widget.character);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'START A BUSINESS',
          style: TextStyle(
            fontSize: 11.7,
            fontWeight: FontWeight.w900,
            color: Color(0xFF9E9E9E),
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 10.8),
        if (available.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14.4),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(9.7),
            ),
            child: const Text(
              "You don't qualify for any businesses yet. Build your stats and money.",
              style: TextStyle(
                fontSize: 11.7,
                color: Color(0xFF9E9E9E),
                fontStyle: FontStyle.italic,
              ),
            ),
          )
        else
          ...available.map((type) => _buildBusinessTypeCard(type)),
      ],
    );
  }

  Widget _buildBusinessTypeCard(BusinessType type) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.6),
      child: Container(
        padding: const EdgeInsets.all(14.4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(11.3),
          border: Border.all(color: const Color(0x0DB39DDB)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(type.emoji, style: const TextStyle(fontSize: 25.2)),
                const SizedBox(width: 9),
                Text(
                  type.name,
                  style: const TextStyle(
                    fontSize: 14.4,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF424242),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 7.2),
            Text(
              type.description,
              style: const TextStyle(
                fontSize: 11.7,
                color: Color(0xFF757575),
                fontStyle: FontStyle.italic,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 9),
            Row(
              children: [
                const Icon(Icons.payments_outlined,
                    size: 12.6, color: Color(0xFF9E9E9E)),
                const SizedBox(width: 3.6),
                Text(
                  'Startup: ${type.startupCost} money units',
                  style: const TextStyle(
                      fontSize: 10.8, color: Color(0xFF9E9E9E)),
                ),
                const SizedBox(width: 14.4),
                const Icon(Icons.trending_up,
                    size: 12.6, color: Color(0xFF009688)),
                const SizedBox(width: 3.6),
                Text(
                  'GHS ${_fmt(type.baseMonthlyIncome)}/mo',
                  style: const TextStyle(
                    fontSize: 10.8,
                    color: Color(0xFF009688),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB2DFDB),
                  foregroundColor: const Color(0xFF00695C),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 10.8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.1)),
                ),
                onPressed: () => _showStartBusinessDialog(type),
                child: const Text(
                  'Start This Business',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showStartBusinessDialog(BusinessType type) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        title: Text('Name Your ${type.name} ${type.emoji}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Give your business a name the whole neighbourhood will remember.',
              style: TextStyle(fontSize: 11.7, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 10.8),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "e.g. Kofi's ${type.name}",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.1)),
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10.8, vertical: 9),
              ),
              textCapitalization: TextCapitalization.words,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFB2DFDB),
              foregroundColor: const Color(0xFF00695C),
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.5)),
            ),
            onPressed: () {
              final name = controller.text.trim();
              if (name.isEmpty) {
                _showSnack('Please give your business a name first.');
                return;
              }
              Navigator.of(ctx).pop();
              BusinessService.startBusiness(widget.character, type, name);
              _refresh();
              _showSnack(
                  'Welcome to the business world! $name is now open. ${type.emoji}');
            },
            child: const Text('Open for Business!'),
          ),
        ],
      ),
    );
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCFAFF),
      appBar: AppBar(
        title: const Text(
          'My Businesses 💼',
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
            _buildMyBusinesses(),
            const SizedBox(height: 25.2),
            _buildStartBusiness(),
            const SizedBox(height: 36),
          ],
        ),
      ),
    );
  }
}
