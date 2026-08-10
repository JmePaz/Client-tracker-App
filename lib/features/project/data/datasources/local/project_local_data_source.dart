import 'package:task_management/features/project/data/model/project_model.dart';

abstract class ProjectLocalDataSource {
  Future<List<Map<String, dynamic>>> fetchProjectList();
  Future<ProjectModel> addProject(ProjectModel project);
  Future<ProjectModel> updateProject(ProjectModel project);
  Future<void> deleteProject(ProjectModel project);
}
