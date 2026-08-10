import 'package:task_management/core/utils/result_future.dart';
import 'package:task_management/core/utils/use_case.dart';
import 'package:task_management/features/project/domain/entities/project_entity.dart';
import 'package:task_management/features/project/domain/repositories/project_repository.dart';

class FetchProjectUseCase extends UseCaseWithParams<ProjectEntity, String> {
  final ProjectRepository _repository;

  FetchProjectUseCase({required ProjectRepository repository})
    : _repository = repository;

  @override
  ResultFuture<ProjectEntity> call(String projectId) async {
    return _repository.fetchProject(projectId);
  }
}
