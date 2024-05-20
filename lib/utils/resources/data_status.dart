// // Define a sealed class called Result
// sealed class Result<T> {
//   // Private constructor to prevent direct instantiation
//   const Result._();

//   // Define a factory method for the Success case
//   factory Result.success(T data) = Success;

//   // Define a factory method for the Error case
//   factory Result.error(String message) = Error;
// }

// // Define a subclass for the Success case
// class Success<T> extends Result<T> {
//   // Data associated with the Success case
//   final T data;

//   // Constructor for Success case
//   const Success(this.data) : super._();
// }

// // Define a subclass for the Error case
// class Error<T> extends Result<T> {
//   // Error message associated with the Error case
//   final String message;

//   // Constructor for Error case
//   const Error(this.message) : super._();
// }


// // Create a Success instance
// Result<String> successResult = Result.success('Data from successful operation');

// // Access the data from the Success instance
// String data = successResult.data; // 'Data from successful operation'

// // Create an Error instance
// Result<String> errorResult = Result.error('An error occurred');

// // Access the error message from the Error instance
// String errorMessage = errorResult.message; // 'An error occurred'