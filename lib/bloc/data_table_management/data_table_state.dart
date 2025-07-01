import 'package:equatable/equatable.dart';

abstract class DataTableState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DataTableInitial extends DataTableState {}

class DataTableLoading extends DataTableState {
  final String currentType;

  DataTableLoading({required this.currentType});

  @override
  List<Object?> get props => [currentType];
}

class DataTableLoaded extends DataTableState {
  final List<dynamic> data;
  final String currentType;

  DataTableLoaded({required this.data, required this.currentType});

  @override
  List<Object?> get props => [data, currentType];
}

class DataTableError extends DataTableState {
  final String message;
  final String currentType;

  DataTableError({required this.message, required this.currentType});

  @override
  List<Object?> get props => [message, currentType];
}

class DataUpdating extends DataTableState {
  final List<dynamic> currentData;
  final String currentType;

  DataUpdating({required this.currentData, required this.currentType});

  @override
  List<Object?> get props => [currentData, currentType];
}

class DataUpdateSuccess extends DataTableState {
  final List<dynamic> updatedData;
  final String currentType;
  final String message;

  DataUpdateSuccess({required this.updatedData, required this.currentType, required this.message});

  @override
  List<Object?> get props => [updatedData, currentType, message];
}

class DataUpdateFailure extends DataTableState {
  final List<dynamic> currentData;
  final String currentType;
  final String message;

  DataUpdateFailure({required this.currentData, required this.currentType, required this.message});

  @override
  List<Object?> get props => [currentData, currentType, message];
}

class DataAdding extends DataTableState {
  final String currentType;

  DataAdding({required this.currentType});

  @override
  List<Object?> get props => [currentType];
}

class DataAddSuccess extends DataTableState {
  final String currentType;
  final String message;

  DataAddSuccess({required this.currentType, required this.message});

  @override
  List<Object?> get props => [currentType, message];
}

class DataAddFailure extends DataTableState {
  final String currentType;
  final String message;

  DataAddFailure({required this.currentType, required this.message});

  @override
  List<Object?> get props => [currentType, message];
}
