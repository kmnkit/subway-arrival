class Station {
  int code;
  String name_kor;
  String name_eng;
  String line_num;

  Station({this.code, this.name_kor, this.name_eng, this.line_num});

  factory Station.fromJson(Map<String, dynamic> data){
    return Station(
      code: int.tryParse(data["STATION_CD"]) ?? 0,
      name_kor: data["STATION_NM"] ?? "",
      name_eng: data["STATION_NM_ENG"] ?? "",
      line_num: data["LINE_NUM"] ?? ""
    );
  }
}