import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;

class SiteIconWidget extends StatefulWidget {
  final String hostname;
  final double size;

  const SiteIconWidget({super.key, required this.hostname, this.size = 24});

  @override
  State<SiteIconWidget> createState() => _SiteIconWidgetState();
}

class _SiteIconWidgetState extends State<SiteIconWidget> {
  late Future<Widget> _future;

  @override
  void initState() {
    super.initState();
    _future = getSiteIcon(widget.hostname);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
        if (snapshot.hasData) {
          return SizedBox(
            width: widget.size,
            height: widget.size,
            child: snapshot.data!,
          );
        } else {
          return SizedBox(
            width: widget.size,
            height: widget.size,
            child: const CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Future<Widget> getSiteIcon(String hostname) async {
    Uri url = Uri.https(hostname);
    http.Response response = await http.get(url);
    dom.Document document = parser.parse(response.body);
    dom.Element? iconElement =
        document.head!.querySelector('link[rel~="icon"]');
    if (iconElement != null) {
      String iconUrl = iconElement.attributes['href'] ?? '';
      if (!iconUrl.startsWith('http')) {
        iconUrl = '$url$iconUrl';
      }
      return SizedBox(
        height: 24,
        width: 24,
        child: Image.network(iconUrl),
      );
    } else {
      return const Icon(
        Icons.public,
        size: 24,
      );
    }
  }
}
