package ;

	import flash.display.Sprite;
	import flash.Lib;
	
	/**
	 * ...
	 * @author E
	 */
	class HorizontalLine extends Sprite 
	{
		public var _z:Float;
		public var size:Int;
		function new(__z:Float,_size:Int,_color:Int) {
			_z = __z;
			size = _size;
			super();
			graphics.lineStyle(_size, _color);
			graphics.lineTo(Lib.current.stage.stageWidth, 0);
			this.cacheAsBitmap = true;
			//init();
		}
		public function Update(_clr):Void {
			graphics.clear();
			var clr:Int = Std.int(Math.random() * 0xffffff);
			graphics.lineStyle(size, _clr);
			graphics.lineTo(Lib.current.stage.stageWidth, 0);
		}
		function init():Void {
			
		}
		
	}
	
