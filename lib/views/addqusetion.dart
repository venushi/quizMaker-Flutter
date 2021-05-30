import "package:flutter/material.dart";
import 'package:flutter_appwe/services/database.dart';
import 'package:flutter_appwe/widgets/widgets.dart';

class AddQusetion extends StatefulWidget {

  final String quizId;
  AddQusetion({this.quizId});



  @override
  _AddQusetionState createState() => _AddQusetionState();
}

class _AddQusetionState extends State<AddQusetion> {

  final _formKy = GlobalKey<FormState>();
  String question,option1,option2,option3,option4;
  bool _isLoading = false;

  DatabaseService databaseService = new DatabaseService();

  uploadQuizData() async {
    if (_formKy.currentState.validate()) {

      setState(() {
        _isLoading=true;
      });

      Map<String,String> questionMap ={
        "question":question,
        "option1":option1,
        "option2":option2,
        "option3":option3,
        "option4":option4
      };

      print("Quiz ID : ${widget.quizId}");
      // print("questionMap : ${questionMap}");

      await databaseService.addQuestionData(questionMap, widget.quizId)
        .then((value){
        setState(() {
        _isLoading=false;
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
        body: _isLoading ? Container(
          child: Center(child :CircularProgressIndicator()),
        ): Form(
          key:_formKy,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                TextFormField(
                  validator: (val) =>
                  val.isEmpty ? "Enter Question" : null,
                  decoration: InputDecoration(
                    hintText: "Question",
                  ),
                  onChanged: (val) {
                    question = val;
                  },
                ),

                TextFormField(
                  validator: (val) =>
                  val.isEmpty ? "Enter Option 1" : null,
                  decoration: InputDecoration(
                    hintText: "Option 1",
                  ),
                  onChanged: (val) {
                    option1 = val;
                  },
                ),

                TextFormField(
                  validator: (val) =>
                  val.isEmpty ? "Enter Option 2" : null,
                  decoration: InputDecoration(
                    hintText: "Option 2",
                  ),
                  onChanged: (val) {
                    option2 = val;
                  },
                ),

                TextFormField(
                  validator: (val) =>
                  val.isEmpty ? "Enter Option 3" : null,
                  decoration: InputDecoration(
                    hintText: "Option 3",
                  ),
                  onChanged: (val) {
                    option3 = val;
                  },
                ),

                TextFormField(
                  validator: (val) =>
                  val.isEmpty ? "Enter Option 4" : null,
                  decoration: InputDecoration(
                    hintText: "Option 4",
                  ),
                  onChanged: (val) {
                    option4 = val;
                  },
                ),
                Spacer(),
                Row(

                  children: [
                    GestureDetector(
                      onTap:(){
                      Navigator.pop(context) ;

                      },
                      child: blueButton(context: context,
                          label: "Submit",
                          buttonWidth: MediaQuery
                              .of(context)
                              .size
                              .width / 2 - 36),
                    ),

                    SizedBox(width: 24),

                    GestureDetector(
                      onTap: () {
                        uploadQuizData();
                      },
                      child: blueButton(context: context,
                          label: "Add Query",
                          buttonWidth: MediaQuery
                              .of(context)
                              .size
                              .width / 2 - 36),
                    ),
                  ],
                ),
                SizedBox(height: 60,),

              ],),
          ),
        ),
      );
    }







}
