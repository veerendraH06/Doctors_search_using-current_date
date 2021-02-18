

class Doctor {
  String id;
  String name;
  String doctorsName;
  String status;
  String time;
  String hospital;

  Doctor(
      {this.id,
        this.name,
        this.doctorsName,
        this.status,
        this.time,
        this.hospital});



  String get _id => this.id;
  String get _name => this.name;
  String get _doctorsName => this.doctorsName;
  String get _status => this.status;
  String get _time => this.time;
  String get _hospital=>this.hospital;

  set _id(String id){
    this.id =id;
  }
  set _name(String name){
    this.name =name;
  }
  set _doctorsName(String doctorsName){
    this.doctorsName =doctorsName;
  }
  set _status(String status){
    this.status =status;
  }
  set _time(String time){
    this.time =time;
  }
  set _hospital(String hospital){
    this.hospital =hospital;
  }


  Doctor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    doctorsName = json['Doctors name'];
    status = json['status'];
    time = json['time'];
    hospital = json['Hospital'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['Doctors name'] = this.doctorsName;
    data['status'] = this.status;
    data['time'] = this.time;
    data['Hospital'] = this.hospital;
    return data;
  }
}

