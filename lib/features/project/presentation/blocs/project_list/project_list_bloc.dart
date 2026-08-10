import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_management/core/utils/failure.dart';
import 'package:task_management/features/project/domain/entities/project_entity.dart';
import 'package:task_management/features/project/domain/usecases/fetch_project_list.dart';

part 'project_list_event.dart';
part 'project_list_state.dart';

class ProjectListBloc extends Bloc<ProjectListEvent, ProjectListState> {
  final FetchProjectListUseCase _fetchProjectList;

  ProjectListBloc({required FetchProjectListUseCase fetchProjectList})
    : _fetchProjectList = fetchProjectList,
      super(ProjectListInitial()) {
    on<FetchProjectList>(_onFetchProjectList);
  }

  void _onFetchProjectList(
    FetchProjectList event,
    Emitter<ProjectListState> emit,
  ) async {
    emit(ProjectListLoading());

    final result = await _fetchProjectList();
    result.fold(
      (failure) => emit(ProjectListFailed(failure: failure)),
      (projects) => emit(ProjectListFetched(projects: projects)),
    );
  }
}
