package ;


import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Shape;
import flash.display.Sprite;
import flash.geom.Point;
import flash.geom.Vector3D;
import flash.Lib;
import openfl.Assets;
	class ObstacleTest extends Sprite {
		
		var obstacleCount:Int = 10;
		var maxRad:Int = 20;
		
		public var obstacleArray3D:Array<ObstacleObj>;
		public var active:Bool = false;
		var DataTree:BitmapData; 
		var DataMushroom:BitmapData;
		var tempObj:ObstacleObj;
		var tempVec:Vector3D;
		var tempPoint:Point;
		var fl:Int; //= 160;
		var yOff:Int;// = 100;
		var objY:Int;// = 60;
		var topZ:Int = 0;
		public var zCount:Float = 0;
		var lineColor:Int;
		
		var RowMade:Bool = false;
		var type:String;
		public function new(_fl:Int,_objY:Int,_yOff:Int,zWait:Float,_color:Int,_type:String) {
			fl = _fl;
			yOff = _yOff;
			objY = _objY;
			zCount -= zWait;
			lineColor = _color;
			type = _type;
			tempVec = new Vector3D(0, 0, 0, 0);
			tempPoint = new Point(0, 0);
			tempObj = new ObstacleObj(fl, maxRad, 0, objY, yOff,new BitmapData(1,1),1);
			obstacleArray3D = [];
			super();
			setup();
			
		}
		
		function setup():Void {
			var BMPTree:Bitmap = new Bitmap(Assets.getBitmapData("img/treeONE.png"));
			var BMPMushroom:Bitmap = new Bitmap(Assets.getBitmapData("img/Weird mushroom.png"));
			DataTree = new BitmapData(Std.int(BMPTree.width), Std.int(BMPTree.height), true, 0x00000000);
			DataTree.draw(BMPTree);
			DataMushroom = new BitmapData(Std.int(BMPMushroom.width), Std.int(BMPMushroom.height), true, 0x00000000);
			DataMushroom.draw(BMPMushroom);
		
			//mushroom 40
			if (type == "tree") { obstacleCount = 20;}
			for (i in 0...obstacleCount) {
					var uniqueWidth:Int;
					var uniqueData:BitmapData;
					
					if (type == "tree") { uniqueData = DataTree; uniqueWidth = 17; }
					else if (type == "shroom") { uniqueData = DataMushroom; uniqueWidth = 23;}
					else if (Math.random() <0.6) { uniqueData = DataMushroom; uniqueWidth = 23; }
					else { uniqueData = DataTree; uniqueWidth = 17; }
					
					
					var obstacle:ObstacleObj = new ObstacleObj(fl, maxRad, lineColor, objY, yOff,uniqueData,uniqueWidth);
					addChild(obstacle);
					obstacleArray3D.push(obstacle);
			}
		}
		public function NextFrame(_vx:Float, _vz:Float):Void {
			if(active==true){
				for (i in 0...obstacleCount) {
					tempObj = obstacleArray3D[i];
					if (tempObj.active == true) {
						tempVec = tempObj.vec3D;
						tempVec.x += _vx;
						tempVec.z += _vz;
						if (tempVec.z <= -fl) {
							tempObj.Stop();
						}
						else {
							tempObj.Next();
						}
					}
				}
				zCount += _vz;
				if (zCount <= -fl) { Stop(); }
			}
			
			
		}
		public function Start(zOff:Int,breakSpot:Int):Void {
			zCount = zOff;
			active = true;
			NewRow(zOff,breakSpot);
		}
		public function Stop():Void {
			active = false;
		}
		public function NewObstacle(xPos:Float,zPos:Float):Void {
			for (i in 0...obstacleCount) {
				tempObj = obstacleArray3D[i];
				if (tempObj.active == false) {
					tempObj.Start(xPos,zPos);
					break;
				}
			}
			obstacleArray3D.sort(function(a:ObstacleObj, b:ObstacleObj):Int{
				if (a.vec3D.z > b.vec3D.z) return -1;
				if (a.vec3D.z < b.vec3D.z) return 1; return 0; } );
				for (i in 0...obstacleArray3D.length) {addChild(obstacleArray3D[i]);}
		}	
		public function NewRow(zOff,breakSpot:Int):Void {
			var xOff:Int = Std.int(Math.random() * maxRad) * 2;
			var diff:Int= Std.int((maxRad * 1.25) + (3 * Math.random()));
			var xPos:Float = 0;// = ( -diff * obstacleCount) + i * diff * 2;
			var zPos:Float = Std.int(Math.random() * zOff);
			if(type!="tree"){
				if (Math.random() > 0.5) { xOff *= -1;}
				for (i in 0...obstacleCount) {
					xPos = ( -diff * obstacleCount) + i * diff*2;
					zPos=3+ Std.int(Math.random() * zOff);
					NewObstacle(xPos,zPos);
				}
			}
			else {
				var offset:Int = maxRad*2;
				//diff = maxRad * 1.1;
				zPos = 0;
				for (j in 0...Std.int(obstacleCount / 2)) {
					zPos = 0;
					xPos = breakSpot + (maxRad*3) + (j * (maxRad*2));
					NewObstacle(xPos, zPos);
					xPos = breakSpot - (maxRad*3) - (j * (maxRad*2));
					NewObstacle(xPos, zPos);
				}
				
			}
			
		}
	}