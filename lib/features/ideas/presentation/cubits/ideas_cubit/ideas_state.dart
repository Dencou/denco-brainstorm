part of 'ideas_cubit.dart';

sealed class IdeasState extends Equatable {
  const IdeasState();

  @override
  List<Object> get props => [];
}

final class IdeasInitial extends IdeasState {}

final class IdeasLoading extends IdeasState {}

final class IdeasLoaded extends IdeasState {
  final List<IdeaEntity> ideas;

  const IdeasLoaded(this.ideas);

  @override
  List<Object> get props => [ideas];
}

final class IdeasError extends IdeasState {
  final String message;

  const IdeasError(this.message);

  @override
  List<Object> get props => [message];
}