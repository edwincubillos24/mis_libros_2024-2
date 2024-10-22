import 'package:hive/hive.dart';

part 'hive_local_book.g.dart';

@HiveType(typeId: 0)
class HiveLocalBook extends HiveObject {

  @HiveField(0)
  String? title;

  @HiveField(1)
  String? bookImage;

  @HiveField(2)
  String? author;

  @HiveField(3)
  String? publisher;

  @HiveField(4)
  String? description;

}