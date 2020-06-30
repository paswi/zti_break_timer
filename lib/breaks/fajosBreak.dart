import 'package:cloud_firestore/cloud_firestore.dart';

class FajosBreak {
  // 1
  String mail;
  DateTime start;
  DateTime end;
  // 2
  DocumentReference reference;
  FajosBreak(this.mail, this.start, {this.end, this.reference});
  // 3
 factory FajosBreak.fromSnapshot(DocumentSnapshot snapshot) {
   FajosBreak newBreak = FajosBreak.fromJson(snapshot.data);
   newBreak.reference = snapshot.reference;
   return newBreak;
 }
  factory FajosBreak.fromJson(Map<dynamic, dynamic> json) => _FajosBreakFromJson(json);
  // 4
  Map<String, dynamic> toJson() => _FajosBreakToJson(this);
  @override
  String toString() => "FajosBreak<$FajosBreak>";
}

//1
FajosBreak _FajosBreakFromJson(Map<dynamic, dynamic> json) {
  return FajosBreak(
    json['mail'] as String,
    json['start'] == null ? null : (json['start'] as Timestamp).toDate(),
    end: json['end'] == null ? null : (json['end'] as Timestamp).toDate(),
  );
}
//2
Map<String, dynamic> _FajosBreakToJson(FajosBreak instance) =>
    <String, dynamic> {
      'fajosBreak': instance.mail,
      'start': instance.start,
      'end': instance.end,
    };
