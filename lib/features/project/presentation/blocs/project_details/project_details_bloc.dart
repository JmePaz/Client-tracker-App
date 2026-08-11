import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_management/core/utils/failure.dart';
import 'package:task_management/features/project/domain/entities/project_entity.dart';
import 'package:task_management/features/project/domain/usecases/add_project.dart';
import 'package:task_management/features/project/domain/usecases/delete_project.dart';
import 'package:task_management/features/project/domain/usecases/fetch_project.dart';
import 'package:task_management/features/project/domain/usecases/update_project.dart';

part 'project_details_event.dart';
part 'project_details_state.dart';

class ProjectDetailsBloc
    extends Bloc<ProjectDetailsEvent, ProjectDetailsState> {
  final AddProjectUseCase _addProject;
  final UpdateProjectUseCase _updateProject;
  final DeleteProjectUseCase _deleteProject;
  final FetchProjectUseCase _fetchProject;

  ProjectDetailsBloc({
    required AddProjectUseCase addProject,
    required UpdateProjectUseCase updateProject,
    required DeleteProjectUseCase deleteProject,
    required FetchProjectUseCase fetchProject,
  }) : _addProject = addProject,
       _updateProject = updateProject,
       _deleteProject = deleteProject,
       _fetchProject = fetchProject,
       super(ProjectDetailsInitial()) {
    on<FetchProjectDetails>(_onFetchProjectDetails);
    on<AddProjectDetails>(_onAddProjectDetails);
    on<UpdateProjectDetails>(_onUpdateProjectDetails);
    on<DeleteProjectDetails>(_onDeleteProjectDetails);
  }

  void _onFetchProjectDetails(
    FetchProjectDetails event,
    Emitter<ProjectDetailsState> emit,
  ) async {
    emit(ProjectDetailsLoading());

    final result = await _fetchProject(event.projectId);
    result.fold(
      (failure) => emit(ProjectDetailsFailed(failure: failure)),
      (project) => emit(ProjectDetailsFetched(project: project)),
    );
  }

  void _onAddProjectDetails(
    AddProjectDetails event,
    Emitter<ProjectDetailsState> emit,
  ) async {
    emit(ProjectDetailsLoading());
    final result = await _addProject(event.project);
    result.fold(
      (failure) => emit(ProjectDetailsFailed(failure: failure)),
      (project) => emit(ProjectDetailsFetched(project: project)),
    );
  }

  void _onUpdateProjectDetails(
    UpdateProjectDetails event,
    Emitter<ProjectDetailsState> emit,
  ) async {
    emit(ProjectDetailsLoading());
    final result = await _updateProject(event.project);
    result.fold(
      (failure) => emit(ProjectDetailsFailed(failure: failure)),
      (project) => emit(ProjectDetailsUpdated(project: project)),
    );
  }

  void _onDeleteProjectDetails(
    DeleteProjectDetails event,
    Emitter<ProjectDetailsState> emit,
  ) async {
    emit(ProjectDetailsLoading());
    final result = await _deleteProject(event.project);
    result.fold(
      (failure) => emit(ProjectDetailsFailed(failure: failure)),
      (_) => emit(ProjectDetailsDeleted()),
    );
  }
}
