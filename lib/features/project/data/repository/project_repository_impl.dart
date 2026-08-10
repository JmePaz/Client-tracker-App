import 'package:task_management/core/utils/result_future.dart';
import 'package:task_management/features/project/domain/entities/project_entity.dart';
import 'package:task_management/features/project/domain/repositories/project_repository.dart';

class ProjectRepositoryImpl extends ProjectRepository {
  @override
  ResultFuture<ProjectEntity> addProject(ProjectEntity project) {
    // TODO: implement addProject
    throw UnimplementedError();
  }

  @override
  ResultFuture<void> deleteProject(ProjectEntity project) {
    // TODO: implement deleteProject
    throw UnimplementedError();
  }

  @override
  ResultFuture<List<ProjectEntity>> fetchProjectList() {
    // TODO: implement fetchProjectList
    throw UnimplementedError();
  }

  @override
  ResultFuture<ProjectEntity> updateProject(ProjectEntity project) {
    // TODO: implement updateProject
    throw UnimplementedError();
  }
}
