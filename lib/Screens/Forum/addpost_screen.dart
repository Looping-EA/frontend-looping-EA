import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:frontend_looping_ea/Models/post.dart';
import 'package:frontend_looping_ea/Models/user.dart';
import 'package:frontend_looping_ea/Shared/shared_preferences.dart';
import 'package:frontend_looping_ea/Shared/side_menu.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import '../../styles.dart';
import 'package:frontend_looping_ea/styles.dart';
import 'package:intl/intl.dart';
import '../../Shared/shared_preferences.dart';


class AddPostScreen extends StatefulWidget {
  final User user;
  AddPostScreen({key, required this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AddPostState(this.user);
  }
}

class AddPostState extends State<AddPostScreen> {
  final User user;
  AddPostState(this.user);

  final _formKey = GlobalKey<FormBuilderState>();
  final _post = Post("","","");

  @override
  Widget build(BuildContext context) {
    print(user.uname);
    return Scaffold(
        //An App Bar is created with the name of the current page
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Text('Add Post'),
        ),

        //The drawer opens a side menu
        drawer: SideMenu(user: this.user),
        backgroundColor: Styles.colorBackground,
        body: Center(
            child: Container(
                width: 700,
                height: 700,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.black38,
                      offset: new Offset(10.0, 10.0),
                    ),
                  ],
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Write your post!',
                          style: Styles.title,
                        )
                      ],
                    ),
                    FormBuilder(
                        key: _formKey,
                        child: SizedBox(
                            width: 600,
                            child: Column(
                              children: [
                                FormBuilderTextField(
                                  maxLines: 7,
                                  name: 'message',
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(context)
                                  ]),
                                  decoration: InputDecoration(
                                      hintText: 'Enter your message',
                                      labelText: "Message",
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)))),
                                ),
                                SizedBox(height: 20)
                              ],
                            ))),
                    SizedBox(height: 10),
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            new BoxShadow(
                              color: Colors.black26,
                              offset: new Offset(5.0, 5.0),
                            ),
                          ],
                        ),
                        child: SizedBox(
                            height: 60,
                            width: 120,
                            child: ElevatedButton(
                                onPressed: _onPressButton,
                                style: ElevatedButton.styleFrom(
                                  primary: Styles.colorBackground,
                                ),
                                child: Text(
                                  'Post!',
                                  style: Styles.button_big,
                                ))))
                  ],
                ))));
  }

  void _onPressButton() {
    final validator = _formKey.currentState!.validate();

    if (validator) {
      // SAVE THE STATE OF THE FORM
      _formKey.currentState!.save();

      // GRAB THE FIELDS
      _post.msg = _formKey.currentState!.fields['message']!.value;

      // http?
      try {
        var post = new Post("", "", "");
        _createPost().then((value) {
          post = value;
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddPostScreen(user: this.user)));
        });
      } catch (err) {
        print(err);
      }
    } else {}
  }

  Future<Post> _createPost() async {
    Post post = new Post("", "", "");
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    String? token;
    try {
      await getTokenFromSharedPrefs().then((value) => token = value);
      print(token);
      print("token printed above");
    } catch (err) {
      print(err);
    }

    // create JSON object
    final body = {
      "uname": user.uname,
      "msg" : _post.msg,
      "date": formattedDate,
    };
    final bodyParsed = json.encode(body);


    // finally the POST HTTP operation
    return await http
        .post(Uri.parse("http://localhost:8080/api/post/add"),
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json'
            },
            body: bodyParsed)
        .then((http.Response response) {
      if (response.statusCode == 201) {
        return Post.fromJson(json.decode(response.body));
      } else {
        return new Post("", "", "");
      }
    });
  }
}