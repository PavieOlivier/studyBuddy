import 'dart:async';
import 'package:notifications/notifications.dart';
import 'package:study_buddy/Logic/Logic.dart' as subMessageLogic;

  Notifications _notifications;
  StreamSubscription<NotificationEvent> _subscription;
  bool isStudying = false ;
  bool _isSecondCallBack = false;
Future <bool> wasProcessed(String message) async {
    return subMessageLogic.processedMessages.contains(message);
  }

  void startListening() {
    _notifications = new Notifications();
    try {
      _subscription = _notifications.notificationStream.listen(onData);
    } on NotificationException catch (exception) {
      print(exception);
    }
  }

  void stopListening() async{
    print('Cancelling the notification');
    await _subscription.cancel();
  }

   void onData(NotificationEvent event) async {
     //print(event);
    if (isStudying == true) {
      //we want to listen only to whats'app messages 
      if (event.packageName == 'com.whatsapp') {
        if (event.packageText == 'WhatsApp') {
          return;
        }
        if(subMessageLogic.networkProcessedMessage.contains(event.packageMessage))
          {
            print('The message \n${event.packageMessage}\nwas processed and important sending notif with the force option');

            subMessageLogic.sendNotification(withName: event.packageText, andMessage: event.packageMessage, forceNotif: true);
          }
        //check if the server did not process this before
        else if (await wasProcessed(event.packageMessage) != true) {
          //we add the message to the list
          
          subMessageLogic.processedMessages.add(event.packageMessage);
          subMessageLogic.serverQueuMessage.add(event.packageMessage);
          subMessageLogic.serverQueuName.add(event.packageText);
          subMessageLogic.tempMessageTime.add(event.timeStamp);
          processData();
        }

      }
    }
  }



  void processData() {
    if (_isSecondCallBack == true) {
      return;
    } else {
      //it takes less than 2 seconds to read all notifications and add them to the list
      Future.delayed(Duration(seconds: 3), () async {
        for (int i = 0; i < subMessageLogic.serverQueuMessage.length; i++) {
          await subMessageLogic.checkMessageImportance(subMessageLogic.serverQueuMessage[i])
              .then((onImportanceValue) async {
            //message not important
            if (onImportanceValue == 0) {
              print('filtering ${subMessageLogic.serverQueuMessage[i]}');
              subMessageLogic.filteredName.add(subMessageLogic.serverQueuName[i]);
              subMessageLogic.filteredMessage.add(subMessageLogic.serverQueuMessage[i]);
              subMessageLogic.messageTime.add(subMessageLogic.tempMessageTime[i]);
            }
            //message important
            else if (onImportanceValue == 1) {
             
                 subMessageLogic.processingName = subMessageLogic.serverQueuName[i];
                await subMessageLogic.sendNotification(
                  forceNotif: false,
                        withName: subMessageLogic.serverQueuName[i],
                        andMessage: subMessageLogic.serverQueuMessage[i]);
                subMessageLogic.networkProcessedMessage.add(subMessageLogic.serverQueuMessage[i]);
            }
          });
        }

        _isSecondCallBack = false;
      });
    }
  }


