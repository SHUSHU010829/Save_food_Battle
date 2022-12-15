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
    title: "五秒完成食材登入",
    image: "assets/images/image1.png",
    desc: "想要更快速的登入發票？\n只要掃一下發票資訊就可以了！\n五秒鐘搞定一切。",
  ),
  OnboardingContents(
    title: "快速管理食材",
    image: "assets/images/image2.png",
    desc: "覺得懶的一一編輯食品細部內容？\n我們使用現有超市中的資訊快速幫你填上你需要的資訊！",
  ),
  OnboardingContents(
    title: "不再費心於食材",
    image: "assets/images/image3.png",
    desc: "你可以在耗盡食材時順手將它\n加入購物車，系統也會在你快耗盡\n食材時提醒您。",
  ),
];
