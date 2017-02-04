using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Application as App;
using Toybox.ActivityMonitor as Act;

class KWatchView extends Ui.WatchFace {

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

        var info = Time.Gregorian.info(date, Time.FORMAT_SHORT);

        var month = info.month;
        var day = info.day;
       // var dow = info.day_of_week;

        var stepsGoalPercent = getStepsGoalPercent();

        var batt = Sys.getSystemStats().battery;

        updateBar("HourBar", clockTime.hour, dc);
        updateBar("MinuteBar", clockTime.min, dc);
        updateBar("MonthBar", month, dc);
        updateBar("DayBar", day, dc);
        updateBar("StepsBar", stepsGoalPercent, dc);
        updateBar("BatteryBar", batt, dc);

        var devSettings = Sys.getDeviceSettings();

        updateNotificationIcon("BluetoothNotification", devSettings.phoneConnected, dc);
        updateNotificationIcon("MessageNotification", devSettings.notificationCount > 0, dc);
        updateNotificationIcon("AlarmNotification", devSettings.alarmCount > 0, dc);

        View.onUpdate(dc);
    }

    hidden function updateNotificationIcon(iconId, visible, dc){
        System.println("Updating " + iconId + ": visible: " + visible );

        var icon = View.findDrawableById(iconId);
        icon.setVisible(visible);
        icon.draw(dc);
    }

    hidden function updateBar(barId, value, dc){
        System.println("Updating " + barId);

        var bar = View.findDrawableById(barId);
        System.println(bar);

        bar.setFill(value);
        bar.draw(dc);
    }

    hidden function getStepsGoalPercent(){

        var info = Act.getInfo();

        var goalPerc;

        if(info.stepGoal.toDouble() > 0){
            goalPerc = (info.steps.toDouble()/info.stepGoal.toDouble())*100;
        }
        else {
            goalPerc = 0;
        }
        return goalPerc <= 100 ? goalPerc : 100;
    }


    hidden function updateField(field, value, format){
        var color = Gfx.COLOR_BLUE;

        var updatedDrawable = View.findDrawableById(field);

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
