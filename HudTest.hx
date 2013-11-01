package ;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Shape;
import flash.display.Sprite;
import flash.geom.Matrix;
import flash.Lib;
import flash.text.Font;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import openfl.Assets;


	
	/**
	 * ...
	 * @author E
	 */
	class HudTest extends Sprite
	{
		var DataHud:BitmapData;
		var box:Sprite;
		var bmpWidth:Int;
		var bmpHeight:Int;
		
		var healthField:TextField;
		var magicField:TextField;
		var levelField:TextField;
		var xpField:TextField;
		var nextField:TextField;
		var scoreField:TextField;
		//var font:Font;
		function new() {
			super();
			init();
		}
		function init():Void {
			healthField = new TextField();
			magicField = new TextField();
			levelField = new TextField();
			xpField = new TextField();
			nextField = new TextField();
			scoreField = new TextField();
			var BMPHud:Bitmap = new Bitmap(Assets.getBitmapData("img/HUD_1.png"));
			var font = Assets.getFont("font/MAYFAIRB.ttf");
			bmpWidth = Std.int(BMPHud.width);
			bmpHeight = Std.int(BMPHud.height);
			DataHud = GetBitmapData(BMPHud);
			
			box = new Sprite();
			box.graphics.beginBitmapFill(DataHud, new Matrix(), false, false);
			box.graphics.drawRect(0, 0, DataHud.width, DataHud.height);
			addChild(box);
			box.y =  Lib.current.stage.stageHeight - box.height;
			
			var format:TextFormat = new TextFormat(font.fontName);
			format.color = 0xff0000;
			format.size = 28;
			format.bold = true;
			format.font = font.fontName;
			
			healthField.textColor = 0xff0000;
			healthField.embedFonts = true;
			healthField.defaultTextFormat = format;
			healthField.text = "35";
			healthField.autoSize = TextFieldAutoSize.LEFT;
			box.addChild(healthField);
			healthField.y = box.height - healthField.height - 3;	
			
			format.color = 0x00ffff;
			magicField.textColor = 0x0000ff;
			magicField.embedFonts = true;
			magicField.defaultTextFormat = format;
			magicField.text = "99";
			magicField.autoSize = TextFieldAutoSize.LEFT;
			box.addChild(magicField);
			magicField.y = box.height - magicField.height-3;
			magicField.x = box.x + box.width - magicField.width + 4;
			
			format.color = 0xffffff;
			nextField.textColor = 0xffffff;
			nextField.embedFonts = true;
			nextField.defaultTextFormat = format;
			nextField.text = "NEXT:332";
			nextField.autoSize = TextFieldAutoSize.LEFT;
			box.addChild(nextField);
			nextField.y = box.height - nextField.height;
			nextField.x = box.x + 545-nextField.width;
			
			xpField.textColor = 0xffffff;
			xpField.embedFonts = true;
			xpField.defaultTextFormat = format;
			xpField.text = "EXP:32";
			xpField.autoSize = TextFieldAutoSize.LEFT;
			box.addChild(xpField);
			xpField.y =  box.height - xpField.height;
			xpField.x = Lib.current.stage.stageWidth / 2 - xpField.width / 2;// nextField.x - xpField.width - 5;
			
			scoreField.textColor = 0xffffff;
			scoreField.embedFonts = true;
			scoreField.defaultTextFormat = format;
			scoreField.text = "SCORE: 3200";
			scoreField.autoSize = TextFieldAutoSize.LEFT;
			addChild(scoreField);
			scoreField.y =  0; //box.y + box.height - scoreField.height;
			scoreField.x = Lib.current.stage.stageWidth - scoreField.width;//
			
			levelField.textColor = 0xffffff;
			levelField.embedFonts = true;
			levelField.defaultTextFormat = format;
			levelField.text = "LVL:3200";
			levelField.autoSize = TextFieldAutoSize.LEFT;
			box.addChild(levelField);
			levelField.y =  box.height - levelField.height;
			levelField.x = 60;
		}
		public function UpdateHP(num:Int):Void {
			healthField.text = Std.string(num);
		}
		public function UpdateMP(num:Int):Void {
			magicField.text = Std.string(num);
		}
		public function UpdateLVL(num:Int):Void {
			levelField.text = "LVL:" + Std.string(num);
		}
		public function UpdateXP(num:Int):Void {
			xpField.text="EXP:" + Std.string(num);
		}
		public function UpdateNEXT(num:Int):Void {
			nextField.text="NEXT:" + Std.string(num);
		}
		public function UpdateSCORE(num:Int):Void {
			scoreField.text="SCORE:" + Std.string(num);
		}
		
		function GetBitmapData(bmp:Bitmap):BitmapData {
			var d:BitmapData = new BitmapData(bmpWidth, bmpHeight, true, 0x000000);
			d.draw(bmp);
			return d;
		}
		
		
	}