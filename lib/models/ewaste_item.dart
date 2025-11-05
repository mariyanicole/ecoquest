class EWasteItem {
  final int level;
  final String image;
  final String question;
  final String explanation;
  final String correctAction;
  EWasteItem({
    required this.level,
    required this.image,
    required this.question,
    required this.explanation,
    required this.correctAction,
  });
}

final List<EWasteItem> eWasteItems = [
  EWasteItem(
    level: 1,
    image: 'assets/image1.png',
    question: 'What should you do with old batteries?',
    explanation: 'Batteries should be recycled at designated drop-off points.',
    correctAction: 'Recycle',
  ),
  EWasteItem(
    level: 2,
    image: 'assets/image2.png',
    question: 'How to dispose of a broken phone?',
    explanation: 'Phones contain hazardous materials and should be recycled.',
    correctAction: 'Recycle',
  ),
];
