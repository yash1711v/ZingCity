import 'dart:convert';

import 'package:equatable/equatable.dart';

class FilterPriceItem extends Equatable {
  final double min;
  final double max;

  const FilterPriceItem({
    required this.min,
    required this.max,
  });

  FilterPriceItem copyWith({
    double? min,
    double? max,
  }) {
    return FilterPriceItem(
      min: min ?? this.min,
      max: max ?? this.max,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'min': min,
      'max': max,
    };
  }

  factory FilterPriceItem.fromMap(Map<String, dynamic> map) {
    return FilterPriceItem(
      min: map['min'] != null ? double.parse(map['min'].toString()) : 0.0,
      max: map['max'] != null ? double.parse(map['max'].toString()) : 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory FilterPriceItem.fromJson(String source) =>
      FilterPriceItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [min, max];
}
