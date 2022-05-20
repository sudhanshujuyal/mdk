import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

List<Map> writeData=[
  {'image':'assets/read_nfc.png','title':'Write Data'},
  {'image':'assets/read_nfc.png','title':'Copy Data'},
];
List<Map> data=[
  {'name':'Write a plain text','value': 'Plain/text'},
  {'name':'Map a link','value': 'URL'},
  {'name':'Write SMS','value': 'SMS',},
  {'name':'Write an e-mail','value': 'Email',},
  {'name':'Write a contact','value': 'Contact',},
  {'name':'Write location record','value': 'Location',},
];

List<Map> aboutus=[
  {'name':'What is MDK?','value': 'MDK brings to the forefront unprecedented functionality by simplifying social sharing. '
      'MDK effortlessly sticks to your mobile device or comes in the form of a personalized card that helps you share, connect, and '
      'network with other individuals through just a tap! \n\n The other person doesn\'t need an app or a MDK to receive your info 💥 '
      '\n\nMDK on your side, the sky is truly the limit. It can be used by anyone in any industry to share a customized, all-in-one social '
      'profile to people they meet.\n\nIf you don\'t want to share your whole profile, use MDK Direct feature to directly share your Instagram,'
      ' TikTok, Contact card, Snapchat, etc.\n\nMDK can help improve your networking and will leave a lasting impression on everyone you meet.'},
  {'name':'How does this work?','value': 'MDK products contain a smart chip that wirelessly sends your information to the phone. The sharing is'
      ' initiated by a push notification that will appear on the other person\'s phone. If that notification is tapped, your profile will load '
      'in the browser on their phone.\n\nNo app is required for this! Other individual doesn’t need to have an app installed to receive your '
      'information. It’s a win-win situation! MDK boasts compatibility with almost all devices.'},
];

Map<String, IconData> imagemap = {
  "Plain/text": Icons.text_snippet,
  "URL": Icons.web,
  "SMS": Icons.sms,
  "Email": Icons.contact_mail,
  "Contact": Icons.phone_iphone_outlined,
  "Location": Icons.add_location,
};

showsnacbar(BuildContext context, String mesage){
  var snackBar = SnackBar(
    content: Text(mesage),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void launchMap(String address) async {
  String googleUrl = "https://www.google.com/maps/search/?api=1&query=$address";
  String appleUrl = "https://maps.apple.com/?sll=$address";
  if(Platform.isIOS){
    // for iOS phone only
    await launchUrlString(googleUrl);
  }else{
    // android , web
    await launchUrlString(googleUrl);
  }
}

void launchurl(String url) async {
  if(Platform.isIOS){
    // for iOS phone only
    await launchUrlString(url);
  }else{
    // android , web
    await launchUrlString(url);
  }
}

void opengmail(String mail) async {
  var uri = 'mailto:$mail}?subject=""&body=';
  await launchUrlString(uri);
}

void sendtocall(String s) {
  launchUrlString("tel://$s");
}

void sendtosms(String message) async {
  // Android
  var uri = 'sms:""?body=$message';
  if (await canLaunchUrlString(uri)) {
    await launchUrlString(uri);
  } else {
    // iOS
    var uri = 'sms:""?body=$message';
    if (await canLaunchUrlString(uri)) {
      await launchUrlString(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }
}

