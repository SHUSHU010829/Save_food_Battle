class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents(
      {required this.title, required this.image, required this.desc});
}

// 登入前簡介
List<OnboardingContents> contents = [
  OnboardingContents(
    title: "功能一",
    image: "assets/images/image1.png",
    desc: "功能介紹一",
  ),
  OnboardingContents(
    title: "功能二",
    image: "assets/images/image2.png",
    desc: "功能介紹二",
  ),
  OnboardingContents(
    title: "功能三",
    image: "assets/images/image3.png",
    desc: "功能介紹三",
  ),
];
