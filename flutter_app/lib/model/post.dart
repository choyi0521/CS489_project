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
  String link;
  String linktext;
  int postnum;

  Post({this.title, this.category, this.imagePath, this.content, this.surveys, this.messages, this.linktext, this.link, this.postnum}){
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
        imagePath: "assets/default_post_image.jpg",
        content:
        "  AI has made a painting through deep learning technology. Microsoft recently sold a painting of AI in 8000 dollars. China court also admitted that AI has a right for its creative derivative.\n"
            " For more details, please refer to this link: ",
        surveys:[
          Survey(question: "Do you agree with AI having its own personality so it can have own copyright?"),
          Survey(question: "Do you agree with the opinion that AI's works are also artistic as every artistic outcome is influenced by others?")
        ],
        link: "https://www.asiae.co.kr/article/2017021508251055703",
        linktext: "What if AI claims for copyright?",
        postnum: 1,
    ),
    Post(
        title: "Autonomous car",
        category: "Artificial Intelligence",
        content:
        " Nowadays, press is saying that autonomous driving is almost real thing. It will bring great comfort and improvement on various fields. But simultaneously, some are considering of safety problem it will bring.\n"
            " For more details, please refer to this link: ",
        imagePath: "assets/autonomous.jpg",
        surveys:[
          Survey(question: "How do you think about commercialize the autonomous car(level 5)?"),
          Survey(question: "Do you think autonomous vehicles will cause accidents or other ethical problems than human drivers?")
        ],
        link: "http://www.coincatmedia.com/7949",
        linktext: "Who's to blame when a self-driving car has an accident?",
        postnum: 2),
    Post(
        title: "AI interview for hiring",
        category: "Artificial Intelligence",
        imagePath: "assets/job_interview.jpeg",
        content:
        " Due to the improvement of AI, some of the companies are considering AI hiring system which means AI will be the decision maker on hiring people. Definitely this will bring several benefits as cost saving, "
            "lower press on interview, and even some fairness. But some think that this is too imperfect as AIs cannot consider many things such as gesture or emotions. What do you think about this?\n "
            " For more details, please refer to this link: ",
        surveys:[
          Survey(question: "If you are the candidate for job interview, will you agree on AI interviewing you?"),
          Survey(question: "What if there is an AI that can consider sophisticated factors like emotions and gestures. Do you agree that this kind of AI can be better than human?")
        ],
        link: "https://slate.com/technology/2020/10/artificial-intelligence-job-interviews.html",
        linktext: "Should Robots be conducting job interviews?",
        postnum: 3),
    Post(
        title: "Gig economy",
        category: "Telecommunication",
        imagePath: "assets/gig_economy.jpg",
        content:
        " Telecommunication technology has improved tremendously with internet. Working is not an off-house stuff anymore. Working from home is a new form of working. This is called gig economy. "
            "While there is a advantage that people can easily earn money while they are in home, also there is a disadvantage that payment for specific works are so low. What do you think about society transforming to gig economy?\n"
            " For more details, please refer to this link: ",
        surveys:[
          Survey(question: "Do you agree with society changing into gig economy?"),
          Survey(question: "Is gig economy also has the similar form of nowadays working environment? Especially on ethical side?")
        ],
        link: "https://www.flexjobs.com/blog/post/what-is-the-gig-economy-v2/",
        linktext: "What is Gig economy, pros&cons",
        postnum: 4),
    Post(
        title: "Deep fake",
        category: "Artificial Intelligence",
        imagePath: "assets/deep_fake.jpg",
        content:
        " As computer science and digital signal processing techniques improved, there are many derivatives from them. One is deep fake tech. What it does is to replace one another's into total difference person's face"
            "There are many videos made with this tech in Youtube. It's fun but causing lots of problems such as making rumors or fake pornography. What do you think about this amazing thing?\n"
            " For more details, please refer to this link: ",
        surveys:[
        Survey(question: "Do you agree with free deep fake technology meaning that its own person's right to create what they want? (Regardless of copyright problem)"),
        Survey(question: "Do you think there can be any good aspect on using deep fake technology?")
        ],
        link: "https://electronics.howstuffworks.com/future-tech/deepfake-videos-scary-good.htm",
        linktext: "Deep fake videos are getting scary good",
        postnum: 5),
    Post(
        title: "Neuralink",
        category: "Artificial Intelligence",
        imagePath: "assets/neuralink.jpg",
        content:
        " Neuralink is developing the technology to plant computer chips in the brain. in August this year, Neuralink CEO Musk introduced a pig with a chip implanted in its brain. "
            "He also made headlines for introducing surgical robots that automatically perform chip transplants. Musk expects that if transplanted into a human brain and working properly, it will help patients with numbness or degenerative diseases. "
            "However, there are also voices of concern because implanting chips into a human brain is directly linked to life.\n"
            " For more details, please refer to this link: ",
        surveys:[
          Survey(question: "Do you agree with the clinical trial of implanting and testing chips in the human brain?"),
          Survey(question: "Do you think the scale is manageable when a situation like hacking occurs?")
        ],
        link: "https://www.nbcnews.com/tech/tech-news/elon-musk-s-neuralink-puts-computer-chips-pigs-brains-bid-n1238782",
        linktext: "Elon Musk's Neuralink puts computer chips in pigs' brains in bid to cure diseases",
        postnum: 6),
    Post(
        title: "Privacy vs public interest",
        category: "Security",
        imagePath: "assets/personal.jpg",
        content:
        " The iPhone even if an iPhone user is arrested for a crime. In fact, there were 11 casualties in Florida last December, and the culprit was using an iPhone. "
            "FBI asked to release the iPhone for investigation, but Apple refused it. Due to the attitude of Apple, there is sharp conflict between the claim that it is legitimate privacy protection and the claim that it hinders the investigation.\n"
            " For more details, please refer to this link: ",
        surveys:[
          Survey(question: "Do you think Apple is justified in not cooperating with the investigation?"),
          Survey(question: "If so, do you think it is an invasion of privacy for the FBI to release the criminal's cell phone?")
        ],
        link: "https://nakedsecurity.sophos.com/2020/05/20/fbi-finally-unlock-shooters-iphones-berate-apple-for-not-helping/",
        linktext: "FBI finally unlock shooter’s iPhones, Apple berated for not helping",
        postnum: 7),
    Post(
        title: "Role of media platform",
        category: "Media platform",
        imagePath: "assets/fake_news.jpg",
        content:
        " As technology advances, the size and volume of media platforms such as YouTube and Facebook are growing, and it is expected to continue to be."
            " As the influence of the media platform grows, positive effects such as events and accidents that were previously uninterested are occurring to the public. "
            "On the other hand, negative effects are occurring, such as spreading information favorable to certain political forces, regardless of whether it is true or false. "
            "As negative effects grow, there is talk of how much media platforms should intervene in various situations, namely the role of media platforms.\n"
            " For more details, please refer to this link: ",
        surveys:[
          Survey(question: "Do you think media platforms have an obligation to intervene in situations where negative effects can occur?"),
          Survey(question: "Do you think the media platform is also responsible if a crime has occurred through the media platform?")
        ],
        link: "https://www.vice.com/en/article/z3vxdx/youtube-is-doing-basically-nothing-to-stop-election-misinformation-from-spreading",
        linktext: "YouTube Is Doing Very Little to Stop Election Misinformation From Spreading",
        postnum: 8),
  ];
}
