using Toybox.System as Sys;

module SystemUtility{
    function getBattery(){
        return  Sys.getSystemStats().battery;
    }
}