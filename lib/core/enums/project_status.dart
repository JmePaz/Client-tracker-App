enum ProjectStatus {
  pending,
  inProgress,
  onHold,
  completed;

  String toLabel() {
    switch (this) {
      case ProjectStatus.pending:
        return 'Pending';
      case ProjectStatus.inProgress:
        return 'In Progress';
      case ProjectStatus.onHold:
        return 'On Hold';
      case ProjectStatus.completed:
        return 'Completed';
    }
  }

  int toInt() {
    switch (this) {
      case ProjectStatus.pending:
        return 0;
      case ProjectStatus.inProgress:
        return 1;
      case ProjectStatus.onHold:
        return 2;
      case ProjectStatus.completed:
        return 3;
    }
  }

  static ProjectStatus fromInt(int value) {
    switch (value) {
      case 0:
        return ProjectStatus.pending;
      case 1:
        return ProjectStatus.inProgress;
      case 2:
        return ProjectStatus.onHold;
      case 3:
        return ProjectStatus.completed;
      default:
        throw ArgumentError('Invalid integer value for ProjectStatus: $value');
    }
  }
}
