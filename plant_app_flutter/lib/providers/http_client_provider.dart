
import 'dart:io';

import 'package:http/http.dart'as http;
import 'package:http/io_client.dart';

import '../main.dart';

class ClientProvider extends HttpOverrides{
  Future<http.Client> createClient() async {
    var client = HttpClient(context: await globalContext)
      ..badCertificateCallback = ((X509Certificate cert, String host, int port) => true);

    return IOClient(client);
  }
}