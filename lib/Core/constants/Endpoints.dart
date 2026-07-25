class EndPoints {
  // static const String baseUrl =
  //     'https://student-attendane-app-api.vercel.app/api/v1/';
  static const String baseUrl =
      'https://unenlightened-caleb-unneedy.ngrok-free.dev/api/v1/';
  // Authentication
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String forGetPassword =
      'https://unenlightened-caleb-unneedy.ngrok-free.dev/api/v1/password/forgot-password/';
  static const String logout = '/auth/logout';
  static const String verifyCode = '/auth/verify-teacher-code/';
  // User
  static const String userProfile = '/users/';
  static const String imagesProfile = '/profile/uploadimages/';
  //Attendence
  static const String markAttendance = '/attendance/mark';
  // Teacher
  static const String createSession = '/sessions/create';
  static const String getSessionbysessionId = '/sessions/';
  static const String getMySessions = '/sessions/teacher/';
  static const String getAttendanceForSession = '/attendance/';
}
