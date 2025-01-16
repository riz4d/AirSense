// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LogModel {
  final int? id;
  final String logString;
  final String logTime;

  LogModel({
    this.id,
    required this.logString,
    required this.logTime,
  });

  LogModel copyWith({
    int? id,
    String? logString,
    String? logTime,
  }) {
    return LogModel(
      id: id ?? this.id,
      logString: logString ?? this.logString,
      logTime: logTime ?? this.logTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'logString': logString,
      'logTime': logTime,
    };
  }

  factory LogModel.fromMap(Map<String, dynamic> map) {
    return LogModel(
      id: map['id'] != null ? map['id'] as int : null,
      logString: map['logString'] as String,
      logTime: map['logTime'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LogModel.fromJson(String source) =>
      LogModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'LogModel(id: $id, logString: $logString, logTime: $logTime)';

  @override
  bool operator ==(covariant LogModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.logString == logString &&
        other.logTime == logTime;
  }

  @override
  int get hashCode => id.hashCode ^ logString.hashCode ^ logTime.hashCode;
}
