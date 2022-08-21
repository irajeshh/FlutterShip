import 'package:equatable/equatable.dart';
import 'package:fluttership/Constants/Constants.dart';




class ProductOption {
  final String title;
  final String description;
  final List<Option> options;
  ProductOption(this.title, this.description, this.options);
}

class Option extends Equatable { //you can create separate class for 
//individual option types, but just showing here an addditonal way
  final String title;
  final double price;
  final OptionType type;


  Option(this.title, this.price, this.type);

  @override
  List<Object> get props => [title, price, type];  

  @override
  String toString() {
  return """
  Option: $title
  Price: $price
  Type: $type
  """;
   }
}