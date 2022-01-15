import 'package:flutter/material.dart';
class Exercises extends StatefulWidget {
  @override
  _ExercisesState createState() => _ExercisesState();
}

class _ExercisesState extends State<Exercises> {
  @override
  Widget build(BuildContext context) {
    final title = "ListView";

    List choices = const [
      const Choice(
          title: 'Practice pranayama and yoga',
          date: 'Morning Times',
          description:
          'To combat the stress, pranayama and yoga should be made a regular part of your regime. It does not need any fancy equipment, just your mat and your will to stay fit and healthy.',
          imglink:
          'https://firebasestorage.googleapis.com/v0/b/miniproject5717.appspot.com/o/exercises%2Fmeditation.jpeg?alt=media&token=6b04f585-3e44-4501-9b10-c5a901ca35d5'),
     
      const Choice(
          title: 'Vajrasanam',
          date: 'Any Time after eating',
          description:
          'Vajrasana has been named after the shape it takes – a diamond or thunderbolt.  Benefit is : Enhances blood circulation in the lower abdomen, improving digestion. Relieves excessive gas and pain in the stomach region.',
          imglink:
          'https://firebasestorage.googleapis.com/v0/b/miniproject5717.appspot.com/o/exercises%2Fvajrasanam.jpeg?alt=media&token=56ceb065-3b7b-47bf-8a13-fdaf6b5ff1b7'),
      const Choice(
          title: 'Toe Touch',
          date: 'Every Day',
          description:
          'Stretching out your lower back and hamstrings via toe touches also helps to boost circulation, meaning that post-exercise repair is speedier and more efficient, and the more blood and oxygen you get to your joints, the better for long term mobility and well as short term gains (and preventing falls)',
          imglink:
          'https://firebasestorage.googleapis.com/v0/b/miniproject5717.appspot.com/o/exercises%2Ftoetoucher.jpeg?alt=media&token=08ffb5b3-31cd-44d4-af18-d09281c4b736'),
      const Choice(
          title: 'Child Pose',
          date: 'Sun Set Times',
          description:
          'Benefits: Releases tension in the back, shoulders and chest.It lengthens and stretches the spine. Relieves neck and lower back pain when performed with the head and torso supported.',
          imglink:
          'https://firebasestorage.googleapis.com/v0/b/miniproject5717.appspot.com/o/exercises%2Fchildpose.jpeg?alt=media&token=9f347408-6535-4efb-b9ba-9adb5f518a8f'),
    ];

    return MaterialApp(
        title: title,
        debugShowCheckedModeBanner: false,
        home: Scaffold(

            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("lib/img/best.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              width: MediaQuery.of(context).size.width,
              child: new ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(20.0),
                  children: List.generate(choices.length, (index) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      child: Center(

                        child: ChoiceCard(
                            choice: choices[index], item: choices[index]),
                      ),
                    );
                  })),
            )));
  }
}

class Choice {
  final String title;
  final String date;
  final String description;
  final String imglink;

  const Choice({this.title, this.date, this.description, this.imglink});
}

class ChoiceCard extends StatelessWidget {
  const ChoiceCard(
      {Key key,
        this.choice,
        this.onTap,
        @required this.item,
        this.selected: false})
      : super(key: key);

  final Choice choice;

  final VoidCallback onTap;

  final Choice item;

  final bool selected;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.display1;

    if (selected)
      textStyle = textStyle.copyWith(color: Colors.lightGreenAccent[400]);

    return Card(

        color: Colors.white,
        child: Column(
          children: [
            new Container(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(choice.imglink)),
            new Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(choice.title, style: Theme.of(context).textTheme.title),
                  Text(choice.date,
                      style: TextStyle(color: Colors.black.withOpacity(0.5))),
                  Text(choice.description),
                ],
              ),
            )
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ));
  }
}
