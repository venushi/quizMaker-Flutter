import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appwe/services/database.dart';
import 'package:flutter_appwe/views/addqusetion.dart';
import 'package:flutter_appwe/widgets/widgets.dart';
import 'package:random_string/random_string.dart';

class CreateQuiz extends StatefulWidget {
  @override
  _CreateQuizState createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  final _formKy = GlobalKey<FormState>();
  String quizImageUrl, quizTitle, quizDescription, quizId;
  DatabaseService databaseService = new DatabaseService();

  bool _isLoading = false;

  createQuizOnline() async {
    if (_formKy.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });

      quizId = randomAlphaNumeric(16);

      Map<String, String> quizMap = {
        "quizId": quizId,
        "quizImgUrl": quizImageUrl,
        "quizTitle": quizTitle,
        "quizDescription": quizDescription,
      };

      await databaseService.addQuizData(quizMap, quizId).then((value) {
        setState(() {
          _isLoading = false;
          Navigator.pushReplacement(
              context, MaterialPageRoute(
              builder: (context) => AddQusetion(quizId: quizId,)));
          // builder: (context) =>  AddQuestion(quizId)

        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black87),
        brightness: Brightness.light,
      ),
      body: _isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Form(
              key: _formKy,
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (val) =>
                            val.isEmpty ? "Enter image URL" : null,
                        decoration: InputDecoration(
                          hintText: "Quiz Image Url",
                        ),
                        onChanged: (val) {
                          quizImageUrl = val;
                        },
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      TextFormField(
                        validator: (val) =>
                            val.isEmpty ? "Enter quiz title" : null,
                        decoration: InputDecoration(
                          hintText: "Quiz title",
                        ),
                        onChanged: (val) {
                          quizTitle = val;
                        },
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      TextFormField(
                        validator: (val) =>
                            val.isEmpty ? "Enter quiz description" : null,
                        decoration: InputDecoration(
                          hintText: "Quiz description",
                        ),
                        onChanged: (val) {
                          quizDescription = val;
                        },
                      ),
                      Spacer(),
                      GestureDetector(
                          onTap: () {
                            createQuizOnline();
                          },
                          child: blueButton(
                            context:context,
                            label: "Create Quiz",
                          )),
                      SizedBox(
                        height: 60,
                      ),
                    ],
                  )),
            ),
    );
  }
}
