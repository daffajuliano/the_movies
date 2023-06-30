import 'package:equatable/equatable.dart';

class AppException extends Equatable {
  final String message;

  const AppException({this.message = 'Something Wrong'});

  @override
  List<Object?> get props => [message];
}

class NetworkException extends AppException {
  const NetworkException({message = 'Network Error'}) : super(message: message);
}
