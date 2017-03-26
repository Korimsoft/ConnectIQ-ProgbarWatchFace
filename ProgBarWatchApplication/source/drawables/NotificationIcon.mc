using Toybox.WatchUi as Ui;

module NotificationIcons {

// A void icon used for masking out inactive notifications.
hidden const voidIcon = Ui.loadResource(Rez.Drawables.VoidIcon);

//! Notification icon that can be used for example for notifying
//! Mobile connection status, or new messages...
class NotificationIcon extends Ui.Drawable {

    hidden var visible = false;
    hidden var image;

   function initialize(params){
        Drawable.initialize(params);

        locX = params.get(:x);
        locY = params.get(:y);

        var imageID = params.get(:image);
        image = Ui.loadResource(imageID);

   }

    //! Set the notification icon's visibility.
   function setVisible(newVisible){
     visible = newVisible;
   }

    //! If the notification is active (visible), draw the notification icon
    //! If it is invisible, draw a void place instead.
   function draw(dc){

        if(visible){
            dc.drawBitmap(locX, locY, image);
        } else {
            //Draw a void image to mask out the icon
            dc.drawBitmap(locX, locY, voidIcon);
        }

   }
}
}