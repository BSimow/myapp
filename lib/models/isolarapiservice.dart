// lib/services/isolarchart_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class ISolarApiService {
  static const _baseUrl = 'https://gateway.isolarcloud.com.hk/openapi';
  final String appKey, userAccount, userPassword, accessKey;
  final Map<String, String> defaultHeaders;

  String? _token;
  String? _psKey;

  ISolarApiService({
    required this.appKey,
    required this.userAccount,
    required this.userPassword,
    required this.accessKey,
  }) : defaultHeaders = {
          'x-access-key': accessKey,
          'sys_code': '901',
          'Content-Type': 'application/json;charset=UTF-8',
        };

  Future<void> login() async {
    final resp = await http.post(
      Uri.parse('$_baseUrl/login'),
      headers: defaultHeaders,
      body: jsonEncode({
        'appkey': appKey,
        'user_account': userAccount,
        'user_password': userPassword,
        'lang': '_en_US',
      }),
    );
    if (resp.statusCode == 200) {
      _token = jsonDecode(resp.body)['result_data']['token'];
    } else {
      throw Exception('Login failed: ${resp.statusCode}');
    }
  }

  Future<void> fetchPsKey() async {
    if (_token == null) await login();

    final plantResp = await http.post(
      Uri.parse('$_baseUrl/getPowerStationList'),
      headers: defaultHeaders,
      body: jsonEncode({
        'appkey': appKey,
        'token': _token,
        'curPage': 1,
        'size': 10,
        'lang': '_en_US',
      }),
    );
    if (plantResp.statusCode != 200) {
      throw Exception('Plant list failed: ${plantResp.statusCode}');
    }
    final psId = jsonDecode(plantResp.body)['result_data']['pageList'][0]['ps_id'];

    final deviceResp = await http.post(
      Uri.parse('$_baseUrl/getDeviceList'),
      headers: defaultHeaders,
      body: jsonEncode({
        'appkey': appKey,
        'token': _token,
        'ps_id': psId,
        'curPage': 1,
        'size': 10,
      }),
    );
    if (deviceResp.statusCode == 200) {
      _psKey = jsonDecode(deviceResp.body)['result_data']['pageList'][0]['ps_key'];
    } else {
      throw Exception('Device list failed: ${deviceResp.statusCode}');
    }
  }

  Future<Map<String, dynamic>> fetchData({
    required String dataPoint,
    required String dataType, // "day", "month", "year"
    required DateTime start,
    required DateTime end,
  }) async {
    if (_psKey == null) await fetchPsKey();

    final url = Uri.parse('$_baseUrl/getDevicePointsDayMonthYearDataList');
    final params = {
      'appkey': appKey,
      'token': _token,
      'lang': '_en_US',
      'data_point': dataPoint,
      'data_type': '2', // assuming this placeholder
      'ps_key_list': [_psKey],
      'query_type': dataType == 'day' ? '1' : dataType == 'month' ? '2' : '3',
      'start_time': _formatDate(start, dataType),
      'end_time': _formatDate(end, dataType),
      'order': 0,
    };

    final resp = await http.post(url, headers: defaultHeaders, body: jsonEncode(params));
    if (resp.statusCode == 200) {
      return jsonDecode(resp.body);
    } else {
      throw Exception('Data fetch failed: ${resp.statusCode}');
    }
  }

  Future<Map<String, dynamic>> fetchMinuteData({
    required DateTime start,
    required DateTime end,
  }) async {
    if (_psKey == null) await fetchPsKey();

    final url = Uri.parse('$_baseUrl/getDevicePointMinuteDataList');
    final params = {
      'appkey': appKey,
      'token': _token,
      'lang': '_en_US',
      'ps_key_list': [_psKey],
      'points': 'p24',
      'start_time_stamp': _formatTimeStamp(start),
      'end_time_stamp': _formatTimeStamp(end),
    };

    final resp = await http.post(url, headers: defaultHeaders, body: jsonEncode(params));
    if (resp.statusCode == 200) {
      return jsonDecode(resp.body);
    } else {
      throw Exception('Minute data failed: ${resp.statusCode}');
    }
  }

  String _formatDate(DateTime dt, String type) {
    if (type == 'year') {
      return dt.toIso8601String().substring(0, 4);
    } else if (type == 'month') {
      return dt.toIso8601String().substring(0, 7).replaceAll('-', '');
    } else {
      return dt.toIso8601String().substring(0, 10).replaceAll('-', '');
    }
  }

  String _formatTimeStamp(DateTime dt) =>
      '${dt.year}${_two(dt.month)}${_two(dt.day)}${_two(dt.hour)}${_two(dt.minute)}00';

  String _two(int value) => value.toString().padLeft(2, '0');
}
