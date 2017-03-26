using Toybox.ActivityMonitor;

//! Utility methods for calculating activity information
module ActivityUtility{
    hidden var actInfo = null;

	//! Return how many percent of step goal are reached, if the goal was reached, 100 is returned.
    function getStepsGoalPercent(){

        var goalPerc;

        if(actInfo.stepGoal.toDouble() > 0){
            goalPerc = (actInfo.steps.toDouble()/actInfo.stepGoal.toDouble())*100;
        }
        else {
            goalPerc = 0;
        }
        return goalPerc <= 100 ? goalPerc : 100;
    }

    function shouldMove(){
        return actInfo.moveBarLevel > ActivityMonitor.MOVE_BAR_LEVEL_MIN;
    }

    function setActInfo(newActInfo){
        actInfo = newActInfo;
    }
}