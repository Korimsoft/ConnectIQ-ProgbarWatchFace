using Toybox.WatchUi as Ui;

module NotificationIcons {

// A void icon used for masking out inactive notifications.
hidden const voidIcon = Ui.loadResource(Rez.Drawables.VoidIcon);

class NotificationIcon extends Ui.Drawable {

    hidden var visible = false;
    hidden var posX, posY;
    hidden var image;

   function initialize(params){
        Drawable.initialize(params);

        posX = params.get(:x);
        posY = params.get(:y);

        var imageID = params.get(:image);
        image = Ui.loadResource(imageID);

   }

   function setVisible(newVisible){
     visible = newVisible;
   }

   function draw(dc){

        if(visible){
            dc.drawBitmap(posX, posY, image);
        } else {
            //Draw a void image to mask out the icon
            dc.drawBitmap(posX, posY, voidIcon);
        }

   }
}
}