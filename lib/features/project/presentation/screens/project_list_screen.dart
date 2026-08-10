import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/features/project/presentation/blocs/project_list/project_list_bloc.dart';
import 'package:task_management/features/project/presentation/widgets/cards/project_card.dart';

class ProjectListScreen extends StatelessWidget {
  static const String routePath = '/project-list';

  const ProjectListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectListBloc, ProjectListState>(
      builder: (context, state) {
        if (state is ProjectListLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProjectListFetched) {
          final projects = state.projects;

          if (projects.isEmpty) {
            return const Center(
              child: Text(
                'No projects found.',
                style: TextStyle(color: Colors.black),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<ProjectListBloc>().add(FetchProjectList());
            },
            child: ListView.builder(
              itemCount: projects.length,
              padding: EdgeInsets.symmetric(horizontal: 8),
              itemBuilder: (context, index) {
                final project = projects[index];
                return ProjectCard(project: project);
              },
            ),
          );
        } else if (state is ProjectListFailed) {
          return Center(
            child: Text(
              'Failed to load projects: ${state.failure.message}',
              style: TextStyle(color: Colors.black),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
