import 'package:equatable/equatable.dart';

class CategoryDetailEntity extends Equatable {
  final String id;
  final String label;
  final String image;

  const CategoryDetailEntity({required this.id, required this.label, required this.image});
  
  @override
  List<Object?> get props => [id, label, image];
}
