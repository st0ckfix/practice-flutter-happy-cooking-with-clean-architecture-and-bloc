import 'package:equatable/equatable.dart';

class CategoryDetailItemEntity extends Equatable {
  final String id;
  final String label;
  final String image;
  final String type;

  const CategoryDetailItemEntity({
    required this.id,
    required this.label,
    required this.image,
    required this.type,
  });

  @override
  List<Object?> get props => [id, label, image, type];
}
