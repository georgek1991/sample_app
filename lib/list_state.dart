part of 'list_bloc.dart';

abstract class ListState extends Equatable {
  final List<ListData> list;
  final bool isEndOfList;
  final int pageNumber;
  const ListState(this.list, this.isEndOfList, this.pageNumber);
}

class ListInitial extends ListState {
  ListInitial() : super([], false, 0);
  @override
  List<Object> get props => [];
}

class ListSuccess extends ListState {
  ListSuccess({
    required List<ListData> list,
    required bool isEndOfList,
    required int pageNumber,
  }) : super(list, isEndOfList, pageNumber);

  @override
  List<Object> get props => [list, isEndOfList, pageNumber];
}

class ListFailure extends ListState {
  final String errorStatus;

  ListFailure(this.errorStatus) : super([], false, 0);
  @override
  List<Object> get props => [];
}
