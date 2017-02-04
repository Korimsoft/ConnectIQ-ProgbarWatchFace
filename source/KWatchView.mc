using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Application as App;
using Toybox.ActivityMonitor as Act;
using Toybox.Position;

class KWatchView extends Ui.WatchFace {

    // Days of month lookup - February is close enough.
    hidden const days_per_month = [ 0, 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ];

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {

        var twoDigitFormat = "%02d";
        var clockTime = Sys.getClockTime();
        var date = Time.today();
        var timeInfo = Time.Gregorian.info(date, Time.FORMAT_SHORT);
        var month = timeInfo.month;
        var day = timeInfo.day;

        // Lookup the number of segments for the day progress bar.
        var dayBarSegmentCount = days_per_month[month];


        var devSettings = Sys.getDeviceSettings();
        var actInfo = Act.getInfo();
        var stepsGoalPercent = getStepsGoalPercent(actInfo);
        var batt = Sys.getSystemStats().battery;

        updateBar("HourBar", clockTime.hour, dc);
        updateBar("MinuteBar", clockTime.min, dc);
        updateBar("MonthBar", month, dc);
        updateDayBar("DayBar", dayBarSegmentCount, day, dc); //This one is specific...different count of days in the month...
        updateBar("StepsBar", stepsGoalPercent, dc);
        updateBar("BatteryBar", batt, dc);

        updateNotificationIcon("BluetoothNotification", devSettings.phoneConnected, dc);
        updateNotificationIcon("MessageNotification", devSettings.notificationCount > 0, dc);
        updateNotificationIcon("AlarmNotification", devSettings.alarmCount > 0, dc);
        updateNotificationIcon("MoveNotification", actInfo.moveBarLevel > 0, dc);

        View.onUpdate(dc);
    }

    hidden function updateNotificationIcon(iconId, visible, dc){
        System.println("Updating " + iconId + ": visible: " + visible );

        var icon = View.findDrawableById(iconId);
        icon.setVisible(visible);
        icon.draw(dc);
    }

    hidden function updateBar(barId, value, dc){

        var bar = View.findDrawableById(barId);
        bar.setFill(value);
        bar.draw(dc);
    }

    hidden function updateDayBar(barId, segments, value, dc){

        var bar = View.findDrawableById(barId);
        bar.setSegmentation(segments);
        bar.setFill(value);
        bar.draw(dc);
    }

    hidden function getStepsGoalPercent(actInfo){

        var goalPerc;

        if(actInfo.stepGoal.toDouble() > 0){
            goalPerc = (actInfo.steps.toDouble()/actInfo.stepGoal.toDouble())*100;
        }
        else {
            goalPerc = 0;
        }
        return goalPerc <= 100 ? goalPerc : 100;
    }


    hidden function updateTextField(fieldId, value, format){

        var color = Gfx.COLOR_BLUE;
        var updatedDrawable = View.findDrawableById(fieldId);

        updatedDrawable.setColor(color);

        updatedDrawable.setText(value.format(format));
    }






    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {

    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {

    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {

    }

}
