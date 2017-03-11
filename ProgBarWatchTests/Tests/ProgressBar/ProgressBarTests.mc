using Toybox.Application;

module ProgressBarTests{

    hidden const PARAMS = {
        :x=>"0",
        :y=>"0", 
        :segments=>"1", 
        :defaultLength=>"100", 
        :defaultThickness=>"15",
        :orientation=>"horizontal"
    };

    //! Segmentation values of the progress bar must be between 0 and 100.
    //! They throw an InvalidValueException otherwise
    (:test)
    function testSegmentationInvalidValueLow(logger) {
    	    
        var exception = InvalidValueException;
        var result = testSegmentationInvalid(0, exception, logger);
        return result;
        
    }

    //! Segmentation values of the progress bar must be between 0 and 100.
    //! They throw an InvalidValueException otherwise
    (:test)
    function testSegmentationInvalidValueHigh(logger) {
        var exception = InvalidValueException;
        var result = testSegmentationInvalid(101, exception, logger);
        return result;
    }


    hidden function testSegmentationInvalid(value, exception, logger){
       	    
        var progBar = new ProgressBars.ProgressBar(PARAMS);

        try{
            progBar.setSegmentation(value);
        } catch (ex) {
        	if (ex instanceof exception){
        		logger.debug("Expected exception caught.");
        		return true;
        	}
            else {
             logger.warning("Unexpected exception caught!");
             return false;
            }
        }

		logger.warning("No Exception caught!!!");
        return false;
    }
}