using Toybox.Application;

module ProgressBarTests{

	hidden const FILLED_RATIO = 0.5;

    hidden const PARAMS_HORIZONTAL = {
        :x=>"0",
        :y=>"0", 
        :segments=>"1", 
        :defaultLength=>"100", 
        :defaultThickness=>"15",
        :orientation=>"horizontal"
    };
    
    hidden const PARAMS_VERTICAL = {
    	:x=>"0",
        :y=>"0", 
        :segments=>"1", 
        :defaultLength=>"100", 
        :defaultThickness=>"15",
        :orientation=>"vertical"
    };

    //! Segmentation values of the progress bar must be between 1 and 100.
    //! They throw an InvalidValueException otherwise
    (:test)
    function testSegmentationInvalidValueLow(logger) {
    	    
        var exception = InvalidValueException;
        var result = testSegmentationInvalid(0, exception, logger);
        return result;
        
    }

    //! Segmentation values of the progress bar must be between 1 and 100.
    //! They throw an InvalidValueException otherwise
    (:test)
    function testSegmentationInvalidValueHigh(logger) {
        var exception = InvalidValueException;
        var result = testSegmentationInvalid(101, exception, logger);
        return result;
    }


    (:test)
    function testHorizontalDraw(logger){
    	var drawResults =  getDrawResults(PARAMS_HORIZONTAL);
    	return checkDrawResults(PARAMS_HORIZONTAL[:x], PARAMS_HORIZONTAL[:y], PARAMS_HORIZONTAL[:defaultLength], PARAMS_HORIZONTAL[:defaultThickness]);
    	
    }
    
    (:test)
    function testVerticalDraw(logger){
    	var drawResults = getDrawResults(PARAMS_VERTICAL);
    }
    
    hidden function getDrawResults(params){
    		var progBar = new ProgressBars.ProgressBar(params);
    		progBar.setFillRatio(FILLED_RATIO);
    		var dc = new DrawingContextMock();
    		
    		progBar.draw(dc);
    		
    		var results = dc.getRectangleResults;
    		
    		
    }
    
    hidden function testSegmentationInvalid(value, exception, logger){
       	    
        var progBar = new ProgressBars.ProgressBar(PARAMS_HORIZONTAL);

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