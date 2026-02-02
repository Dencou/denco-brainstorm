import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../../domain/entities/comments_entity.dart';
import '../../domain/entities/ideas_entity.dart';
import '../cubits/idea_detail_cubit/ideas_detail_cubit.dart';

class IdeaDetailPage extends StatelessWidget {
  final IdeaEntity idea;

  const IdeaDetailPage({super.key, required this.idea});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<IdeaDetailCubit>()..loadComments(idea.id),
      child: Scaffold(
        appBar: AppBar(title: const Text('Discusión')),
        body: Column(
          children: [
            _IdeaHeader(idea: idea),
            const Divider(height: 1),
            Expanded(
              child: BlocBuilder<IdeaDetailCubit, IdeaDetailState>(
                builder: (context, state) {
                  return switch (state) {
                    DetailInitial() || DetailLoading() => const Center(child: CircularProgressIndicator()),
                    DetailError(message: final msg) => Center(child: Text(msg)),
                    DetailLoaded(comments: final comments) => _CommentsList(comments: comments),
                  };
                },
              ),
            ),
            _CommentInput(ideaId: idea.id),
          ],
        ),
      ),
    );
  }
}

class _IdeaHeader extends StatelessWidget {
  final IdeaEntity idea;
  const _IdeaHeader({required this.idea});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Theme.of(context).cardColor,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(idea.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(idea.description, style: TextStyle(color: Colors.grey[700], fontSize: 16)),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.bolt, size: 16, color: Colors.amber),
              Text(' ${idea.voteCount} votos'),
              const Spacer(),
              Text('Creada hace poco', style: TextStyle(color: Colors.grey[500], fontSize: 12)),
            ],
          )
        ],
      ),
    );
  }
}

class _CommentsList extends StatelessWidget {
  final List<CommentEntity> comments;
  const _CommentsList({required this.comments});

  @override
  Widget build(BuildContext context) {
    if (comments.isEmpty) {
      return const Center(child: Text('Nadie comentó aún. ¡Sé el primero! 🦗'));
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: comments.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final comment = comments[index];
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Colors.primaries[index % Colors.primaries.length].withValues(alpha: 0.2),
              child: Text(comment.authorName[0], style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(comment.authorName, style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(width: 8),
                      Text(
                        'hace un rato',
                        style: TextStyle(color: Colors.grey[500], fontSize: 10),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(comment.text),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _CommentInput extends StatefulWidget {
  final String ideaId;
  const _CommentInput({required this.ideaId});

  @override
  State<_CommentInput> createState() => _CommentInputState();
}

class _CommentInputState extends State<_CommentInput> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), offset: const Offset(0, -2), blurRadius: 10)],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Escribe un comentario...',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton.filled(
              onPressed: () {
                context.read<IdeaDetailCubit>().postComment(widget.ideaId, _controller.text);
                _controller.clear();
                FocusScope.of(context).unfocus();
              },
              icon: const Icon(Icons.send_rounded),
            ),
          ],
        ),
      ),
    );
  }
}