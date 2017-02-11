using Toybox.System;
using Toybox.Time;

module DateTimeUtility{
// Days of month lookup - February is close enough.
    hidden const days_per_month = [ 0, 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ];

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
        currentTimeInfo = Time.Gregorian.info(date, format);
    }

    //! Sets the time
    function setTime(time){
        clockTime=time;
    }

    //! Gets the month provided by the date state of this module
    function getCurrentMonth(){
        return currentTimeInfo.month;
    }

    //! Gets the date provided by the state of the module
    function getCurrentDay(){
        return currentTimeInfo.day;
    }

    //!
    function getCurrentHour(){
        return clockTime.hour;
    }

    function getCurrentMinute(){
        return clockTime.min;
    }

    function getDaysPerCurrentMonth(){
        return days_per_month[getCurrentMonth()];
    }

}