enum AppFailureType { save, migration, ageUp, contentValidation, unexpected }

class AppFailure implements Exception {
  const AppFailure(this.type, this.userMessage, {this.cause});

  final AppFailureType type;
  final String userMessage;
  final Object? cause;

  factory AppFailure.save(Object cause) => AppFailure(
    AppFailureType.save,
    'That change could not be saved. Please try again.',
    cause: cause,
  );

  factory AppFailure.ageUp(Object cause) => AppFailure(
    AppFailureType.ageUp,
    'The year could not be completed. Please try again.',
    cause: cause,
  );

  factory AppFailure.unexpected(Object cause) => AppFailure(
    AppFailureType.unexpected,
    'Something went wrong. Your last valid life is still safe.',
    cause: cause,
  );
}
