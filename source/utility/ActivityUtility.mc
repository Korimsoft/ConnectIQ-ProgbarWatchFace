using Toybox.ActivityMonitor as Act;

module ActivityUtility{
    hidden var actInfo = Act.getInfo();

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

    function reload(){
        actInfo = Act.getInfo();
    }
}