part of 'project_details_bloc.dart';

enum ProjectDetailsStatus { initial, loading, success, failure }

sealed class ProjectDetailsState extends Equatable {
  const ProjectDetailsState();

  @override
  List<Object> get props => [];
}

final class ProjectDetailsInitial extends ProjectDetailsState {}

final class ProjectDetailsLoading extends ProjectDetailsState {}

class ProjectDetailsFetched extends ProjectDetailsState {
  final ProjectEntity project;

  const ProjectDetailsFetched({required this.project});

  @override
  List<Object> get props => [project];
}

class ProjectDetailsFailed extends ProjectDetailsState {
  final Failure failure;

  const ProjectDetailsFailed({required this.failure});

  @override
  List<Object> get props => [failure];
}
