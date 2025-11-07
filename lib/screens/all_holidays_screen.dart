import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/holiday_card.dart';
import '../models/holiday.dart';

class AllHolidaysScreen extends StatefulWidget {
  @override
  _AllHolidaysScreenState createState() => _AllHolidaysScreenState();
}

class _AllHolidaysScreenState extends State<AllHolidaysScreen> {
  final ApiService _apiService = ApiService();
  List<Holiday> _holidays = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAllHolidays();
  }

  Future<void> _loadAllHolidays() async {
    try {
      final holidays = await _apiService.getAllHolidays();
      setState(() {
        _holidays = holidays;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка загрузки списка праздников')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Все праздники'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadAllHolidays,
              child: ListView.builder(
                itemCount: _holidays.length,
                itemBuilder: (context, index) {
                  return HolidayCard(holiday: _holidays[index]);
                },
              ),
            ),
    );
  }
}
