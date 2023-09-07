String? isFieldEmpty(String? text) {
  if (text == null || text.trim().isEmpty) {
    return 'Field is required!';
  }
  return null;
}
