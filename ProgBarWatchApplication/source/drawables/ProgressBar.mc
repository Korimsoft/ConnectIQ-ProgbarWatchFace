using Toybox.WatchUi as Ui;

module ProgressBars {

//! An outline of the progress bar - this will be rendered as a background for each progress bar.
hidden const outline = Ui.loadResource(Rez.Drawables.BarOutline);
hidden const DEFAULT_ORIENTATION = "horizontal";

class ProgressBar extends Ui.Drawable
{
    hidden var segmentation;
    hidden var filledRatio = 0;

    hidden var defaultThickness;
    hidden var defaultLength;

    hidden var filledLength = 0;
    
    hidden var orientation = DEFAULT_ORIENTATION;

    function initialize(params){

        Drawable.initialize(params);

        //Drawable should have locX and locY parameters,
        //however, they apparently cannot be  initialized in the layout.xml (as x and y)
        //
        locX = params.get(:x);
        locY = params.get(:y);
		me.segmentation=params.get(:segments);
        me.defaultLength = params.get(:barWidth);
        me.defaultThickness = params.get(:barThickness);
		
		me.orientation = params.get(:orientation);


    }

    //! Draw the progress bar on the drawing context.
    function draw(dc)
    {

        dc.drawBitmap(locX, locY, outline);

        dc.fillRectangle(locX, locY, filledWidth, defaultHeight);

    }

    //! Set the segmentation of the progress bar. This function will accept
    //! values ranging from 1 to 100 since that is the minimum and maximum
    //! for the app.
    function setSegmentation(value){

        if(value < 1 || value > 100){
            throw new InvalidValueException("Invalid value of setSegmentation: " + value);
        }

        me.segmentation = value;
    }

    //! Set the width of the fill of the progress bar.
    function setFill(value){

        if(value >= 0 && value <= me.segmentation){

                me.filledLength = Math.floor(me.defaultLength * (value.toDouble()/me.segmentation.toDouble()));

            } else {
                throw new InvalidValueException("Invalid value of setFill" + value);
            }
    }
}
}