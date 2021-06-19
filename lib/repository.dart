import 'package:sample_app/models/ListResponse.dart';

class ListRepository {
  ListRepository();

  Future<ListResponse> getList(int pageNumber, int pageSize) async {
    Future.delayed(Duration(seconds: 3));
    ListResponse resp = ListResponse(
      pageSize: pageSize,
      pageNumber: pageNumber,
      data: List.generate(
        5,
        (index) =>
            ListData(title: 'title $index', tags: 'tags$index', userId: index),
      ),
    );
    return resp;
  }
}
