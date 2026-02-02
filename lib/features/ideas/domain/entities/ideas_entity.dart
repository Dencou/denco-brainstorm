import 'package:equatable/equatable.dart';

enum IdeaCategory {
  tech,
  product,
  culture,
  random,
}

class IdeaEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final int voteCount;
  final IdeaCategory category;
  final DateTime createdAt;

  const IdeaEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.voteCount,
    required this.category,
    required this.createdAt,
  });

  factory IdeaEntity.empty() {
    return IdeaEntity(
      id: '',
      title: '',
      description: '',
      voteCount: 0,
      category: IdeaCategory.random,
      createdAt: DateTime.now(),
    );
  }

  IdeaEntity copyWith({
    String? id,
    String? title,
    String? description,
    int? voteCount,
    IdeaCategory? category,
    DateTime? createdAt,
  }) {
    return IdeaEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      voteCount: voteCount ?? this.voteCount,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        voteCount,
        category,
        createdAt,
      ];
}