package ;


import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Shape;
import flash.display.Sprite;
import flash.geom.Point;
import flash.geom.Vector3D;
import flash.Lib;
import openfl.Assets;

	class ProjTest extends Sprite {
		
		var projCount:Int = 10;
		var maxRad:Int = 5;
		
		public var projArray3D:Array<ProjObj>;
		
		var tempObj:ProjObj;
		var tempVec:Vector3D;
		var tempPoint:Point;
		var fl:Int; //= 160;
		var yOff:Int;// = 100;
		var objY:Int;// = 60;
		var topZ:Int = 0;
		var lineColor:Int;
		
		public function new(_fl:Int,_objY:Int,_yOff:Int,_color) {
			fl = _fl;
			yOff = _yOff;
			objY = _objY;
			lineColor = _color;
			tempVec = new Vector3D(0, 0, 0, 0);
			tempPoint = new Point(0, 0); 
			tempObj = new ProjObj(fl, maxRad, 0, objY, yOff,new BitmapData(1,1));
			projArray3D = [];
			super();
			setup();
		}
		
		function setup():Void {
			var bmp:Bitmap = new Bitmap(Assets.getBitmapData("img/Wizardball.png"));
			var d:BitmapData = new BitmapData(Std.int(bmp.width), Std.int(bmp.height), true, 0x00000000);
			d.draw(bmp);
			for (i in 0...projCount) {
				var tempProj:ProjObj = new ProjObj(fl, maxRad,lineColor, objY, yOff,d);
				addChild(tempProj);
				projArray3D.push(tempProj);
			}
		}
		public function NextFrame(_vx:Float, _vz:Float,_projSpeed:Float):Void {
			for (i in 0...projCount) {
				tempObj = projArray3D[i];
				if (tempObj.active == true) {
					tempVec = tempObj.vec3D;
					tempVec.x += _vx;
					tempVec.z += _vz;
					tempVec.z += _projSpeed;
					if (tempVec.z >= topZ) {
						tempObj.Stop();
					}
					else {
						tempObj.Next();
					}
				}
			}	
		}
		public function NewProj():Void {
			for (i in 0...projCount) {
				tempObj = projArray3D[i];
				if (tempObj.active == false) {
					tempObj.Start();
					break;
				}
			}
		}
		
	
		
	}