import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:manitfirst/subject.dart';
import 'package:manitfirst/utils/utility.dart';
import '../utils/theme.dart';

class SubjectCard extends StatefulWidget {
  const SubjectCard({
    super.key,
    required this.id,
    required this.data,
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;
  final String id;
  final Map<String, dynamic> data;

  @override
  State<SubjectCard> createState() => _SubjectCardState();
}

class _SubjectCardState extends State<SubjectCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          child: GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Subject(data: widget.data)),
            ),
            child: Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: isHovered
                      ? MyTheme.primary
                      : Utils.isDarkTheme()
                      ? const Color(0x26ffffff)
                      : const Color(0xffE9EEF2),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 100),
                      child: CircleAvatar(
                        backgroundColor: isHovered
                            ? MyTheme.primary
                            : MyTheme.halkaPrimary,
                        radius: 30,
                        child: FaIcon(
                          widget.icon,
                          size: 32,
                          color: isHovered ? Colors.white : MyTheme.primary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.text,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'regular',
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Theme.of(context).textTheme.headlineSmall?.color,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}