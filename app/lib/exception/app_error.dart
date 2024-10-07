enum AppError {
  connectionNotAvailable(message: "Connection not available"),
  elaborationFailed(message: "An error occurred during the elaboration");

  const AppError({
    required this.message
  });

  final String message;
}
