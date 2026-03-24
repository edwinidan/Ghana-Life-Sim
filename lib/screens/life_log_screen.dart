import 'package:flutter/material.dart';
import '../models/character.dart';

class LifeLogScreen extends StatefulWidget {
  final Character character;
  const LifeLogScreen({super.key, required this.character});

  @override
  State<LifeLogScreen> createState() => _LifeLogScreenState();
}

class _LifeLogScreenState extends State<LifeLogScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final log = widget.character.lifeLog;

    return Scaffold(
      backgroundColor: const Color(0xFFFCFAFF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF7E57C2),
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          'Life Log 📖',
          style: TextStyle(
            fontSize: 16.2,
            fontWeight: FontWeight.w900,
            color: Color(0xFF424242),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 0.9, color: const Color(0x33B39DDB)),
        ),
      ),
      floatingActionButton: log.isNotEmpty
          ? FloatingActionButton.small(
              onPressed: _scrollToBottom,
              backgroundColor: const Color(0xFFB39DDB),
              foregroundColor: Colors.white,
              elevation: 2,
              child: const Icon(Icons.keyboard_arrow_down),
            )
          : null,
      body: log.isEmpty
          ? const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('🌱', style: TextStyle(fontSize: 43.2)),
                  SizedBox(height: 14.4),
                  Text(
                    'Nothing has happened yet.',
                    style: TextStyle(
                      fontSize: 14.4,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF757575),
                    ),
                  ),
                  SizedBox(height: 3.6),
                  Text(
                    'Start living.',
                    style: TextStyle(fontSize: 12.6, color: Color(0xFF9E9E9E)),
                  ),
                ],
              ),
            )
          : ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(vertical: 10.8, horizontal: 14.4),
              itemCount: log.length,
              itemBuilder: (context, index) {
                final isEven = index % 2 == 0;
                return Container(
                  margin: const EdgeInsets.only(bottom: 5.4),
                  padding: const EdgeInsets.symmetric(horizontal: 14.4, vertical: 10.8),
                  decoration: BoxDecoration(
                    color: isEven ? Colors.white : const Color(0xFFF3E5F5),
                    borderRadius: BorderRadius.circular(9.7),
                    border: Border.all(color: const Color(0x0DB39DDB)),
                  ),
                  child: Text(
                    log[index],
                    style: const TextStyle(
                      fontSize: 11.7,
                      color: Color(0xFF616161),
                      height: 1.5,
                    ),
                  ),
                );
              },
            ),
    );
  }
}
