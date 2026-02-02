import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/ideas_entity.dart';

part 'ideas_model.g.dart';

@JsonSerializable()
class IdeaModel extends IdeaEntity {
  const IdeaModel({
    required super.id,
    required super.title,
    required super.description,
    required super.voteCount,
    required super.category,
    required super.createdAt,
  });

  factory IdeaModel.fromJson(Map<String, dynamic> json) => _$IdeaModelFromJson(json);

  Map<String, dynamic> toJson() => _$IdeaModelToJson(this);

  factory IdeaModel.fromEntity(IdeaEntity entity) {
    return IdeaModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      voteCount: entity.voteCount,
      category: entity.category,
      createdAt: entity.createdAt,
    );
  }
}