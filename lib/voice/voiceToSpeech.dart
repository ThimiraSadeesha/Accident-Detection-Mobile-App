import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'call-emergency.dart';
import 'locator.dart';

class VoiceCommandController {
  stt.SpeechToText speech = stt.SpeechToText();

  void startListening() async {
    bool available = await speech.initialize();
    if (available) {
      speech.listen(onResult: (result) {
        if (result.recognizedWords == "Help me") {
          print('sdfsdnfdswfnw');
        } else if (result.recognizedWords == "Call police") {
          callNumber("911");
        } else if (result.recognizedWords == "Where am I") {
          getLocation().then((position) {});
        }
      });
    }
  }
}
