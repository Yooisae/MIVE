import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mive/provider/authProvider.dart';
import 'package:provider/provider.dart';
import 'package:survey_kit/survey_kit.dart';

class ExerciseFrom extends StatefulWidget {
  ExerciseFrom({Key? key, required this.memberId}) : super(key: key);

  String memberId;
  @override
  _ExerciseFrom createState() => _ExerciseFrom();
}

class _ExerciseFrom extends State<ExerciseFrom> {

  late AuthProvider _authProvider;
  @override
  Widget build(BuildContext context) {
    _authProvider = Provider.of<AuthProvider>(context, listen: false);
    print(widget.memberId);
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Align(
          alignment: Alignment.center,
          child: FutureBuilder<Task>(
            future: getSampleTask(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData &&
                  snapshot.data != null) {
                final task = snapshot.data!;
                return SurveyKit(
                  onResult: (SurveyResult result) {
                    _authProvider.getTraining(result, widget.memberId);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('운동생성완료')),
                    );
                    Navigator.popUntil(context, ModalRoute.withName('/'));
                  },
                  task: task,
                  showProgress: true,
                  localizations: const {
                    'cancel': '',
                    'next': 'Next',
                  },
                  themeData: Theme.of(context).copyWith(
                    colorScheme: ColorScheme.fromSwatch(
                      primarySwatch: Colors.cyan,
                    ).copyWith(
                      onPrimary: Colors.white,
                    ),
                    primaryColor: Colors.cyan,
                    backgroundColor: Colors.white,
                    appBarTheme: const AppBarTheme(
                      color: Colors.white,
                      iconTheme: IconThemeData(
                        color: Colors.cyan,
                      ),
                      titleTextStyle: TextStyle(
                        color: Colors.cyan,
                      ),
                    ),
                    iconTheme: const IconThemeData(
                      color: Colors.cyan,
                    ),
                    textSelectionTheme: TextSelectionThemeData(
                      cursorColor: Colors.cyan,
                      selectionColor: Colors.cyan,
                      selectionHandleColor: Colors.cyan,
                    ),
                    cupertinoOverrideTheme: CupertinoThemeData(
                      primaryColor: Colors.cyan,
                    ),
                    outlinedButtonTheme: OutlinedButtonThemeData(
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                          Size(150.0, 60.0),
                        ),
                        side: MaterialStateProperty.resolveWith(
                              (Set<MaterialState> state) {
                            if (state.contains(MaterialState.disabled)) {
                              return BorderSide(
                                color: Colors.grey,
                              );
                            }
                            return BorderSide(
                              color: Colors.cyan,
                            );
                          },
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        textStyle: MaterialStateProperty.resolveWith(
                              (Set<MaterialState> state) {
                            if (state.contains(MaterialState.disabled)) {
                              return Theme
                                  .of(context)
                                  .textTheme
                                  .button
                                  ?.copyWith(
                                color: Colors.grey,
                              );
                            }
                            return Theme
                                .of(context)
                                .textTheme
                                .button
                                ?.copyWith(
                              color: Colors.cyan,
                            );
                          },
                        ),
                      ),
                    ),
                    textButtonTheme: TextButtonThemeData(
                      style: ButtonStyle(
                        textStyle: MaterialStateProperty.all(
                          Theme
                              .of(context)
                              .textTheme
                              .button
                              ?.copyWith(
                            color: Colors.cyan,
                          ),
                        ),
                      ),
                    ),
                    textTheme: const TextTheme(
                      headline2: TextStyle(
                        fontSize: 28.0,
                        color: Colors.black,
                      ),
                      headline5: TextStyle(
                        fontSize: 24.0,
                        color: Colors.black,
                      ),
                      bodyText2: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                      ),
                      subtitle1: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                      ),
                    ),
                    inputDecorationTheme: const InputDecorationTheme(
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  surveyProgressbarConfiguration: SurveyProgressConfiguration(
                    backgroundColor: Colors.white,
                  ),
                );
              }
              else if(snapshot.connectionState == ConnectionState.done){
                Navigator.pop(context);
              }
              return const CircularProgressIndicator.adaptive();
            },
          ),
        ),
      ),
    );
  }

  Future<Task> getSampleTask() {
    var task = NavigableTask(
      id: TaskIdentifier(),
      steps: [
        InstructionStep(
          title: 'MIVE Training',
          text: '정확한 PT를 위해 고객의 상태를 체크하세요.',
          buttonText: 'start',
        ),
        QuestionStep(
          title: '발',
          answerFormat: const SingleChoiceAnswerFormat(
            textChoices: [
              TextChoice(text: '문제없음', value: 'default'),
              TextChoice(text: '평발', value: 'flat'),
              TextChoice(text: '요족', value: 'caves'),
            ],
            defaultSelection: TextChoice(text: '문제없음', value: 'default'),
          ),
          isOptional: false,
        ),
        QuestionStep(
          title: '무릅',
          answerFormat: const SingleChoiceAnswerFormat(
            textChoices: [
              TextChoice(text: '문제없음', value: 'default'),
              TextChoice(text: '외반슬', value: 'valgum'),
              TextChoice(text: '내반슬', value: 'varum'),
            ],
            defaultSelection: TextChoice(text: '문제없음', value: 'default'),
          ),
          isOptional: false,
        ),
        QuestionStep(
          title: '골반',
          answerFormat: const SingleChoiceAnswerFormat(
            textChoices: [
              TextChoice(text: '문제없음', value: 'default'),
              TextChoice(text: '전반경사', value: 'anterior'),
              TextChoice(text: '후반경사', value: 'posterior'),
            ],
            defaultSelection: TextChoice(text: '문제없음', value: 'default'),
          ),
          isOptional: false,
        ),

        CompletionStep(
          stepIdentifier: StepIdentifier(id: '321'),
          text: 'PT를 시작하시면 됩니다!',
          title: 'Done!',
          buttonText: '운동법 생성',
        ),
      ],
    );
    task.addNavigationRule(
      forTriggerStepIdentifier: task.steps[4].stepIdentifier,
      navigationRule: ConditionalNavigationRule(
        resultToStepIdentifierMapper: (input) {
          switch (input) {
            case "Yes":
              return task.steps[0].stepIdentifier;
            case "No":
              return task.steps[4].stepIdentifier;
            default:
              return null;
          }
        },
      ),
    );
    return Future.value(task);
  }

  Future<Task> getJsonTask() async {
    final taskJson = await rootBundle.loadString('assets/example_json.json');
    final taskMap = json.decode(taskJson);

    return Task.fromJson(taskMap);
  }
}