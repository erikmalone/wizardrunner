package ;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Matrix;
import flash.Lib;
import openfl.Assets;


	
	/**
	 * ...
	 * @author E
	 */
	class WizardObj extends Sprite
	{
		var DataShoot:BitmapData;
		var DataStand:BitmapData;
		var DataLeft:BitmapData;
		var DataRight:BitmapData;
		var DataHit:BitmapData;
		var DataArray:Array<BitmapData>;
		var bmpWidth:Int;
		var bmpHeight:Int;
		var cnt:Int = 0;
		var wiz:Shape;
		
		public var playerHP:Int;
		public var playerMP:Int;
		public var playerXP:Int;
		public var playerNEXT:Int;
		public var playerLVL:Int;
		var arrayHP:Array<Int>;
		var arrayMP:Array<Int>;
		var arrayNEXT:Array<Int>;
		
		var maxMP:Int = 0;
		
		function new() {
			super();
			init();
		}
		function init():Void {
			arrayHP = [100, 8, 12, 13, 16, 20,25,35,100];
			arrayMP = [500, 10, 15, 20, 30, 50,65,70,100];
			arrayNEXT = [2000, 4, 6, 8, 9, 100,250,500,999];
			
			var BMPShoot:Bitmap = new Bitmap(Assets.getBitmapData("img/wizard/wizardshoot.png"));
			var BMPStand:Bitmap  = new Bitmap(Assets.getBitmapData("img/wizard/wizardstand.png"));
			var BMPLeft:Bitmap  = new Bitmap(Assets.getBitmapData("img/wizard/wizardleft.png"));
			var BMPRight:Bitmap  = new Bitmap(Assets.getBitmapData("img/wizard/wizardright.png"));
			var BMPHit:Bitmap = new Bitmap(Assets.getBitmapData("img/wizard/wizardhit.png"));
			bmpWidth = Std.int(BMPShoot.width);
			bmpHeight = Std.int(BMPShoot.height);
			DataShoot = GetBitmapData(BMPShoot);
			DataStand = GetBitmapData(BMPStand);
			DataLeft = GetBitmapData(BMPLeft);
			DataRight = GetBitmapData(BMPRight);
			DataHit = GetBitmapData(BMPHit);
			
			wiz = new Shape();
			wiz.graphics.beginBitmapFill(DataShoot, new Matrix(), false, false);
			wiz.graphics.drawRect(0, 0, DataShoot.width, DataShoot.height);
			addChild(wiz);
			wiz.x = -wiz.width / 2;
			this.x = Lib.current.stage.stageWidth / 2+10;
			this.y = Lib.current.stage.stageHeight - wiz.height - 50;
		}
		public function Next():Void {
			cnt++;
			if (cnt== 3) {
				wiz.graphics.clear();
				wiz.graphics.beginBitmapFill(DataLeft, new Matrix(), false, false);
				wiz.graphics.drawRect(0, 0, DataShoot.width, DataShoot.height);
			}
			if (cnt == 6) {
				wiz.graphics.clear();
				wiz.graphics.beginBitmapFill(DataStand, new Matrix(), false, false);
				wiz.graphics.drawRect(0, 0, DataShoot.width, DataShoot.height);
			}
			if (cnt == 9) {
				wiz.graphics.clear();
				wiz.graphics.beginBitmapFill(DataRight, new Matrix(), false, false);
				wiz.graphics.drawRect(0, 0, DataShoot.width, DataShoot.height);
			}
			if (cnt == 12) {
				cnt = 0;
				wiz.graphics.clear();
				wiz.graphics.beginBitmapFill(DataStand, new Matrix(), false, false);
				wiz.graphics.drawRect(0, 0, DataShoot.width, DataShoot.height);
			}
		}
		public function Shoot():Void {
			cnt = 0;
				wiz.graphics.clear();
				wiz.graphics.beginBitmapFill(DataShoot, new Matrix(), false, false);
				wiz.graphics.drawRect(0, 0, DataShoot.width, DataShoot.height);
		}
		public function Hit():Void {
			cnt = 0;
				wiz.graphics.clear();
				wiz.graphics.beginBitmapFill(DataHit, new Matrix(), false, false);
				wiz.graphics.drawRect(0, 0, DataShoot.width, DataShoot.height);
		}
		function GetBitmapData(bmp:Bitmap):BitmapData {
			var d:BitmapData = new BitmapData(bmpWidth, bmpHeight, true, 0x000000);
			d.draw(bmp);
			return d;
		}
		public function UpdateHP():Void {
			playerHP -= 1;
			SendUpdate();
		}
		public function UpdateMP():Void {
			playerMP -= 1;
			SendUpdate();
		}
		public function UpdateXP():Void {
			var num:Int = 0;
			if (Math.random() < 0.5) {
				num = 1;
			}
			else { num = 2; }
			playerXP += num;
			CheckLevel();
		}
		public function AddMP():Void {
			playerMP++;
			if (playerMP > maxMP) {
				playerMP = maxMP;
			}
			SendUpdate();
		}
		function CheckLevel():Void {
			if (playerXP >= playerNEXT) {
				playerLVL++;
				Main.HitFive.play();
				playerHP = arrayHP[playerLVL - 1];
				playerMP = arrayMP[playerLVL - 1];
				maxMP = arrayMP[playerLVL - 1];
				playerNEXT = arrayNEXT[playerLVL - 1];
			}
			SendUpdate();
		}
		public function SetUp():Void {
			playerHP = arrayHP[0];
			playerMP = arrayMP[0];
			maxMP = arrayMP[0];
			playerXP = 0;
			playerNEXT = arrayNEXT[0];
			playerLVL = 1;
			SendUpdate();
		}
		public function SendUpdate():Void {
			dispatchEvent(new Event("UpdatePlayer", true));
		}
		
		
	}