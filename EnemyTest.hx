package ;


import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Shape;
import flash.display.Sprite;
import flash.geom.Point;
import flash.geom.Vector3D;
import flash.Lib;
import openfl.Assets;
	class EnemyTest extends Sprite {
		
		var enemyCount:Int = 10;
		var maxRad:Int = 20;
		
		public var enemyArray3D:Array<EnemyObj>;
		public var active:Bool = false;
		
		var tempObj:EnemyObj;
		var tempVec:Vector3D;
		var tempPoint:Point;
		var fl:Int; //= 160;
		var yOff:Int;// = 100;
		var objY:Int;// = 60;
		var topZ:Int = 0;
		var zCount:Float = 0;
		var lineColor:Int;
		
		public function new(_fl:Int,_objY:Int,_yOff:Int,zWait:Float,_color:Int) {
			fl = _fl;
			yOff = _yOff;
			objY = _objY;
			zCount -= zWait;
			lineColor = _color;
			tempVec = new Vector3D(0, 0, 0, 0);
			tempPoint = new Point(0, 0);
			tempObj = new EnemyObj(fl, maxRad, 0, objY, yOff, new BitmapData(1,1),new BitmapData(1,1),new BitmapData(1,1));
			enemyArray3D = [];
			super();
			setup();
			
		}
		
		function setup():Void {
			var BMPG1:Bitmap = new Bitmap(Assets.getBitmapData("img/monster/blobG1.png"));
			var BMPG2:Bitmap = new Bitmap(Assets.getBitmapData("img/monster/blobG2.png"));
			var BMPG3:Bitmap = new Bitmap(Assets.getBitmapData("img/monster/blobG3.png"));
			var DataG1:BitmapData = new BitmapData(Std.int(BMPG1.width), Std.int(BMPG1.height), true, 0x00000000);
			var DataG2:BitmapData = new BitmapData(Std.int(BMPG2.width), Std.int(BMPG2.height), true, 0x00000000);
			var DataG3:BitmapData = new BitmapData(Std.int(BMPG3.width), Std.int(BMPG3.height), true, 0x00000000);
			DataG1.draw(BMPG1);
			DataG2.draw(BMPG2);
			DataG3.draw(BMPG3);
			
			var BMPP1:Bitmap = new Bitmap(Assets.getBitmapData("img/monster/blobP1.png"));
			var BMPP2:Bitmap = new Bitmap(Assets.getBitmapData("img/monster/blobP2.png"));
			var BMPP3:Bitmap = new Bitmap(Assets.getBitmapData("img/monster/blobP3.png"));
			var DataP1:BitmapData = new BitmapData(Std.int(BMPP1.width), Std.int(BMPP1.height), true, 0x00000000);
			var DataP2:BitmapData = new BitmapData(Std.int(BMPP2.width), Std.int(BMPP2.height), true, 0x00000000);
			var DataP3:BitmapData = new BitmapData(Std.int(BMPP3.width), Std.int(BMPP3.height), true, 0x00000000);
			DataP1.draw(BMPP1);
			DataP2.draw(BMPP2);
			DataP3.draw(BMPP3);
			
			
			var data1:BitmapData;
			var data2:BitmapData;
			var data3:BitmapData;
			
			data1 = DataG1;
			data2 = DataG2;
			data3 = DataG3;
			
			for (i in 0...enemyCount) {
					if (Math.random() > 0.5) {
						data1 = DataG1;
						data2 = DataG2;
						data3 = DataG3;
					}
					else {
						data1 = DataP1;
						data2 = DataP2;
						data3 = DataP3;
					}
				
					var enemy:EnemyObj = new EnemyObj(fl, maxRad, lineColor, objY, yOff,data1,data2,data3);
					addChild(enemy);
					enemyArray3D.push(enemy);
			}
		}
		public function NextFrame(_vx:Float, _vz:Float):Void {
			if(active==true){
				for (i in 0...enemyCount) {
					tempObj = enemyArray3D[i];
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
		public function Start(zOff:Int):Void {
			zCount = zOff;
			active = true;
			NewRow(zOff);
		}
		public function Stop():Void {
			active = false;
		}
		public function NewEnemy(xPos:Float, zPos:Float, speed:Float):Void {
		
			for (i in 0...enemyCount) {
				tempObj = enemyArray3D[i];
				if (tempObj.active == false) {
					
					tempObj.Start(xPos,zPos,speed);
					break;
				}
			}
		}	
		public function NewRow(zOff:Int):Void {
			var tempSpeed:Float = 1 + (Math.random() * 2);
			if (Math.random() > 0.5) { tempSpeed *= -1;}
			var xOff:Int = Std.int(Math.random() * maxRad)*2;
			for (i in 0...enemyCount) {
				var xPos:Float =xOff+( -maxRad * enemyCount + ((maxRad * 4) * i));
				var zPos:Float = 3+Std.int(Math.random() * zOff);
				NewEnemy(xPos,zPos,tempSpeed);
			}
			
		}
	}