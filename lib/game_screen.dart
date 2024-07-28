// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:hangman_flutter/constColor.dart';
import 'package:hangman_flutter/utils.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});
  @override
  State<GameScreen> createState() => _GameScreenState();
}
class _GameScreenState extends State<GameScreen> {

  
void gameControlCenter(){

  setState(() {
    for (int i = 0; i < selectedWord.length; i++) {
      if (selectedWord[i]==letter) {
        questWord[i]=letter;}
        }
        if(!selectedWord.contains(letter)){
          wrongNumber++;
          print(selectedWord);
          if (wrongNumber==6) {
            Future.delayed(
              Duration(milliseconds: 200), () {
                gameOver();}); 
                }
                }   
                if (questWord.join()==selectedWord){
                  Future.delayed(
                    Duration(milliseconds: 200), () {
                      youWin();});
                    }
                    });
}
void youWin(){
  showDialog(context: context, builder: (context)=>AlertDialog(backgroundColor: Colors.deepPurple,
                        actions: [
                          TextButton(onPressed: (){
                            Navigator.of(context).pop();
                            checkLetter();
                          },child: Text("Continue",style:Alertcolorstyle.AlertstyleChild,),),
                        ],
                        title:Text("Correct!!!",style: Alertcolorstyle.AlertstyleWinTitle),
                        actionsPadding: EdgeInsets.all(20),
                        titlePadding: EdgeInsets.all(20),
                      )
                      );
                      }
void gameOver(){
  showDialog(context: context, builder: (context)=>AlertDialog(backgroundColor: Colors.deepPurple,
                        actions: [
                          TextButton(onPressed: (){
                            Navigator.of(context).pop();
                            restart();
                            
                          }, child: Text("Restart",style:Alertcolorstyle.AlertstyleChild),)
                        ],
                        
                        title:Text("Game Over",style: Alertcolorstyle.AlertstyleWinTitle),
                        content:Column(mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Your score is $score ",style:Alertcolorstyle.AlertstyleContent),
                            SizedBox(height: 20,),
                            Text("word is: $selectedWord",style: Alertcolorstyle.AlertstyleContent,),
                          ],
                        ),
                        contentPadding: EdgeInsets.all(40),
                        actionsPadding: EdgeInsets.all(20),
                      )
                      );
}
void checkLetter(){
    setState(() {
      score++;
      wrongNumber=0;
      randomIndex = random.nextInt(words.length);
      selectedWord=words[randomIndex];
      questWord = List.filled(selectedWord.length, "_");
      print(selectedWord);
    });
  }
void restart(){
    setState(() {
      score=0;
      wrongNumber=0;
      randomIndex = random.nextInt(words.length);
      selectedWord=words[randomIndex].toUpperCase();
      questWord = List.filled(selectedWord.length, "_");
      print(selectedWord);
    });
  }

  @override
  Widget build(BuildContext context) {
    
    //width size 
    final width=MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor:backgroundColor,
      appBar: AppBar(
        backgroundColor:backgroundColor,
        centerTitle: true,
        title: Text(
          "HANGMAN GAME",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 30,
            color:screenTextColor,
          ),
          ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(child: Center(
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(width: 40,),
                  Text("Score $score",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 30,color:screenTextColor),),
                  IconButton(icon:Icon(Icons.restart_alt,size: 30,color:screenTextColor),
                  onPressed: (){
                    restart();
                  },
                  ),
                ],
              ),
        
              SizedBox(height: 30,),
              //hang man image!!
              Image.asset("images/$wrongNumber.png",height: 200,),
        
              SizedBox(height: 50,),
        
              //Quest word for loop!!
              Row(mainAxisSize: MainAxisSize.max,mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                  for(int i=0;i<selectedWord.length;i++)
                  Text(questWord[i],style: TextStyle(letterSpacing:20,fontSize: 35,fontWeight: FontWeight.w500,color: Colors.white),)
                  
                ],
              ),
              SizedBox(height: 80,),
              
              //letters in gridview!!
              Container(height:260,width:width,
                child: GridView.builder(itemCount: alphabet.length,primary: false,physics: NeverScrollableScrollPhysics(),
                  gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
                   itemBuilder: (context, index) {
                  return InkWell(
                    child: Center(child: Text(alphabet[index],style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.w600),textAlign: TextAlign.center,)),
                    onTap: (){
                      letter=alphabet[index];
                      gameControlCenter();
                    },
                  );
                },)
              ),
        
            ],
          ),
        )),
      ),
      
    );
  }
}