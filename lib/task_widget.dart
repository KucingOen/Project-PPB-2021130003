import 'package:flutter/material.dart';
//import 'package:task_manager/const/colors.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({super.key});

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  bool isDone = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: backgroundColors,
      backgroundColor: Colors.grey,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Container(
            width: double.infinity,
            height: 130,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 2))
                ]),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  // image
                  imageTask(),
                  const SizedBox(width: 25),
                  const Text(
                    'title',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  // title & subtitle
                  /* Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 25),

                          Text(
                            'title',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          )


                          */ /*Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'title',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Checkbox(
                                value: isDone,
                                onChanged: (value) {
                                  setState(() {
                                    isDone = !isDone;
                                  });
                                },
                              )
                            ],
                          ),
                          SizedBox(height: 5),
                          Text(
                            'subtitle',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade400),
                          ),
                          Spacer(),
                          Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                children: [
                                  Container(
                                      width: 90,
                                      height: 28,
                                      decoration: BoxDecoration(
                                          // color: custom_green,
                                          color: Colors.green.shade400,
                                          borderRadius:
                                              BorderRadius.circular(18)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 6),
                                        child: Row(
                                          children: [
                                            // Image.asset('images/icon_time.png'),
                                            //SizedBox(),
                                            Text(
                                              'time',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      )),
                                  SizedBox(width: 10),
                                  Container(
                                    width: 90,
                                    height: 28,
                                    decoration: BoxDecoration(
                                        color: Color(0xffE2F6F1),
                                        borderRadius:
                                            BorderRadius.circular(18)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 6),
                                      child: Row(
                                        children: [
                                          // Image.asset('images/icon_edit.png'),
                                          //SizedBox(),
                                          Text(
                                            'edit',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ))*/ /*
                        ],
                      ),
                    ],
                  )*/
                ],
              ),
            )),
      )),
    );
  }

  Widget imageTask() {
    return Container(
      height: 130,
      width: 100,
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
            image: AssetImage('images/notes.png'), fit: BoxFit.cover),
      ),
    );
  }
}
