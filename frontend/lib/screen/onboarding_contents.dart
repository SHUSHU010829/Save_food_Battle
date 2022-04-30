import 'package:flutter/material.dart';

class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents(
      {required this.title, required this.image, required this.desc});
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: "快速登入食材",
    image: "assets/images/image1.png",
    desc: "功能介紹一",
  ),
  OnboardingContents(
    title: "多人同居",
    image: "assets/images/image2.png",
    desc: "功能介紹二",
  ),
  OnboardingContents(
    title: "食材掃描",
    image: "assets/images/image3.png",
    desc: "功能介紹三",
  ),
];
