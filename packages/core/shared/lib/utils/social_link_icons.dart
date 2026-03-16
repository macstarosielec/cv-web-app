import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

IconData socialLinkIcon(String name) =>
    _icons[name.toLowerCase().replaceAll(' ', '')] ??
    FontAwesomeIcons.link;

const _icons = <String, IconData>{
  'linkedin': FontAwesomeIcons.linkedin,
  'github': FontAwesomeIcons.github,
  'twitter': FontAwesomeIcons.xTwitter,
  'x': FontAwesomeIcons.xTwitter,
  'youtube': FontAwesomeIcons.youtube,
  'stackoverflow': FontAwesomeIcons.stackOverflow,
  'medium': FontAwesomeIcons.medium,
  'dev.to': FontAwesomeIcons.dev,
  'devto': FontAwesomeIcons.dev,
  'facebook': FontAwesomeIcons.facebook,
  'instagram': FontAwesomeIcons.instagram,
  'dribbble': FontAwesomeIcons.dribbble,
  'behance': FontAwesomeIcons.behance,
  'twitch': FontAwesomeIcons.twitch,
  'discord': FontAwesomeIcons.discord,
  'reddit': FontAwesomeIcons.reddit,
  'hackthebox': FontAwesomeIcons.cube,
  'tryhackme': FontAwesomeIcons.flag,
  'kaggle': FontAwesomeIcons.kaggle,
  'codepen': FontAwesomeIcons.codepen,
};
