class DeviceAuto {
  String name;
  String on;
  String off;
  String hOn;
  String hOff;
  bool status;

  DeviceAuto(this.name, this.on, this.off, this.hOn, this.hOff, this.status);

  DeviceAuto.fromJson(Map<String, dynamic> json)
      : name = json['name'].toString(),
        on = json['on'].toString(),
        off = json['off'].toString(),
        hOn = json['ho'].toString(),
        hOff = json['hof'].toString(),
        status = json['status'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'on': on,
        'off': off,
        'ho': hOn,
        'hof': hOff,
        'status': status,
        'fo': "23:8:10",
      };
}
