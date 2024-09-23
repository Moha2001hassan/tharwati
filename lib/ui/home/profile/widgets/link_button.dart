import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkButton extends StatelessWidget {
  const LinkButton({
    super.key,
    required this.link,
    required this.title,
    required this.img,
    required this.color,
    this.fontColor = Colors.black,
  });

  final String link, title, img;
  final Color color, fontColor;

  Future<void> _launchURL() async {
    final Uri url = Uri.parse(link);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $link';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(15),
      elevation: 10,
      child: InkWell(
        onTap: _launchURL,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(img, width: 25),
              const SizedBox(width: 20),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  color: fontColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
