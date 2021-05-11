class Error {
  List<dynamic> error;
  int status;
  String path;
 

  Error(
      this.error, this.status, this.path);

  Error.fromJson(Map<dynamic, dynamic> json) {
    this.error = json['error'];
    this.status = json['status'];
    this.path = json['path'];
  }

  Map<String, dynamic> toJson() {
    return {
      'error': this.error,
      'status': this.status,
      'path': this.path,
    };
  }
}
