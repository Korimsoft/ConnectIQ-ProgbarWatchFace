using Toybox.Time;

//! Initialize the DateTimeUtility with testing data
class DateTimeFactory{

    hidden var dateTimeFormat;

    function Initialize(format){
        dateTimeFormat = format;
    }

    function createDate(year, month, day){
        var options - {:year=>year, :month=>month, :day=>day};
        var moment = new Moment(options);

        var date = new

    }

    function createTime(hour, minute, second){
    }
}