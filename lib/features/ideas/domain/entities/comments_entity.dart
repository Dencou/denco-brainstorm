import 'package:equatable/equatable.dart';

class CommentEntity extends Equatable {
  final String id;
  final String text;
  final String authorName;
  final DateTime createdAt;

  const CommentEntity({
    required this.id,
    required this.text,
    required this.authorName,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, text, authorName, createdAt];
}