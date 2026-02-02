import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../cubits/ideas_cubit/ideas_cubit.dart';
import '../widgets/add_idea_modal.dart';
import '../widgets/ideas_list_widget.dart';

class IdeasPage extends StatelessWidget {
  const IdeasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<IdeasCubit>()..loadIdeas(),
      child: const _IdeasView(),
    );
  }
}

class _IdeasView extends StatelessWidget {
  const _IdeasView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Friday Ideas 💡'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () => context.read<IdeasCubit>().loadIdeas(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF111111),
        foregroundColor: Colors.white,
        elevation: 4,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (_) {
              return BlocProvider.value(
                value: context.read<IdeasCubit>(),
                child: const AddIdeaModal(),
              );
            },
          );
        },
        label: const Text('Nueva Idea', style: TextStyle(fontWeight: FontWeight.bold)),
        icon: const Icon(Icons.add_circle_outline_rounded),
      ),

      body: BlocBuilder<IdeasCubit, IdeasState>(
        builder: (context, state) {
          return switch (state) {
            IdeasInitial() => const SizedBox(),
            
            IdeasLoading() => const Center(child: CircularProgressIndicator()),
            
            IdeasError(message: final msg) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 48, color: Colors.redAccent),
                    const SizedBox(height: 10),
                    Text(msg),
                    TextButton(
                      onPressed: () => context.read<IdeasCubit>().loadIdeas(), 
                      child: const Text('Reintentar')
                    )
                  ],
                ),
              ),
            
            IdeasLoaded(ideas: final ideas) => ideas.isEmpty
                ? _buildEmptyState()
                : IdeasListWidget(ideas: ideas),
          };
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.lightbulb_outline, size: 64, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            'No hay ideas aún\n¡Sé el primero en innovar!',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[500], fontSize: 16),
          ),
        ],
      ),
    );
  }
}