class ApiResponse<T> {
  final int statusCode;
  final String message;
  final T? data;

  ApiResponse({
    required this.statusCode,
    required this.message,
    this.data,
  });

  factory ApiResponse.fromJson(
      Map<String, dynamic> json, T Function(dynamic json) parseData) {
    return ApiResponse<T>(
      statusCode: json['STATUS_CODE'] ?? 0,
      message: json['MESSAGE'] ?? 'Unknown error occurred',
      data: json['DATA'] != null ? parseData(json['DATA']) : null,
    );
  }
}