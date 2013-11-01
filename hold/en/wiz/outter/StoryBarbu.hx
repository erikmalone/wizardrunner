package hold.en.wiz.outter ;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Matrix;
import flash.Lib;
class StoryBar extends Sprite {
	var DataLine:BitmapData;
	var SwirlLeft:Sprite;
	var SwirlRight:Sprite;
	var lineRight:Sprite;
	var lineLeft:Sprite;
	var lineSize:Int = 0;
	var lineOffset:Int = 0;
	var counter:Int = 0;
	var rotSpeed:Int = 1;
	var MoveLinesOutward:Bool = true;
	function new(BMPLine:Bitmap, BMPSwirl:Bitmap) {
		super();
		lineSize = Std.int(Lib.current.stage.stageWidth * .4);
		lineOffset = Std.int(Lib.current.stage.stageWidth * .1);
		lineRight = new Sprite();
		lineLeft = new Sprite();
		var matLeft:Matrix = new Matrix();
		var matRight:Matrix = new Matrix();
		SwirlLeft = new Sprite(); var BMPTemp1:Bitmap = new Bitmap(BMPSwirl.bitmapData);
		SwirlRight = new Sprite(); var BMPTemp2:Bitmap = new Bitmap(BMPSwirl.bitmapData);
		DataLine = new BitmapData(Std.int(BMPLine.width), Std.int(BMPLine.height), true, 0x00000000);
		DataLine.draw(BMPLine);
		
		lineLeft.graphics.clear();
		lineLeft.graphics.beginBitmapFill(DataLine, matLeft, true, false);
		lineLeft.graphics.drawRect(0, 0, lineSize, DataLine.height);
		lineRight.graphics.clear();
		lineRight.graphics.beginBitmapFill(DataLine, matRight, true, false);
		lineRight.graphics.drawRect(0, 0, lineSize, DataLine.height);
		lineRight.x = Lib.current.stage.stageWidth / 2;
		lineLeft.x = lineOffset;
		lineLeft.y = BMPTemp1.height / 2-lineLeft.height/2;
		lineRight.y = BMPTemp1.height / 2-lineRight.height/2;
		BMPTemp1.x = -BMPTemp1.width / 2; BMPTemp1.y = -BMPTemp1.height / 2;
		BMPTemp2.x = -BMPTemp2.width / 2; BMPTemp2.y = -BMPTemp2.height / 2;
		SwirlLeft.x = lineOffset;
		SwirlRight.x = Lib.current.stage.stageWidth - lineOffset;
		SwirlLeft.y =  lineLeft.y + lineLeft.height / 2;
		SwirlRight.y = lineRight.y + lineRight.height / 2;
		
		addChild(lineRight);
		addChild(lineLeft);
		addChild(SwirlLeft);
		addChild(SwirlRight);
		SwirlRight.addChild(BMPTemp2);
		SwirlLeft.addChild(BMPTemp1);
		
		addEventListener(Event.ENTER_FRAME, eFrame);
	}
	function Run():Void {
		var matLeft:Matrix = new Matrix();
		var matRight:Matrix = new Matrix();
		counter++;
		if(MoveLinesOutward==true){
			matRight.tx = counter;
			matLeft.tx = -counter; }
		else {
			matRight.tx = -counter;
			matLeft.tx = counter;
		}
		if (counter >= DataLine.width) { counter = 0;}
		lineLeft.graphics.clear();
		lineLeft.graphics.beginBitmapFill(DataLine, matLeft, true, false);
		lineLeft.graphics.drawRect(0, 0, lineSize, DataLine.height);
		lineRight.graphics.clear();
		lineRight.graphics.beginBitmapFill(DataLine, matRight, true, false);
		lineRight.graphics.drawRect(0, 0, lineSize, DataLine.height);
		SwirlLeft.rotation -= rotSpeed;
		SwirlRight.rotation += rotSpeed;
	}
	public function ChangeSwirlRotation():Void {
		rotSpeed = -rotSpeed;
	}
	public function ChangeLineDirection():Void {
		MoveLinesOutward = !MoveLinesOutward;
	}
	
	function eFrame(e:Event):Void {
		var matLeft:Matrix = new Matrix();
		var matRight:Matrix = new Matrix();
		counter++;
		if(MoveLinesOutward==true){
			matRight.tx = counter;
			matLeft.tx = -counter; }
		else {
			matRight.tx = -counter;
			matLeft.tx = counter;
		}
		if (counter >= DataLine.width) { counter = 0;}
		lineLeft.graphics.clear();
		lineLeft.graphics.beginBitmapFill(DataLine, matLeft, true, false);
		lineLeft.graphics.drawRect(0, 0, lineSize, DataLine.height);
		lineRight.graphics.clear();
		lineRight.graphics.beginBitmapFill(DataLine, matRight, true, false);
		lineRight.graphics.drawRect(0, 0, lineSize, DataLine.height);
		SwirlLeft.rotation -= rotSpeed;
		SwirlRight.rotation += rotSpeed;
		
	}
}