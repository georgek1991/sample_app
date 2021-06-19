class ListResponse {
  int pageNumber = 0;
  int? pageSize;
  List<ListData>? data;

  ListResponse({
    this.pageNumber = 0,
    this.pageSize,
    this.data,
  });

  ListResponse.fromJson(Map<String, dynamic> json) {
    pageNumber = json['pageNumber'];
    pageSize = json['pageSize'];

    if (json['data'] != null) {
      data = <ListData>[];
      json['data'].forEach((v) {
        data!.add(new ListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pageNumber'] = this.pageNumber;
    data['pageSize'] = this.pageSize;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListData {
  int? userId;
  String? title;
  String? tags;

  ListData({
    this.userId,
    this.title,
    this.tags,
  });

  ListData.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    title = json['title'];
    tags = json['tags'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['title'] = this.title;
    data['tags'] = this.tags;
    return data;
  }
}
