import 'package:hive_ce/hive.dart';
import 'package:task_management/features/project/data/model/project_model.dart';
import 'package:uuid/uuid.dart';

abstract class ProjectLocalDataSource {
  Future<List<ProjectModel>> fetchProjectList();

  Future<ProjectModel> fetchProject(String projectId);
  Future<ProjectModel> addProject(ProjectModel project);
  Future<ProjectModel> updateProject(ProjectModel project);
  Future<void> deleteProject(ProjectModel project);
}

class ProjectLocalDataSourceImpl extends ProjectLocalDataSource {
  final String _boxName = 'projects';

  Future<Box> init() async {
    // Initialize the database and create the projects table if it doesn't exist
    if (Hive.isBoxOpen(_boxName)) {
      return Hive.box(_boxName);
    }
    final box = await Hive.openBox(_boxName);
    return box;
  }

  @override
  Future<ProjectModel> addProject(ProjectModel project) async {
    try {
      final box = await init();
      box.put(project.getId(), project.toJson());
      return project;
    } catch (e) {
      throw Exception('Failed to add project: $e');
    }
  }

  @override
  Future<void> deleteProject(ProjectModel project) async {
    try {
      final box = await init();
      box.delete(project.getId());
    } catch (e) {
      throw Exception('Failed to delete project: $e');
    }
  }

  @override
  Future<List<ProjectModel>> fetchProjectList() async {
    try {
      final box = await init();
      final projectsRaw = box.values.toList();
      final projects = projectsRaw
          .map(
            (projectData) => ProjectModel.fromJson(
              Map<String, dynamic>.from(projectData as Map),
            ),
          )
          .toList();

      projects.sort(
        (a, b) => a.id!.compareTo(b.id!),
      ); // Sort by ID in ascending order
      return projects;
    } catch (e) {
      throw Exception('Failed to fetch projects: $e');
    }
  }

  @override
  Future<ProjectModel> updateProject(ProjectModel project) async {
    try {
      final box = await init();
      box.put(project.getId(), project.toJson());
      return project;
    } catch (e) {
      throw Exception('Failed to update project: $e');
    }
  }

  @override
  Future<ProjectModel> fetchProject(String projectId) async {
    try {
      final box = await init();
      final projectData = box.get(projectId);
      if (projectData == null) {
        throw Exception('Project not found');
      }
      return ProjectModel.fromJson(projectData);
    } catch (e) {
      throw Exception('Failed to fetch project: $e');
    }
  }
}
