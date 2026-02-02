import 'package:bloc_test/bloc_test.dart'; 
import 'package:mocktail/mocktail.dart';   

import 'package:dartz/dartz.dart';
import 'package:denco_brainstorm/core/errors/failures.dart';
import 'package:denco_brainstorm/core/usecases/usecase.dart';
import 'package:denco_brainstorm/features/ideas/domain/entities/ideas_entity.dart';
import 'package:denco_brainstorm/features/ideas/domain/usecases/add_idea.dart';
import 'package:denco_brainstorm/features/ideas/domain/usecases/get_ideas_usecase.dart';
import 'package:denco_brainstorm/features/ideas/domain/usecases/vote_idea.dart';
import 'package:denco_brainstorm/features/ideas/presentation/cubits/ideas_cubit/ideas_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

class MockGetIdeas extends Mock implements GetIdeas {}
class MockAddIdea extends Mock implements AddIdea {}
class MockVoteIdea extends Mock implements VoteIdea {}

void main() {
  late IdeasCubit cubit;
  late MockGetIdeas mockGetIdeas;
  late MockAddIdea mockAddIdea;
  late MockVoteIdea mockVoteIdea;

  final tIdea = IdeaEntity(
    id: '1',
    title: 'Test Idea',
    description: 'Desc',
    voteCount: 0,
    category: IdeaCategory.tech,
    createdAt: DateTime.now(),
  );

  setUp(() {
    mockGetIdeas = MockGetIdeas();
    mockAddIdea = MockAddIdea();
    mockVoteIdea = MockVoteIdea();
    
    cubit = IdeasCubit(mockGetIdeas, mockAddIdea, mockVoteIdea);
    
    registerFallbackValue(tIdea); 
    registerFallbackValue(NoParams());
  });

  group('IdeasCubit', () {
    
    test('initial state should be IdeasInitial', () {
      expect(cubit.state, equals(IdeasInitial()));
    });

    blocTest<IdeasCubit, IdeasState>(
      'emits [Loading, Loaded] when loadIdeas is successful',
      build: () {
        when(() => mockGetIdeas(any()))
            .thenAnswer((_) async => Right([tIdea]));
        return cubit;
      },
      act: (cubit) => cubit.loadIdeas(),
      expect: () => [
        IdeasLoading(),      
        IdeasLoaded([tIdea]) 
      ],
    );

    blocTest<IdeasCubit, IdeasState>(
      'emits [Loading, Error] when loadIdeas fails',
      build: () {
        when(() => mockGetIdeas(any()))
            .thenAnswer((_) async => const Left(ServerFailure(message: 'Ups!')));
        return cubit;
      },
      act: (cubit) => cubit.loadIdeas(),
      expect: () => [
        IdeasLoading(),
        const IdeasError('Ups!') 
      ],
    );

    blocTest<IdeasCubit, IdeasState>(
      'emits [Loading, Loaded] when adding idea succeeds',
      build: () {
        when(() => mockAddIdea(any())).thenAnswer((_) async => const Right(unit));
        when(() => mockGetIdeas(any())).thenAnswer((_) async => Right([tIdea]));
        return cubit;
      },
      act: (cubit) => cubit.addIdea(tIdea),
      expect: () => [
        IdeasLoading(),       
        IdeasLoaded([tIdea])
      ],
    );
  });
}