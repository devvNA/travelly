class FormatPrice {
  int formatPrice(String price) {
    if (price.contains('.')) {
      price = price.replaceAll(RegExp(r'\.00$'), '');
    }
    return int.parse(price);
  }
}
