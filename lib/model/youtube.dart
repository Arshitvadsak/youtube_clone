class YouTube {
  final String videoId;
  final String userId;
  final String title;
  final String body;
  final String chanelTitle;

  YouTube({
    required this.userId,
    required this.title,
    required this.body,
    required this.videoId,
    required this.chanelTitle
  });

  factory YouTube.fromMap({required Map data}) {
    return YouTube(
      userId: data['id']['videoId'],
      title: data['snippet']['title'],
      body: data['snippet']['description'],
      videoId: data['snippet']['thumbnails']['high']['url'],
      chanelTitle: data['snippet']['channelTitle'],
    );
  }
}
