//! Mock class for Drawing Context
//! It is used for testing the ProgressBar drawing functions
class DrawingContextMock{
 
 hidden var filledRectangle=null;
 hidden var drawnRectangle=null;
 
 function drawRectangle(x, y, width, height){
 	me.drawnRectangle = new Rectangle(x, y, width, height);
 }
 
 function fillRectangle(x, y, width, height){
 	me.filledRectangle = new Rectangle(x, y, width, height);
 }
 
 function getRectangleResults(){
 	return {:filled=>filledRectangle, :drawn=>drawnRectangle};
 }
  
}

//! Mockup class for a rectangle, if it is uninitialized, all the values are set to -1;
class Rectangle{

	hidden var x=-1, y=-1, width=-1, height=-1;

 	function Initialize(x, y, width, height){
 		me.x = x;
 		me.y = y;
 		me.width = width;
 		me.height = height;
 	}
 	
 	function getX(){
 		return me.x;
 	}
	
	function getY(){
 		return me.y;
 	}
 	
 	function getWidth(){
 		return me.width;
 	}
 	
 	function getHeight(){
 		return me.height;
 	}
}