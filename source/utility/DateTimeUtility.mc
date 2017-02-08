using Toybox.System;
using Toybox.Time;

module DateTimeUtility{
// Days of month lookup - February is close enough.
    hidden const days_per_month = [ 0, 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ];

    hidden var format = Time.FORMAT_SHORT;
    hidden var currentTimeInfo;
    hidden var clockTime;

    function setFormat(timeFormat){
        format = timeFormat;
    }

    function now(){
        setTime(System.getClockTime());
        setDate(Time.today());
    }


    function setDate(date){
        currentTimeInfo = Time.Gregorian.info(date, format);
    }

    function setTime(time){
        clockTime=time;
    }

    function getCurrentMonth(){
        return currentTimeInfo.month;
    }

    function getCurrentDay(){
        return currentTimeInfo.day;
    }

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