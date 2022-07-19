import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

class GenericFailure extends Failure {}

class BluetoothFailure extends Failure {}

class UnableToConnectDevice extends Failure {}
