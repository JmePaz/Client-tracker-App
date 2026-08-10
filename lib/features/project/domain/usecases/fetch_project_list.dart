import 'package:task_management/core/utils/result_future.dart';
import 'package:task_management/core/utils/use_case.dart';
import 'package:task_management/features/project/domain/entities/project_entity.dart';
import 'package:task_management/features/project/domain/repositories/project_repository.dart';

class FetchProjectListUseCase extends UseCase<List<ProjectEntity>> {
  final ProjectRepository _repository;

  FetchProjectListUseCase({required ProjectRepository repository})
    : _repository = repository;

  @override
  ResultFuture<List<ProjectEntity>> call() async {
    return _repository.fetchProjectList();
  }
}
