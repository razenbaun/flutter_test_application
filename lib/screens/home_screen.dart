import 'package:flutter/material.dart';
import 'all_holidays_screen.dart';
import '../services/api_service.dart';
import '../widgets/holiday_card.dart';
import '../models/holiday.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();
  String _todayHoliday = 'Загрузка...';
  String _tomorrowHoliday = 'Загрузка...';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadHolidays();
  }

  Future<void> _loadHolidays() async {
    try {
      final today = await _apiService.getHoliday(1);
      final tomorrow = await _apiService.getHoliday(2);
      
      setState(() {
        _todayHoliday = today;
        _tomorrowHoliday = tomorrow;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _todayHoliday = 'Ошибка загрузки';
        _tomorrowHoliday = 'Ошибка загрузки';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Праздники'),
        actions: [
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AllHolidaysScreen()),
              );
            },
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadHolidays,
              child: ListView(
                children: [
                  HolidayCard(
                    holiday: Holiday(
                      date: DateTime.now().toString().split(' ')[0],
                      text: _todayHoliday,
                    ),
                    color: Colors.lightBlue[50],
                  ),
                  HolidayCard(
                    holiday: Holiday(
                      date: DateTime.now().add(Duration(days: 1)).toString().split(' ')[0],
                      text: _tomorrowHoliday,
                    ),
                    color: Colors.lightGreen[50],
                  ),
                ],
              ),
            ),
    );
  }
}
