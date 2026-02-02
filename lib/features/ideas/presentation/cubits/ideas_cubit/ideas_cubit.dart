import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/usecases/usecase.dart';
import '../../../domain/entities/ideas_entity.dart';
import '../../../domain/usecases/add_idea.dart';
import '../../../domain/usecases/get_ideas_usecase.dart';
import '../../../domain/usecases/vote_idea.dart';

part 'ideas_state.dart';

@injectable
class IdeasCubit extends Cubit<IdeasState> {
  final GetIdeas _getIdeas;
  final AddIdea _addIdea;
  final VoteIdea _voteIdea;

  IdeasCubit(
    this._getIdeas,
    this._addIdea,
    this._voteIdea,
  ) : super(IdeasInitial());

  Future<void> loadIdeas() async {
    emit(IdeasLoading());
    final result = await _getIdeas(NoParams()); 

    result.fold(
      (failure) => emit(IdeasError(failure.message)),
      (ideas) => emit(IdeasLoaded(ideas)),
    );
  }

  Future<void> addIdea(IdeaEntity idea) async {
    emit(IdeasLoading());
    final result = await _addIdea(idea);

    result.fold(
      (failure) => emit(IdeasError(failure.message)),
      (_) => loadIdeas(),
    );
  }

  Future<void> voteIdea(String id) async {
    final result = await _voteIdea(id);
    
    result.fold(
      (failure) => emit(IdeasError(failure.message)),
      (_) => loadIdeas(),
    );
  }
}