part of 'project_list_bloc.dart';

sealed class ProjectListState extends Equatable {
  const ProjectListState();

  @override
  List<Object> get props => [];
}

final class ProjectListInitial extends ProjectListState {}

final class ProjectListLoading extends ProjectListState {}

final class ProjectListFetched extends ProjectListState {
  final List<ProjectEntity> projects;

  const ProjectListFetched({required this.projects});

  @override
  List<Object> get props => [projects];
}

class ProjectListFailed extends ProjectListState {
  final Failure failure;

  const ProjectListFailed({required this.failure});

  @override
  List<Object> get props => [failure];
}
