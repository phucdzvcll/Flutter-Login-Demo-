part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

class RegisEvent extends RegisterEvent {
  final String email, password;

  RegisEvent({required this.email, required this.password});
}
