// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ideas_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IdeaModel _$IdeaModelFromJson(Map<String, dynamic> json) => IdeaModel(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  voteCount: (json['voteCount'] as num).toInt(),
  category: $enumDecode(_$IdeaCategoryEnumMap, json['category']),
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$IdeaModelToJson(IdeaModel instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'voteCount': instance.voteCount,
  'category': _$IdeaCategoryEnumMap[instance.category]!,
  'createdAt': instance.createdAt.toIso8601String(),
};

const _$IdeaCategoryEnumMap = {
  IdeaCategory.tech: 'tech',
  IdeaCategory.product: 'product',
  IdeaCategory.culture: 'culture',
  IdeaCategory.random: 'random',
};
