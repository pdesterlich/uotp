import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;

class NetworkHelpers {

  static Future<Widget> getSiteIcon(String hostname, double size) async {
    print('get site icon $hostname');
    Uri url = Uri.https(hostname);
    http.Response response = await http.get(url);
    dom.Document document = parser.parse(response.body);
    dom.Element? iconElement =
    document.head!.querySelector('link[rel~="icon"]');
    if (iconElement != null) {
      String iconUrl = iconElement.attributes['href'] ?? '';

      if (iconUrl.startsWith('data')) {
        // String mimeType = iconUrl.split(';')[0].split(':')[1];
        Uint8List bytes = base64.decode(iconUrl.split(',')[1]);
        return Image(
            image: MemoryImage(bytes), width: size, height: size);
      }
      if (!iconUrl.startsWith('http')) {
        iconUrl = '$url/$iconUrl';
      }
      return SizedBox(
        height: 24,
        width: 24,
        child: Image.network(iconUrl),
      );
    }
    return const Icon(
      Icons.public,
      size: 24,
    );
  }

}