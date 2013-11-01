package ;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.ColorTransform;
import flash.geom.Matrix;
import flash.Lib;
import flash.text.Font;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

import flash.text.TextFormatAlign;
import openfl.Assets;



	
	/**
	 * ...
	 * @author E
	 */
	class StoryScreen extends Sprite
	{
		
		var MainString:String;
		
		var DataHud:BitmapData;
		var box:Sprite;
		var bmpWidth:Int;
		var bmpHeight:Int;
		
		var type:String;
		
		var MainField:TextField;
		
		//var font:Font;
		
		var DataSwirl:BitmapData;
		var DataLine:BitmapData;
		var DataLogo:BitmapData;
		public var logo:Sprite;
		var SpaceField:TextField;
		
		var TitleField:TextField;
		var ChronicleField:TextField;
		var ChapterField:TextField;
		var CreditField:TextField;
		
		function new(_type:String) {
			type = _type;
			super();
			init();
			if(type!="title"){
			setup();
			setup2(); }
			else if (type == "title") {
			setup();
			setup3();
			}
		}
		function init():Void {
			MainField = new TextField();
			SpaceField = new TextField();
			GetString();
			var BMPRedSwirl:Bitmap = new Bitmap(Assets.getBitmapData("img/story/Swirl_red.png"));
			var BMPGreenSwirl:Bitmap = new Bitmap(Assets.getBitmapData("img/story/Swirl_green.png"));
			var BMPBlueSwirl:Bitmap = new Bitmap(Assets.getBitmapData("img/story/Swirl_blue.png"));
			var BMPBlackSwirl:Bitmap = new Bitmap(Assets.getBitmapData("img/story/Swirl.png"));
			
			var BMPRedLine:Bitmap = new Bitmap(Assets.getBitmapData("img/story/line_red.png"));
			var BMPGreenLine:Bitmap = new Bitmap(Assets.getBitmapData("img/story/line_green.png"));
			var BMPBlueLine:Bitmap = new Bitmap(Assets.getBitmapData("img/story/line_blue.png"));
			var BMPBlackLine:Bitmap = new Bitmap(Assets.getBitmapData("img/story/line1.png"));
			
			var BMPRedLogo:Bitmap = new Bitmap(Assets.getBitmapData("img/story/Storyscreen_DIAM.png"));
			var BMPBlueLogo:Bitmap = new Bitmap(Assets.getBitmapData("img/story/storyscreen_STARRY.png"));
			var BMPGreenLogo:Bitmap = new Bitmap(Assets.getBitmapData("img/story/storyscreen_PATH.png"));
			var BMPBlackLogo:Bitmap = new Bitmap(Assets.getBitmapData("img/wizard/wizardshoot.png"));
			
			
			if (type == "red") {
				DataSwirl = GetBitmapData(BMPBlackSwirl);
				DataLine = GetBitmapData(BMPBlackLine);
				DataLogo = GetBitmapData(BMPRedLogo);
			}
			else if (type == "green") {
				DataSwirl = GetBitmapData(BMPGreenSwirl);
				DataLine = GetBitmapData(BMPGreenLine);
				DataLogo = GetBitmapData(BMPGreenLogo);
			}
			else if (type == "blue") {
				DataSwirl = GetBitmapData(BMPBlueSwirl);
				DataLine = GetBitmapData(BMPBlueLine);
				DataLogo = GetBitmapData(BMPBlueLogo);
			}
			else if (type == "title") {
				DataLine = GetBitmapData(BMPRedLine);
				DataSwirl = GetBitmapData(BMPRedSwirl);
				DataLogo = GetBitmapData(BMPBlackLogo);
			}
			else if (type == "lost") {
				DataSwirl = GetBitmapData(BMPBlackSwirl);
				DataLine = GetBitmapData(BMPBlackLine);
				DataLogo = GetBitmapData(BMPRedLogo);
			}
			else if (type == "won") {
				DataSwirl = GetBitmapData(BMPBlueSwirl);
				DataLine = GetBitmapData(BMPBlueLine);
				DataLogo = GetBitmapData(BMPBlueLogo);
			}
			
			
			
		}
		function setup():Void {
			var topline:Sprite = new Sprite();
			addChild(topline);
			topline.graphics.beginBitmapFill(DataLine, null, true, false);
			topline.graphics.drawRect(0, 0, 500, 15);
			topline.x = 50;
			topline.y = 25;
			var squareOne:Sprite = new Sprite();
			squareOne.graphics.beginBitmapFill(DataSwirl, null, true, false);
			squareOne.graphics.drawRect(0, 0, DataSwirl.width, DataSwirl.height);
			squareOne.x = 10;
			squareOne.y = 2;
			addChild(squareOne);
			var squareTwo:Sprite = new Sprite();
			squareTwo.graphics.beginBitmapFill(DataSwirl, null, true, false);
			squareTwo.graphics.drawRect(0, 0, DataSwirl.width, DataSwirl.height);
			squareTwo.x = Lib.current.stage.stageWidth - 10 - squareTwo.width;
			squareTwo.y = 2;
			addChild(squareTwo);
			var topline2:Sprite = new Sprite();
			addChild(topline2);
			topline2.graphics.beginBitmapFill(DataLine, null, true, false);
			topline2.graphics.drawRect(0, 0, 500, 15);
			topline2.x = 50;
			topline2.y = Lib.current.stage.stageHeight-25-topline2.height;
			var squareOne2:Sprite = new Sprite();
			squareOne2.graphics.beginBitmapFill(DataSwirl, null, true, false);
			squareOne2.graphics.drawRect(0, 0, DataSwirl.width, DataSwirl.height);
			squareOne2.x = 10;
			squareOne2.y =Lib.current.stage.stageHeight - 2 - squareTwo.height;
			addChild(squareOne2);
			var squareTwo2:Sprite = new Sprite();
			squareTwo2.graphics.beginBitmapFill(DataSwirl, null, true, false);
			squareTwo2.graphics.drawRect(0, 0, DataSwirl.width, DataSwirl.height);
			squareTwo2.x = Lib.current.stage.stageWidth - 10 - squareTwo.width;
			squareTwo2.y = Lib.current.stage.stageHeight - 2 - squareTwo.height;
			addChild(squareTwo2);
			
			logo = new Sprite();
			logo.graphics.beginBitmapFill(DataLogo, null, false, false);
			logo.graphics.drawRect(0, 0, DataLogo.width, DataLogo.height);
			addChild(logo);
			logo.x = Lib.current.stage.stageWidth / 2 - logo.width/2;
			logo.y = topline2.y - logo.height - 2;
			
		}
		function setup2():Void {
			var font = Assets.getFont("font/MAYFAIRB.ttf");
			var format:TextFormat = new TextFormat(font.fontName);
			
			format.color = 0xffffff;
			format.size = 18;
			format.bold = true;
			format.font = font.fontName;
			SpaceField.autoSize = TextFieldAutoSize.LEFT;
			SpaceField.embedFonts = true;
			SpaceField.defaultTextFormat = format;
			SpaceField.text = "HIT SPACE TO CONTINUE";
			SpaceField.textColor = 0xffffff;
			addChild(SpaceField);
			SpaceField.x = Lib.current.stage.stageWidth / 2 - SpaceField.width / 2;
			SpaceField.y = logo.y - SpaceField.height;
			
			var clr:Int = 0xffffff;
			if (type == "red") { clr = 0x00ffff; }
			if (type == "blue") { clr = 0x00ffff; }
			if (type == "green") { clr = 0x00ff00;}
			format.color = clr;
			format.size = 16;
			format.bold = true;
			format.font = font.fontName;
			
			format.leading = 5;
			if (type == "blue" || type=="green") { format.leading = 4; }
			
			MainField.textColor = clr;
			MainField.embedFonts = true;
			MainField.wordWrap = true;
			MainField.multiline = true;
			MainField.defaultTextFormat = format;
			//MainField.text = MainString;
			MainField.text = "";
			MainField.autoSize = TextFieldAutoSize.LEFT;
			addChild(MainField);
			MainField.width = 500;
			MainField.x = 70;
			MainField.y = 55;
			if (type == "lost" || type == "won") {
				MainField.x = Lib.current.stage.stageWidth / 2 - MainField.width / 2;
				MainField.y = Lib.current.stage.stageHeight / 2 - MainField.height / 2-100;
			}
		}
		function setup3():Void {
			
			TitleField = new TextField();
			ChronicleField = new TextField();
			ChapterField = new TextField();
			CreditField = new TextField();
		
			var font = Assets.getFont("font/MAYFAIRB.ttf");
			var format:TextFormat = new TextFormat(font.fontName);
			
			format.color = 0xffffff;
			format.size = 18;
			format.bold = true;
			format.font = font.fontName;
			SpaceField.autoSize = TextFieldAutoSize.LEFT;
			SpaceField.embedFonts = true;
			SpaceField.defaultTextFormat = format;
			SpaceField.text = "HIT SPACE TO CONTINUE";
			SpaceField.textColor = 0xffffff;
			addChild(SpaceField);
			SpaceField.x = Lib.current.stage.stageWidth / 2 - SpaceField.width / 2;
			SpaceField.y = logo.y - SpaceField.height;
			
			format.size = 32;
			format.leading = 5;
			TitleField.autoSize = TextFieldAutoSize.LEFT;
			TitleField.embedFonts = true;
			TitleField.defaultTextFormat = format;
			TitleField.textColor = 0xffffff;
			TitleField.text = "The Battles of\n Wizard Runner";
			addChild(TitleField);
			TitleField.x = Lib.current.stage.stageWidth / 2 - TitleField.width / 2;
			TitleField.y = 85;
			
			format.size = 22;
			ChronicleField.autoSize = TextFieldAutoSize.LEFT;
			ChronicleField.embedFonts = true;
			ChronicleField.defaultTextFormat = format;
			ChronicleField.textColor = 0xffffff;
			ChronicleField.text= "Sugar Mountain Chronicles";
			addChild(ChronicleField);
			ChronicleField.x = Lib.current.stage.stageWidth / 2 - ChronicleField.width / 2;
			ChronicleField.y = TitleField.y+TitleField.height+20;
			
			format.size = 18;
			format.align = TextFormatAlign.CENTER;
			ChapterField.autoSize = TextFieldAutoSize.CENTER;
			ChapterField.embedFonts = true;
			
			ChapterField.defaultTextFormat = format;
			ChapterField.textColor = 0xffffff;
			ChapterField.text= "CHAPTER ONE: \nThe Forest of Guaroon";
			addChild(ChapterField);
			ChapterField.x = Lib.current.stage.stageWidth / 2 - ChapterField.width / 2;
			ChapterField.y = ChronicleField.y + ChronicleField.height + 20;
			
			format.size = 14;
			CreditField.autoSize = TextFieldAutoSize.LEFT;
			CreditField.embedFonts = true;
			CreditField.defaultTextFormat = format;
			CreditField.textColor = 0xffffff;
			CreditField.text= "developed by britta(coldgold) and erik(tactswiftly)";
			addChild(CreditField);
			CreditField.x = Lib.current.stage.stageWidth / 2 - CreditField.width / 2;
			CreditField.y = Lib.current.stage.stageHeight - CreditField.height;
			
		}
		function GetBitmapData(bmp:Bitmap):BitmapData {
			var d:BitmapData = new BitmapData(Std.int(bmp.width), Std.int(bmp.height), true, 0x000000);
			d.draw(bmp);
			return d;
		}
		function GetString():Void {
			if (type == "red") {
			MainString = "Once lived a a great sorcerer, Adelric, who was very wise and courageous. However, in his village, people had stopped believing in magic, so he found himself poor and not respected.\n\nThere was an old legend in the village, of a sacred, magical diamond that was stolen eons ago, and hidden in the Sugar Mountains.\n\nMany warriors had died, trying to retrieve the diamond. Before the mountains was said to be a magical forest of Guaroon, which was said to be full of things no one could explain nor defeat with any swords or bows.\n\nSo, the warriors stopped trying to find the diamond, and it became a legend. That time, no one remembered anymore, where these mountains were.";
			}
			else if (type == "blue") {
				MainString = "One starry night, as Adelric was sleeping, he saw a dream. Everything was dark... The only thing around, was the subtle sound of wind, and leaves. Then, slowly the surroundings, and a path appeared before him.\n\nEverything felt real - the trees, the ground below him, the cold air against his skin. He looked around him, and just as he was about to get worried, he heard a soft voice inside his head.\n\n\"Hello, Adelric. Don't be afraid. I am the spirit of your village. The people in the village have long lost their faith in the unseen, and have become arrogant and trivial.\n\nBut this is not what I came to tell you. I came to you this night, to tell you that you were chosen.\"";
			}
			else if (type == "green") {
				MainString = "I want you to know, that you\'re the only one to possess the knowledge and skills necessary to return the Diamond back to its place. Now - observe as I show you the Path.\"\n\nSuddenly Adelric began floating fast along the path until he reached forests and hills, which he\'d never seen. Then, a strange forest... Suddenly, the movement stopped.\n\n\"This is as far as I'll take you today,\" said the voice. \"This is the forest of Guaroon. Behind this forest, you can see the Sugar Mountains. Farewell.\"\n\nAt that moment, Adelric woke up, still in his house. It was still night, but he grabbed his sorcerer's staff and clothes. \"There's no time to wait,\" he thought, and so began the journey.";
			}
			else if (type == "lost") {
				MainString = "Despite your valiant efforts you have failed to conquer The Forest of Guaroon and the beast that lays within.";
			}
			else if (type == "won") {
				MainString = "Victory!  The Forest of Guaroon has been properly traversed and you have slain the evil Mushie that dwells inside.  However this is just the beginning of your journey.  To Be Continued...";
			}
		}
		public function Start():Void {
			MainField.text = "";
			cnt = 0;
			
			addEventListener(Event.ENTER_FRAME, eFrame);
			
		}
		public function Stop():Void {
			cnt = 0;
			MainField.text = "";
			removeEventListener(Event.ENTER_FRAME, eFrame);
		}
		var cnt:Int = 0;
		public function eFrame(e:Event):Void {
			
			if(cnt< MainString.length){
			MainField.appendText(MainString.charAt(cnt));
			MainField.appendText(MainString.charAt(cnt+1));
			MainField.appendText(MainString.charAt(cnt + 2));
			MainField.appendText(MainString.charAt(cnt + 3));
			MainField.appendText(MainString.charAt(cnt + 4));
			MainField.appendText(MainString.charAt(cnt+5));
			}
			else { removeEventListener(Event.ENTER_FRAME, eFrame); }
			cnt+=6;
		}
		
		
		
	}