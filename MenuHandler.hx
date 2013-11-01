package ;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.geom.Matrix;
import flash.Lib;
import flash.media.Sound;
import flash.media.SoundChannel;
import flash.text.Font;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import openfl.Assets;


	
	/**
	 * ...
	 * @author E
	 */
	class MenuHandler extends Sprite
	{
		var TitleScreen:StoryScreen;
		var PartOne:StoryScreen;
		var PartTwo:StoryScreen;
		var PartThree:StoryScreen;
		var LostScreen:StoryScreen;
		var WonScreen:StoryScreen;
		
		var part:String;
		
		function new() {
			super();
			init();
		}
		function init():Void {
			part = "";
			
			TitleScreen = new StoryScreen("title");
			PartOne = new StoryScreen("red");
			PartTwo = new StoryScreen("blue");
			PartThree = new StoryScreen("green");
			LostScreen = new StoryScreen("lost");
			WonScreen = new StoryScreen("won");
			addChild(TitleScreen);
			addChild(PartOne);
			addChild(PartTwo);
			addChild(PartThree);
			addChild(LostScreen);
			addChild(WonScreen);
			TitleScreen.visible = PartOne.visible = PartTwo.visible = PartThree.visible = LostScreen.visible =  WonScreen.visible = false;
			part = "title";
			TitleScreen.visible = true;
			Start();
		}
		function Start():Void {
		
			Lib.current.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		function Stop():Void {
			
			Lib.current.stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		public function onKeyUp(event:KeyboardEvent):Void{
			if (event.keyCode == 32) { Next(); }
		}
		public function ShowWin():Void {
			WonScreen.visible = true;
			WonScreen.Stop();
			WonScreen.Start();
			part = "won";
			Start();
		}
		public function ShowLost():Void {
			LostScreen.visible = true;
			part = "lost";
			LostScreen.Stop();
			LostScreen.Start();
			Start();
		}
		function Next():Void {
			Main.HitOne.play();
			
			TitleScreen.visible = PartOne.visible = PartTwo.visible = PartThree.visible = LostScreen.visible = false; WonScreen.visible = false;
			if (part == "title") {
				PartOne.visible = true;
				PartOne.Start();
				part = "one";
			}
			else if (part == "one") {
				PartTwo.visible = true;
				PartOne.Stop();
				PartTwo.Start();
				part = "two";
			}
			else if (part == "two") {
				PartThree.visible = true;
				PartThree.Start();
				PartTwo.Stop();
				part = "three";
			}
			else if (part == "three") {
				Stop();
				PartThree.Stop();
				dispatchEvent(new Event("StartGame", true));
			}
			else if (part == "lost") {
				TitleScreen.visible = true;
				
				part = "title";
			}
			else if (part == "won") {
				TitleScreen.visible = true;
				part = "title";
			}
		}
		
	}