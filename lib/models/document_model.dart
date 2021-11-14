class Document {

  final String title;
  final String date;
  final String url;

  Document(
      this.title,
      this.date,
      this.url);

  Document.fromSnapshot(Map<String, dynamic> json)
      : title = json['title'],
        date = json['date'],
        url = json['url'];

}
