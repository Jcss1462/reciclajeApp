import 'package:reciclaje_app/data/model/visitaCivil.dart';

class VisitaCivilList {
  final List<VisitaCivil> visitas;

  VisitaCivilList({
    this.visitas,
  });

  factory VisitaCivilList.fromJson(List<dynamic> parsedJson) {
    // ignore: deprecated_member_use
    List<VisitaCivil> visitas = new List<VisitaCivil>();

    visitas = parsedJson.map((i) => VisitaCivil.fromJson(i)).toList();

    return new VisitaCivilList(
      visitas: visitas,
    );
  }
}
