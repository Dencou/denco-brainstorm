import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/ideas_entity.dart';
import '../cubits/ideas_cubit/ideas_cubit.dart';
import '../pages/ideas_detail_page.dart';

class IdeasListWidget extends StatelessWidget {
  final List<IdeaEntity> ideas;

  const IdeasListWidget({super.key, required this.ideas});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 100),
      itemCount: ideas.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) => _IdeaCard(idea: ideas[index]),
    );
  }
}

class _IdeaCard extends StatelessWidget {
  final IdeaEntity idea;

  const _IdeaCard({required this.idea});

  Color _getCategoryColor(IdeaCategory category) {
    return switch (category) {
      IdeaCategory.tech => Colors.blueAccent,
      IdeaCategory.product => Colors.orangeAccent,
      IdeaCategory.culture => Colors.green,
      IdeaCategory.random => Colors.purpleAccent,
    };
  }

  IconData _getCategoryIcon(IdeaCategory category) {
    return switch (category) {
      IdeaCategory.tech => Icons.terminal_rounded,
      IdeaCategory.product => Icons.rocket_launch_rounded,
      IdeaCategory.culture => Icons.coffee_rounded,
      IdeaCategory.random => Icons.lightbulb_rounded,
    };
  }

  @override
  Widget build(BuildContext context) {
    final catColor = _getCategoryColor(idea.category);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => {
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (_) => IdeaDetailPage(idea: idea)),
            )
          },
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: catColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          Icon(_getCategoryIcon(idea.category), size: 14, color: catColor),
                          const SizedBox(width: 6),
                          Text(
                            idea.category.name.toUpperCase(),
                            style: TextStyle(
                              color: catColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          context.read<IdeasCubit>().voteIdea(idea.id);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.thumb_up_rounded, 
                                size: 20, 
                                color: idea.voteCount > 0 ? Colors.blueAccent : Colors.grey[400]
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '${idea.voteCount}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  idea.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  idea.description,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}