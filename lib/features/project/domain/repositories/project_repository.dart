import 'package:task_management/core/utils/result_future.dart';
import 'package:task_management/features/project/domain/entities/project_entity.dart';

abstract class ProjectRepository {
  ResultFuture<List<ProjectEntity>> fetchProjectList();
  ResultFuture<ProjectEntity> addProject(ProjectEntity project);
  ResultFuture<ProjectEntity> updateProject(ProjectEntity project);
  ResultFuture<void> deleteProject(ProjectEntity project);
}
