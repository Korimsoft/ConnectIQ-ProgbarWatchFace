using Toybox;
using Toybox.System;
using Toybox.Time;
using Toybox.Lang;

//! Utility module for retrieving various time info.
module DateTimeUtility{
	
	const MINUTES_PER_HOUR = 60;
	const HOURS_PER_DAY = 24;
	const MONTHS_PER_YEAR = 12;
	
    // Days of month lookup array, months are enumerated from 1 to 12.
    hidden const days_per_month = [ 0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ];

    hidden var format = Time.FORMAT_SHORT;

    hidden var currentMoment = Time.now();
    hidden var currentInfo;


    //! Set the date and time format
    //! Input: Time format forom Toybox.Time (eg. TIME_FORMAT_SHORT)
    function setFormat(timeFormat){
        format = timeFormat;
        currentInfo = Time.Gregorian.info(currentMoment, format);
    }

    //! Sets the date and time information to current time moment
    function now(){
        currentMoment = Time.now();
        currentInfo = Time.Gregorian.info(currentMoment, format);
    }

   //! Initialize the module with custom date/time options dictionary
   //! Dictionary keys:
   //! :year, :month, :day, :hour, :minute, :second; all instances of Number
   //!
   //! The input value in options is in UTC, the output value is in local time!!!
   function moment(options){
        currentMoment = Time.Gregorian.moment(options);
        currentInfo = Time.Gregorian.info(currentMoment, format);
   }

    //! Gets the year provided by the date state of this module
	//! The returned value is dependent on the Time format
	//! The returned value is expressed in local time zone
    function getCurrentYear(){
    	var year = currentInfo.year;
    	System.println(year);
        return year;
    }

    //! Gets the month provided by the date state of this module
  	//! The returned value is dependent on the Time format
    //! The returned value is expressed in local time zone
    function getCurrentMonth(){
        return currentInfo.month;
    }

    //! Gets the date provided by the state of the module
    //! The returned value is dependent on the Time format
    //! The returned value is expressed in local time zone
    function getCurrentDay(){
        return currentInfo.day;
    }

    //! Gets the current hour.
    //! The returned value is dependent on the Time format
    //! The returned value is expressed in local time zone
    function getCurrentHour(){
        return currentInfo.hour;
    }

    //! Gets the current minute
    //! The returned value is dependent on the Time format
    //! The returned value is expressed in local time zone
    function getCurrentMinute(){
        return currentInfo.min;
    }

    //! Gets the current second
    function getCurrentSecond(){
    	return currentInfo.sec;
    }

    //! Get the number of days of current month
    function getDaysPerCurrentMonth(){
        
        //Only the Time.FORMAT_SHORT returns numeric values for month
        var info = Time.Gregorian.info(currentMoment, Time.FORMAT_SHORT);
        
        var month = info.month;
        var year = info.year;
        
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