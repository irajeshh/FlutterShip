import 'package:equatable/equatable.dart';

class CustomStep extends Equatable{
  final int createdAt;
  final String title;
  final String description;

  CustomStep(this.createdAt, this.title, this.description);

  @override
  List<dynamic> get props => [this.createdAt, this.title, this.description];

  @override
  String toString() {
    return props.toString();
  }

  
}