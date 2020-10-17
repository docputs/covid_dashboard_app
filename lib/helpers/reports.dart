import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Reports {
  static Future<Map<String, dynamic>> getReports() async {
    Map<String, dynamic> data = {'overview': null, 'chart': null};
    try {
      var overviewReport = await getOverviewReport();
      final dailyReports = await getDailyReports();

      final date = DateFormat('dd/MM').parse(dailyReports[0]['_id']);

      if (date.day == DateTime.now().day) {
        overviewReport['hoje'] = {
          'casosNovos': dailyReports[0]['casosNovos'],
          'obitosNovos': dailyReports[0]['obitosNovos'],
        };
        overviewReport['ontem'] = {
          'casosNovos': dailyReports[1]['casosNovos'],
          'obitosNovos': dailyReports[1]['obitosNovos'],
        };
      } else {
        overviewReport['hoje'] = null;
        overviewReport['ontem'] = {
          'casosNovos': dailyReports[0]['casosNovos'],
          'obitosNovos': dailyReports[0]['obitosNovos'],
        };
      }
      data['overview'] = overviewReport;
      data['chart'] = dailyReports;

      return data;
    } catch (error) {
      throw error;
    }
  }

  static Future<Map> getOverviewReport() async {
    const url =
        'https://xx9p7hp1p7.execute-api.us-east-1.amazonaws.com/prod/PortalGeralApi';
    try {
      final response = await http.get(url);
      final Map overviewData = json.decode(response.body);
      return {
        'confirmados': overviewData['confirmados'],
        'obitos': overviewData['obitos'],
      };
    } catch (error) {
      throw error;
    }
  }

  static Future<List> getDailyReports() async {
    const url =
        'https://xx9p7hp1p7.execute-api.us-east-1.amazonaws.com/prod/PortalCasos';
    try {
      final response = await http.get(url);
      final List dailyData = json.decode(response.body)['dias'];
      return dailyData.reversed.toList().sublist(0, 7);
    } catch (error) {
      throw error;
    }
  }

  static Future<List> getGlobalRanking() async {
    const url = 'https://coronavirus-19-api.herokuapp.com/countries';
    final response = await http.get(url);
    final responseData = json.decode(response.body);
    return responseData;
  }
}
