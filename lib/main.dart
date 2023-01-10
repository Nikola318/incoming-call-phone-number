import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phone_call_demo/next_page.dart';
import 'package:phone_call_demo/platform_channel.dart';
import 'dart:io' show Platform;
// import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:http/http.dart' as http;

Future<void> main() async {
  // await NotificationController.initializeLocalNotifications();
   await NotificationService().init(); 
  runApp(const MyApp());
}

// class NotificationController {
//   static ReceivedAction? initialAction;

//   ///  *********************************************
//   ///     INITIALIZATIONS
//   ///  *********************************************
//   ///
//   static Future<void> initializeLocalNotifications() async {
//     await AwesomeNotifications().initialize(
//         null, //'resource://drawable/res_app_icon',//
//         [
//           NotificationChannel(
//               channelKey: 'alerts',
//               channelName: 'Alerts',
//               channelDescription: 'Notification tests as alerts',
//               playSound: true,
//               onlyAlertOnce: true,
//               groupAlertBehavior: GroupAlertBehavior.Children,
//               importance: NotificationImportance.High,
//               defaultPrivacy: NotificationPrivacy.Private,
//               defaultColor: Colors.deepPurple,
//               ledColor: Colors.deepPurple)
//         ],
//         debug: true);

//     // Get initial notification action is optional
//     initialAction = await AwesomeNotifications()
//         .getInitialNotificationAction(removeFromActionEvents: false);
//   }

//   ///  *********************************************
//   ///     NOTIFICATION EVENTS LISTENER
//   ///  *********************************************
//   ///  Notifications events are only delivered after call this method
//   static Future<void> startListeningNotificationEvents() async {
//     AwesomeNotifications()
//         .setListeners(onActionReceivedMethod: onActionReceivedMethod);
//   }

//   ///  *********************************************
//   ///     NOTIFICATION EVENTS
//   ///  *********************************************
//   ///
//   @pragma('vm:entry-point')
//   static Future<void> onActionReceivedMethod(
//       ReceivedAction receivedAction) async {

//     // if(
//     // receivedAction.actionType == ActionType.SilentAction ||
//     //     receivedAction.actionType == ActionType.SilentBackgroundAction
//     // ){
//     //   // For background actions, you must hold the execution until the end
//     //   print('Message sent via notification input: "${receivedAction.buttonKeyInput}"');
//     //   await executeLongTaskInBackground();
//     // }
//     // else {
//     //   MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(
//     //       '/notification-page',
//     //           (route) =>
//     //       (route.settings.name != '/notification-page') || route.isFirst,
//     //       arguments: receivedAction);
//     // }
//   }

//   ///  *********************************************
//   ///     REQUESTING NOTIFICATION PERMISSIONS
//   ///  *********************************************
//   ///
//   static Future<bool> displayNotificationRationale() async {
//     bool userAuthorized = false;
//     BuildContext context = MyApp.navigatorKey.currentContext!;
//     await showDialog(
//         context: context,
//         builder: (BuildContext ctx) {
//           return AlertDialog(
//             title: Text('Get Notified!',
//                 style: Theme.of(context).textTheme.titleLarge),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Image.asset(
//                         'assets/animated-bell.gif',
//                         height: MediaQuery.of(context).size.height * 0.3,
//                         fit: BoxFit.fitWidth,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 const Text(
//                     'Allow Awesome Notifications to send you beautiful notifications!'),
//               ],
//             ),
//             actions: [
//               TextButton(
//                   onPressed: () {
//                     Navigator.of(ctx).pop();
//                   },
//                   child: Text(
//                     'Deny',
//                     style: Theme.of(context)
//                         .textTheme
//                         .titleLarge
//                         ?.copyWith(color: Colors.red),
//                   )),
//               TextButton(
//                   onPressed: () async {
//                     userAuthorized = true;
//                     Navigator.of(ctx).pop();
//                   },
//                   child: Text(
//                     'Allow',
//                     style: Theme.of(context)
//                         .textTheme
//                         .titleLarge
//                         ?.copyWith(color: Colors.deepPurple),
//                   )),
//             ],
//           );
//         });
//     return userAuthorized &&
//         await AwesomeNotifications().requestPermissionToSendNotifications();
//   }

//   ///  *********************************************
//   ///     BACKGROUND TASKS TEST
//   ///  *********************************************
//   static Future<void> executeLongTaskInBackground() async {
//     print("starting long task");
//     await Future.delayed(const Duration(seconds: 4));
//     final url = Uri.parse("http://google.com");
//     final re = await http.get(url);
//     print(re.body);
//     print("long task done");
//   }

//   ///  *********************************************
//   ///     NOTIFICATION CREATION METHODS
//   ///  *********************************************
//   ///
//   static Future<void> createNewNotification(String phoneNumber) async {
//     bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
//     if (!isAllowed) isAllowed = await displayNotificationRationale();
//     if (!isAllowed) return;

//     await AwesomeNotifications().createNotification(
//         content: NotificationContent(
//             id: -1, // -1 is replaced by a random number
//             channelKey: 'alerts',
//             title: 'Demo for incoming phone number',
//             body: "Incoming call from "+phoneNumber,
//             bigPicture: 'https://storage.googleapis.com/cms-storage-bucket/d406c736e7c4c57f5f61.png',
//             largeIcon: 'https://storage.googleapis.com/cms-storage-bucket/0dbfcc7a59cd1cf16282.png',
//             //'asset://assets/images/balloons-in-sky.jpg',
//             notificationLayout: NotificationLayout.BigPicture,
//             payload: {'notificationId': '1234567890'}),
//         // actionButtons: [
//         //   NotificationActionButton(key: 'REDIRECT', label: 'Redirect'),
//         //   NotificationActionButton(
//         //       key: 'REPLY',
//         //       label: 'Reply Message',
//         //       requireInputText: true,
//         //       actionType: ActionType.SilentAction
//         //   ),
//         //   NotificationActionButton(
//         //       key: 'DISMISS',
//         //       label: 'Dismiss',
//         //       actionType: ActionType.DismissAction,
//         //       isDangerousOption: true)
//         // ]
//     );
//   }

