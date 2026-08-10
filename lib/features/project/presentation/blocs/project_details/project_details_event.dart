part of 'project_details_bloc.dart';

sealed class ProjectDetailsEvent extends Equatable {
  const ProjectDetailsEvent();

  @override
  List<Object> get props => [];
}

class FetchProjectDetails extends ProjectDetailsEvent {
  final String projectId;

  const FetchProjectDetails({required this.projectId});

  @override
  List<Object> get props => [projectId];
}

class AddProjectDetails extends ProjectDetailsEvent {
  final ProjectEntity project;

  const AddProjectDetails({required this.project});

  @override
  List<Object> get props => [project];
}

class UpdateProjectDetails extends ProjectDetailsEvent {
  final ProjectEntity project;

  const UpdateProjectDetails({required this.project});

  @override
  List<Object> get props => [project];
}

class DeleteProjectDetails extends ProjectDetailsEvent {
  final ProjectEntity project;

  const DeleteProjectDetails({required this.project});

  @override
  List<Object> get props => [project];
}
