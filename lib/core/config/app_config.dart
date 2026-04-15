enum Environment { dev, staging, prod }

class AppConfig {
  final String apiBaseUrl;
  final Environment environment;

  AppConfig({required this.apiBaseUrl, required this.environment});

  static late AppConfig instance;

  static void init({required Environment env, required String apiBaseUrl}) {
    instance = AppConfig(environment: env, apiBaseUrl: apiBaseUrl);
  }
}
