class Category {
  Category({
    this.title = '',
    this.imagePath = '',
  });

  String title;
  String imagePath;

  static List<Category> popularCourseList = <Category>[
    Category(
      imagePath: 'assets/images/plant_1.jpg',
      title: 'Plant 1',
    ),
    Category(
      imagePath: 'assets/images/plant_2.jpg',
      title: 'Plant 2',
    ),
    Category(
      imagePath: 'assets/images/plant_3.jpg',
      title: 'Plant 3',
    ),
  ];
}
