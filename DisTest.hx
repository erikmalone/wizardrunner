package ;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.Lib;
import hold.en.wiz.mere.uibasics.MereText;
import hold.en.wiz.outter.StoryBar;
import hold.en.wiz.outter.StoryPage;
import hold.en.wiz.outter.StoryText;
import openfl.Assets;
class DisTest extends Sprite {
var DataOne:BitmapData;
var DataTwo:BitmapData;
var rand:Int;
var pixelTotal:Int=0;
var pixelCurrent:Int=0;
var pixelsAtATime:Int = 50;
var s:Sprite;// = new Sprite();
var OrigBlue:BitmapData;
var OrigRed:BitmapData;
	function new() {
		super();
		init();
	}
	function init():Void {
		s = new Sprite();
		var bit:Bitmap = new Bitmap(Assets.getBitmapData("img/story/Swirl_blue.png"));
		DataOne = new BitmapData(Std.int(bit.width), Std.int(bit.height), true, 0x00000000);
		OrigBlue = new BitmapData(Std.int(bit.width), Std.int(bit.height), true, 0x00000000);
		DataOne.draw(bit);
		OrigBlue.draw(bit);
		var bit2:Bitmap = new Bitmap(Assets.getBitmapData("img/story/Swirl_red.png"));
		DataTwo = new BitmapData(Std.int(bit.width), Std.int(bit.height), true, 0x00000000);
		OrigRed = new BitmapData(Std.int(bit.width), Std.int(bit.height), true, 0x00000000);
		DataTwo.draw(bit2);
		OrigRed.draw(bit2);
		
		
		addChild(new StoryPage());
		
		
		
		var txt:StoryText = new StoryText();
		addChild(txt);
		txt.SetText("32");
		txt.Start();
		s.graphics.beginBitmapFill(DataOne);
		s.graphics.drawRect(0, 0, DataOne.width, DataOne.height);
		//addChild(s);
		s.y = Lib.current.stage.stageHeight / 2 - s.height / 2;
		s.x = Lib.current.stage.stageWidth / 2 - s.width / 2;
		addEventListener(Event.ENTER_FRAME, eFrame);
		pixelTotal = DataOne.width * DataOne.height;
		var font = Assets.getFont("font/MAYFAIRB.ttf");
		addChild(new MereText("BLAH BLAH", 0, 18, font));
	//	addChild(new StoryPage(new Bitmap(Assets.getBitmapData("img/story/line_blue.png")), new Bitmap(Assets.getBitmapData("img/story/Swirl_blue.png")), new Bitmap(Assets.getBitmapData("img/story/storyscreen_STARRY.png"))));
		//var bar:StoryBar = new StoryBar( new Bitmap(Assets.getBitmapData("img/story/line_blue.png")), new Bitmap(Assets.getBitmapData("img/story/Swirl_blue.png")));
		//bar.y = 100;
		//addChild(bar);
		
		//bar.ChangeLineDirection();
		}
		var down:Bool = false;
		function eFrame(e:Event):Void {
			
			
			rand = DataOne.pixelDissolve(DataTwo, new Rectangle(0, 0, DataOne.width, DataOne.height), new Point(0, 0), rand,pixelsAtATime, 0xff0000);
			
			pixelCurrent += pixelsAtATime;
			if (pixelCurrent >= pixelTotal) {
				//removeEventListener(Event.ENTER_FRAME, eFrame);
				down = !down;
				pixelCurrent = 0;
				
				
				if (down == true) {
					DataOne = OrigRed.clone();
					DataTwo = OrigBlue.clone();
				}
				else { DataOne = OrigBlue.clone(); DataTwo = OrigRed.clone();}
				
				s.graphics.clear();
				s.graphics.beginBitmapFill(DataOne);
				s.graphics.drawRect(0, 0, DataOne.width, DataOne.height);
			}
		
		}
}