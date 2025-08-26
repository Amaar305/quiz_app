import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:quiz_app/core/app_colors.dart';
import 'package:quiz_app/core/widgets/app_text_field.dart';
import 'package:quiz_app/core/widgets/widgets.dart';
import 'package:quiz_app/quiz/models/question.dart';

class AddQuizPage extends StatefulWidget {
  const AddQuizPage({super.key});

  @override
  State<AddQuizPage> createState() => _AddQuizPageState();
}

class _AddQuizPageState extends State<AddQuizPage> {
  late final TextEditingController _controller;
  bool isTrue = true;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void saveQuiz() {
    final formResult = formKey.currentState?.validate();
    if (formResult != null && formResult) {
      // Save
      final box = Hive.box<Question>('quizzes');

      final quiz = Question(_controller.text.trim(), isTrue);

      box.add(quiz);

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        title: Text('Add Quiz', style: TextStyle(color: AppColors.whiteColor)),
        iconTheme: IconThemeData(color: AppColors.whiteColor),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            AppTextField(
              label: 'Quiz Text',
              controller: _controller,
              maxLine: 3,
              maxLength: 50,
              textInputType: TextInputType.multiline,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Quiz Text should not be empty';
                }

                return null;
              },
            ),
            SwitchListTile(
              title: Text(
                'True/False',
                style: TextStyle(color: AppColors.whiteColor),
              ),
              subtitle: Text('Select if true or false'),
              value: isTrue,
              onChanged: (value) {
                setState(() {
                  isTrue = value;
                });
              },
            ),
            SizedBox(height: 25),
            AppButton(label: 'Add', onTap: saveQuiz),
          ],
        ),
      ),
    );
  }
}
