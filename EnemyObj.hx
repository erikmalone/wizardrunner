package ;

	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	import flash.Lib;
	
	/**
	 * ...
	 * @author E
	 */
	class EnemyObj extends Shape
	{
		public var active:Bool = false;
		public var vec3D:Vector3D;
		public var vec2D:Point;
		var fl:Int = 0;
		var objY:Int = 0;
		var yOff:Int = 0;
		var size:Int = 0;
		var color:Int = 0;
		var _scale:Float = 0;
		var mat:Matrix;
		var DataMonster:BitmapData;
		var data1:BitmapData;
		var data2:BitmapData;
		var data3:BitmapData;
		var DataCount:Int = 0;
		var DataWait:Int = 6;
		public var uniqueWidth:Int = 0;
		var sWidth:Int = 0;
		var speed:Float = 0;
		var horizontalDistance:Float = 0;
		var horizontalMax:Int = 40;
		function new(_fl:Int,_size:Int,_color:Int,_objY:Int,_yOff:Int,_data1:BitmapData,_data2:BitmapData,_data3:BitmapData) {
			fl = _fl;
			objY = _objY;
			yOff = _yOff;
			size = _data1.width;
			uniqueWidth = 45;
			color = _color;
			vec3D = new Vector3D(0, 0, 0, size);
			vec2D = new Point(0, 0);
			mat = new Matrix();
			DataMonster = _data1;
			data1 = _data1;
			data2 = _data2;
			data3 = _data3;
			sWidth = Lib.current.stage.stageWidth;
			super(); 
			init();
		}
		function init():Void {
			this.x = Lib.current.stage.stageWidth / 2;
			this.y = Lib.current.stage.stageHeight / 2 - yOff;
		}
		public function Start(xPos:Float,zPos:Float,_speed:Float):Void {
			this.visible = true;
			speed = _speed;
			horizontalDistance = 0;
			active = true;
			vec3D.x = xPos;
			vec3D.y = objY;
			vec3D.z = zPos;
			Next(); 
		}
		public function Stop():Void {
			this.visible = false;
			active = false;
		}
		public function Next():Void {
			
			vec3D.x += speed;	
			horizontalDistance += speed;
			if (horizontalDistance > horizontalMax) { speed *= -1; }
			else if ( horizontalDistance < -horizontalMax) { speed *= -1;}
			ConverPointIn3DToPointIn2D();
			graphics.clear();
			//graphics.lineStyle(3, color);
			
		
			
			if (vec3D.z > 0 || vec3D.z < -98) { this.visible = false; } 
			else if (vec2D.x+vec3D.w <  -sWidth/2 || vec2D.x-vec3D.w > sWidth/2) { this.visible = false;}
			else { 
			this.visible = true;
			DataCount++;
			if (DataCount == DataWait) {
				DataMonster = data2;
			}
			else if (DataCount == DataWait*2) {
				DataMonster = data3;
			}
			else if (DataCount == DataWait*3) {
				DataMonster = data2;
			}
			else if (DataCount == DataWait*4) {
				DataCount = 0;
				DataMonster = data1;
			}
			mat.tx = vec2D.x -vec3D.w / 2;
			mat.ty = vec2D.y -vec3D.w;
			graphics.beginBitmapFill(DataMonster, mat, false, false);
			graphics.drawRect(vec2D.x -vec3D.w / 2, vec2D.y -vec3D.w, vec3D.w, vec3D.w);
			}
			
		}
		
		function ConverPointIn3DToPointIn2D()
		{
			_scale = fl / (fl + vec3D.z);
			vec3D.w = _scale * size;
			mat = new Matrix();
			mat.scale(_scale, _scale);
			vec2D.x=vec3D.x*_scale;
			vec2D.y = vec3D.y * _scale;
		}
		
	}