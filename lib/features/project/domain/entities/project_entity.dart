import 'package:equatable/equatable.dart';
import 'package:task_management/core/enums/project_priority.dart';
import 'package:task_management/core/enums/project_status.dart';

class ProjectEntity extends Equatable {
  final String? id;
  final String clientName;
  final String projectName;
  final String description;
  final ProjectStatus status;
  final ProjectPriority priority;
  final DateTime startDate;
  final DateTime dueDate;

  const ProjectEntity({
    this.id,
    required this.clientName,
    required this.projectName,
    required this.description,
    required this.status,
    required this.priority,
    required this.startDate,
    required this.dueDate,
  });

  String getId() {
    if (id == null) {
      throw Exception('Project ID is null');
    }
    return id!;
  }

  ProjectEntity copyWith({
    String? id,
    String? clientName,
    String? projectName,
    String? description,
    ProjectStatus? status,
    ProjectPriority? priority,
    DateTime? startDate,
    DateTime? dueDate,
  }) {
    return ProjectEntity(
      id: id ?? this.id,
      clientName: clientName ?? this.clientName,
      projectName: projectName ?? this.projectName,
      description: description ?? this.description,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      startDate: startDate ?? this.startDate,
      dueDate: dueDate ?? this.dueDate,
    );
  }

  @override
  List<Object?> get props => [id];
}
