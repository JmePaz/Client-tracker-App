import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_management/core/enums/project_priority.dart';
import 'package:task_management/core/enums/project_status.dart';
import 'package:task_management/features/project/domain/entities/project_entity.dart';
import 'package:task_management/features/project/presentation/blocs/project_details/project_details_bloc.dart';
import 'package:task_management/shared/alert/app_alert.dart';
import 'package:task_management/shared/buttons/app_outline_button.dart';
import 'package:task_management/shared/buttons/app_primary_button.dart';
import 'package:task_management/shared/loading/app_loader_modal.dart';

class ProjectDetailsScreen extends StatefulWidget {
  static const String routePath = '/project/:projectId';

  final String projectId;

  const ProjectDetailsScreen({super.key, required this.projectId});

  @override
  State<ProjectDetailsScreen> createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  final _formKey = GlobalKey<FormState>();

  final _clientNameController = TextEditingController();
  final _projectNameController = TextEditingController();
  final _descriptionController = TextEditingController();

  late final ProjectEntity _project;

  ProjectStatus _status = ProjectStatus.pending;
  ProjectPriority _priority = ProjectPriority.medium;

  DateTime? _startDate;
  DateTime? _dueDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _clientNameController.dispose();
    _projectNameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickDate(
    BuildContext context, {
    required bool isStartDate,
  }) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked == null) return;

    setState(() {
      if (isStartDate) {
        _startDate = picked;
      } else {
        _dueDate = picked;
      }
    });
  }

  String? _validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  void _updateDetails() {
    if (!_formKey.currentState!.validate()) return;
    if (_startDate == null || _dueDate == null) {
      AppAlert.show(
        context: context,
        title: 'Invalid Dates',
        message: 'Please select both start and due dates.',
        type: AppAlertType.warning,
      );
    } else if (_startDate != null &&
        _dueDate != null &&
        _startDate!.isAfter(_dueDate!)) {
      AppAlert.show(
        context: context,
        title: 'Invalid Dates',
        message: 'Start date cannot be after due date.',
        type: AppAlertType.warning,
      );
      return;
    }

    final project = ProjectEntity(
      id: widget.projectId,
      clientName: _clientNameController.text.trim(),
      projectName: _projectNameController.text.trim(),
      description: _descriptionController.text.trim(),
      status: _status,
      priority: _priority,
      startDate: _startDate!,
      dueDate: _dueDate!,
    );

    context.read<ProjectDetailsBloc>().add(
      UpdateProjectDetails(project: project),
    );
  }

  void _deleteProject() {
    AppAlert.show(
      context: context,
      title:
          "Do you want to delete project ${_projectNameController.text.trim()}?",
      message: "This action cannot be undone.",
      type: AppAlertType.warning,
      confirmText: "Delete",
      cancelText: "Cancel",
      onConfirm: () {
        final project = ProjectEntity(
          id: widget.projectId,
          clientName: _clientNameController.text.trim(),
          projectName: _projectNameController.text.trim(),
          description: _descriptionController.text.trim(),
          status: _status,
          priority: _priority,
          startDate: _startDate!,
          dueDate: _dueDate!,
        );

        context.read<ProjectDetailsBloc>().add(
          DeleteProjectDetails(project: project),
        );
      },
      onCancel: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProjectDetailsBloc, ProjectDetailsState>(
      listener: (context, state) {
        if (state is ProjectDetailsLoading) {
          AppLoaderModal.show(context: context);
        } else if (state is ProjectDetailsFailed) {
          final failure = state.failure;
          if (kDebugMode) {
            print(failure.message);
          }
          AppAlert.show(
            context: context,
            title: 'Error',
            message: failure.displayMessage,
            type: AppAlertType.error,
            onConfirm: () {
              if (context.canPop()) {
                context.pop();
                context.pop();
              }
            },
            barrierDismissible: false,
          );
        } else if (state is ProjectDetailsFetched) {
          AppLoaderModal.hide(context);
          final project = state.project;
          _clientNameController.text = project.clientName;
          _projectNameController.text = project.projectName;
          _descriptionController.text = project.description;
          setState(() {
            _status = project.status;
            _priority = project.priority;
            _startDate = project.startDate;
            _dueDate = project.dueDate;
          });
        } else if (state is ProjectDetailsUpdated) {
          AppLoaderModal.hide(context);
          AppAlert.show(
            context: context,
            title: 'Success',
            message: 'Project updated successfully.',
            type: AppAlertType.success,
            onConfirm: () {
              if (context.canPop()) {
                context.pop();
              }
            },
            barrierDismissible: false,
          );
        } else if (state is ProjectDetailsDeleted) {
          AppLoaderModal.hide(context);
          AppAlert.show(
            context: context,
            title: 'Success',
            message: 'Project deleted successfully.',
            type: AppAlertType.success,
            onConfirm: () {
              if (context.canPop()) {
                context.pop();
              }
            },
            barrierDismissible: false,
          );
        }
      },
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _projectNameController,
                      decoration: const InputDecoration(
                        labelText: 'Project Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                          _validateRequired(value, 'Project name'),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _clientNameController,
                      decoration: const InputDecoration(
                        labelText: 'Client Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                          _validateRequired(value, 'Client name'),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _descriptionController,
                      maxLines: 6,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(),
                        alignLabelWithHint: true,
                      ),
                      validator: (value) =>
                          _validateRequired(value, 'Description'),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<ProjectStatus>(
                            value: _status,
                            decoration: const InputDecoration(
                              labelText: 'Status',
                              border: OutlineInputBorder(),
                            ),
                            items: ProjectStatus.values
                                .map(
                                  (status) => DropdownMenuItem(
                                    value: status,
                                    child: Text(status.toLabel()),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              if (value != null) {
                                setState(() => _status = value);
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: DropdownButtonFormField<ProjectPriority>(
                            value: _priority,
                            decoration: const InputDecoration(
                              labelText: 'Priority',
                              border: OutlineInputBorder(),
                            ),
                            items: ProjectPriority.values
                                .map(
                                  (priority) => DropdownMenuItem(
                                    value: priority,
                                    child: Text(priority.toLabel()),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              if (value != null) {
                                setState(() => _priority = value);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => _pickDate(context, isStartDate: true),
                            child: InputDecorator(
                              decoration: const InputDecoration(
                                labelText: 'Start Date',
                                border: OutlineInputBorder(),
                              ),
                              child: Text(
                                _startDate == null
                                    ? 'Select date'
                                    : _startDate!.toLocal().toString().split(
                                        ' ',
                                      )[0],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: InkWell(
                            onTap: () => _pickDate(context, isStartDate: false),
                            child: InputDecorator(
                              decoration: const InputDecoration(
                                labelText: 'Due Date',
                                border: OutlineInputBorder(),
                              ),
                              child: Text(
                                _dueDate == null
                                    ? 'Select date'
                                    : _dueDate!.toLocal().toString().split(
                                        ' ',
                                      )[0],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: AppPrimaryButton(
                    onPressed: _updateDetails,
                    label: 'Update',
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: AppOutlineButton(
                    onPressed: _deleteProject,
                    label: 'Delete',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
