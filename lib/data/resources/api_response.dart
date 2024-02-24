import 'package:mvvm/data/resources/status.dart';

class ApiResponse<T> {
  Status? status;
  T? data;
  String? message;

  //constructor
  ApiResponse(this.status, this.data, this.message);

  //here we use super meathod like ApiResponse.loading()
  ApiResponse.loading() : status = Status.LOADING;

  ApiResponse.completed(this.data) : status = Status.COMPLETED;

  ApiResponse.error(this.message) : status = Status.ERROR;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}
