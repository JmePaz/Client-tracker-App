import 'package:task_management/core/utils/result_future.dart';
import 'package:task_management/core/utils/use_case.dart';
import 'package:task_management/features/project/domain/entities/project_entity.dart';
import 'package:task_management/features/project/domain/repositories/project_repository.dart';

class DeleteProjectUseCase extends UseCaseWithParams<void, ProjectEntity> {
  final ProjectRepository _repository;

  DeleteProjectUseCase({required ProjectRepository repository})
    : _repository = repository;

  @override
  ResultFuture<void> call(ProjectEntity project) {
    return _repository.deleteProject(project);
  }
}
