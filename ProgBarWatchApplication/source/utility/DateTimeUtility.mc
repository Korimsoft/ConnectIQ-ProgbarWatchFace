using Toybox.System;
using Toybox.Time;

module DateTimeUtility{

    // Days of month lookup
    hidden const days_per_month = [ 0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ];

    hidden var format = Time.FORMAT_SHORT;
    hidden var currentTimeInfo;
    hidden var clockTime;

    //! Set the date and time format
    //! Input: Time format forom Toybox.Time (eg. TIME_FORMAT_SHORT)
    function setFormat(timeFormat){
        format = timeFormat;
    }

    //! Sets the date and time information to current time moment
    function now(){
        setTime(System.getClockTime());
        setDate(Time.today());
    }

    //! Sets the date
    function setDate(date){
        if (date instanceof Toybox.Time.Moment){
            currentTimeInfo = Time.Gregorian.info(date, format);
        } else {
            throw new UnexpectedTypeException(Toybox.Time.Moment, date, "setDate()");
        }
    }

    //! Sets the time
    function setTime(time){
        if(time instanceof Toybox.System.ClockTime){
            clockTime=time;
        } else {
            throw new UnexpectedTypeException(Toybox.Time, time, "setTime()");
        }
    }

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
        return clockTime.hour;
    }

    //! Gets the current minute
    function getCurrentMinute(){
        return clockTime.min;
    }

    //! Return how many days are in current month
    function getDaysPerCurrentMonth(){
        var currentMonth = getCurrentMonth();
        var currentYear = getCurrentYear();

        // Detect february on leap year...
        if(currentMonth == 1 && isLeapYear(currentYear)){
            return days_per_month[currentMonth] + 1;
        }

        return days_per_month[currentMonth];
    }


    //! Check whtther a year is a leap year
    function isLeapYear(year){

        if(!(year instanceof Toybox.Lang.Number)){
            throw new UnexpectedTypeException(Number, year, "isLeapYear()");
        }

        return (year % 4 == 0);

    }

}