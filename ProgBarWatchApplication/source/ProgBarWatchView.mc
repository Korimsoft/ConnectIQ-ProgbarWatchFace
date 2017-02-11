using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Application as App;
using DateTimeUtility as Dut;
using ActivityUtility as Aut;
using SystemUtility as Sut;

class ProgBarWatchView extends Ui.WatchFace {

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

        Dut.now();
        Aut.reload();

        updateBar("HourBar", Dut.getCurrentHour(), dc);
        updateBar("MinuteBar", Dut.getCurrentMinute(), dc);
        updateBar("MonthBar", Dut.getCurrentMonth(), dc);
        updateDayBar("DayBar", Dut.getDaysPerCurrentMonth(), Dut.getCurrentDay(), dc); //This one is specific...different count of days in the month...
        updateBar("StepsBar", Aut.getStepsGoalPercent(), dc);
        updateBar("BatteryBar", Sut.getBattery(), dc);


        var devSettings = Sys.getDeviceSettings();
        updateNotificationIcon("BluetoothNotification", devSettings.phoneConnected, dc);
        updateNotificationIcon("MessageNotification", devSettings.notificationCount > 0, dc);
        updateNotificationIcon("AlarmNotification", devSettings.alarmCount > 0, dc);
        updateNotificationIcon("MoveNotification", Aut.shouldMove(), dc);

        View.onUpdate(dc);
    }

    //! Update the notification icon.
    hidden function updateNotificationIcon(iconId, visible, dc){
        System.println("Updating " + iconId + ": visible: " + visible );

        var icon = View.findDrawableById(iconId);
        icon.setVisible(visible);
        icon.draw(dc);
    }

    //! Update the progress bar with new value.
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
