//! Utility methods for calculating activity information
module ActivityUtility{
    hidden var actInfo = null;

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
        return actInfo.moveBarLevel > 0;
    }

    function setActInfo(newActInfo){
        actInfo = newActInfo;
    }
}