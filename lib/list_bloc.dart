import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sample_app/models/ListResponse.dart';

import 'repository.dart';

part 'list_event.dart';
part 'list_state.dart';

class ListBloc extends Bloc<ListEvent, ListState> {
  static const int PAGE_SIZE = 30;

  final ListRepository listRepository;

  ListBloc({required this.listRepository}) : super(ListInitial());

  @override
  Stream<Transition<ListEvent, ListState>> transformEvents(
    Stream<ListEvent> events,
    TransitionFunction<ListEvent, ListState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<ListState> mapEventToState(
    ListEvent event,
  ) async* {
    if (event is ListRequested) {
      yield* _mapListRequestedToState(event, state);
    } else if (event is ListPulledToRefresh) {
      yield* _mapListRefreshedToState(event, state);
    }
  }

  Stream<ListState> _mapListRefreshedToState(
      ListPulledToRefresh event, ListState state) async* {
    yield ListInitial();
    add(ListRequested());
  }

  Stream<ListState> _mapListRequestedToState(
      ListRequested event, ListState state) async* {
    if (event is ListRequested) {
      if (!state.isEndOfList) {
        try {
          var pageNumber = state.pageNumber == 0 ? 1 : state.pageNumber;
          final ListResponse response =
              await listRepository.getList(pageNumber, PAGE_SIZE);

          var list = state.list;
          var data = response.data ?? [];
          list.addAll(data);
          yield ListSuccess(
            list: list,
            isEndOfList: (data.length < PAGE_SIZE) ? true : false,
            pageNumber: response.pageNumber + 1,
          );
        } on Exception catch (_) {
          if (state.list.length > 0) {
            yield ListSuccess(
              list: state.list,
              isEndOfList: false,
              pageNumber: state.pageNumber,
            );
            return;
          }
          yield ListFailure('server error');
        }
      }
    }
  }
}
