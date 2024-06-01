import 'package:flutter/material.dart';

class GlobalModal {
  static void loadingModal(deviceWidth, context) {
    showModalBottomSheet(
        isDismissible: true,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(deviceWidth / 20),
              topRight: Radius.circular(deviceWidth / 20)),
        ),
        builder: (context) {
          return PopScope(
            canPop: false,
            child: StatefulBuilder(builder: (context, StateSetter setState) {
              return IntrinsicHeight(
                child: Padding(
                  padding: EdgeInsets.all(deviceWidth / 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Mohon ditunggu',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: deviceWidth / 20,
                        ),
                      ),
                      SizedBox(
                        height: deviceWidth / 20,
                      ),
                      const CircularProgressIndicator(),
                    ],
                  ),
                ),
              );
            }),
          );
        });
  }
}
