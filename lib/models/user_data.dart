class UserData {

  final Info _info;
  final List<Document> docs;

  UserData(this._info, this.docs);
}

class Info {
  final String name;
  final String email;
  final String image;

  Info(this.name, this.email, this.image);
}

class Document {

}