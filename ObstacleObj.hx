package ;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	import flash.Lib;
	import nme.AssetData;
	import openfl.Assets;
	
	/**
	 * ...
	 * @author E
	 */
	class ObstacleObj extends Sprite
	{
		public var active:Bool = false;
		public var vec3D:Vector3D;
		public var vec2D:Point;
		public var uniqueWidth:Int;
		var uniqueOffset:Int = 1;
		var fl:Int = 0;
		var objY:Int = 0;
		var yOff:Int = 0;
		var size:Int = 0;
		var color:Int = 0;
		var _scale:Float = 0;
		var DataTree:BitmapData;
		var mat:Matrix;
		var tree:Shape;
		public var type:String;
		var uniqueMushMove:Int = 2;
		var uniqueMushCount:Int = 0;
		var sWidth:Int;
		function new(_fl:Int,_size:Int,_color:Int,_objY:Int,_yOff:Int,_DataTree:BitmapData,_uniqueWidth:Int) {
			fl = _fl;
			objY = _objY;
			yOff = _yOff;
			type = "";
			//size= _size;
			size = _DataTree.width;
			color = _color;
			DataTree = _DataTree;
			uniqueWidth = _uniqueWidth;
			sWidth = Lib.current.stage.stageWidth;
			if (uniqueWidth == 23) { uniqueOffset = 1; type = "mushroom"; }//MUSHROOM
			else if (uniqueWidth == 17) { uniqueOffset = 2; type = "tree"; }//TREE
			tree = new Shape();
			addChild(tree);
			mat = new Matrix();
			vec3D = new Vector3D(0, 0, 0, size);
			vec2D = new Point(0, 0);
			super(); 
			init();
		}
		function init():Void {
			
			this.x = Lib.current.stage.stageWidth / 2;
			this.y = Lib.current.stage.stageHeight / 2 - yOff;
			if (uniqueOffset == 1) { this.y -= Math.random() * 25; }
		
		}
		public function Start(xPos:Float,zPos:Float):Void {
			this.visible = true;
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
			ConverPointIn3DToPointIn2D();
			graphics.clear();
			//trace(vec2D.x);
			if (vec3D.z > 0 || vec3D.z < -98) { this.visible = false; } 
			else if (vec2D.x+vec3D.w <  -sWidth/2 || vec2D.x-vec3D.w > sWidth/2) { this.visible = false;}
			else { 
				this.visible = true;
					mat.tx = vec2D.x -vec3D.w / 2;
					mat.ty = vec2D.y -vec3D.w * uniqueOffset;
					graphics.beginBitmapFill(DataTree, mat, false, false);
					graphics.drawRect(vec2D.x -vec3D.w / 2, vec2D.y -vec3D.w*uniqueOffset, vec3D.w, vec3D.w*uniqueOffset);
			
				}
			
			if (uniqueOffset == 1) {
				uniqueMushCount++;
				if (uniqueMushCount == 20) {
					uniqueMushMove *= -1;
					uniqueMushCount = 0;
					
				}
				this.y -= uniqueMushMove;
				
			}
				
		}
		
		function ConverPointIn3DToPointIn2D()
		{
			//trace(_scale);
			_scale = fl / (fl + vec3D.z); 
			vec3D.w = _scale * size;
			mat = new Matrix();
			mat.scale(_scale, _scale);
			vec2D.x=vec3D.x*_scale;
			vec2D.y = vec3D.y * _scale;
			
		}
		
	}