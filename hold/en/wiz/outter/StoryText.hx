package hold.en.wiz.outter ;
import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import flash.text.Font;
import hold.en.wiz.mere.uibasics.MereText;
import openfl.Assets;
class StoryText extends Sprite {
	var txt:MereText;
	var str:String;
	var cnt:Int = 0;
	function new(?_str:String) {super(); (_str != null)? str = _str:str = " "; init(); }
	function init():Void { txt = new MereText(str, 0xffffff, 16, Assets.getFont("font/MAYFAIRB.ttf"));
	graphics.beginFill(0, 0.8);
	graphics.drawRoundRect(Lib.current.stage.stageWidth*0.1, Lib.current.stage.stageHeight*0.15, Lib.current.stage.stageWidth * 0.8, Lib.current.stage.stageHeight * 0.8, 25, 25);
	addChild(txt);
	txt.wordWrap = true;
	txt.multiline = true;
	txt.width = Lib.current.stage.stageWidth * 0.8;
	txt.x = Lib.current.stage.stageWidth * 0.1;
	txt.y = Lib.current.stage.stageHeight * 0.15;
	txt.format.leading = 4;
	txt.defaultTextFormat = txt.format;
	txt.text = "";
	}
	public function Start():Void {
		addEventListener(Event.ENTER_FRAME, eFrame);
	}
	public function Stop():Void {
		txt.text = str;
		removeEventListener(Event.ENTER_FRAME, eFrame);
	}
	public function SetText(_str:String):Void {
		str = _str;
	
		str = "Once lived a a great sorcerer, Adelric, who was very wise and courageous. However, in his village, people had stopped believing in magic, so he found himself poor and not respected.\n\nThere was an old legend in the village, of a sacred, magical diamond that was stolen eons ago, and hidden in the Sugar Mountains.\n\nMany warriors had died, trying to retrieve the diamond. Before the mountains was said to be a magical forest of Guaroon, which was said to be full of things no one could explain nor defeat with any swords or bows.\n\nSo, the warriors stopped trying to find the diamond, and it became a legend. That time, no one remembered anymore, where these mountains were.";
		
	}
	function eFrame(e:Event):Void {
		var letter:String = "";
		var tempString:String = "";
		while (letter != " ") {
			letter = str.charAt(cnt);
			cnt++;
			tempString += letter;
			if (cnt == str.length) { Stop();  break; }
		}
		txt.appendText(tempString);
		graphics.clear();
		graphics.beginFill(0, 0.4);
		graphics.drawRoundRect(Lib.current.stage.stageWidth * 0.1, Lib.current.stage.stageHeight * 0.15, Lib.current.stage.stageWidth * 0.8, txt.height,25,25);
		
	}
}