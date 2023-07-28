import 'package:e_commerce_app/domain/entities/rating.dart';
import 'package:equatable/equatable.dart';

class RatingModel extends Equatable {
  final double? rate;
  final int? count;

  const RatingModel({
    required this.rate,
    required this.count,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) => RatingModel(
        rate: json["rate"]?.toDouble(),
        count: json["count"],
      );

  factory RatingModel.fromEntity(Rating rating) => RatingModel(
        rate: rating.rate,
        count: rating.count,
      );

  Map<String, dynamic> toJson() => {
        "rate": rate,
        "count": count,
      };

  Rating toEntity() => Rating(
        rate: rate!,
        count: count!,
      );

  @override
  List<Object?> get props => [
        rate,
        count,
      ];
}
