package ;


import flash.display.Shape;
import flash.display.Sprite;
import flash.geom.Point;
import flash.geom.Vector3D;
import flash.Lib;
	class ObjTest extends Sprite {
		
		var fl:Int = 160;
		var yOff:Int = 100;
		var objY:Int = 60;
		var topZ:Int = 0;
		var tempVec:Vector3D;
		var tempPoint:Point;
		public var objArray3D:Array<EnemyTest>;
		var box:Shape;
		var objCount:Int = 20;
		
		public function new(_fl:Int,_objY:Int,_yOff:Int) {
			super();
			fl = _fl;
			yOff = _yOff;
			objY = _objY;
			init();
			setup();
		}
		function init():Void {
			objArray3D = [];
			box = new Shape();
			tempVec = new Vector3D(0, 0, 0, 0);
			tempPoint = new Point(0, 0);
		}
		function setup():Void {
			addChild(box);
			box.x = Lib.current.stage.stageWidth / 2;
			box.y = Lib.current.stage.stageHeight / 2 - yOff;
			for (i in 0...objCount) {
					var enemy:EnemyTest = new EnemyTest();
					addChild(enemy);
					objArray3D.push(enemy);
			}
		}
		public function NextFrame(_vx:Float, _vz:Float):Void {
			box.graphics.clear();
			box.graphics.lineStyle(2, 0);
			box.graphics.beginFill(0xff0000);
			for (i in 0...objCount) {
				var enemy:EnemyTest = objArray3D[i];
				if (enemy.active == true) {
					tempVec = enemy.vec3D;
					tempVec.x += _vx;
					tempVec.z += _vz;
					if (tempVec.z < -fl) {
						enemy.active = false;
						enemy.Stop();
					}
					else {
						tempPoint = ConverPointIn3DToPointIn2D(tempVec);
						enemy.Next();
						enemy.x = tempPoint.x;
						enemy.y = tempPoint.y;
						//do conversion in NEXT and also rescale image THERE
						
					}
					
				}
			}
		}
		public function NewObj():Void {
			
			for (i in 0...objCount) {
				var enemy:EnemyTest = objArray3D[i];
				if (enemy.active == false) {
					enemy.active = true;
					enemy.vec3D = new Vector3D(0, objY, 0, 0);
					enemy.Start();
					break;
				}
			}
		}
		function ConverPointIn3DToPointIn2D(pointIn3D:Vector3D):Point
		{
			var pointIn2D:Point = new Point();
			var scaleRatio:Float = fl / (fl + pointIn3D.z);
			pointIn2D.x=pointIn3D.x*scaleRatio;
			pointIn2D.y = pointIn3D.y * scaleRatio;
			pointIn2D.x+= Lib.current.stage.stageWidth / 2;
			pointIn2D.y+= Lib.current.stage.stageHeight / 2 - yOff;
			return pointIn2D;
		}
	
		
	}