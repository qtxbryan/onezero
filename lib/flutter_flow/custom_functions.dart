bool showSearchResults(
  String textSearchFor,
  String textSearchIn,
) {
  return textSearchIn.toLowerCase().contains(textSearchFor.toLowerCase());
}
