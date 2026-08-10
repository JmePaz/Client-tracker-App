import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_management/core/dependency_injection/dependency_injection.dart';
import 'package:task_management/features/project/presentation/blocs/project_details/project_details_bloc.dart';
import 'package:task_management/features/project/presentation/blocs/project_list/project_list_bloc.dart';
import 'package:task_management/features/project/presentation/screens/project_add_screen.dart';
import 'package:task_management/features/project/presentation/screens/project_details_screen.dart';
import 'package:task_management/features/project/presentation/screens/project_list_screen.dart';
import 'package:task_management/shared/base/app_base.dart';
import 'package:task_management/shared/base/app_pushed_base.dart';

final router = GoRouter(
  initialLocation: ProjectListScreen.routePath,
  routes: [
    GoRoute(
      path: ProjectListScreen.routePath,
      builder: (context, state) {
        return AppBase(
          title: 'Client Project Management',
          action: FloatingActionButton(
            onPressed: () async {
              // Navigate to the project creation screen
              await context.push(
                "${ProjectListScreen.routePath}${ProjectAddScreen.routePath}",
              );
              if (context.mounted) {
                // After returning from the project creation screen, refresh the project list
                context.read<ProjectListBloc>().add(FetchProjectList());
              }
            },
            child: const Icon(Icons.add),
          ),
          child: ProjectListScreen(),
        );
      },
      routes: [
        GoRoute(
          path: ProjectDetailsScreen.routePath,
          builder: (context, state) {
            return BlocProvider(
              create: (context) => sl<ProjectDetailsBloc>(),
              child: AppPushedBase(
                title: 'Project Details',
                child: ProjectDetailsScreen(),
              ),
            );
          },
        ),
        GoRoute(
          path: ProjectAddScreen.routePath,
          builder: (context, state) {
            return BlocProvider(
              create: (context) => sl<ProjectDetailsBloc>(),
              child: AppPushedBase(
                title: 'Add Project',
                child: ProjectAddScreen(),
              ),
            );
          },
        ),
      ],
    ),
  ],
);
