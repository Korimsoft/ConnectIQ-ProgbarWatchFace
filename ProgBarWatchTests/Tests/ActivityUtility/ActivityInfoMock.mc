//! Mock object that simulates the Toybox.ActivityMonitor
class ActivityInfoMock{
     var moveBarLevel = 0;
     var steps = 0;
     var stepGoal = 0;

     //! Constructor that initializes the mock object
     //!
     function initialize(valuesDictionary){

        moveBarLevel = valuesDictionary[:moveBarLevel];
        steps = valuesDictionary[:steps];
        stepGoal = valuesDictionary[:stepGoal];

     }
}