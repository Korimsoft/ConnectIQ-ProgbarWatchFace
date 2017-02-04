using Toybox.WatchUi as Ui;

class NotificationIcon extends Ui.Drawable {

    hidden var visible = false;
    hidden var posX, posY;
    hidden var image;

   function initialize(params){
        Drawable.initialize(params);

        System.println("***\tCreating notification icon\t***");
        posX = params.get(:x);
        System.println("Notification X:" + posX);

        posY = params.get(:y);
        System.println("Notification Y:" + posY);

        var imageID = params.get(:image);

        image = Ui.loadResource(imageID);
        System.println("Icon: " + image);
   }

   function setVisible(newVisible){
     visible = newVisible;
   }

   function draw(dc){
        if(visible){
            System.println("Drawing icon");
            dc.drawBitmap(posX, posY, image);
        } else {
            System.println("Icon invisible");
        }

   }
}