import 'package:dartz/dartz.dart';
import 'package:task_management/core/utils/failure.dart';
import 'package:task_management/core/utils/result_future.dart';
import 'package:task_management/features/project/data/datasources/local/project_local_data_source.dart';
import 'package:task_management/features/project/data/model/project_model.dart';
import 'package:task_management/features/project/domain/entities/project_entity.dart';
import 'package:task_management/features/project/domain/repositories/project_repository.dart';
import 'package:uuid/uuid.dart';

class ProjectRepositoryImpl extends ProjectRepository {
  final ProjectLocalDataSource _localDataSource;

  ProjectRepositoryImpl({required ProjectLocalDataSource localDataSource})
    : _localDataSource = localDataSource;

  @override
  ResultFuture<ProjectEntity> addProject(ProjectEntity project) async {
    try {
      final newProject = project.copyWith(
        id: Uuid().v4(),
      ); // Ensure the ID is a new UUID for a new project
      final result = await _localDataSource.addProject(
        ProjectModel.fromEntity(newProject),
      );
      return Right(result);
    } catch (e) {
      return Left(
        LocalFailure(
          message: e.toString(),
          displayMessage: "Failed to add project. Please try again.",
        ),
      );
    }
  }

  @override
  ResultFuture<void> deleteProject(ProjectEntity project) async {
    try {
      final _ = await _localDataSource.deleteProject(
        ProjectModel.fromEntity(project),
      );
      return Right(null);
    } catch (e) {
      return Left(
        LocalFailure(
          message: e.toString(),
          displayMessage: "Failed to delete project. Please try again.",
        ),
      );
    }
  }

  @override
  ResultFuture<List<ProjectEntity>> fetchProjectList() async {
    try {
      final projectList = await _localDataSource.fetchProjectList();
      return Right(projectList);
    } catch (e) {
      return Left(
        LocalFailure(
          message: e.toString(),
          displayMessage: "Failed to fetch project list. Please try again.",
        ),
      );
    }
  }

  @override
  ResultFuture<ProjectEntity> updateProject(ProjectEntity project) async {
    try {
      final updatedProject = await _localDataSource.updateProject(
        ProjectModel.fromEntity(project),
      );
      return Right(updatedProject);
    } catch (e) {
      return Left(
        LocalFailure(
          message: e.toString(),
          displayMessage: "Failed to update project. Please try again.",
        ),
      );
    }
  }

  @override
  ResultFuture<ProjectEntity> fetchProject(String projectId) async {
    try {
      final fetchedProject = await _localDataSource.fetchProject(projectId);
      return Right(fetchedProject);
    } catch (e) {
      return Left(
        LocalFailure(
          message: e.toString(),
          displayMessage: "Failed to fetch project. Please try again.",
        ),
      );
    }
  }
}
