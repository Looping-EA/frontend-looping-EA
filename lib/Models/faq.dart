class Faq {
  String quest;
  String resp;

  Faq(this.quest, this.resp);

  factory Faq.fromJson(dynamic json) {
    return Faq(
      json['quest'] as String,
      json['resp'] as String,
    );
  }
}
