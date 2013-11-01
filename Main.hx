package ;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.display.StageQuality;
import flash.events.Event;
import flash.filters.GlowFilter;
import flash.geom.Matrix;
import flash.Lib;
import flash.media.Sound;
import flash.media.SoundChannel;
import flash.text.TextField;
import haxe.Timer;
import openfl.Assets;

/**
 * ...
 * @author E
 */

class Main extends Sprite 
{
	var inited:Bool;
	var temp:TempGame;
	var story:MenuHandler;
	
	var text:TextField;
	var fps:CustomFPS;
	var wait:Bool = false;
	var con:Sprite;
	var conSpeed:Float = 0.25;
	var conMax:Int = 10;
	
	var mat2:Matrix;
	
	var MenuMode:Bool = true;
	var PlayMode:Bool = false;
	
	public static var HitOne:Sound;
	public static var HitTwo:Sound;
	public static var HitThree:Sound;
	public static var HitFour:Sound;
	public static var HitFive:Sound;
	public static var HitSix:Sound;
	public static var TheSong:Sound;
	/* ENTRY POINT */
	
	function resize(e) 
	{
		if (!inited) init();
		// else (resize or orientation change)
	}
	
	function init() 
	{
		inited = true;
		addChild(new DisTest());
	/*	HitOne = Assets.getSound("sound/hit.mp3");
		HitOne.play();
		HitTwo = Assets.getSound("sound/hit_mushroom.mp3");
		HitThree = Assets.getSound("sound/hit_Tree.mp3");
		HitFour = Assets.getSound("sound/OW.mp3");//KILL BLOB
		HitFive = Assets.getSound("sound/shoot.mp3");//LEVEL
		HitSix = Assets.getSound("sound/monster_shoot.mp3");//SHOOT
		TheSong = Assets.getSound("sound/weird.mp3");
		TheSong.play(0, 500);
		mat2 = new Matrix();
		
		if (inited) return;
		inited = true;
		graphics.beginFill(0);
		graphics.drawRect(0, 0, Lib.current.stage.stageWidth, 180);
		graphics.beginFill(0);
		graphics.drawRect(0, 180, Lib.current.stage.stageWidth, 260);
		var _width:Int = Lib.current.stage.stageWidth;
		var _height:Int = Lib.current.stage.stageHeight;
		// (your code here)
		con = new Sprite();
		addChild(con);
		
		con.x = _width / 2;
		con.y = _height / 2;
		temp = new TempGame();
		story = new MenuHandler();
		
		addChild(temp);
		addChild(story);
		temp.visible = false;
		story.visible = true;
		temp.Stop();
		addEventListener(Event.ENTER_FRAME, eFrame);
		Lib.current.stage.quality = StageQuality.LOW;
		
		addEventListener("StartGame", StartGame);
		addEventListener("GameOver", GameOver);
		*/
	}

	/* SETUP */
	function StartGame(e:Event):Void {
		temp.Setup();
		temp.visible = true;
		story.visible = false;
		PlayMode = true;
	}
	function GameOver(e:Event):Void {
		PlayMode =false;
		temp.visible = false;
		temp.Stop();
		story.visible = true;
		if (temp.WonGame == true) {
			story.ShowWin();
		}
		else if (temp.WonGame == false) {
			story.ShowLost();
		}
	}
	function eFrame(e:Event):Void {
		if(PlayMode==true){
		temp.Next(); }
	
		
	}
	public function new() 
	{
		super();	
		addEventListener(Event.ADDED_TO_STAGE, added);
	}

	function added(e) 
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);
		stage.addEventListener(Event.RESIZE, resize);
		#if ios
		haxe.Timer.delay(init, 100); // iOS 6
		#else
		init();
		#end
	}
	
	public static function main() 
	{
		// static entry point
		Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
		Lib.current.addChild(new Main());
	}
}
