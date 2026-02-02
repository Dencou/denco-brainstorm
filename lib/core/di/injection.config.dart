// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/ideas/data/datasources/ideas_datasource.dart' as _i853;
import '../../features/ideas/data/repositories/repository_impl.dart' as _i406;
import '../../features/ideas/domain/repositories/ideas_repository.dart' as _i88;
import '../../features/ideas/domain/usecases/add_idea.dart' as _i946;
import '../../features/ideas/domain/usecases/get_ideas_usecase.dart' as _i705;
import '../../features/ideas/domain/usecases/vote_idea.dart' as _i484;
import '../../features/ideas/presentation/cubits/idea_detail_cubit/ideas_detail_cubit.dart'
    as _i269;
import '../../features/ideas/presentation/cubits/ideas_cubit/ideas_cubit.dart'
    as _i844;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i853.IdeasLocalDataSource>(
      () => _i853.IdeasLocalDataSourceImpl(),
    );
    gh.lazySingleton<_i88.IdeasRepository>(
      () => _i406.IdeasRepositoryImpl(gh<_i853.IdeasLocalDataSource>()),
    );
    gh.factory<_i269.IdeaDetailCubit>(
      () => _i269.IdeaDetailCubit(gh<_i88.IdeasRepository>()),
    );
    gh.lazySingleton<_i705.GetIdeas>(
      () => _i705.GetIdeas(gh<_i88.IdeasRepository>()),
    );
    gh.lazySingleton<_i946.AddIdea>(
      () => _i946.AddIdea(gh<_i88.IdeasRepository>()),
    );
    gh.lazySingleton<_i484.VoteIdea>(
      () => _i484.VoteIdea(gh<_i88.IdeasRepository>()),
    );
    gh.factory<_i844.IdeasCubit>(
      () => _i844.IdeasCubit(
        gh<_i705.GetIdeas>(),
        gh<_i946.AddIdea>(),
        gh<_i484.VoteIdea>(),
      ),
    );
    return this;
  }
}
