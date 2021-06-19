import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sample_app/list_bloc.dart';
import 'package:sample_app/models/ListResponse.dart';
import 'package:sample_app/repository.dart';

class MockListRepository extends Mock implements ListRepository {}

void main() {
  late ListRepository mockListRepository;

  setUp(() {
    mockListRepository = MockListRepository();

    when(() => mockListRepository.getList(any(), any()))
        .thenAnswer((_) async => mockListResponse1);
  });

  group('List bloc test', () {
    blocTest<ListBloc, ListState>(
      'emits [success] on failure api fetch but the data list is not empty',
      build: () {
        when(() => mockListRepository.getList(any(), any()))
            .thenThrow(Exception('oops'));
        return ListBloc(listRepository: mockListRepository);
      },
      // seed: () => ListSuccess(list: [], isEndOfList: false, pageNumber: 1),
      seed: () =>
          ListSuccess(list: [mockListData1], isEndOfList: false, pageNumber: 1),

      wait: const Duration(seconds: 3),
      act: (bloc) => bloc.add(ListRequested()),
      expect: () => [
        ListSuccess(list: [mockListData1], isEndOfList: false, pageNumber: 1)
      ],
      verify: (_) {
        verify(() => mockListRepository.getList(2, 30)).called(1);
      },
    );
  });
}

ListResponse mockListResponse1 = ListResponse(
  pageNumber: 1,
  pageSize: 20,
  data: [mockListData1],
);

ListData mockListData1 = ListData(
  userId: 1,
  title: 'title',
  tags: 'tags',
);
