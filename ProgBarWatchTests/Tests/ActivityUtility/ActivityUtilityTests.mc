using ActivityUtility as Aut;
using Toybox.Test as Test;

module ActivityUtilityTests{

    hidden function getActivityInfoMock(stepGoal, steps, moveBarLevel){
        var params = {
            :stepGoal=>stepGoal,
            :steps=>steps,
            :moveBarLevel => moveBarLevel
            };

            return new ActivityInfoMock(params);
    }

    //! Zero goal should result in zero percent (it marks that the activity monitoring is off)
    (:test)
    function testGoalPercentGoalZero(logger){
        return testGoalPercent(0, 1234, 0);
    }


    //!
    (:test)
    function testGoalPercentPositive(logger){
        return testGoalPercent(2000, 200, 10.0);
    }

    //!
    (:test)
    function testGoalPercentOver100(logger){
        return testGoalPercent(1000, 1234, 100);
    }

    //!
    (:test)
    function testShouldMovePositive(logger){
        return testShouldMove(1, true); //MoveBar level ranges between 0 and 5
    }

    //!
    (:test)
    function testShouldMoveNegative(logger){
        return testShouldMove(0, false);
    }

    //! Test method for step goals
    hidden function testGoalPercent(stepGoal, steps, expected){
        //Initialization

        var activityInfo = getActivityInfoMock(stepGoal, steps, 0);
        Aut.setActInfo(activityInfo);

        //Test
        var test = Aut.getStepsGoalPercent();
        return  test == expected;
    }

    hidden function testShouldMove(moveBarLevel, expected){

        //Initialization
        var activityInfo = getActivityInfoMock(0, 0, moveBarLevel);
        Aut.setActInfo(activityInfo);

        //Test
        var test = Aut.shouldMove();
        return  test == expected;
    }


}