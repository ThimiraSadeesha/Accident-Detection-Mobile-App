import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'call-emergency.dart';
import 'locator.dart';

class VoiceCommandController {
  stt.SpeechToText speech = stt.SpeechToText();

  Future<void> startForegroundTask() async {
    await FlutterForegroundTask.startService(
      notificationTitle: 'Listening for Help Command',
      notificationText: 'Voice command listener is running in the background.',
      callback: backgroundTaskCallback,
    );
  }

  void startListening() async {
    bool available = await speech.initialize();
    if (available) {
      speech.listen(onResult: (result) {
        if (result.recognizedWords == "Help me") {
          // Handle "Help me" command
          print('Help command recognized');
        } else if (result.recognizedWords == "Call police") {
          callNumber("911");
        } else if (result.recognizedWords == "Where am I") {
          getLocation().then((position) {
            print('Location: ${position.latitude}, ${position.longitude}');
          });
        }
      });
    }
  }
}


void backgroundTaskCallback() {
  VoiceCommandController voiceController = VoiceCommandController();
  voiceController.startListening();
}
