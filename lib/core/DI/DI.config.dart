// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/datasource/articles_dao.dart' as _i851;
import '../../data/datasource/sources_dao.dart' as _i166;
import '../../data/datasource_impl/articles_api_dao_impl.dart' as _i112;
import '../../data/datasource_impl/sources_api_dao_impl.dart' as _i81;
import '../../data/repository_impl/articles_repo_impl.dart' as _i902;
import '../../data/repository_impl/sources_repo_impl.dart' as _i805;
import '../../repository/articles_repo.dart' as _i707;
import '../../repository/sources_repo.dart' as _i396;
import '../../ui/articles/articles_list/viewmodel/articles_list_view_model.dart'
    as _i698;
import '../../ui/articles/articles_widget/viewmodel/articles_view_model.dart'
    as _i939;
import '../remote/network/api_manager.dart' as _i133;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.singleton<_i133.ApiManager>(() => _i133.ApiManager());
    gh.factory<_i851.ArticlesDao>(
      () => _i112.ArticlesApiDaoImpl(gh<_i133.ApiManager>()),
    );
    gh.factory<_i166.SourcesDao>(
      () => _i81.SourcesApiDaoImpl(gh<_i133.ApiManager>()),
    );
    gh.factory<_i707.ArticlesRepo>(
      () => _i902.ArticlesRepoImpl(gh<_i851.ArticlesDao>()),
    );
    gh.factory<_i396.SourcesRepo>(
      () => _i805.SourcesRepoImpl(gh<_i166.SourcesDao>()),
    );
    gh.factory<_i939.ArticlesViewModel>(
      () => _i939.ArticlesViewModel(gh<_i396.SourcesRepo>()),
    );
    gh.factory<_i698.ArticlesListViewModel>(
      () => _i698.ArticlesListViewModel(gh<_i707.ArticlesRepo>()),
    );
    return this;
  }
}
