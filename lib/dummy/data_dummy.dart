import 'package:shopping_car/models/category_model.dart';
import 'package:shopping_car/models/product_model.dart';

class DataDummy {
  static List<Category> categories = [
    Category(id: "1", name: "Electricidad", imageUrl: "https://www.plcmadrid.es/wp-content/uploads/2017/02/velocidad-electricidad-cable.jpg"),
    Category(id: "2", name: "Plomeria", imageUrl: "https://cdn.forbes.com.mx/2020/06/plomeria-e1593467669275-640x360.jpg")
  ];

  static List<Product> products = [
    Product(id: "1", name: "Cable", sku: "123", description: "Cable de alta resistencia", price: "20.0", imageUrl: "https://www.tecnoseguro.com/media/k2/items/cache/256f1d28767893094218dbbe12498f63_XL.jpg", categoryId: "1"),
    Product(id: "2", name: "Tubo", sku: "321", description: "Tubo de media pulgada", price: "14.50", imageUrl: "https://s1.significados.com/foto/tubo-tube_sm.jpg", categoryId: "2"),
    Product(id: "3", name: "Bateria", sku: "1212", description: "Bateria de litio recargable", price: "150.00", imageUrl: "https://www.teknosolar.com/wp-content/uploads/2018/09/samrt12200-2.jpg", categoryId: "1"),
    Product(id: "1", name: "Cable", sku: "123", description: "Cable de alta resistencia", price: "20.0", imageUrl: "https://www.tecnoseguro.com/media/k2/items/cache/256f1d28767893094218dbbe12498f63_XL.jpg", categoryId: "1"),
    Product(id: "2", name: "Tubo", sku: "321", description: "Tubo de media pulgada", price: "14.50", imageUrl: "https://s1.significados.com/foto/tubo-tube_sm.jpg", categoryId: "2"),
    Product(id: "3", name: "Bateria", sku: "1212", description: "Bateria de litio recargable", price: "150.00", imageUrl: "https://www.teknosolar.com/wp-content/uploads/2018/09/samrt12200-2.jpg", categoryId: "1"),
    Product(id: "1", name: "Cable", sku: "123", description: "Cable de alta resistencia", price: "20.0", imageUrl: "https://www.tecnoseguro.com/media/k2/items/cache/256f1d28767893094218dbbe12498f63_XL.jpg", categoryId: "1"),
    Product(id: "2", name: "Tubo", sku: "321", description: "Tubo de media pulgada", price: "14.50", imageUrl: "https://s1.significados.com/foto/tubo-tube_sm.jpg", categoryId: "2"),
    Product(id: "3", name: "Bateria", sku: "1212", description: "Bateria de litio recargable", price: "150.00", imageUrl: "https://www.teknosolar.com/wp-content/uploads/2018/09/samrt12200-2.jpg", categoryId: "1"),
  ];
}