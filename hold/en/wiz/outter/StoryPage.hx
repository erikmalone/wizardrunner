package hold.en.wiz.outter ;
import flash.display.Bitmap;
import flash.display.Shape;
import flash.display.Sprite;
import flash.Lib;
import openfl.Assets;
class StoryPage extends Sprite {
	function new() {
		super();
		init();
	}
	function init():Void {
		graphics.beginFill(0);
		graphics.drawRect(0, 0, Lib.current.stage.stageWidth, Lib.current.stage.stageHeight);
		var topbar:StoryBar = new StoryBar( new Bitmap(Assets.getBitmapData("img/story/line_blue.png")), new Bitmap(Assets.getBitmapData("img/story/Swirl_blue.png")));
		var bottombar:StoryBar = new StoryBar( new Bitmap(Assets.getBitmapData("img/story/line_blue.png")), new Bitmap(Assets.getBitmapData("img/story/Swirl_blue.png")));
		addChild(topbar);
		topbar.alpha = 0.5;
		//addChild(bottombar);
		bottombar.scaleX = bottombar.scaleY = 0.6;
		bottombar.x = Lib.current.stage.stageWidth / 2 - bottombar.width / 2;
		bottombar.y = Lib.current.stage.stageHeight / 2 - bottombar.height / 2;
		//addChild(bottombar);
		//bottombar.ChangeLineDirection();
		//bottombar.ChangeSwirlRotation();
		//topbar.y =  5;
		//bottombar.y = Lib.current.stage.stageHeight - bottombar.height - 5;
		
		//addChild(new StoryText());
		
	}
	
	
}