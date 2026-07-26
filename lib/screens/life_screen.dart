import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app/theme/app_theme.dart';
import '../domain/models/timeline_entry.dart';
import '../domain/models/financial_transaction.dart';
import '../domain/repositories/financial_ledger_repository.dart';
import '../features/life_timeline/life_controller.dart';
import '../models/character.dart';
import '../models/event.dart';
import '../services/activity_service.dart';
import '../services/settings_service.dart';
import 'achievements_screen.dart';
import 'business_screen.dart';
import 'death_screen.dart';
import 'housing_screen.dart';
import 'health_screen.dart';
import 'job_screen.dart';
import 'life_log_screen.dart';
import 'school_screen.dart';
import 'settings_screen.dart';
import 'social_screen.dart';

class LifeScreen extends ConsumerStatefulWidget {
  const LifeScreen({super.key, required this.character});

  final Character character;

  @override
  ConsumerState<LifeScreen> createState() => _LifeScreenState();
}

class _LifeScreenState extends ConsumerState<LifeScreen> {
  int _destination = 0;
  bool _handlingAge = false;

  Character get character =>
      ref.read(lifeControllerProvider(widget.character)).character;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(lifeControllerProvider(widget.character));
    final bodies = [
      _LifeTimelineView(state: state, onProfile: _showProfile),
      _PeopleView(
        character: state.character,
        open: _open,
        onUpdated: _persistExternalMutation,
      ),
      _ActivitiesView(
        character: state.character,
        open: _open,
        onActivity: _performActivity,
        onUpdated: _persistExternalMutation,
      ),
      _AssetsView(
        character: state.character,
        open: _open,
        onUpdated: _persistExternalMutation,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 20,
        title: const Text(
          'GHANA LIFE',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 17,
            letterSpacing: 0.8,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            tooltip: 'More',
            onSelected: _handleMenu,
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'profile', child: Text('Profile')),
              PopupMenuItem(value: 'log', child: Text('Full life log')),
              PopupMenuItem(
                value: 'achievements',
                child: Text('Achievements & legacy'),
              ),
              PopupMenuItem(value: 'settings', child: Text('Settings')),
            ],
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: SafeArea(
        top: false,
        child: AnimatedSwitcher(
          duration:
              SettingsService.reducedMotion.value ||
                  MediaQuery.disableAnimationsOf(context)
              ? Duration.zero
              : const Duration(milliseconds: 180),
          child: KeyedSubtree(
            key: ValueKey(_destination),
            child: bodies[_destination],
          ),
        ),
      ),
      bottomNavigationBar: _LifeNavigation(
        selected: _destination,
        isAgeing: state.isBusy || _handlingAge,
        onDestination: (value) => setState(() => _destination = value),
        onAge: _ageUp,
      ),
    );
  }

  Future<void> _ageUp() async {
    if (_handlingAge) return;
    setState(() => _handlingAge = true);
    if (SettingsService.hapticsEnabled.value) {
      HapticFeedback.mediumImpact();
    }
    final provider = lifeControllerProvider(widget.character);
    final controller = ref.read(provider.notifier);
    await controller.ageUp();

    if (!mounted) return;
    var state = ref.read(provider);
    if (state.errorMessage != null) {
      _snack(state.errorMessage!);
    }

    while (mounted && state.currentDecision != null) {
      final event = state.currentDecision!;
      final choice = await _showDecision(event);
      if (choice == null) break;
      await controller.choose(choice);
      if (!mounted) return;
      if (SettingsService.hapticsEnabled.value) {
        HapticFeedback.selectionClick();
      }
      await _showOutcome(event, choice);
      state = ref.read(provider);
    }

    if (mounted) {
      setState(() {
        _handlingAge = false;
        _destination = 0;
      });
      _goToDeathIfNeeded();
    }
  }

  Future<EventChoice?> _showDecision(LifeEvent event) {
    return showModalBottomSheet<EventChoice>(
      context: context,
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      builder: (context) => SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            20,
            4,
            20,
            20 + MediaQuery.viewInsetsOf(context).bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'AGE ${character.age}',
                style: const TextStyle(
                  color: AppColors.green,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                event.title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 10),
              Text(event.description),
              const SizedBox(height: 20),
              ...event.choices.map(
                (choice) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context, choice),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.cocoa,
                      alignment: Alignment.centerLeft,
                      minimumSize: const Size.fromHeight(52),
                      side: const BorderSide(color: AppColors.divider),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(choice.text),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showOutcome(LifeEvent event, EventChoice choice) {
    final state = ref.read(lifeControllerProvider(widget.character));
    final entry = state.timeline.where(
      (entry) =>
          entry.sourceEventId == event.stableId &&
          entry.type == TimelineEntryType.outcome,
    );
    final deltas = entry.isEmpty ? <TimelineDelta>[] : entry.first.deltas;
    return showModalBottomSheet<void>(
      context: context,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.auto_stories_outlined,
                color: AppColors.gold,
                size: 32,
              ),
              const SizedBox(height: 12),
              Text(
                'What happened',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(choice.outcome),
              if (deltas.isNotEmpty) ...[
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: deltas.map(_DeltaChip.new).toList(),
                ),
              ],
              const SizedBox(height: 20),
              FilledButton(
                onPressed: () => Navigator.pop(context),
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                ),
                child: const Text('Continue'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _performActivity(ActivityOption option) async {
    final result = ActivityService.performActivity(character, option);
    await ref.read(lifeControllerProvider(widget.character).notifier).refresh();
    if (!mounted) return;
    if (result.success && SettingsService.hapticsEnabled.value) {
      HapticFeedback.lightImpact();
    }
    _snack(result.message);
  }

  void _persistExternalMutation() {
    ref
        .read(lifeControllerProvider(widget.character).notifier)
        .persistExternalMutation();
  }

  void _goToDeathIfNeeded() {
    if (!character.isDead) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => DeathScreen(character: character)),
    );
  }

  Future<void> _open(Widget screen) async {
    await Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
    if (!mounted) return;
    await ref.read(lifeControllerProvider(widget.character).notifier).refresh();
  }

  void _handleMenu(String value) {
    switch (value) {
      case 'profile':
        _showProfile();
        return;
      case 'log':
        _open(LifeLogScreen(character: character));
        return;
      case 'achievements':
        _open(const AchievementsScreen());
        return;
      case 'settings':
        _open(const SettingsScreen());
        return;
    }
  }

  void _showProfile() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.72,
        minChildSize: 0.45,
        maxChildSize: 0.92,
        builder: (context, controller) => ListView(
          controller: controller,
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 28),
          children: [
            Text(
              character.name,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              'Age ${character.age} · ${character.lifeStage}',
              style: const TextStyle(color: AppColors.green),
            ),
            const SizedBox(height: 20),
            _ProfileStat('Reputation', character.reputation),
            _ProfileStat('Discipline', character.discipline),
            _ProfileStat('Street sense', character.streetSense),
            _ProfileStat('Connections', character.connections),
            _ProfileStat('Financial stability', character.money),
            const Divider(height: 28),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Born'),
              subtitle: Text(
                '${character.birthRegion} · ${character.birthYear}',
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Household background'),
              subtitle: Text(character.householdClass),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Current home'),
              subtitle: Text(character.housingStatus),
            ),
          ],
        ),
      ),
    );
  }

  void _snack(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }
}

