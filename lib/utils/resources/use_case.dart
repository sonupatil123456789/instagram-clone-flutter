import 'package:flutter/material.dart';

abstract interface class UseCase<SuccessDataType, Parameters>{
  Future<SuccessDataType> call(Parameters params, BuildContext context );
}

abstract interface class StreamedUseCase<SuccessDataType, Parameters>{
  SuccessDataType call(Parameters params, BuildContext context );
}



class EmptyParams{}