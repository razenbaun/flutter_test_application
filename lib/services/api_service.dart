import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/holiday.dart';
import '../utils/constants.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  
  factory ApiService() {
    return _instance;
  }
  
  ApiService._internal();

  Future<String> getHoliday(int day) async {
    try {
      final response = await http.post(
        Uri.parse('$BASE_URL/main.php'),
        body: {'day': day.toString()},
      );

      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('Failed to load holiday');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<List<Holiday>> getAllHolidays() async {
    try {
      final response = await http.get(Uri.parse('$BASE_URL/all_holidays.php'));

      if (response.statusCode == 200) {
        final lines = response.body.split('\n');
        final holidays = <Holiday>[];

        for (final line in lines) {
          if (line.trim().isNotEmpty) {
            final parts = line.split('|');
            if (parts.length == 2) {
              holidays.add(Holiday(
                date: parts[0].trim(),
                text: parts[1].trim(),
              ));
            }
          }
        } 

        holidays.sort((a, b) => a.dateTime.compareTo(b.dateTime));
        return holidays;
      } else {
        throw Exception('Failed to load holidays');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
