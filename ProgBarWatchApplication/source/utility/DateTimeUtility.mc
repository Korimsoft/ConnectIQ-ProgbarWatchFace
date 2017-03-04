using Toybox;
using Toybox.System;
using Toybox.Time;
using Toybox.Lang;

//!
module DateTimeUtility{

    // Days of month lookup
    hidden const days_per_month = [ 0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ];

    hidden var format = Time.FORMAT_SHORT;
    hidden var currentTimeInfo;
    //hidden var clockTime;

    //! Set the date and time format
    //! Input: Time format forom Toybox.Time (eg. TIME_FORMAT_SHORT)
    function setFormat(timeFormat){
        format = timeFormat;
    }

    //! Sets the date and time information to current time moment
    function now(){
        var moment = Time.now();
        currentTimeInfo = Time.Gregorian.info(moment, format);

        //setTime(System.getClockTime());
        //setDate(Time.today());
   }

   //! Initialize the module with custom date/time options
   function moment(options){
        var moment = Time.Gregorian.moment(options);
        currentTimeInfo = Time.Gregorian.info(moment, format);
   }

//   //! Sets the date
//   function setDate(date){
//        if (date instanceof Toybox.Time.Moment){
//            currentTimeInfo = Time.Gregorian.info(date, format);
//        } else {
//            throw new UnexpectedTypeException(Toybox.Time.Moment, date, "setDate()");
//        }
//   }

//    //! Sets the time
//    function setTime(time){
//        if(time instanceof Toybox.System.ClockTime){
//            clockTime=time;
//        } else {
//            throw new UnexpectedTypeException(Toybox.Time, time, "setTime()");
//        }
//    }

    function getCurrentYear(){
        return currentTimeInfo.year;
    }

    //! Gets the month provided by the date state of this module
    function getCurrentMonth(){
        return currentTimeInfo.month;
    }

    //! Gets the date provided by the state of the module
    function getCurrentDay(){
        return currentTimeInfo.day;
    }

    //! Gets the current hour.
    function getCurrentHour(){
        return currentTimeInfo.hour;
    }

    //! Gets the current minute
    function getCurrentMinute(){
        return currentTimeInfo.min;
    }

    //! Gets the current second
    function getCurrentSecond(){
        return currentTimeInfo.sec;
    }

    function getDaysPerCurrentMonth(){
        return getDaysPerMonth(getCurrentMonth(), getCurrentYear());
    }

    //! Return how many days are in month of a year (thanks, February...)
    function getDaysPerMonth(month, year){

        checkCorrectType(year, Toybox.Lang.Number);

        //Months are indexed starting by 1...
        if(month < 1 || month > 12 || !(month instanceof Toybox.Lang.Number)){
            throw new InvalidValueException("Invalid month input: " + month);
        }

        // Detect february on leap year...
        if(month == 2 && isLeapYear(year)){
            return days_per_month[month] + 1;
        }
        else{
             return days_per_month[month];
        }
    }


    //! Check whtther a year is a leap year (Approximately...see the rules about the leap years)
    function isLeapYear(year){

        checkCorrectType(year, Toybox.Lang.Number);

        return (year % 4 == 0);

    }

    // TODO: This should be moved to a separate Module in order to be accessible from anywhere
    // And also testable...
    hidden function checkCorrectType(tested, type){
        if(!(tested instanceof type)){
            throw new Toybox.Lang.UnexpectedTypeException("", tested, "");
        }
    }

}