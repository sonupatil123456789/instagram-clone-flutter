import 'dart:developer';


class CoustomLog {

  static coustomLogData( String title , dynamic data ){
    log("[ $title ] ===>>>> $data" );
  }

  static coustomLogError(String errorTitle ,  error , StackTrace stack ){
    log("[ Error IN $errorTitle ] ===>>>> ${error}" , error:error, );
    log("[ StackTrace In $errorTitle ] ===>>>> ${stack}" , stackTrace: stack);
  }
  
}
