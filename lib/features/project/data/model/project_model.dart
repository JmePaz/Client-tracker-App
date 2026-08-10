import 'package:task_management/core/enums/project_priority.dart';
import 'package:task_management/core/enums/project_status.dart';
import 'package:task_management/features/project/domain/entities/project_entity.dart';

class ProjectModel extends ProjectEntity {
  const ProjectModel({
    super.id,
    required super.clientName,
    required super.projectName,
    required super.description,
    required super.status,
    required super.priority,
    required super.startDate,
    required super.dueDate,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'] as int?,
      clientName: json['clientName'] as String,
      projectName: json['projectName'] as String,
      description: json['description'] as String,
      status: ProjectStatus.fromInt(json['status'] as int),
      priority: ProjectPriority.fromInt(json['priority'] as int),
      startDate: DateTime.parse(json['startDate'] as String),
      dueDate: DateTime.parse(json['dueDate'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'clientName': clientName,
      'projectName': projectName,
      'description': description,
      'status': status.toInt(),
      'priority': priority.toInt(),
      'startDate': startDate.toIso8601String(),
      'dueDate': dueDate.toIso8601String(),
    };
  }
}
