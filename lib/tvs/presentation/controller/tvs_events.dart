import 'package:equatable/equatable.dart';

abstract class TvsEvents extends Equatable {
  const TvsEvents();

  @override
  List<Object> get props => [];
}

class GetOnTheAirTvsEvents extends TvsEvents {}

class GetPopularTvsEvents extends TvsEvents {}

class GetTopRatedTvsEvents extends TvsEvents {}
