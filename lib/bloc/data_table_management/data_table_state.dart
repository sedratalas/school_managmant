import 'package:equatable/equatable.dart';

abstract class DataTableState extends Equatable {
  final List<dynamic> data;
  final String currentType;
  final bool isLoading;
  final String? message;

  const DataTableState({
    this.data = const [],
    this.currentType = "student",
    this.isLoading = false,
    this.message,
  });

  @override
  List<Object?> get props => [data, currentType, isLoading, message];
}

class DataTableInitial extends DataTableState {
  const DataTableInitial() : super();
}

class DataTableLoading extends DataTableState {
  const DataTableLoading({
    super.data,
    required super.currentType,
  }) : super(
    isLoading: true,
  );
}

class DataTableLoaded extends DataTableState {
  const DataTableLoaded({
    required super.data,
    required super.currentType,
  }) : super(
    isLoading: false,
  );
}

class DataTableError extends DataTableState {
  const DataTableError({
    super.data,
    required super.message,
    required super.currentType,
  }) : super(
    isLoading: false,
  );
}

class DataUpdating extends DataTableState {
  const DataUpdating({
    required super.data,
    required super.currentType,
  }) : super(
    isLoading: true,
  );
}

class DataUpdateSuccess extends DataTableState {
  const DataUpdateSuccess({
    required super.data,
    required super.currentType,
    required super.message,
  }) : super(
    isLoading: false,
  );
}

class DataUpdateFailure extends DataTableState {
  const DataUpdateFailure({
    required super.data,
    required super.currentType,
    required super.message,
  }) : super(
    isLoading: false,
  );
}

class DataAdding extends DataTableState {
  const DataAdding({
    super.data,
    required super.currentType,
  }) : super(
    isLoading: true,
  );
}

class DataAddSuccess extends DataTableState {
  const DataAddSuccess({
    super.data,
    required super.currentType,
    required super.message,
  }) : super(
    isLoading: false,
  );
}

class DataAddFailure extends DataTableState {
  const DataAddFailure({
    super.data,
    required super.currentType,
    required super.message,
  }) : super(
    isLoading: false,
  );
}
