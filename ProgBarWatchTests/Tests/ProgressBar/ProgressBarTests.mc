module ProgressBarTests{

    hidden var params = {
        :x=>"0", :y=>"0", :segments=>"1"
    };

    //! Segmentation values of the progress bar must be between 0 and 100.
    //! They throw an Exception otherwise
    (:test)
    function testSegmentationInvalidValueLow(logger) {
        var exception = Toybox.Lang.Exception;
        //var result = testSegmentationInvalid(0, exception);
        //return result;
        logger.warning("Test not implemented yet!");
        return false;
    }

    //! Segmentation values of the progress bar must be between 0 and 100.
    //! They throw an Exception otherwise
    (:test)
    function testSegmentationInvalidValueHigh(logger) {
        logger.warning("Test not implemented yet!");
        return false;
    }

    hidden function testSegmentationInvalid(value, exception){
        var progBar = new ProgressBars.ProgressBar(params);

        try{
            progBar.setSegmentation(value);
        } catch (ex) {
            return ex instanceof exception;
        }

        return false;
    }
}