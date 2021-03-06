import 'package:flutter/material.dart';

import '../custom/text_style.dart';
import '../html_open_link.dart';
import '../theme/config.dart';
import 'data.dart';

class ProjectsCard extends StatefulWidget {
  const ProjectsCard(
      {Key? key,
      required this.height,
      required this.width,
      required this.title,
      required this.techStack,
      required this.desc,
      required this.link,
      required this.isMobile})
      : super(key: key);

  final double height, width;
  final String title, techStack, desc, link;
  final bool isMobile;
  @override
  _ProjectsCardState createState() => _ProjectsCardState();
}

class _ProjectsCardState extends State<ProjectsCard> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: isHover ? Colors.black12 : Colors.black45,
            blurRadius: 10.0,
            offset: const Offset(8, 12),
          )
        ],
      ),
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.only(
          top: isHover ? widget.height * 0.005 : widget.height * 0.01,
          bottom: !isHover ? widget.height * 0.005 : widget.height * 0.01),
      child: InkWell(
        onHover: (bool value) {
          setState(() {
            isHover = value;
          });
        },
        onTap: () => htmlOpenLink(widget.link),
        child: Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.only(
              top: widget.height * 0.02,
              left: widget.width * 0.015,
              right: widget.width * 0.015,
              bottom: widget.height * 0.02),
          width: !widget.isMobile ? widget.width * 0.28 : widget.width,
          height: !widget.isMobile ? widget.height * 0.35 : widget.height / 2,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: isHover ? Colors.black12 : Colors.black45,
                blurRadius: 10.0,
                offset: const Offset(8, 12),
              )
            ],
            color: currentTheme.currentTheme == ThemeMode.dark
                ? Theme.of(context).cardColor
                : Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(
              5.0,
            ),
          ),
          child:
               Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              FittedBox(
                                  fit: BoxFit.cover,
                                  child: text(widget.title, 25, Colors.white)),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 5.0, bottom: 16.0),
                                child: FittedBox(
                                    fit: BoxFit.cover,
                                    child: text(
                                        widget.techStack, 14, Colors.white)),
                              ),
                              text(widget.desc, 15, Colors.white),
                            ],
                          ),
                        ),
                      ),
                    ),
                    FutureBuilder(
                        future: starsAndForks(widget.link),
                        builder: (BuildContext context,
                            AsyncSnapshot<Object?> snapshot) {
                          if (snapshot.hasData) {
                            final List<String> data =
                                snapshot.data as List<String>;
                            if (data[1] == 'null' && data[0] == 'null')
                              return const Center();
                            return Row(
                              children: [
                                Image.asset(
                                    'assets/projects/constant/stars.png',
                                    scale: 2),
                                Padding(
                                  padding: const EdgeInsets.only(right: 24.0),
                                  child: text(' ${data[0]}', 12, Colors.white),
                                ),
                                Image.asset(
                                    'assets/projects/constant/forks.png',
                                    scale: 2),
                                text(' ${data[1]}', 12, Colors.white),
                              ],
                            );
                          }
                          return const Center();
                        }),
                  ],
                ),
        ),
      ),
    );
  }
}
