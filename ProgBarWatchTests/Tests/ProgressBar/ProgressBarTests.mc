using Toybox.Application;

module ProgressBarTests{

	hidden const FILLED_RATIO = 0.5f;

    hidden const PARAMS_HORIZONTAL = {
        :x=>0,
        :y=>0, 
        :length=>100, 
        :thickness=>15,
        :orientation=>"horizontal"
    };
    
    hidden const PARAMS_VERTICAL = {
    	:x=>0,
        :y=>0, 
        :length=>100, 
        :thickness=>15,
        :orientation=>"vertical"
    };


    (:test)
    function testFillHorizontal(logger){
    	return testFill(logger, PARAMS_HORIZONTAL);
    	
    }
    
    (:test)
    function testFillVertical(logger){
    	return testFill(logger, PARAMS_VERTICAL);
    }
    
    (:test)
    function testOutlineHorizontal(logger){
    	return testOutline(logger, PARAMS_HORIZONTAL);
    }
    
    (:test)
    function testOutlineVertical(logger){
    	return testOutline(logger, PARAMS_VERTICAL);
    }
    
    
    hidden function testFill(logger, params){
    	// Initialization
    	var progBar = new ProgressBars.ProgressBar(params);
    	
    	// Test step
    	var fillResult =  getFillDrawResults(logger, progBar, params, FILLED_RATIO);
    	
    	// Result validation
    	var fillOk = checkShape(logger, fillResult, params, FILLED_RATIO);
    	
    	logger.debug("Fill passed: " + fillOk);
    	
    	return fillOk;
    }
    
    hidden function testOutline(logger, params){
    	
    	var progBar = new ProgressBars.ProgressBar(params);
    	
    	var dc = new DrawingContextMock(); 
    	progBar.draw(dc);
    	
    	
    	var outlineResult = dc.getRectangleResults()[:drawn];
    	
    	var outlineOk = checkShape(logger, outlineResult, params, 1); 
    	
    	logger.debug("Outline passed: " + outlineOk);
    	
    	return outlineOk;
    	
    }
    
    //This is the test action itself
    // Sets the fill of the progress bar
    // The changed state of the progress bar is readable when the progress bar draws itself
    hidden function getFillDrawResults(logger, progBar, params, fill){
    		   		
    		logger.debug("Filling: " + fill);
    		progBar.setFillRatio(fill);
    		
    		var dc = new DrawingContextMock();
    		
    		// To get the results...
    		progBar.draw(dc);
    		
    		var result = dc.getRectangleResults()[:filled];
    		return result;
    		
    }
    
    // This is the result validation step
	hidden function checkShape(logger, returned, expectedParams, lengthRatio)
	{
		var expectedX = expectedParams[:x], expectedY = expectedParams[:y], expectedWidth, expectedHeight;
		
		var defaultLength = expectedParams[:length];
		
		var expectedLength = defaultLength*lengthRatio;
		
		if(expectedParams[:orientation].equals("horizontal")) {
			expectedWidth = expectedLength;
			expectedHeight = expectedParams[:thickness];
		} else {
			expectedWidth = expectedParams[:thickness];
			expectedHeight = expectedLength;
		}
		
		logger.debug("X expected: " + expectedX + "; returned: " + returned.getX()); 
		logger.debug("Y expected: " + expectedY + "; returned: " + returned.getY());
		logger.debug("Width expected: " + expectedWidth + "; returned: " + returned.getWidth());
		logger.debug("Height expected: " + expectedHeight + "; returned: " + returned.getHeight());
		
		return expectedX == returned.getX() && expectedY == returned.getY() && expectedWidth == returned.getWidth() && expectedHeight == returned.getHeight();
		
	}    
	
   
   
    
}