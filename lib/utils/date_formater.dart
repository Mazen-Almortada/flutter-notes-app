String dateFormatter(DateTime currentDate) {
  bool minuteLessThanTen = currentDate.minute < 10;
  bool hourLessThanTen = currentDate.hour < 10;
  String formatedDate =
      "${currentDate.year}-${currentDate.month}-${currentDate.day}  ${hourLessThanTen ? '0${currentDate.hour}' : currentDate.hour}:${minuteLessThanTen ? '0${currentDate.minute}' : currentDate.minute}";

  return formatedDate;
}
