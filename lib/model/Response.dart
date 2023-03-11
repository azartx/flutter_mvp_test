class Response<T> {
  final T? response;
  final String code;
  final String message;

  Response(this.response, this.message, this.code);
}
