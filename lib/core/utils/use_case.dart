import 'package:task_management/core/utils/result_future.dart';

abstract class UseCase<T> {
  ResultFuture<T> call();
}

abstract class UseCaseWithParams<T, K> {
  ResultFuture<T> call(K params);
}
