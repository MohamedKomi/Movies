import 'package:equatable/equatable.dart';

class MovieGenres extends Equatable {
  final String name;
  final int id;

  const MovieGenres({
    required this.name,
    required this.id,
  });

  @override
  List<Object?> get props => [
        name,
        id,
      ];
}
