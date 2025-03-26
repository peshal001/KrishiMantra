// AI Model Service
import 'dart:io';
import 'dart:typed_data';
//port 'package:tflite_flutter/tflite_flutter.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class AIModelService {
  //te Interpreter _diseaseDetectionInterpreter;

  Future<void> loadModels() async {
    try {
      //iseaseDetectionInterpreter = await Interpreter.fromAsset('assets/models/disease_detection_model.tflite');
      print("Model loaded successfully!");
    } on PlatformException catch (e) {
      print("Error loading model: ${e.message}");
    }
  }

  Future<String> detectDisease(XFile image) async {
    try {
      File imageFile = File(image.path);
      var input = await _processImage(imageFile);
      var output = List.filled(1, 0.0);
      //iseaseDetectionInterpreter.run(input, output);
      return output[0].toString();
    } catch (e) {
      print('Error in disease detection: $e');
      return 'Error detecting disease';
    }
  }

  Future<Float32List> _processImage(File image) async {
    return Float32List(224 * 224 * 3); // Placeholder for actual image processing
  }

  Future<void> closeModel() async {
   //diseaseDetectionInterpreter.close();
    print("Model closed successfully!");
  }
}
