using Toybox.WatchUi as Ui;

class NotificationIcon extends Ui.Drawable {

    hidden const voidIcon = Ui.loadResource(Rez.Drawables.VoidIcon);

    hidden var visible = false;
    hidden var posX, posY;
    hidden var image;

   function initialize(params){
        Drawable.initialize(params);

        System.println("***Instantiating notification icon " + Drawable + "***");
        posX = params.get(:x);
        System.println("Notification X:" + posX);

        posY = params.get(:y);
        System.println("Notification Y:" + posY);

        var imageID = params.get(:image);

        image = Ui.loadResource(imageID);
        System.println("Icon: " + imageID + ": " + image);
   }

   function setVisible(newVisible){
     System.println("Setting visibility of icon to :" + newVisible);
     visible = newVisible;
   }

   function draw(dc){
        System.println("NotificationIcon.draw:");
        if(visible){
            System.println("Drawing icon");
            dc.drawBitmap(posX, posY, image);
        } else {
            System.println("Icon invisible: " + image);
            dc.drawBitmap(posX, posY, voidIcon);
        }

   }
}