class _LifeTimelineView extends StatelessWidget {
  const _LifeTimelineView({required this.state, required this.onProfile});

  final LifeState state;
  final VoidCallback onProfile;

  @override
  Widget build(BuildContext context) {
    final character = state.character;
    return CustomScrollView(
      key: const PageStorageKey('life-timeline'),
      slivers: [
        SliverToBoxAdapter(
          child: InkWell(
            onTap: onProfile,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 14),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: AppColors.gold.withValues(alpha: 0.18),
                    child: Text(
                      _avatar(character),
                      style: const TextStyle(fontSize: 28),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          character.name,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Age ${character.age} · ${character.lifeStage}',
                          style: const TextStyle(color: AppColors.muted),
                        ),
                        Text(
                          _status(character),
                          style: const TextStyle(
                            color: AppColors.green,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right, color: AppColors.muted),
                ],
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(child: _PrimaryStats(character: character)),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 22, 20, 8),
          sliver: SliverToBoxAdapter(
            child: Row(
              children: [
                Text(
                  'Your life',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const Spacer(),
                Text(
                  _ghs(character.cash),
                  style: const TextStyle(
                    color: AppColors.green,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (state.timeline.isEmpty)
          const SliverFillRemaining(
            hasScrollBody: false,
            child: Center(child: Text('Your story begins here.')),
          )
        else
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 6, 20, 28),
            sliver: SliverList.builder(
              itemCount: state.timeline.length,
              itemBuilder: (context, index) {
                final entry = state.timeline[index];
                return _TimelineCard(
                  entry: entry,
                  transactions: entry.type == TimelineEntryType.finance
                      ? const FinancialLedgerRepository().read(
                          character,
                          age: entry.age,
                        )
                      : const [],
                );
              },
            ),
          ),
      ],
    );
  }

  static String _avatar(Character character) {
    if (character.age < 3) return '👶';
    if (character.age < 13) return '🧒';
    if (character.age < 18) return character.gender == 'Male' ? '👦' : '👧';
    if (character.age < 60) return character.gender == 'Male' ? '👨' : '👩';
    return character.gender == 'Male' ? '👴' : '👵';
  }

  static String _status(Character character) {
    if (character.isEnrolled) return character.enrolledIn;
    if (character.careerPath != 'None') return character.careerPath;
    if (character.age < 18) return 'Growing up';
    return 'Unemployed';
  }
}

class _PrimaryStats extends StatelessWidget {
  const _PrimaryStats({required this.character});

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Primary character statistics',
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.divider),
        ),
        child: Row(
          children: [
            _CompactStat(
              'Happy',
              character.happiness,
              Icons.sentiment_satisfied,
            ),
            _CompactStat('Health', character.health, Icons.favorite_outline),
            _CompactStat('Smarts', character.smarts, Icons.psychology_outlined),
            _CompactStat('Looks', character.looks, Icons.auto_awesome_outlined),
          ],
        ),
      ),
    );
  }
}

