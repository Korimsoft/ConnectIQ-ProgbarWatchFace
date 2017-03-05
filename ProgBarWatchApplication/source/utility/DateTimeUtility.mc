using Toybox;
using Toybox.System;
using Toybox.Time;
using Toybox.Lang;

//!
module DateTimeUtility{

    // Days of month lookup
    hidden const days_per_month = [ 0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ];

    hidden var format = Time.FORMAT_SHORT;

    hidden var currentMoment;


    //! Set the date and time format
    //! Input: Time format forom Toybox.Time (eg. TIME_FORMAT_SHORT)
    function setFormat(timeFormat){
        format = timeFormat;
    }

    //! Sets the date and time information to current time moment
    function now(){
        var moment = Time.now();
    }

   //! Initialize the module with custom date/time options dictionary
   //! Dictionary keys:
   //! :year, :month, :day, :hour, :minute, :second; all instances of Number
   function moment(options){
        var moment = Time.Gregorian.moment(options);
   }

    //! Gets the year provided by the date state of this module
    //! It is dependent on the Time format
    function getCurrentYear(){
        return Time.Gregorian.Info(currentMoment, format).year;
    }

    //! Gets the month provided by the date state of this module
    //! It is dependent on the Time format
    function getCurrentMonth(){
        return Time.Gregorian.Info(currentMoment, format).month;
    }

    //! Gets the date provided by the state of the module
    //! It is dependent on the Time format
    function getCurrentDay(){
        return Time.Gregorian.Info(currentMoment, format).day;
    }

    //! Gets the current hour.
    //! It is dependent on the Time format
    function getCurrentHour(){
        return Time.Gregorian.Info(currentMoment, format).hour;
    }

    //! Gets the current minute
    //! It is dependent on the Time format
    function getCurrentMinute(){
        return Time.Gregorian.Info(currentMoment, format).min;
    }

    //! Gets the current second
    function getCurrentSecond(){
        return Time.Gregorian.Info(currentMoment, format).sec;
    }

    //! Get the number of days of current month
    function getDaysPerCurrentMonth(){
        var month = Time.Gregorian.Info(currentMoment, Time.FORMAT_SHORT).month;
        var year = Time.Gregorian.Info(currentMoment, Time.FORMAT_SHORT).year;
        return getDaysPerMonth(month, year);
    }

    //! Return how many days are in month of a year (thanks, February...)
    //! Years and months are numbers, months have their index starting with 1.
    function getDaysPerMonth(month, year){

        checkCorrectType(year, Toybox.Lang.Number); //Year is always a number

        //Months are indexed starting by 1...
        //In Time.FORMAT_MEDIUM or Time.FORMAT_LONG are the months represented as string
        //Need to resolve the mapping...
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


    //! Check whether a year is a leap year (Approximately...see the rules about the leap years)
    //! It should work at least for the 21st century. I doubt that this code will survive any longer...
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