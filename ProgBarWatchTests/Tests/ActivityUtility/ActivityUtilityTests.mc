using ActivityUtility as Aut;
using Toybox.Test as Test;

module ActivityUtilityTests{


    //! Negative value should result in zero
    (:test)
    function TestGoalPercentGoalZero(logger){

        //Initialization
        var params = {:stepGoal=>0, :steps=>1234};
        var activityInfo = new ActivityInfoMock(params);
        Aut.setActInfo(activityInfo);

        //Test
        Test.assertEqual(Aut.getGoalPercent, 0);

        //Cleanup
    }


    //!
    (:test)
    function TestGoalPercentPositive(logger){

    }

    //!
    (:test)
    function TestGoalPercentOver100(logger){

    }

    //!
    (:test)
    function TestShouldMovePositive(logger){

    }

    //!
    (:test)
    function TestShouldMoveNegative(logger){

    }


}