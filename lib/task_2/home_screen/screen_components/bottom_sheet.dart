import 'package:flutter/material.dart';
import '../../components/custom_text_field.dart';

Widget bottomSheet({
  required context,
  required String text,
  required TextEditingController titleController,
  required TextEditingController bodyController,
  required Function()? onPressed,
}) {
  showModalBottomSheet<void>(
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {
      double screenWidth = MediaQuery.of(context).size.width;
      double screenHeight = MediaQuery.of(context).size.height;
      return Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Column(
            children: [
              Text(text),
              CustomTextField(
                controller: titleController,
                hintText: 'task title',
                icon: Icons.task,
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              CustomTextField(
                hasNext: false,
                controller: bodyController,
                hintText: 'body',
                icon: Icons.message,
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Row(
                children: [
                  Expanded(
                    flex: (screenWidth * 0.7).round(),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      onPressed: onPressed,
                      child: const Text(
                        'SAVE',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.01,
                  ),
                  Expanded(
                    flex: (screenWidth * 0.4).round(),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'CANCEL',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    },
  );
  return Container();
}
