import 'survey.dart';
import 'package:dash_chat/dash_chat.dart';

class Post {
  String title;
  String category;
  String imagePath;
  String content;
  bool isFavorite=false;
  bool onChannel=false;
  List<Survey> surveys;
  List<ChatMessage> messages;

  Post({this.title, this.category, this.imagePath, this.content, this.surveys, this.messages}){
    surveys ??= [];
    messages ??= [
      ChatMessage(
        text: 'Hello! This is a discussion channel of "${title}".',
        user: ChatUser(
            name: "nubjuk",
            uid: "nubjuk",
            avatar: "https://pbs.twimg.com/profile_images/536509461204987905/BGuldKRe_400x400.png"
        ),
        createdAt: DateTime.now()
      )
    ];
  }
}

List getPosts() {
  return [
    Post(
        title: "AI copyright",
        category: "Artificial Intelligence",
        content:
        "  AI has made a painting through deep learning technology. Microsoft recently sold a painting of AI in 8000 dollars. China court also admitted that AI has a right for its creative derivative.",
        surveys:[
          Survey(question: "ok?"),
          Survey(question: "ok?")
        ]
    ),
    Post(
        title: "Introduction to Driving",
        category: "Beginner",
        content:
        "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
    Post(
        title: "Observation at Junctions",
        category: "Beginner",
        content:
        "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
    Post(
        title: "Reverse parallel Parking",
        category: "Intermidiate",
        content:
        "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
    Post(
        title: "Reversing around the corner",
        category: "Intermidiate",
        content:
        "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
    Post(
        title: "Incorrect Use of Signal",
        category: "Advanced",
        content:
        "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
    Post(
        title: "Engine Challenges",
        category: "Advanced",
        content:
        "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed."),
    Post(
        title: "Self Driving Car",
        category: "Advanced",
        content:
        "Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed.  ")
  ];
}
