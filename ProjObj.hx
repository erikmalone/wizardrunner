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
	class ProjObj extends Shape
	{
		public var active:Bool = false;
		public var vec3D:Vector3D;
		public var vec2D:Point;
		var fl:Int = 0;
		var objY:Int = 0;
		var yOff:Int = 0;
		var size:Int = 0;
		var color:Int = 0xffffff;
		var _scale:Float = 0;
		var mat:Matrix;
		var DataProj:BitmapData;
		function new(_fl:Int,_size:Int,_color:Int,_objY:Int,_yOff:Int,_data:BitmapData) {
			fl = _fl;
			objY = _objY;
			yOff = _yOff;
			size = _data.width;
			color = _color;
			DataProj = _data;
			vec3D = new Vector3D(0, 0, 0, size);
			vec2D = new Point(0, 0);
			mat = new Matrix();
			super();
			init();
		}
		function init():Void {
			this.x = Lib.current.stage.stageWidth / 2;
			this.y = Lib.current.stage.stageHeight / 2 - yOff;
		}
		public function Start():Void {
			this.visible = true;
			active = true;
			vec3D.x = 0;
			vec3D.y = objY;
			vec3D.z = -fl + 30;
			ConverPointIn3DToPointIn2D();
		}
		public function Stop():Void {
			this.visible = false;
			active = false;
		}
		public function Next():Void {
			ConverPointIn3DToPointIn2D();
			graphics.clear();
			//graphics.lineStyle(1, color);
			mat.tx = vec2D.x -size / 2;
			mat.ty = vec2D.y -size;
			graphics.beginBitmapFill(DataProj, mat, false, false);
			
			if (yOff < 0) {
				graphics.drawRect(vec2D.x -vec3D.w / 2,vec2D.y , vec3D.w, vec3D.w);
			}
			else { graphics.drawRect(vec2D.x -size / 2, vec2D.y -size, size, size); }
			
			
			mat.tx = vec2D.x -vec3D.w / 2;
			mat.ty = vec2D.y -vec3D.w;
			graphics.beginBitmapFill(DataProj, mat, false, false);
			graphics.drawRect(vec2D.x -vec3D.w / 2, vec2D.y -vec3D.w, vec3D.w, vec3D.w);
			
			
			//else { graphics.drawRect(vec2D.x -vec3D.w / 2, vec2D.y -vec3D.w, vec3D.w, vec3D.w); }
			
		}
		function ConverPointIn3DToPointIn2D()
		{
			_scale = fl / (fl + vec3D.z);
			mat = new Matrix();
			mat.scale(_scale, _scale);
			vec3D.w = _scale * size;
			vec2D.x=vec3D.x*_scale;
			vec2D.y = vec3D.y * _scale;
		}
		
	}
	
