import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class TableBookingScreen extends StatefulWidget {
  final String restaurantName;

  const TableBookingScreen({super.key, required this.restaurantName});

  @override
  State<TableBookingScreen> createState() => _TableBookingScreenState();
}

class _TableBookingScreenState extends State<TableBookingScreen> {
  int _selectedGuests = 2;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = const TimeOfDay(hour: 18, minute: 0);
  bool _isLunchSelected = false;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Book a Table'),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Restaurant Name
            Text(
              widget.restaurantName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),

            // Number of Guests
            const Text(
              'Select number of guests',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),
            _buildGuestSelector(),
            const SizedBox(height: 24),

            // Calendar for Date Selection
            const Text(
              'Select date',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildCalendar(),
            const SizedBox(height: 16),

            // Meal Type Selection
            const Text(
              'Select meal type',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildMealTypeSelector(),
            const SizedBox(height: 24),

            // Available Time Slots
            const Text(
              'Available Time Slots',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildTimeSlot('6:00 PM', '2 offers available'),
            _buildTimeSlot('6:30 PM', '2 offers available'),
            _buildTimeSlot('7:00 PM', '2 offers available'),
            _buildTimeSlot('7:30 PM', '1 offer available'),
            _buildTimeSlot('8:00 PM', '3 offers available'),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: _confirmBooking,
          child: const Text('CONFIRM BOOKING'),
        ),
      ),
    );
  }

  Widget _buildCalendar() {
    return Card(
      color: Colors.white,
      elevation: 4,
      child: TableCalendar(
        firstDay: DateTime.now(),
        lastDay: DateTime.now().add(const Duration(days: 365)),
        focusedDay: _selectedDate,
        calendarFormat: _calendarFormat,
        availableCalendarFormats: const {
          CalendarFormat.month: 'Month',
          CalendarFormat.twoWeeks: 'Two Weeks',
          CalendarFormat.week: 'Week',
        },
        onFormatChanged: (format) {
          setState(() {
            _calendarFormat = format;
          });
        },
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDate, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDate = selectedDay;
          });
        },
        calendarStyle: CalendarStyle(
          selectedDecoration: BoxDecoration(
            color: Colors.red[400],
            shape: BoxShape.circle,
          ),
          todayDecoration: BoxDecoration(
            color: Colors.red[100],
            shape: BoxShape.circle,
          ),
        ),
        headerStyle: HeaderStyle(
          formatButtonVisible: true,
          titleCentered: true,
          formatButtonDecoration: BoxDecoration(
            color: Colors.red[400],
            borderRadius: BorderRadius.circular(20),
          ),
          formatButtonTextStyle: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildGuestSelector() {
    return Row(
      children: List.generate(5, (index) {
        final guests = index + 1;
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ChoiceChip(
              label: Text('$guests'),
              selected: _selectedGuests == guests,
              onSelected: (selected) {
                setState(() {
                  _selectedGuests = guests;
                });
              },
              selectedColor: Colors.red[400],
              disabledColor: Colors.white,
              labelStyle: TextStyle(
                color: _selectedGuests == guests ? Colors.white : Colors.black,
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildMealTypeSelector() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () => setState(() => _isLunchSelected = true),
            style: OutlinedButton.styleFrom(
              backgroundColor: _isLunchSelected ? Colors.red[50] : null,
              side: BorderSide(
                color: _isLunchSelected ? Colors.red : Colors.grey,
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            child: Text(
              'Lunch',
              style: TextStyle(
                color: _isLunchSelected ? Colors.red : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: OutlinedButton(
            onPressed: () => setState(() => _isLunchSelected = false),
            style: OutlinedButton.styleFrom(
              backgroundColor: !_isLunchSelected ? Colors.red[50] : null,
              side: BorderSide(
                color: !_isLunchSelected ? Colors.red : Colors.grey,
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            child: Text(
              'Dinner',
              style: TextStyle(
                color: !_isLunchSelected ? Colors.red : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeSlot(String time, String offers) {
    final isSelected =
        _selectedTime ==
        TimeOfDay(
          hour: int.parse(time.split(':')[0]),
          minute: int.parse(time.split(' ')[0].split(':')[1]),
        );

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      color: isSelected ? Colors.red[50] : null,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isSelected ? Colors.red[400] : Colors.red[50],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            time,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : Colors.red[600],
            ),
          ),
        ),
        title: Text(
          offers,
          style: TextStyle(
            color: isSelected ? Colors.red[600] : Colors.grey[600],
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: isSelected ? Colors.red[600] : Colors.grey,
        ),
        onTap:
            () => setState(() {
              _selectedTime = TimeOfDay(
                hour: int.parse(time.split(':')[0]),
                minute: int.parse(time.split(' ')[0].split(':')[1]),
              );
            }),
      ),
    );
  }

  void _confirmBooking() {
    final bookingDate = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      _selectedTime.hour,
      _selectedTime.minute,
    );

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Confirm Booking'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.restaurantName),
                const SizedBox(height: 8),
                Text(
                  '${DateFormat('EEE, MMM d, y').format(bookingDate)} at ${_selectedTime.format(context)}',
                ),
                const SizedBox(height: 8),
                Text(
                  'For $_selectedGuests guest${_selectedGuests > 1 ? 's' : ''}',
                ),
                const SizedBox(height: 8),
                Text('Meal Type: ${_isLunchSelected ? 'Lunch' : 'Dinner'}'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Table booked successfully!'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                  Navigator.pop(context); // Return to home screen
                },
                child: const Text('Confirm'),
              ),
            ],
          ),
    );
  }
}
