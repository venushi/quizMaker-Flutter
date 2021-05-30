import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OptionTitle extends StatefulWidget {
  final String option,description,correctAnswer,optionSelected;
  OptionTitle({
    @required this.optionSelected,@required this.description,@required this.correctAnswer,@required this.option});

  @override
  _OptionTitleState createState() => _OptionTitleState();
}

class _OptionTitleState extends State<OptionTitle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:Row(
        children: [
          Container(
            padding:EdgeInsets.symmetric(vertical: 10, ),
            width:28,
            height:28,
            decoration: BoxDecoration(
              border:Border.all(color:widget.description == widget.optionSelected ? widget.optionSelected== widget.correctAnswer ?
              Colors.green.withOpacity(0.7):Colors.red.withOpacity(0.7):Colors.grey,width:1.4),
              borderRadius: BorderRadius.circular(30),


            ),
            alignment: Alignment.center,
            child:Text("${widget.option}",style: TextStyle(
              color:widget.optionSelected == widget.description ? widget.correctAnswer == widget.optionSelected?
              Colors.green.withOpacity(0.7):
              Colors.red:Colors.grey

            ),

            ),
          ),
          SizedBox(width:8,),
          Text(widget.description,style: TextStyle(fontSize: 16,color:Colors.black54)),

        ],
      )
    )
    ;
  }
}
