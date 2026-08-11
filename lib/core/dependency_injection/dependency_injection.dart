import 'package:get_it/get_it.dart';
import 'package:task_management/features/project/data/datasources/local/project_local_data_source.dart';
import 'package:task_management/features/project/data/repository/project_repository_impl.dart';
import 'package:task_management/features/project/domain/repositories/project_repository.dart';
import 'package:task_management/features/project/domain/usecases/add_project.dart';
import 'package:task_management/features/project/domain/usecases/delete_project.dart';
import 'package:task_management/features/project/domain/usecases/fetch_project.dart';
import 'package:task_management/features/project/domain/usecases/fetch_project_list.dart';
import 'package:task_management/features/project/domain/usecases/update_project.dart';
import 'package:task_management/features/project/presentation/blocs/project_details/project_details_bloc.dart';
import 'package:task_management/features/project/presentation/blocs/project_list/project_list_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  await initProjects();
}

Future<void> initProjects() async {
  sl
    ..registerFactory<ProjectListBloc>(
      () => ProjectListBloc(fetchProjectList: sl()),
    )
    ..registerLazySingleton(() => FetchProjectListUseCase(repository: sl()))
    ..registerLazySingleton<ProjectRepository>(
      () => ProjectRepositoryImpl(localDataSource: sl()),
    )
    ..registerLazySingleton<ProjectLocalDataSource>(
      () => ProjectLocalDataSourceImpl(),
    );
  ;

  sl
    ..registerFactory<ProjectDetailsBloc>(
      () => ProjectDetailsBloc(
        deleteProject: sl(),
        addProject: sl(),
        updateProject: sl(),
        fetchProject: sl(),
      ),
    )
    ..registerLazySingleton(() => FetchProjectUseCase(repository: sl()))
    ..registerLazySingleton(() => AddProjectUseCase(repository: sl()))
    ..registerLazySingleton(() => UpdateProjectUseCase(repository: sl()))
    ..registerLazySingleton(() => DeleteProjectUseCase(repository: sl()));
}
