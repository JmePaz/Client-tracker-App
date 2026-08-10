part of 'project_list_bloc.dart';

sealed class ProjectListEvent extends Equatable {
  const ProjectListEvent();

  @override
  List<Object> get props => [];
}

class FetchProjectList extends ProjectListEvent {}
