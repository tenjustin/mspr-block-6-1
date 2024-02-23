
import 'dart:io';

import 'package:http/http.dart'as http;
import 'package:http/io_client.dart';

class ClientProvider{
  http.Client createClient(){
    var client = HttpClient()
      ..badCertificateCallback = ((X509Certificate cert, String host, int port) => true);

    return IOClient(client);
  }
}