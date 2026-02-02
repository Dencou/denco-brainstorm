import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/comments_entity.dart';

part 'comment_model.g.dart';

@JsonSerializable()
class CommentModel extends CommentEntity {
  const CommentModel({
    required super.id,
    required super.text,
    required super.authorName,
    required super.createdAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) => _$CommentModelFromJson(json);
  Map<String, dynamic> toJson() => _$CommentModelToJson(this);

  factory CommentModel.fromEntity(CommentEntity entity) {
    return CommentModel(
      id: entity.id,
      text: entity.text,
      authorName: entity.authorName,
      createdAt: entity.createdAt,
    );
  }
}