import 'package:task_management/core/utils/result_future.dart';
import 'package:task_management/core/utils/use_case.dart';
import 'package:task_management/features/project/domain/entities/project_entity.dart';
import 'package:task_management/features/project/domain/repositories/project_repository.dart';

class UpdateProjectUseCase
    extends UseCaseWithParams<ProjectEntity, ProjectEntity> {
  final ProjectRepository _repository;

  UpdateProjectUseCase({required ProjectRepository repository})
    : _repository = repository;

  @override
  ResultFuture<ProjectEntity> call(ProjectEntity project) async {
    return _repository.updateProject(project);
  }
}
