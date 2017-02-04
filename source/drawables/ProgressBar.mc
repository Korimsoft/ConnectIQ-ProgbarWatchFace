using Toybox.WatchUi as Ui;

module ProgressBars {

//! An outline of the progress bar - this will be rendered as a background for each progress bar.
hidden const outline = Ui.loadResource(Rez.Drawables.BarOutline);

class ProgressBar extends Ui.Drawable
{
    hidden var posX, posY, segmentation;
    hidden var filledRatio = 0;

    hidden var defaultHeight;
    hidden var defaultWidth;

    hidden var filledWidth = 0;

    function initialize(params){

        Drawable.initialize(params);

        posX = params.get(:x);
        posY = params.get(:y);
        segmentation=params.get(:segments);

        defaultHeight = Application.getApp().getProperty("BarThickness");
        defaultWidth = Application.getApp().getProperty("BarWidth");

    }

    //! Draw the progress bar on the drawing context.
    function draw(dc)
    {

        dc.drawBitmap(posX, posY, outline);

        dc.fillRectangle(posX, posY, filledWidth, defaultHeight);

    }

    //! Set the segmentation of the progress bar. This function will accept
    //! values ranging from 1 to 100 since that is the minimum and maximum
    //! for the app.
    function setSegmentation(value){

        if(value < 1 || value > 100){
            throw new Exception("Invalid value of setSegmentation: " + value);
        }

        segmentation = value;
    }

    //! Set the width of the fill of the progress bar.
    function setFill(value){

        if(value >= 0 && value <= segmentation){

                filledWidth = Math.floor(defaultWidth * (value.toDouble()/segmentation.toDouble()));

            } else {
                throw new Exception("Invalid value");
            }
    }
}
}