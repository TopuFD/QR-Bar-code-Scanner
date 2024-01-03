import 'package:hive/hive.dart';
part 'data_model.g.dart';

@HiveType(typeId: 0)
class DataModel extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String date;

  DataModel({required this.title, required this.date});
}
