import 'package:flutter/material.dart';
import 'package:flutter_project/models/SheepHistoryModel.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';

class SheepHistoryPage extends StatefulWidget {
  final int sensorId; // sensorId should be an int

  const SheepHistoryPage({Key? key, required this.sensorId}) : super(key: key);

  @override
  _SheepHistoryPageState createState() => _SheepHistoryPageState();
}

class _SheepHistoryPageState extends State<SheepHistoryPage> {
  final List<FlSpot> _spots = [];
  late WebSocketChannel _channel;

  @override
  void initState() {
    super.initState();

    // Connect to WebSocket server
    _channel = WebSocketChannel.connect(Uri.parse('ws://192.168.193.72:3000'));

    // Listen for real-time updates
    _channel.stream.listen((message) {
      final data = json.decode(message);
      if (data.containsKey('sensorId') &&
          data['sensorId'].toString() == widget.sensorId.toString()) {
        setState(() {
          _spots.add(FlSpot(
            data['latitude'].toDouble(),
            data['longitude'].toDouble(),
          ));
        });
      }
    });

    // Fetch historical data from backend API (which interacts with MongoDB)
    fetchHistory();
  }

  SheepHistoryModel? sheepHistoryModel;
  Future<void> fetchHistory() async {
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.193.72:3000/api/sheep/history/${widget.sensorId}'));

      if (response.statusCode == 200) {
        sheepHistoryModel = SheepHistoryModel.fromJson(json.decode(response.body));
        List<dynamic> data = json.decode(response.body);
        setState(() {
          _spots.clear();
          _spots.addAll(data.map((position) {
            return FlSpot(
              position['longitude'].toDouble(),
              position['latitude'].toDouble(),
            );
          }).toList());
        });
      }
    } catch (e) {
      // Handle error
      print('Error fetching history: $e');
    }
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sheep Location History'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LineChart(
          LineChartData(
            gridData: FlGridData(show: true),
            titlesData: FlTitlesData(show: true),
            borderData: FlBorderData(show: true),
            lineBarsData: [
              LineChartBarData(
                spots: _spots,
                isCurved: true,
                barWidth: 3,
                color: Colors.blue, // Fixed color parameter
              ),
            ],
          ),
        ),
      ),
    );
  }
}
