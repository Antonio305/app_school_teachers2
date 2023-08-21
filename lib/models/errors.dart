class Error {
  Map<String, dynamic> _errors = {};

  // FU7JNTION GETTER AND SETTER
  Map<String, dynamic> get error {
    return _errors;
  }

  set errors(Map<String, dynamic> error) {
    _errors = error;
  }
}
