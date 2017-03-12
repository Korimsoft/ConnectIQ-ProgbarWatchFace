using Toybox.WatchUi as Ui;

module ProgressBars {

hidden const HORIZONTAL = "horizontal";
hidden const VERTICAL = "vertical";
hidden const DEFAULT_ORIENTATION = HORIZONTAL;


class ProgressBar extends Ui.Drawable
{    
    hidden var defaultThickness = 0;
    hidden var defaultLength = 0;

    hidden var filledLength = 0;
    
    hidden var orientation = DEFAULT_ORIENTATION;

    function initialize(params){

        Drawable.initialize(params);

        //Drawable should have locX and locY parameters,
        //however, they apparently cannot be  initialized in the layout.xml (as x and y)
        //
        locX = params.get(:x);
        locY = params.get(:y);
		
		me.defaultLength = params.get(:length);
        me.defaultThickness = params.get(:thickness);
		me.orientation = params.get(:orientation);

    }

    //! Draw the progress bar on the drawing context.
    function draw(dc)
    {

       drawOutline(dc);
       drawFill(dc);
		   
    }
    
    hidden function drawFill(dc){
    if(orientation.equals(HORIZONTAL)){
			dc.fillRectangle(locX, locY, filledLength, defaultThickness);
       } else {
       		dc.fillRectangle(locX, locY, defaultThickness, filledLength);
		}
    }
    
    hidden function drawOutline(dc){
    	
    	if(orientation.equals(HORIZONTAL)){
			dc.drawRectangle(locX, locY, defaultLength, defaultThickness);
       	} else {
       		dc.drawRectangle(locX, locY, defaultThickness, defaultLength);
		}
    }

    //! Set the proportion of filled part as value between 0 and 1.
    function setFillRatio(value){
    	if(value instanceof Float && value >= 0 && value <= 1){
    		var length = me.defaultLength * value;
    		me.filledLength = Math.round(length); // Math.Round takes Floats as input
    	}
    	else {
    		throw new InvalidValueException("Value must be a Float between 0 and 1.");
    	}
    	
    
    }
}
}