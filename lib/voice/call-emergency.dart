import 'package:url_launcher/url_launcher.dart';

void callNumber(String number) async {
  final url = 'tel:$number';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
