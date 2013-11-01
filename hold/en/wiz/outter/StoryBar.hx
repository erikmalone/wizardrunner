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
	var DataSwirl:BitmapData;
	var SwirlTopLeft:Sprite;
	var SwirlTopRight:Sprite;
	var SwirlBottomLeft:Sprite;
	var SwirlBottomRight:Sprite;
	var lineRight:Sprite;
	var lineLeft:Sprite;
	var lineTop:Sprite;
	var lineBottom:Sprite;
	var lineHorizontalSize:Int = 0;
	var lineVerticalSize:Int = 0;
	var spotWidthOffset:Float = 0;
	var spotHeightOffset:Float = 0;
	var pytha:Float = 0;
	
	function new(BMPLine:Bitmap, BMPSwirl:Bitmap) {
		super();
		lineHorizontalSize = Std.int(Lib.current.stage.stageWidth * .9);
		lineVerticalSize = Std.int(Lib.current.stage.stageHeight * .9);
		spotWidthOffset = Lib.current.stage.stageWidth * .05;
		spotHeightOffset = Lib.current.stage.stageHeight * .05;
		lineRight = new Sprite();
		lineLeft = new Sprite();
		lineTop = new Sprite();
		lineBottom = new Sprite();
		
		DataLine = BMPLine.bitmapData;
		DataSwirl = BMPSwirl.bitmapData;
		pytha = DataLine.height*10;
		addChild(lineTop);
		addChild(lineBottom);
		//addChild(lineLeft);
		//addChild(lineRight);
		
		SwirlBottomLeft = MakeSwirl();
		SwirlBottomRight = MakeSwirl();
		SwirlTopLeft = MakeSwirl();
		SwirlTopRight = MakeSwirl();
		
		addChild(SwirlTopLeft);
		addChild(SwirlTopRight);
		addChild(SwirlBottomLeft);
		addChild(SwirlBottomRight);
		SwirlTopLeft.x = spotWidthOffset;
		SwirlTopLeft.y = spotHeightOffset;
		SwirlTopRight.x = Lib.current.stage.stageWidth - spotWidthOffset;
		SwirlTopRight.y = spotHeightOffset;
		SwirlBottomLeft.x = spotWidthOffset;
		SwirlBottomLeft.y = Lib.current.stage.stageHeight - spotHeightOffset;
		SwirlBottomRight.x = Lib.current.stage.stageWidth - spotWidthOffset;
		SwirlBottomRight.y = Lib.current.stage.stageHeight - spotHeightOffset;
		
		
		var matTop = new Matrix(1, 0, 0, -1, 0, DataLine.height);
		lineTop.graphics.beginBitmapFill(DataLine, matTop, true, false);
		//lineTop.graphics.drawRect(0, 0, lineHorizontalSize, DataLine.height);
		lineTop.graphics.lineStyle(1, 0, 0);
		lineTop.graphics.lineTo(lineHorizontalSize, 0);
		lineTop.graphics.lineTo(lineHorizontalSize-pytha,pytha);
		lineTop.graphics.lineTo(pytha, pytha);
		lineTop.graphics.lineTo(0, 0);
		
		var matLeft = new Matrix();
		matLeft.rotate(90 * (Math.PI / 180));
		lineLeft.graphics.beginBitmapFill(DataLine, matLeft, true, false);
		//lineLeft.graphics.drawRect(0, 0, DataLine.height, lineVerticalSize);
		lineLeft.graphics.lineStyle(1, 0, 0);
		lineLeft.graphics.lineTo(0, lineVerticalSize);
		lineLeft.graphics.lineTo(pytha, lineVerticalSize-pytha);
		lineLeft.graphics.lineTo(pytha, pytha);
		
		var matRight = new Matrix();
		matRight.rotate(-90 * (Math.PI / 180));
		lineRight.graphics.beginBitmapFill(DataLine, matRight, true, false);
		//lineRight.graphics.drawRect(0, 0, DataLine.height, lineVerticalSize);
		lineRight.graphics.moveTo(0, pytha);
		lineRight.graphics.lineTo(0, lineVerticalSize-pytha);
		lineRight.graphics.lineTo(pytha, lineVerticalSize);
		lineRight.graphics.lineTo(pytha, 0);
		lineRight.graphics.lineTo(0, pytha);
		
		var matBottom:Matrix = new Matrix(1, 0, 0, 1, 0, DataLine.height);
		lineBottom.graphics.beginBitmapFill(DataLine, matBottom, true, false);
		//lineBottom.graphics.drawRect(0, 0, lineHorizontalSize, DataLine.height);
		lineBottom.graphics.moveTo(pytha, 0);
		lineBottom.graphics.lineTo(lineHorizontalSize-pytha, 0);
		lineBottom.graphics.lineTo(lineHorizontalSize,pytha);
		lineBottom.graphics.lineTo(0, pytha);
		lineBottom.graphics.lineTo(pytha, 0);
		
		lineTop.x = spotWidthOffset;
		lineTop.y = spotHeightOffset;// - lineTop.height + 2;
		lineLeft.x = spotWidthOffset;// - lineLeft.width + 2;
		lineLeft.y = spotHeightOffset;
		
		lineBottom.x = spotWidthOffset;
		lineBottom.y = Lib.current.stage.stageHeight - spotHeightOffset-pytha;
		lineRight.x = Lib.current.stage.stageWidth - spotWidthOffset-pytha;
		lineRight.y = spotHeightOffset;
		addEventListener(Event.ENTER_FRAME, eFrame);
		//this.scaleX = this.scaleY = 0.01;
	}
	
	
	var counter:Int = 0;
	function eFrame(e:Event):Void {
		counter++;
		//this.scaleX = this.scaleY += 0.01;
		var matTop = new Matrix(1, 0, 0, -1, 0, DataLine.height);
		matTop.tx = counter;
		matTop.ty = -counter;
		lineTop.graphics.clear();
		lineTop.graphics.beginBitmapFill(DataLine, matTop, true, false);
		//lineTop.graphics.drawRect(0, 0, lineHorizontalSize, DataLine.height);
		lineTop.graphics.lineStyle(1, 0, 0);
		lineTop.graphics.lineTo(lineHorizontalSize, 0);
		lineTop.graphics.lineTo(lineHorizontalSize-pytha, pytha);
		lineTop.graphics.lineTo(pytha, pytha);
		lineTop.graphics.lineTo(0, 0);
		
		
		var matLeft = new Matrix();
		matLeft.rotate(90 * (Math.PI / 180));
		matLeft.ty = -counter;
		matLeft.tx = -counter;
		lineLeft.graphics.clear();
		lineLeft.graphics.beginBitmapFill(DataLine, matLeft, true, false);
		//lineLeft.graphics.drawRect(0, 0, DataLine.height, lineVerticalSize);
		lineLeft.graphics.lineStyle(1, 0, 0);
		lineLeft.graphics.lineTo(0, lineVerticalSize);
		lineLeft.graphics.lineTo(pytha, lineVerticalSize-pytha);
		lineLeft.graphics.lineTo(pytha, pytha);
		
		var matRight = new Matrix();
		matRight.rotate( -90 * (Math.PI / 180));
		matRight.ty = counter;
		matRight.tx = counter;
		lineRight.graphics.clear();
		lineRight.graphics.beginBitmapFill(DataLine, matRight, true, false);
		//lineRight.graphics.drawRect(0, 0, DataLine.height, lineVerticalSize);
		lineRight.graphics.moveTo(0, pytha);
		lineRight.graphics.lineTo(0, lineVerticalSize-pytha);
		lineRight.graphics.lineTo(pytha, lineVerticalSize);
		lineRight.graphics.lineTo(pytha, 0);
		lineRight.graphics.lineTo(0, pytha);
		
		var matBottom:Matrix = new Matrix(1, 0, 0, 1, 0, DataLine.height);
		matBottom.tx = -counter;
		matBottom.ty = counter;
		lineBottom.graphics.clear();
		lineBottom.graphics.beginBitmapFill(DataLine, matBottom, true, false);
		//lineBottom.graphics.drawRect(0, 0, lineHorizontalSize, DataLine.height);
		lineBottom.graphics.moveTo(pytha, 0);
		lineBottom.graphics.lineTo(lineHorizontalSize-pytha, 0);
		lineBottom.graphics.lineTo(lineHorizontalSize,pytha);
		lineBottom.graphics.lineTo(0, pytha);
		lineBottom.graphics.lineTo(pytha, 0);
		
		SwirlBottomLeft.rotation = SwirlBottomRight.rotation = 
		SwirlTopLeft.rotation = SwirlTopRight.rotation = counter*2;
	}
	function MakeSwirl():Sprite {
		var s:Sprite = new Sprite();
		var con:Sprite = new Sprite();
		s.graphics.beginBitmapFill(DataSwirl, null, false, false);
		s.graphics.drawRect(0, 0, DataSwirl.width, DataSwirl.height);
		s.x = -s.width / 2;
		s.y = -s.height / 2;
		con.addChild(s);
		return con;
	}
}