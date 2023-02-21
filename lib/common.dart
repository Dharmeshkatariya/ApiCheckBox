class Common{

static String imageCategory(String category) {
    if (category == "Animals") {
      return "assets/images/animal.jpg";
    } else if (category == "Art & Design") {
      return "assets/images/artimage.jpg";
    } else if (category == "Books") {
      return "assets/images/book.jpg";
    } else {
      return "assets/images/d.jpg";
    }
  }


}