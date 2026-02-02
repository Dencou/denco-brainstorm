
part of 'ideas_detail_cubit.dart';

sealed class IdeaDetailState extends Equatable {
  const IdeaDetailState();
  @override
  List<Object> get props => [];
}

final class DetailInitial extends IdeaDetailState {}
final class DetailLoading extends IdeaDetailState {}
final class DetailLoaded extends IdeaDetailState {
  final List<CommentEntity> comments;
  const DetailLoaded(this.comments);
  @override
  List<Object> get props => [comments];
}
final class DetailError extends IdeaDetailState {
  final String message;
  const DetailError(this.message);
}