class _CompactStat extends StatelessWidget {
  const _CompactStat(this.label, this.value, this.icon);

  final String label;
  final int value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Semantics(
        label: '$label, $value out of 100',
        child: Column(
          children: [
            Icon(icon, size: 18, color: AppColors.green),
            const SizedBox(height: 5),
            Text('$value', style: const TextStyle(fontWeight: FontWeight.w800)),
            Text(label, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}

class _TimelineCard extends StatelessWidget {
  const _TimelineCard({required this.entry, this.transactions = const []});

  final TimelineEntry entry;
  final List<FinancialTransaction> transactions;

  @override
  Widget build(BuildContext context) {
    final accent = switch (entry.type) {
      TimelineEntryType.birth || TimelineEntryType.milestone => AppColors.gold,
      TimelineEntryType.finance => AppColors.green,
      TimelineEntryType.health || TimelineEntryType.death => AppColors.red,
      _ => AppColors.divider,
    };
    return Semantics(
      header: entry.type == TimelineEntryType.milestone,
      label: 'Age ${entry.age}. ${entry.title}. ${entry.body}',
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: accent,
              width: accent == AppColors.divider ? 1 : 2,
            ),
          ),
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'AGE ${entry.age}',
                    style: const TextStyle(
                      color: AppColors.muted,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      entry.title,
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 7),
              Text(entry.body),
              if (entry.deltas.isNotEmpty) ...[
                const SizedBox(height: 11),
                Wrap(
                  spacing: 7,
                  runSpacing: 7,
                  children: entry.deltas.map(_DeltaChip.new).toList(),
                ),
              ],
              if (entry.type == TimelineEntryType.finance &&
                  transactions.isNotEmpty) ...[
                const SizedBox(height: 6),
                TextButton.icon(
                  onPressed: () => _showLedger(context),
                  icon: const Icon(Icons.receipt_long_outlined, size: 18),
                  label: const Text('View full yearly ledger'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _showLedger(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.62,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        builder: (context, controller) => ListView(
          controller: controller,
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 28),
          children: [
            Text(
              'Age ${entry.age} · Year in Review',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),
            ...transactions.map(
              (transaction) => ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(transaction.description),
                subtitle: Text(transaction.category.name),
                trailing: Text(
                  _signedGhs(transaction.amount),
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: transaction.amount >= 0
                        ? AppColors.green
                        : AppColors.red,
                  ),
                ),
              ),
            ),
            const Divider(),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text(
                'Net cash change',
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
              trailing: Text(
                _signedGhs(
                  transactions.fold<int>(
                    0,
                    (sum, transaction) => sum + transaction.amount,
                  ),
                ),
                style: const TextStyle(fontWeight: FontWeight.w900),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DeltaChip extends StatelessWidget {
  const _DeltaChip(this.delta);

  final TimelineDelta delta;

  @override
  Widget build(BuildContext context) {
    final positive = delta.amount >= 0;
    final color = positive ? AppColors.green : AppColors.red;
    final amount = delta.isCurrency
        ? 'GHS ${delta.amount.abs()}'
        : '${delta.amount.abs()}';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.09),
        borderRadius: BorderRadius.circular(99),
      ),
      child: Text(
        '${delta.label} ${positive ? '+' : '−'}$amount',
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _PeopleView extends StatelessWidget {
  const _PeopleView({
    required this.character,
    required this.open,
    required this.onUpdated,
  });

  final Character character;
  final Future<void> Function(Widget screen) open;
  final VoidCallback onUpdated;

  @override
  Widget build(BuildContext context) {
    final hasPartner = character.partnerName.isNotEmpty;
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
      children: [
        Text('People', style: Theme.of(context).textTheme.displaySmall),
        const SizedBox(height: 6),
        const Text('The relationships shaping your story.'),
        const SizedBox(height: 22),
        _CategoryRow(
          icon: Icons.favorite_outline,
          title: hasPartner ? character.partnerName : 'Romance',
          subtitle: hasPartner
              ? '${character.relationshipStatus} · Bond ${character.relationshipScore}'
              : character.age < 16
              ? 'Unlocks during your teenage years'
              : 'Meet someone through your life',
          enabled: character.age >= 16,
          onTap: () => open(
            SocialScreen(character: character, onCharacterUpdated: onUpdated),
          ),
        ),
        const _SectionLabel('FAMILY'),
        ...List.generate(character.familyNames.length, (index) {
          final alive =
              index >= character.familyAlive.length ||
              character.familyAlive[index];
          return _CategoryRow(
            icon: alive ? Icons.person_outline : Icons.person_off_outlined,
            title: character.familyNames[index],
            subtitle:
                '${character.familyRelations[index]} · '
                '${alive ? 'Age ${character.familyAges[index]}' : 'Remembered'} · '
                'Bond ${character.familyBondScores[index]}',
          );
        }),
        if (character.childNames.isNotEmpty) ...[
          const _SectionLabel('CHILDREN'),
          ...List.generate(
            character.childNames.length,
            (index) => _CategoryRow(
              icon: Icons.child_care,
              title: character.childNames[index],
              subtitle:
                  'Age ${character.childAges[index]} · '
                  'Bond ${character.childBondScores[index]}',
            ),
          ),
        ],
      ],
    );
  }
}

class _ActivitiesView extends StatelessWidget {
  const _ActivitiesView({
    required this.character,
    required this.open,
    required this.onActivity,
    required this.onUpdated,
  });

  final Character character;
  final Future<void> Function(Widget screen) open;
  final Future<void> Function(ActivityOption option) onActivity;
  final VoidCallback onUpdated;

  @override
  Widget build(BuildContext context) {
    final activities = ActivityService.availableActivities(character);
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
      children: [
        Text('Activities', style: Theme.of(context).textTheme.displaySmall),
        const SizedBox(height: 6),
        Text(
          'Time This Year: ${character.actionEnergy}',
          style: const TextStyle(
            color: AppColors.green,
            fontWeight: FontWeight.w700,
          ),
        ),
        const _SectionLabel('MIND & EDUCATION'),
        _CategoryRow(
          icon: Icons.school_outlined,
          title: 'Education',
          subtitle: character.isEnrolled
              ? '${character.enrolledIn} · ${character.yearsLeftInSchool} years left'
              : 'School, training, examinations and qualifications',
          onTap: () => open(
            SchoolScreen(character: character, onCharacterUpdated: onUpdated),
          ),
        ),
        const _SectionLabel('THIS YEAR'),
        _CategoryRow(
          icon: Icons.health_and_safety_outlined,
          title: 'Health & treatment',
          subtitle: character.activeIllnesses.isEmpty
              ? 'Check your health and active conditions'
              : '${character.activeIllnesses.length} active condition(s)',
          onTap: () => open(
            HealthScreen(character: character, onCharacterUpdated: onUpdated),
          ),
        ),
        ...activities.map((activity) {
          final cashCost = ActivityService.cashCostFor(character, activity);
          return _CategoryRow(
            leadingText: activity.emoji,
            title: activity.title,
            subtitle:
                '${activity.subtitle}'
                '${cashCost > 0 ? ' · GHS $cashCost' : ''}',
            enabled: character.actionEnergy > 0 && character.cash >= cashCost,
            onTap: () => onActivity(activity),
          );
        }),
      ],
    );
  }
}

class _AssetsView extends StatelessWidget {
  const _AssetsView({
    required this.character,
    required this.open,
    required this.onUpdated,
  });

  final Character character;
  final Future<void> Function(Widget screen) open;
  final VoidCallback onUpdated;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
      children: [
        Text('Assets', style: Theme.of(context).textTheme.displaySmall),
        const SizedBox(height: 6),
        Text(
          '${_ghs(character.cash)} available'
          '${character.debt > 0 ? ' · ${_ghs(character.debt)} debt' : ''}',
        ),
        const _SectionLabel('WORK & INCOME'),
        _CategoryRow(
          icon: Icons.work_outline,
          title: 'Job & side gigs',
          subtitle: character.careerPath == 'None'
              ? 'Unemployed · Browse eligible openings'
              : '${character.careerPath} · ${_ghs(character.monthlyIncome)}/month',
          enabled: character.age >= 15,
          onTap: () => open(
            JobScreen(character: character, onCharacterUpdated: onUpdated),
          ),
        ),
        const _SectionLabel('HOME & BUSINESS'),
        _CategoryRow(
          icon: Icons.home_outlined,
          title: 'Housing',
          subtitle: character.housingStatus,
          enabled: character.age >= 18,
          onTap: () => open(
            HousingScreen(character: character, onCharacterUpdated: onUpdated),
          ),
        ),
        _CategoryRow(
          icon: Icons.storefront_outlined,
          title: 'Businesses',
          subtitle: character.businessNames.isEmpty
              ? 'No businesses yet'
              : '${character.businessNames.length} active · '
                    '${_ghs(character.totalBusinessIncome)}/month',
          enabled: character.age >= 18,
          onTap: () => open(
            BusinessScreen(character: character, onCharacterUpdated: onUpdated),
          ),
        ),
      ],
    );
  }
}

class _CategoryRow extends StatelessWidget {
  const _CategoryRow({
    this.icon,
    this.leadingText,
    required this.title,
    required this.subtitle,
    this.enabled = true,
    this.onTap,
  });

  final IconData? icon;
  final String? leadingText;
  final String title;
  final String subtitle;
  final bool enabled;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1 : 0.55,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
        leading: SizedBox(
          width: 38,
          height: 38,
          child: Center(
            child: leadingText != null
                ? Text(leadingText!, style: const TextStyle(fontSize: 23))
                : Icon(icon, color: AppColors.green),
          ),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
        subtitle: Text(subtitle),
        trailing: onTap == null
            ? null
            : const Icon(Icons.chevron_right, color: AppColors.muted),
        onTap: enabled ? onTap : null,
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 4),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.muted,
          fontSize: 11,
          fontWeight: FontWeight.w900,
          letterSpacing: 1,
        ),
      ),
    );
  }
}

class _ProfileStat extends StatelessWidget {
  const _ProfileStat(this.label, this.value);

  final String label;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Semantics(
        label: '$label, $value out of 100',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: Text(label)),
                Text(
                  '$value',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ],
            ),
            const SizedBox(height: 6),
            LinearProgressIndicator(
              value: value / 100,
              minHeight: 7,
              borderRadius: BorderRadius.circular(99),
              color: AppColors.green,
              backgroundColor: AppColors.divider,
            ),
          ],
        ),
      ),
    );
  }
}

