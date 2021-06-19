part of 'list_bloc.dart';

abstract class ListEvent extends Equatable {
  const ListEvent();
}

class ListRequested extends ListEvent {
  ListRequested();

  @override
  List<Object> get props => [];
}

class ListPulledToRefresh extends ListEvent {
  ListPulledToRefresh();

  @override
  List<Object> get props => [];
}
