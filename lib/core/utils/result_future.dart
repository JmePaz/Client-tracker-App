import 'package:dartz/dartz.dart';
import 'package:task_management/core/utils/failure.dart';

typedef ResultFuture<T> = Future<Either<T, Failure>>;
