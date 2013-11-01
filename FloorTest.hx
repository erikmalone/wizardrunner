package ;

	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	import flash.Lib;
	import flash.Memory;
	import flash.Vector.Vector;
	//import flash.Vector.Vector;

	
	/**
	 * ...
	 * @author E
	 */

	class FloorTest extends Sprite 
	{
		var verticalTopZ:Int;
		var verticalBottomZ:Int; 
		var verticalTopScale:Float;
		var verticalBottomScale:Float;
		var verticalTopArray2D:Array<Point>;
		var verticalTopArray3D:Array<Vector3D>;
		var verticalBottomArray2D:Array<Point>;
		var verticalBottomArray3D:Array<Vector3D>;
		
		var vertical2DPoint:Point;
		var vertical3DPoint:Vector3D;
		
		var topZ:Int = 0;
		var verticalCount:Int =5;
		var verticalHeight:Int;
		var horizontalCount:Int = 5;
		
		var lineSize:Int = 2;
		var lineColor:Int;
		var colorArray:Array<Int>;
		var horizontalArray3D:Array<Point>;
		var horizontalArray2D:Array<Shape>;
		var horizontalArray:Array<HorizontalLine>;
		
		var box:Shape;
		var yOff:Int = 100;
		var fl:Int = 160;
		var objY:Int = 60;
		
		var commands:Vector<Int>;
		var coords:Vector<Float>; 
		var diff:Float = 0;
		var ratio:Float = 0;
		//var pointIn2D:Point;
		var vx:Float = 0;
		var vz:Float = 0;
		
		public var bossMode:Bool = false;
		
		function new(_fl:Int,_objY:Int,_yOff:Int,_color:Int) {
			fl = _fl;
			yOff = _yOff;
			objY = _objY;
			lineColor = _color;
			colorArray =[0x000000, 0x000000, 0x0000C0, 0x0000FF,0xC00000, 0xFF0000, 0xC000C0, 0xFF00FF, 0x00C000, 0x00FF00, 0x00C0C0, 0x00FFFF, 0xC0C000, 0xFFFF00, 0xC0C0C0, 0xFFFFFF];
			super();
			init();
		}
		
		//typedef point = {x: Int,y: Int,z:Int }
		private function init():Void 
		{
			//entry point
			box = new Shape();
			commands = new Vector<Int>();
		    coords = new Vector<Float>();
			vertical2DPoint = new Point();
			vertical3DPoint = new Vector3D();
			verticalTopZ = topZ;
			verticalBottomZ = -fl + 1;
			verticalTopScale = fl / (fl + verticalTopZ);
			verticalBottomScale = (fl / (fl + verticalBottomZ));
			verticalTopArray2D = [];
			verticalTopArray3D = [];
			verticalBottomArray2D = [];
			verticalBottomArray3D = [];
			horizontalArray = [];
			
			var tempHeight:Float = Lib.current.stage.stageHeight;
			var tempWidth:Float = Lib.current.stage.stageWidth;
			addChild(box);
			box.x = tempWidth / 2;
			box.y = tempHeight / 2 - yOff;
			if(yOff>0){
				verticalHeight = Std.int(Lib.current.stage.stageHeight - box.y);
			}
			else {
				verticalHeight = Std.int(box.y);
			}
			//trace(box.y);
			for (i in 0... verticalCount) {
				verticalTopArray3D.push(new Vector3D( -(tempWidth / 2) + (tempWidth / verticalCount) * i +25, objY, 0));
				verticalBottomArray3D.push(new Vector3D( -(tempWidth / 2) + (tempWidth / verticalCount) * i + 25 , objY, -fl + 1));
				commands.push(1);
				commands.push(2);
			}
			var hl:HorizontalLine = new HorizontalLine(topZ,lineSize,lineColor);
			addChild(hl);
			hl.y = ConvertHorizontalPointIn3DToPointIn2D(hl._z);
			for (j in 0... horizontalCount) {
				var s:HorizontalLine = new HorizontalLine(Std.int(-j*(((fl+topZ)/horizontalCount))),lineSize,lineColor);
				addChild(s);
				s.y = ConvertHorizontalPointIn3DToPointIn2D(s._z);
				s.cacheAsBitmap = true;
				horizontalArray.push(s);
			}
			
		
			//addEventListener(Event.ENTER_FRAME, eFrame);
		}
		//function eFrame(e:Event):Void {
		function GetColor():Int {
			var clr:Int = Std.int(Math.floor(Math.random() * 16));
			clr = colorArray[clr];
			return clr;
		}
		public function NextFrame(_vx:Float,_vz:Float):Void{
			//trace(Lib.current.stage.frameRate);
			//var clr:Int = Std.int(Math.random() * 0xffffff);
			vx = _vx; vz = _vz;
			var clr:Int=0;
			if (bossMode == true) {
				
				clr= GetColor();
			}
			else { lineColor = 0xffffff;}
			//var clr:Int = Std.int(Math.random() * 0xffffff);
			for (k in 0...horizontalCount) {
				var hl:HorizontalLine = horizontalArray[k];
				if(bossMode==true){
				hl.Update(clr);}
				hl._z += vz;
				//trace(hl._z);
				if (hl._z <= -fl) {
					//trace("HI");
					diff = fl + hl._z;
					hl._z = topZ + diff;
					
				}
				else if (hl._z >= topZ) {
					
					diff = hl._z - topZ;
					hl._z = -fl +0 + diff;
				}
				hl.y = ConvertHorizontalPointIn3DToPointIn2D(hl._z);
			}
			
			coords.splice(0,coords.length);
			for (i in 0...verticalCount) {
				vertical2DPoint = verticalTopArray2D[i];
				vertical3DPoint	 = verticalTopArray3D[i];
				vertical3DPoint.x += vx;//add the diff check here, cuz it dont get added to the othe rthang
				if (vertical3DPoint.x < -300) {
					diff = -300 - vertical3DPoint.x;
					vertical3DPoint.x = 300 - diff;
				}
				else if (vertical3DPoint.x > 300) {
					diff = vertical3DPoint.x - 300;
					vertical3DPoint.x = -300 + diff;
				}
			
				
				vertical2DPoint = ConvertVerticalTopPointIn3DToPointIn2D(vertical3DPoint);
				#if flash
				coords.push(vertical2DPoint.x);
				coords.push(vertical2DPoint.y);
				#else
					verticalTopArray2D[i] = vertical2DPoint;
				#end
				vertical2DPoint = verticalBottomArray2D[i];
				vertical3DPoint	= verticalBottomArray3D[i];
				vertical3DPoint.x += vx;
				if (vertical3DPoint.x < -300) {
					diff = -300 - vertical3DPoint.x;
					vertical3DPoint.x = 300 - diff;
				}
				else if (vertical3DPoint.x > 300) {
					diff = vertical3DPoint.x - 300;
					vertical3DPoint.x = -300 + diff;
				}
				vertical2DPoint = ConvertVerticalBottomPointIn3DToPointIn2D(vertical3DPoint);
				#if flash
				coords.push(vertical2DPoint.x);
				coords.push(vertical2DPoint.y);
				#else
				verticalBottomArray2D[i] = vertical2DPoint;
				#end
			}
			
			box.graphics.clear();
			if(bossMode==true){
		lineColor = clr;}
			box.graphics.lineStyle(lineSize,lineColor,1,false);
		#if flash	
		box.graphics.drawPath(commands, coords);
		#else	
			for (j in 0...verticalCount) {
				//var p:Point = verticalTopArray2D[j];
				//trace(verticalTopArray2D[j]);
				box.graphics.moveTo(verticalTopArray2D[j].x, verticalTopArray2D[j].y);
				box.graphics.lineTo(verticalBottomArray2D[j].x, verticalBottomArray2D[j].y);
			}
		#end
		
		
		}
		function ConvertVerticalTopPointIn3DToPointIn2D(pointIn3D:Vector3D):Point
		{
			var pointIn2D:Point = new Point(0, 0);
			pointIn2D.x = pointIn3D.x * verticalTopScale;
			pointIn2D.y=pointIn3D.y*verticalTopScale;
			return pointIn2D; 
		}
		function ConvertVerticalBottomPointIn3DToPointIn2D(pointIn3D:Vector3D):Point
		{
			var pointIn2D:Point= new Point(0, 0);
			pointIn2D.x = pointIn3D.x * verticalBottomScale;
			pointIn2D.y = pointIn3D.y * verticalBottomScale;
			if (pointIn2D.x / pointIn2D.y >=-1 && pointIn2D.x/pointIn2D.y <=1) {
				ratio = pointIn2D.y / verticalHeight;
				//trace(verticalHeight+"|"+pointIn2D.y + "| "+ratio);
				}
			else {
				ratio = pointIn2D.x / 300;
			}
			if (ratio < 0) { ratio *= -1;}
			pointIn2D.x /= ratio;
			pointIn2D.y /= ratio;
			return pointIn2D; 
		}
		function ConvertHorizontalPointIn3DToPointIn2D(pointIn3D:Float):Float {
			//calculate the Y according to the scale ratio
			/*var pointIn2D:Object = new Object();
			var scaleRatio:Number = fl/(fl+pointIn3D.z);
			pointIn2D.x=pointIn3D.x*scaleRatio;
			pointIn2D.y=pointIn3D.y*scaleRatio;
			return pointIn2D;*/
			var scaleRatio:Float = fl / (fl + pointIn3D);
			
			return (objY*scaleRatio)+box.y;
		}
		
	}
	
