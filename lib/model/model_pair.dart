import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'model_pair.g.dart';

@JsonSerializable()
class ModelPair extends Equatable {
  final String modelLabel;
  final String modelName;

  const ModelPair({
    required this.modelLabel,
    required this.modelName,
  });

  factory ModelPair.fromJson(Map<String, dynamic> json) =>
      _$ModelPairFromJson(json);

  Map<String, dynamic> toJson() => _$ModelPairToJson(this);

  @override
  List<Object?> get props => [modelLabel, modelName];
}
