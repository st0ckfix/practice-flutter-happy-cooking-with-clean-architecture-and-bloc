String getErrorMessage(String errorCode) {
  const errorMessages = {
    'invalid-email': 'The email address is badly formatted.',
    'user-disabled': 'The user account has been disabled by an administrator.',
    'user-not-found': 'There is no user record corresponding to this identifier.',
    'account-exists-with-different-credential': 'An account already exists with the same email address but different sign-in credentials.',
    'invalid-credential': 'The supplied auth credential is malformed or has expired.',
    'operation-not-allowed': 'The given sign-in provider is disabled for this Firebase project.',
    'wrong-password': 'The password is invalid or the user does not have a password.',
    'invalid-verification-code': 'The verification code used to create the phone credential is invalid.',
    'invalid-verification-id': 'The verification ID used to create the phone credential is invalid.',
    'user-mismatch': 'The supplied credentials do not correspond to the previously signed-in user.',
    'expired-action-code': 'The action code has expired.',
    'invalid-action-code': 'The action code is invalid.',
    'network-request-failed': 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.',
    'too-many-requests': 'We have blocked all requests from this device due to unusual activity. Try again later.',
    'unverified-email': 'The email address is not verified. Please check your email to verify your account.',
    'user-token-expired': 'The user\'s token has expired. Please sign in again.',
    'credential-already-in-use': 'The credential is already associated with a different user.',
    'app-not-authorized': 'This app is not authorized to use Firebase Authentication.',
    'invalid-api-key': 'The API key provided is invalid.',
  };

  return errorMessages[errorCode] ?? 'An unknown error occurred';
}