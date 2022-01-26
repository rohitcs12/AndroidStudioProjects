import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    this.states,
    this.ttl,
  });

  List<Statedata> states;
  int ttl;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    states: List<Statedata>.from(json["states"].map((x) => Statedata.fromJson(x))),
    ttl: json["ttl"],
  );

  Map<String, dynamic> toJson() => {
    "states": List<dynamic>.from(states.map((x) => x.toJson())),
    "ttl": ttl,
  };
}

class Statedata {
  Statedata({
    this.stateId,
    this.stateName,
  });

  int stateId;
  String stateName;

  factory Statedata.fromJson(Map<String, dynamic> json) => Statedata(
    stateId: json["state_id"],
    stateName: json["state_name"],
  );

  Map<String, dynamic> toJson() => {
    "state_id": stateId,
    "state_name": stateName,
  };
}
