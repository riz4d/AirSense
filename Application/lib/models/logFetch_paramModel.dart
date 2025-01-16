// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LogFetchParamModel {
  final int rowsPerPage;
  final int currentPage;
  LogFetchParamModel({
    required this.rowsPerPage,
    required this.currentPage,
  });

  LogFetchParamModel copyWith({
    int? rowsPerPage,
    int? currentPage,
  }) {
    return LogFetchParamModel(
      rowsPerPage: rowsPerPage ?? this.rowsPerPage,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'rowsPerPage': rowsPerPage,
      'currentPage': currentPage,
    };
  }

  factory LogFetchParamModel.fromMap(Map<String, dynamic> map) {
    return LogFetchParamModel(
      rowsPerPage: map['rowsPerPage'] as int,
      currentPage: map['currentPage'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory LogFetchParamModel.fromJson(String source) =>
      LogFetchParamModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'LogFetchParamModel(rowsPerPage: $rowsPerPage, currentPage: $currentPage)';

  @override
  bool operator ==(covariant LogFetchParamModel other) {
    if (identical(this, other)) return true;

    return other.rowsPerPage == rowsPerPage && other.currentPage == currentPage;
  }

  @override
  int get hashCode => rowsPerPage.hashCode ^ currentPage.hashCode;
}
