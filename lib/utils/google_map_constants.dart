class Constant {
  Constant._();

  static const googleApiKey = "AIzaSyAcjPn4QC0lN_aQKKlTZbPSNu8RiqJkp6U";
  static final Constant _singleton = Constant._();

  factory Constant() {
    return _singleton;
  }
}