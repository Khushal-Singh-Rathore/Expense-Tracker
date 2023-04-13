// convert datetime to string yyyymmdd
String ConvertDateTimeToString(DateTime dateTime){
//  converting year to string - yyyy
   String year = dateTime.year.toString();

//   converting month to string - mm
  String month = dateTime.month.toString();
  if(month.length == 1){
     month = '0$month';
  }

//  converting day to string - dd

 String day = dateTime.day.toString();
  if(day.length == 1){
     day = '0$day';
  }

  String yyyymmdd = year+month+day;

  return yyyymmdd;
}