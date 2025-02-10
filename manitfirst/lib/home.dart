import 'package:auto_height_grid_view/auto_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:manitfirst/announcement.dart';
import 'package:manitfirst/comps/subject_card.dart';
import 'package:manitfirst/pdfview.dart';
import 'package:manitfirst/subject.dart';
import 'package:manitfirst/utils/data.dart';
import 'package:manitfirst/utils/dimen.dart';
import 'package:manitfirst/utils/storage.dart';
import 'package:manitfirst/utils/theme.dart';
import 'package:manitfirst/utils/utility.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  bool dark = Utils.isDarkTheme();
  late Utils utils;

  late Map<String, dynamic> json;

  static HomeState? instance;

  static void setStateWithInstance() {
    if (instance != null) {
      instance!.setState(() {});
    }
  }

  List<SubjectCard> items = [];

  @override
  void initState() {
    Data.setData(LocalStorage.getString('data'));
    json = Data.getData();
    utils = Utils(context: context);

    Permission.notification.isDenied.then((value) {
      if (value) {
        Permission.notification.request();
      }
    });

    items = [
      SubjectCard(
          id: 'maths1',
          data: json['maths1'] ?? {},
          icon: FontAwesomeIcons.squareRootVariable,
          text: 'Mathematics 1'),
      SubjectCard(
          id: 'beee',
          data: json['beee'] ?? {},
          icon: FontAwesomeIcons.boltLightning,
          text: 'Basic Electrical Eng.'),
      SubjectCard(
          id: 'maths2',
          data: json['maths2'] ?? {},
          icon: FontAwesomeIcons.squareRootVariable,
          text: 'Mathematics 2'),
      SubjectCard(
          id: 'mechanics',
          data: json['mechanics'] ?? {},
          icon: FontAwesomeIcons.scaleUnbalancedFlip,
          text: 'Engineering Mechanics'),
      SubjectCard(
          id: 'chemistry',
          data: json['chemistry'] ?? {},
          icon: FontAwesomeIcons.flask,
          text: 'Engineering Chemistry'),
      SubjectCard(
          id: 'physics',
          data: json['physics'] ?? {},
          icon: FontAwesomeIcons.atom,
          text: 'Physics'),
      SubjectCard(
          id: 'evs',
          data: json['evs'] ?? {},
          icon: FontAwesomeIcons.earthAmericas,
          text: 'Environmental Science'),
      SubjectCard(
          id: 'biology',
          data: json['biology'] ?? {},
          icon: FontAwesomeIcons.stethoscope,
          text: 'Biology for Engineers'),
      SubjectCard(
          id: 'manufacturing-science',
          data: json['manufacturing-science'] ?? {},
          icon: FontAwesomeIcons.screwdriver,
          text: 'Manufacturing Science'),
      SubjectCard(
          id: 'language-lab',
          data: json['language-lab'] ?? {},
          icon: FontAwesomeIcons.language,
          text: 'Language Lab'),
      SubjectCard(
          id: 'graphics',
          data: json['graphics'] ?? {},
          icon: FontAwesomeIcons.houseLaptop,
          text: 'Engineering Graphics'),
      SubjectCard(
          id: 'computer-programming',
          data: json['computer-programming'] ?? {},
          icon: FontAwesomeIcons.laptopCode,
          text: 'Computer Programming'),
      SubjectCard(
          id: 'communication-skills',
          data: json['communication-skills'] ?? {},
          icon: FontAwesomeIcons.comments,
          text: 'Communication Skills'),
      SubjectCard(
          id: 'nss',
          data: json['nss'] ?? {},
          icon: FontAwesomeIcons.flag,
          text: 'National Service Scheme'),
      SubjectCard(
          id: 'yoga',
          data: json['yoga'] ?? {},
          icon: FontAwesomeIcons.tree,
          text: 'Yoga'),
      SubjectCard(
          id: 'phe',
          data: json['phe'] ?? {},
          icon: FontAwesomeIcons.tableTennisPaddleBall,
          text: 'Physical Health Education'),
      SubjectCard(
          id: 'lsm',
          data: json['lsm'] ?? {},
          icon: FontAwesomeIcons.kitchenSet,
          text: 'Life Skills Management')
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyTheme>(builder: (context, theme, _) {
      return Scaffold(
        appBar: AppBar(
          leading: null,
          title: Text(
            'MANIT Study Portal',
          ),
          actions: [
            IconButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Announcement())),
                icon: Icon(Icons.notifications)),
            IconButton(
                onPressed: theme.setTheme,
                icon: Icon(
                  Utils.isDarkTheme() ? Icons.sunny : Icons.nightlight,
                  color: Colors.white,
                ))
          ],
        ),
        drawer: Drawer(
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                  width: double.infinity,
                  child: DrawerHeader(
                      decoration:
                          BoxDecoration(color: Theme.of(context).primaryColor),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Image.asset('assets/manit.png',
                              height: 80, width: 80),
                          const SizedBox(height: 10),
                          Text('MANIT Study Portal',
                              style: const TextStyle(
                                  fontFamily: 'regular',
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600)),
                          const SizedBox(height: 10)
                        ],
                      ))),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ListTile(
                    titleTextStyle: Dimen.getSidebarTextStyle(context),
                      leading: Icon(Icons.picture_as_pdf,
                          color:
                              Theme.of(context).textTheme.headlineSmall?.color),
                      title: Text('Syllabus'),
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PDFView(
                                  filePath: 'assets/syllabus.pdf',
                                  title: 'BTech Syllabus',
                                  isAsset: true)))),
                  const SizedBox(height: 8),
                  const Divider(height: Dimen.sidebar_divider_thickness),
                  ListTile(
                      leading: Icon(Icons.share,
                          color:
                              Theme.of(context).textTheme.headlineSmall?.color),
                      title: Text('Share App',
                          style: Dimen.getSidebarTextStyle(context)),
                      onTap: Utils.shareApp),
                  ListTile(
                      leading: Icon(Icons.message,
                          color:
                              Theme.of(context).textTheme.headlineSmall?.color),
                      title: Text('Feature Request',
                          style: Dimen.getSidebarTextStyle(context)),
                      onTap: () => Utils.launch("mailto:me@sumitkmr.com")),
                  const SizedBox(height: 8),
                  const Divider(height: Dimen.sidebar_divider_thickness),
                  const SizedBox(height: 8),
                  ListTile(
                      leading: Icon(Icons.web_outlined,
                          color:
                              Theme.of(context).textTheme.headlineSmall?.color),
                      title: Text('Visit Website',
                          style: Dimen.getSidebarTextStyle(context)),
                      onTap: () => Utils.launch("https://manitfirst.web.app")),
                  ListTile(
                      leading: Icon(Icons.help_outline,
                          color:
                              Theme.of(context).textTheme.headlineSmall?.color),
                      title: Text('Contact Me',
                          style: Dimen.getSidebarTextStyle(context)),
                      onTap: () => Utils.launch("mailto:me@sumitkmr.com")),
                  ListTile(
                      leading: Icon(Icons.desktop_mac_outlined,
                          color:
                              Theme.of(context).textTheme.headlineSmall?.color),
                      title: Text('Desktop App',
                          style: Dimen.getSidebarTextStyle(context)),
                      onTap: () =>
                          Utils.launch("https://manitfirst.web.app/downloads")),
                ],
              )
            ],
          )),
        ),
        resizeToAvoidBottomInset: false,
        body: LayoutBuilder(builder: (context, constraints) {
          double maxW = constraints.maxWidth;
          int crossAxisCount = maxW < 400
              ? 1
              : (maxW < 604
                  ? 2
                  : (maxW < 1091
                      ? 3
                      : maxW < 1300
                          ? 4
                          : (maxW < 1600 ? 5 : 6)));
          return AutoHeightGridView(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              crossAxisCount: crossAxisCount,
              itemCount: items.length,
              builder: (c, i) {
                return items.elementAt(i);
              });
          // List<Widget> children = [];
          // int i = 0;
          // while (i < items.length) {
          //   List<Widget> l = [];
          //   for (int i2 = 0; i2 < crossAxisCount; i2++) {
          //     if (i >= items.length) {
          //       l.add(const Expanded(child: SizedBox()));
          //     } else {
          //       l.add(items.elementAt(i));
          //     }
          //     i++;
          //   }
          //   children.add(Row(spacing: 10, children: l));
          // }
          // return Column(spacing: 10, children: children);
        }),
      );
    });
  }
}
