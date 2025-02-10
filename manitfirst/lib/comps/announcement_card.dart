import 'package:flutter/material.dart';
import 'package:manitfirst/utils/utility.dart';

class AnnouncementCard extends StatelessWidget {
  final String author;
  final String date;
  final String title;
  final String desc;
  final String link;

  const AnnouncementCard(
      {super.key,
      required this.author,
      required this.date,
      required this.title,
      required this.desc,
      required this.link});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          if (link.isNotEmpty) {
            Utils.launch(link);
          }
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      author,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      date,
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  title,
                  softWrap: true,
                  style: TextStyle(
                    fontFamily: 'regular',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Theme.of(context).textTheme.headlineSmall?.color,
                  ),
                ),
                SizedBox(height: 5),
                Text(desc, style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 14)),
              ],
            ),
          ),
        ));
  }
}
