import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/view_models/theme/theme_view_model.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';

class Setting extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.keyboard_backspace),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0.0,
        title: const Text(
          "Settings",
          style: TextStyle(),
        ),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            ListTile(
              title: const Text(
                "Dark Mode",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                ),
              ),
              subtitle: const Text("Use the dark mode"),
              trailing: Consumer<ThemeProvider>(
                builder: (context, notifier, child) => CupertinoSwitch(
                  onChanged: (val) {
                    notifier.toggleTheme();
                  },
                  value: notifier.dark,
                  activeColor: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
            const ListTile(
                title: Text(
                  "About us ",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                // subtitle: Text(
                //   "The SGSITS Student Alumni Club is the official Student-Alumni connect club of SGSITS Indore. We connect and collaborate with our prestigious alumni and organize events for the welfare of the students. The club is started in 2022.",
                // ),

subtitle: ReadMoreText(
  "The SGSITS Student Alumni Club is the official Student-Alumni connect club of SGSITS Indore. We connect and collaborate with our prestigious alumni and organize events for the welfare of the students. The club is started in 2022. ",
  trimLines: 2,
  colorClickableText: Colors.blue,
  trimMode: TrimMode.Line,
  trimCollapsedText: 'Show more',
  trimExpandedText: 'Show less',
  moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
)
,
                trailing: Icon(Icons.error)
                
                
                ),
            const Divider(),
            const ListTile(
                title: Text(
                  "About the developer",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                subtitle: Text(
                  "Developed by Aayush Solanki and Student Alumni Club SGSITS.",
                ),
                trailing: Icon(Icons.keyboard_backspace)),
            Padding(
                padding: const EdgeInsets.fromLTRB(12, 1, 0, 0),
                child: InkWell(
                  onTap: () {
                    _launchURLApp();
                  },
                  child: const Text(
                    'Connect with me ',
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.w600),
                  ),
                )),
            const Divider(),
          ],
        ),
      ),
    );
  }
}

Future<void> _launchURLApp() async {
  // Uri url = 'https://www.linkedin.com/in/aayush-solanki-' as Uri;
  if (!await launchUrl(Uri.parse('https://www.linkedin.com/in/aayush-solanki-'),
      mode: LaunchMode.externalApplication)) {
  } else {
    // launchUrl(Uri.parse('https://www.linkedin.com/in/aayush-solanki-'));
  }
}
// Future<void> _launchURLApp() async {
//   const url = 'https://www.linkedin.com/in/aayush-solanki-';
//   if (!await canLaunch(url)) {
//     await launch(url, forceSafariVC: true, forceWebView: true);
//   } else {
//     launchUrl(Uri.parse('https://www.linkedin.com/in/aayush-solanki-'));
//   }
// }
