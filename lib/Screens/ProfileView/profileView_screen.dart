import 'package:flutter/material.dart';
import 'package:frontend_looping_ea/Models/project.dart';
import 'package:frontend_looping_ea/Models/user.dart';
import 'package:frontend_looping_ea/Services/user_service.dart';
import 'package:frontend_looping_ea/Shared/shared_preferences.dart';
import 'package:frontend_looping_ea/Shared/side_menu.dart';

// ignore: must_be_immutable
class ProfileView extends StatefulWidget {
  final User user;
  final String userVisited;
  ProfileView(this.user, this.userVisited);

  @override
  _ProfileViewState createState() => _ProfileViewState(user, userVisited);
}

class _ProfileViewState extends State<ProfileView> {
  final User user;
  final String userVisited;
  User visited = new User("", "", "", "", "", "", [], [], "");
  _ProfileViewState(this.user, this.userVisited);
  String? initialAboutMe = "";
  String? initialSkills = "";
  String? candidate = "";
  UserService userService = new UserService();
  String proyectosMios = "No projects until now";
  String? valueText = "";

  @override
  void initState() {
    super.initState();
    userService.getUser(userVisited).then((value) {
      setState(() {
        visited = value;
        if (visited.projectsOwned.length != 0) {
          proyectosMios = buildProjectsOwned(visited.projectsOwned);
        }
        if (visited.aboutMe == null) {
          initialAboutMe = "Hello!";
        } else {
          initialAboutMe = visited.aboutMe;
        }
        if (visited.skills == null) {
          initialSkills = "Write here your skills!";
        } else {
          initialSkills = visited.skills;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //An App Bar is created with the name of the current page
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text('Profile'),
      ),

      //The drawer opens a side menu
      drawer: SideMenu(user: this.user),

      //BackgroundColor of the page
      backgroundColor: Colors.white10,

      //The body contains all the profile information
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //In this container there is the picture, name and icon to the chat
          Container(
            height: 200.0,
            color: Colors.blueGrey,
            padding: const EdgeInsets.all(32.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //ImageBanner(),
                    InkWell(
                        child: Container(
                            alignment: Alignment.bottomLeft,
                            padding: const EdgeInsets.only(bottom: 8),
                            width: 50.0,
                            margin:
                                const EdgeInsets.fromLTRB(4.0, 0.0, 4.0, 0.0),
                            //padding: const EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 4.0),
                            child: buildPhoto(visited))),
                    Container(
                        alignment: Alignment.bottomLeft,
                        padding: const EdgeInsets.fromLTRB(40.0, 0.0, 4.0, 0.0),
                        child: Text(visited.fullname,
                            style: TextStyle(
                                fontSize: 30.0, color: Colors.white))),
                  ],
                )),
                Icon(Icons.chat, color: Colors.white)
              ],
            ),
          ),

          //This container contains the information about me
          Container(
            margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
            color: Colors.grey,
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                      child: Text('About me',
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold))),
                  Container(
                      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                      child: Text(initialAboutMe!))
                ]),
          ),

          //This container constains the information Skills
          Container(
            margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
            color: Colors.grey,
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                      child: Text('Skills',
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold))),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                    child: Text(initialSkills!),
                  )
                ]),
          ),

          //This container contains the information of the Projects
          Container(
            margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
            color: Colors.grey,
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                    child: Text('Projects',
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold))),
                Container(
                  padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                  child: Text(proyectosMios),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  CircleAvatar buildPhoto(User user) {
    try {
      if ((user.photo == null) || (user.photo == "")) {
        return CircleAvatar(child: FlutterLogo(size: 42.00), radius: 42);
      } else {
        try {
          return CircleAvatar(backgroundImage: NetworkImage(user.photo!));
        } catch (e) {
          print(e);
          return CircleAvatar(child: FlutterLogo(size: 42.00), radius: 42);
        }
      }
    } catch (e) {
      print(e);
      return CircleAvatar(child: FlutterLogo(size: 42.00), radius: 42);
    }
  }

  void findCandidate(User userVisited) async {
    String candidate = "";
    await getCandidateUsernameFromSharedPref().then((value) async {
      await userService.getUser(value).then((value) async {
        userVisited = value;
      });
    });
  }

  String buildProjectsOwned(List<Project> projectsOwned) {
    String projectsText = "";
    if (projectsOwned.length != 0) {
      projectsText = projectsOwned[0].name;
    }
    for (int i = 1; i < projectsOwned.length; i++) {
      projectsText = projectsText + ", " + projectsOwned[i].name;
    }
    return projectsText;
  }
}
