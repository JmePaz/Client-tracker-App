import 'package:equatable/equatable.dart';
import 'package:task_management/core/enums/project_priority.dart';
import 'package:task_management/core/enums/project_status.dart';

class ProjectEntity extends Equatable {
  final int? id;
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

  @override
  List<Object?> get props => [id];
}