//   static Future<void> scheduleNewNotification() async {
//     bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
//     if (!isAllowed) isAllowed = await displayNotificationRationale();
//     if (!isAllowed) return;

//     await AwesomeNotifications().createNotification(
//         content: NotificationContent(
//             id: -1, // -1 is replaced by a random number
//             channelKey: 'alerts',
//             title: "Huston! The eagle has landed!",
//             body:
//             "A small step for a man, but a giant leap to Flutter's community!",
//             bigPicture: 'https://storage.googleapis.com/cms-storage-bucket/d406c736e7c4c57f5f61.png',
//             largeIcon: 'https://storage.googleapis.com/cms-storage-bucket/0dbfcc7a59cd1cf16282.png',
//             //'asset://assets/images/balloons-in-sky.jpg',
//             notificationLayout: NotificationLayout.BigPicture,
//             payload: {
//               'notificationId': '1234567890'
//             }),
//         actionButtons: [
//           NotificationActionButton(key: 'REDIRECT', label: 'Redirect'),
//           NotificationActionButton(
//               key: 'DISMISS',
//               label: 'Dismiss',
//               actionType: ActionType.DismissAction,
//               isDangerousOption: true)
//         ],
//         schedule: NotificationCalendar.fromDate(
//             date: DateTime.now().add(const Duration(seconds: 10))));
//   }

//   static Future<void> resetBadgeCounter() async {
//     await AwesomeNotifications().resetGlobalBadge();
//   }

//   static Future<void> cancelNotifications() async {
//     await AwesomeNotifications().cancelAll();
//   }
// }

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
// The navigator key is necessary to navigate using static methods
  static final GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      routes: <String, WidgetBuilder>{
        '/nextPage': (BuildContext context) => new NextPage(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  String phoneNumber = 'No call';
  int? state;
  late Animation<Color?> animation;
  late AnimationController controller;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  
  const AndroidNotificationDetails androidPlatformChannelSpecifics = 
    AndroidNotificationDetails(
        channelId: String,   //Required for Android 8.0 or after
        channelName: String, //Required for Android 8.0 or after
        channelDescription: String, //Required for Android 8.0 or after
        importance: Importance,
        priority: Priority
    );

  const IOSNotificationDetails iOSPlatformChannelSpecifics =
    IOSNotificationDetails(
        presentAlert: bool?,  // Present an alert when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
        presentBadge: bool?,  // Present the badge number when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
        presentSound: bool?,  // Play a sound when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
        sound: String?,  // Specifics the file path to play (only from iOS 10 onwards)
        badgeNumber: int?, // The application's icon badge number  (only from iOS 10 onwards)
        attachments: List<IOSNotificationAttachment>?,
        subtitle: String?, //Secondary description  (only from iOS 10 onwards)
        threadIdentifier: String? (only from iOS 10 onwards)
   );
  
  const NotificationDetails platformChannelSpecifics = Platform.isAndroid ? NotificationDetails(android: androidPlatformChannelSpecifics) : NotificationDetails(iOS: iOSPlatformChannelSpecifics);
  // const NotificationDetails platformChannelSpecifics = 
  // NotificationDetails(android: androidPlatformChannelSpecifics);
  
  @override
  void initState() {
    // NotificationController.startListeningNotificationEvents();
    super.initState();

    getPermission().then((value) {
      if (value) {
        
        PlatformChannel().callStream().listen((event) {
          var arr = event.split("-");
          phoneNumber = arr[0];
          state = int.tryParse(arr[1]);
          print("telefon: ${event}");
          setState(() {});
          log("telefon: ${phoneNumber.length}");
          if(phoneNumber.length > 5){
            // NotificationController.createNewNotification(phoneNumber);
            flutterLocalNotificationsPlugin.show(
            12345, 
            "A Notification From My Application" ,
            phoneNumber, 
            platformChannelSpecifics,
            payload: 'data');
              }
        });
      }
    });

    controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    final CurvedAnimation curve =
        CurvedAnimation(parent: controller, curve: Curves.linear);
    animation =
        ColorTween(begin: Colors.white, end: Colors.blue).animate(curve);
    // Keep the animation going forever once it is started
    animation.addStatusListener((status) {
      // Reverse the animation after it has been completed
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
      setState(() {});
    });
    // Remove this line if you want to start the animation later
    controller.forward();
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<bool> getPermission() async {
    if (await Permission.phone.status == PermissionStatus.granted) {
      return true;
    } else {
      if (await Permission.phone.request() == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get Phone Number'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Incoming call number:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(phoneNumber, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            Visibility(
              visible: (state ?? 0) == 0 ? false : true,
              child: AnimatedBuilder(
                animation: animation,
                builder: (BuildContext context, Widget? child) {
                  return Container(
                    color: animation.value,
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed("/nextPage");
                      },
                      child: Text(state == 1
                          ? "Çalıyor"
                          : state == 2
                              ? "Açıldı"
                              : ""),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
