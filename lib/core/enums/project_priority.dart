enum ProjectPriority {
  low,
  medium,
  high;

  String toLabel() {
    switch (this) {
      case ProjectPriority.low:
        return 'Low';
      case ProjectPriority.medium:
        return 'Medium';
      case ProjectPriority.high:
        return 'High';
    }
  }

  int toInt() {
    switch (this) {
      case ProjectPriority.low:
        return 0;
      case ProjectPriority.medium:
        return 1;
      case ProjectPriority.high:
        return 2;
    }
  }

  static ProjectPriority fromInt(int value) {
    switch (value) {
      case 0:
        return ProjectPriority.low;
      case 1:
        return ProjectPriority.medium;
      case 2:
        return ProjectPriority.high;
      default:
        throw ArgumentError(
          'Invalid integer value for ProjectPriority: $value',
        );
    }
  }
}
