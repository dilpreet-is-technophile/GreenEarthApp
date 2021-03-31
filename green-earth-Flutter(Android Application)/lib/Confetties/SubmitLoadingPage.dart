import 'package:flutter/material.dart';
import 'package:green_earth/Confetties/confetti.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:green_earth/Home Page/mainpage.dart';

class SubmitLoadingPage extends StatefulWidget {
  final PickedFile myImage;
  final String token;
  SubmitLoadingPage(this.myImage,this.token);
  @override
  _SubmitLoadingPageState createState() => _SubmitLoadingPageState();
}

class _SubmitLoadingPageState extends State<SubmitLoadingPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: imageFutureCaller(widget.myImage,widget.token),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          print("666666666666666666666");
          if (snapshot.hasError) {
            print("++++++++ ${snapshot.error}");
            return Container(
                  child: Text(
                    '${snapshot.error} occured',
                    style: TextStyle(fontSize: 18),
                  ),
            );
          }
          else if(snapshot.hasData){
            print("fffffffff2222 ${snapshot.data}");
            if(snapshot.data==true){
              print("fffffffff");
              // Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) =>
              //             Confetti()));
              return Confetti();
            }
            else{
              return Container(child: Text("Sorry!, Image not uploaded"));
            }
          }
          else{
            return Container(
              color: Colors.white,
                    alignment: Alignment.center,
                    child:CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Future<bool> imageFutureCaller(PickedFile myImage, String token) async {
    try {
      print('xxxxxxxxxxxx------------xxxxxxxxxx$myImage');
      //String filename=myImage.path.split('/').last;
      String filename = myImage.path.toString();
      print('');
      print('%%%%%%%%%%$filename');
      print('');
      var request = await http.MultipartRequest(
          'POST', Uri.parse('http://green-earth.herokuapp.com/uploadphoto'));
      request.headers['authorization'] = 'Bearer '+token;
      print('');
      print('###########');
      print('');
      request.files.add(await http.MultipartFile.fromPath('image', filename));
      print('zzzzzzzzzzzzzzzzzzzzzzz');

      var res = await request.send();
      print(res);
      print("");
      print('mmmmmmmmmmmmmmmmmmmm');
      print(res.statusCode);
      if (res.statusCode == 200) {
        print("image uploaded");
        successfulUploadedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
        return true;
      } else {
        return false;
        print('error');
      }
    } catch (e) {
      print(e);
      print("image not uploaded");
    }
  }
}