class _LifeNavigation extends StatelessWidget {
  const _LifeNavigation({
    required this.selected,
    required this.isAgeing,
    required this.onDestination,
    required this.onAge,
  });

  final int selected;
  final bool isAgeing;
  final ValueChanged<int> onDestination;
  final VoidCallback onAge;

  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.textScalerOf(context).scale(10) / 10;
    return Material(
      elevation: 12,
      color: AppColors.surface,
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 76 + ((textScale - 1).clamp(0, 1) * 20),
          child: Row(
            children: [
              _NavItem(
                label: 'Life',
                icon: Icons.auto_stories_outlined,
                selected: selected == 0,
                onTap: () => onDestination(0),
              ),
              _NavItem(
                label: 'People',
                icon: Icons.people_outline,
                selected: selected == 1,
                onTap: () => onDestination(1),
              ),
              Expanded(
                child: Semantics(
                  button: true,
                  label: 'Age up one year',
                  child: InkWell(
                    onTap: isAgeing ? null : onAge,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColors.green,
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.gold, width: 3),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.green.withValues(alpha: 0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: isAgeing
                              ? const Padding(
                                  padding: EdgeInsets.all(14),
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 29,
                                ),
                        ),
                        const Text(
                          'AGE',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              _NavItem(
                label: 'Activities',
                icon: Icons.explore_outlined,
                selected: selected == 2,
                onTap: () => onDestination(2),
              ),
              _NavItem(
                label: 'Assets',
                icon: Icons.account_balance_wallet_outlined,
                selected: selected == 3,
                onTap: () => onDestination(3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.green : AppColors.muted;
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 3),
            Text(
              label,
              maxLines: 1,
              style: TextStyle(
                color: color,
                fontSize: 10,
                fontWeight: selected ? FontWeight.w800 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String _ghs(int value) {
  final formatted = value.toString().replaceAllMapped(
    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
    (match) => '${match[1]},',
  );
  return 'GHS $formatted';
}

String _signedGhs(int value) {
  final amount = _ghs(value.abs());
  if (value < 0) return '-$amount';
  if (value > 0) return '+$amount';
  return amount;
}
