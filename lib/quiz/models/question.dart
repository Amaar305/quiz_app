import 'package:hive/hive.dart';

part 'question.g.dart';

@HiveType(typeId: 0)
class Question extends HiveObject {
  @HiveField(0)
  final String questionText;
  @HiveField(1)
  final bool questionAnswer;

  Question(this.questionText, this.questionAnswer);
}
