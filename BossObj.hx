package ;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.Lib;
import openfl.Assets;


	
	/**
	 * ...
	 * @author E
	 */
	class BossObj extends Sprite
	{
		var DataOne:BitmapData;
		var DataTwo:BitmapData;
		var DataThree:BitmapData;
		var DataFour:BitmapData;
		var DataHit:BitmapData;
		var DataArray:Array<BitmapData>;
		var bmpWidth:Int;
		var bmpHeight:Int;
		var cnt:Int = 0;
		var wait:Int = 6;
		var boss:Shape;
		var RandomDistance:Int;
		var speed:Float = 5;
		var con:Sprite;
		public var BossHP:Int = 2;
	  	public var location:Point;
		function new() {
			super();
			init();
		}
		function init():Void {
			con = new Sprite();
			boss = new Shape();
			location = new Point();
			var BMPOne:Bitmap = new Bitmap(Assets.getBitmapData("img/boss/mushieboss.png"));
			var BMPTwo:Bitmap  = new Bitmap(Assets.getBitmapData("img/boss/mushieboss2.png"));
			var BMPThree:Bitmap  = new Bitmap(Assets.getBitmapData("img/boss/mushieboss3.png"));
			var BMPFour:Bitmap  = new Bitmap(Assets.getBitmapData("img/boss/mushieboss4.png"));
			var BMPHit:Bitmap = new Bitmap(Assets.getBitmapData("img/boss/mushiebossHIT.png"));
			bmpWidth = Std.int(BMPOne.width);
			bmpHeight = Std.int(BMPOne.height);
			DataOne = GetBitmapData(BMPOne);
			DataTwo = GetBitmapData(BMPTwo);
			DataThree = GetBitmapData(BMPThree);
			DataFour = GetBitmapData(BMPFour);
			DataHit = GetBitmapData(BMPHit);
	
			boss.graphics.beginBitmapFill(DataOne);
			boss.graphics.drawRect(0, 0, DataOne.width, DataOne.height);
			//addChild(boss);
			con.addChild(boss);
			addChild(con);
			boss.x = -boss.width / 2;
			boss.y = -boss.height/2+115;
			this.x = Lib.current.stage.stageWidth / 2;
			this.y = Lib.current.stage.stageHeight / 2 - 200;
			location.y = boss.y;
		}
		public function UpdateAction():Void {
			con.x += speed;
			location.y = boss.y;
			location.x = con.x;
			if (con.x > 200) {
				speed *= -1;
				con.x = 200;
			}
			else if (con.x < -200) {
				speed *= -1;
				con.x = -200;
			}
			cnt++;
			if (cnt == wait) {
				boss.graphics.clear();
				boss.graphics.beginBitmapFill(DataTwo);
				boss.graphics.drawRect(0, 0, DataOne.width, DataOne.height);
			}
			else if (cnt == wait * 2) {
				boss.graphics.clear();
				boss.graphics.beginBitmapFill(DataThree);
				boss.graphics.drawRect(0, 0, DataOne.width, DataOne.height);
			}
			else if (cnt == wait * 3) {
				boss.graphics.clear();
				boss.graphics.beginBitmapFill(DataFour);
				boss.graphics.drawRect(0, 0, DataOne.width, DataOne.height);
			}
			else if (cnt == wait * 4) {
				cnt = 0;
				boss.graphics.clear();
				boss.graphics.beginBitmapFill(DataOne);
				boss.graphics.drawRect(0, 0, DataOne.width, DataOne.height);
			}
			
			
		}
		public function Hit():Void {
			cnt = 0;
			boss.graphics.clear();
			boss.graphics.beginBitmapFill(DataHit);
			boss.graphics.drawRect(0, 0, DataOne.width, DataOne.height);
			BossHP--;
			if (BossHP <= 0) {
				dispatchEvent(new Event("BossDead", true));
			}
		}
		function GetBitmapData(bmp:Bitmap):BitmapData {
			var d:BitmapData = new BitmapData(bmpWidth, bmpHeight, true, 0x000000);
			d.draw(bmp);
			return d;
		}
		
		
	}