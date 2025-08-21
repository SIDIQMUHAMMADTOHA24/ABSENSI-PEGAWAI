import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String username;
  final String jabatan;

  const User({required this.id, required this.username, required this.jabatan});

  @override
  List<Object?> get props => [id, username, jabatan];
}
