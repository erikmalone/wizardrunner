package ;

	import flash.display.Bitmap;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.Lib;
	import haxe.Timer;
	import openfl.Assets;
	
	/**
	 * ...
	 * @author E
	 */
	class TempGame extends Sprite 
	{
		var fl:Int = 120;
		var yOff:Int = 100;
		var objY:Int = 60;
		var wiz:WizardObj;
		var boss:BossObj;
		var floor:FloorTest;
		var proj:ProjTest;
	
		
		
	
		var enemyCount:Int = 5;
		var treeCount:Int = 6;
		var obstacleCount:Int = 6;
		var mushroomCount:Int = 6;
		
		var lDown:Bool = false;
		var rDown:Bool = false;
		var uDown:Bool = false;
		var dDown:Bool = false; 
		var fDown:Bool = true;
		
		var vx:Float = 0;
		var vy:Float = 0;
		var vz:Float = 0;
		var vxSpeed:Int = 120;
		var vzSpeed:Int = 60;
		var projSpeed:Float= 150;
		var zCount:Float = 0;
		
		var wait:Bool = false;
		var _t:Float = 0;
		var dt:Float = 0;
		var lineColor:Int = 0xffffff;
		
		var MoveBackwardsBool:Bool = false;
		var MoveBackwardsCount:Int = 0;
		var MoveBackwardsMaxCount:Int = 10;
		
		var ObjArray:Array<Sprite>;
		var EnemyArray:Array<EnemyTest>;
		var ObstacleArray:Array<ObstacleTest>;
		var TreeArray:Array<ObstacleTest>;
		var ShroomArray:Array<ObstacleTest>;
		
		public var WonGame:Bool = false;
		
		var collision:CollisionChecker;
		
		var MakeCount:Float = 0;
		var MakeMax:Int = 60;
		var EnemyOrObstacle:Bool = false;
		var treeMode:Bool = false;
		var bossMode:Bool = false;
		var levelSpot:Int = 0;
		var levelArray:Array<String>;
		var treeOffset:Int = 0;
		
		var HUD:HudTest;
		
		var playerHP:Int;
		var playerMP:Int;
		var playerXP:Int;
		var playerNEXT:Int;
		var playerLVL:Int;
		var playerSCORE:Int;
		
		var arrayHP:Array<Int>;
		var arrayMP:Array<Int>;
		var arrayNEXT:Array<Int>;
		
		var MPRegenMax:Int = 10;
		var MPRegenCount:Int = 0;
		
		function new() {
			super();
			init();
			
			levelArray = ["t", "t", "t", "e", "t", "t","t","o","o","e","o","o","e","o","e","o","e",
			"t", "e", "e", "o", "e", "o", "b", "o", "e", "o", "e", "e", "e", 
			"e", "e", "e", "e","o","o","e","o","o","e","o","e","o","e",
			"t", "e", "e", "o", "e", "o", "e", "o", "e", "o", "e", "e", "e", 
			"e", "e", "e", "e","o","o","e","o","o","e","o","e","o","e",
			"t", "e", "e", "o", "e", "o", "e", "o", "e", "o", "e", "e", "e", 
			"e", "e", "e", "e","o","o","o","o","o","o","o","o","e","o","o","e","o","e","o","e",
			"t", "e", "e", "o", "e", "o", "e", "o", "e", "o", "e", "e", "e", 
			"t", "e", "e", "o", "e", "o", "e", "o", "e", "o", "e", "e", "e", 
			"e", "e", "e", "e","t","t","o","e",
			"t", "e", "e", "o", "e", "o", "e", "o", "e", "o", "e", "e", "e", 
			"t", "e", "e", "o", "e", "o", "e", "o", "e", "o", "e", "e", "e", 
			"e", "e", "e", "e","t","t","o","e",
			"t", "e", "e", "o", "e", "o", "e", "o", "e", "o", "e", "e", "e", 
			"e", "e", "e", "e", "o", "e", "o", "e", "e", "e", 
			"e", "e", "e", "e", "t", "t", "t", "t", "t", "t", "t", "t", "t", "b"];
			
		}
		function init():Void {
			
			arrayHP = [5, 8, 12, 13, 16, 20];
			arrayMP = [5, 10, 15, 20, 30, 50];
			arrayNEXT = [1, 4, 6, 8, 9, 100];
			
			Lib.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			Lib.current.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			wiz = new WizardObj();
			HUD = new HudTest();
			boss = new BossObj();
			floor = new FloorTest(fl, objY, yOff,lineColor );
			proj = new ProjTest(fl, objY, yOff, lineColor);
			collision = new CollisionChecker();
			ObjArray = [];
			EnemyArray = [];
			ObstacleArray = [];
			TreeArray = [];
			ShroomArray = [];
			var bmp:Bitmap = new Bitmap(Assets.getBitmapData("img/Weirdestmountains.png"));
			addChild(bmp);
			addChild(floor);
			addChild(proj);
			for (i in 0...enemyCount) {CreateEnemy();}
			for (j in 0...treeCount) {CreateTree();}
			for (k in 0...obstacleCount) { CreateObstacle(); }
			for (m in 0...mushroomCount) { CreateMushroom();}
			addChild(wiz);
			addChild(boss);
			addChild(HUD);
			addChild(collision);
			boss.visible = false;
			
			addEventListener("UpdatePlayer", UpdatePlayer);
			addEventListener("EnemyKilled", EnemyKilled);
			addEventListener("PlayerHit", PlayerHit);
			addEventListener("BossDead", BossDead);
			Setup();
		}
		
		public function Stop():Void {
			Lib.current.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			Lib.current.stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		public function Next():Void {
			CalculateDisplayList();
			CalculateVelocities();
			CalculateObjects();
			CalculateLevel();
			if(bossMode==true){
				boss.UpdateAction();
				collision.CheckProjectileToBoss(proj.projArray3D, boss);
				for (k in 0...mushroomCount) {var shroom:ObstacleTest = ShroomArray[k];ObstacleUpdate(shroom);}
			}
			
			floor.NextFrame(vx, vz);
			proj.NextFrame(vx, vz, projSpeed * dt);
			wiz.Next();
			MPRegenCount++;
			if (MPRegenCount >= MPRegenMax) { MPRegenCount = 0; wiz.AddMP(); }
		}
		public function Setup():Void {
			wiz.SetUp();
			Lib.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			Lib.current.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			vz = -fl;
			CalculateObjects();
			Next();
			MakeMax = 60;
			levelSpot = 0;
			playerSCORE = 0;
			boss.BossHP = 2;
			wiz.SetUp();
			bossMode = false;
			floor.bossMode = false;
		rDown = uDown = dDown = fDown = false;
		lDown = false;
		fDown = false;
		vz = vx = vy = 0;
		
		zCount = 0;
		wait = false;
		MoveBackwardsBool = false;
		MoveBackwardsCount = 0;
		MoveBackwardsMaxCount = 10;
			
		}
		function CalculateLevel():Void {
			
			MakeCount -= vz;
			
			if (MakeCount >= MakeMax) {
				
				if (levelSpot == 50) {
					MakeMax = 50;
				}
				else if (levelSpot == 100) {
					MakeMax = 40;
				}
				else if (levelSpot == 135) {
					MakeMax = 30;
				}
				playerSCORE += 2;
				MakeCount = 0;
				if(bossMode==false){
				var next:String = levelArray[levelSpot];
				if (next == "e") {
					for (i in 0...EnemyArray.length) {
							var enemy:EnemyTest;
							enemy = EnemyArray[i];
							if (enemy.active == false) {
								enemy.Start(MakeMax +1);
								
								if(Math.random()>0.5){TreeLine();}
								break;
							}
						}
				}
				else if (next == "o") {
					for (j in 0...ObstacleArray.length) {
							var obstacle:ObstacleTest;
							obstacle = ObstacleArray[j];
							if (obstacle.active == false) {
								obstacle.Start(MakeMax + 1, 0);
								//TreeLine();
								break;
							}
						}
				}
				else if (next == "t") {
					for (k in 0...TreeArray.length) {
						var tree:ObstacleTest;
						tree = TreeArray[k];
						if (tree.active == false) {
							tree.Start(MakeMax, treeOffset);
							break;
						}
					}
				}
				else if (next == "b") {
					MakeMax = 40;
					bossMode = true;
					boss.visible = true;
					floor.bossMode = true;
					}
					levelSpot++;
				}
				
				//else bossmode
				else {
					for (m in 0...ShroomArray.length) {
							var obstacle2:ObstacleTest;
							obstacle2 = ShroomArray[m];
							if (obstacle2.active == false) {
								obstacle2.Start(MakeMax + 1, 0);
								//TreeLine();
								break;
							}
						}
				}
			
			}
			
		}
		function PlayerHit(e:Event):Void {
			wiz.UpdateHP();
			wiz.Hit();
			if (wiz.playerHP <= 0) {
				PlayerDead();
			}
		}
		function EnemyKilled(e:Event):Void {
			wiz.UpdateXP();
			playerSCORE += 13;
		}
		function UpdatePlayer(e:Event):Void {
			playerHP = wiz.playerHP;HUD.UpdateHP(playerHP);
			playerMP = wiz.playerMP; HUD.UpdateMP(playerMP);
			playerLVL = wiz.playerLVL; HUD.UpdateLVL(playerLVL);
			playerNEXT = wiz.playerNEXT; HUD.UpdateNEXT(playerNEXT);
			playerXP = wiz.playerXP; HUD.UpdateXP(playerXP);
			HUD.UpdateSCORE(playerSCORE);
			
		}
		function TreeLine():Void {
			for (k in 0...TreeArray.length) {
						var tree:ObstacleTest;
						tree = TreeArray[k];
						if (tree.active == false) {
							tree.Start(MakeMax, treeOffset);
							break;
						}
					}
		}
		function CalculateDisplayList():Void {
			ObjArray.sort(function(a:Dynamic, b:Dynamic):Int{
				if (a.zCount > b.zCount) return -1;if (a.zCount < b.zCount) return 1;return 0;});
			for (i in 0...ObjArray.length) {addChild(ObjArray[i]);}
			addChild(wiz);
			addChild(HUD);
		}
		public function CalculateVelocities():Void {
			if (lDown == true) {vx = vxSpeed;}
			else if (rDown == true) {vx = -vxSpeed;}
			else { vx = 0;}
			if (uDown == true) {vz = -vzSpeed;}
			else if (dDown == true) {vz = vzSpeed;}
			else { vz = -vzSpeed / 2; }
			if (MoveBackwardsBool == true) {
				vz = vzSpeed*0.75;
				MoveBackwardsCount++;
				if (MoveBackwardsCount == MoveBackwardsMaxCount) {MoveBackwardsBool = false;MoveBackwardsCount = 0;}
			}
			vz *= 2;var t:Float = Timer.stamp();dt = (t - _t);_t = t;vx *= dt;vz *= dt;
		}
		function CalculateObjects():Void {
			for (i in 0...enemyCount) {var enemy:EnemyTest = EnemyArray[i];EnemyUpdate(enemy);}
			for (j in 0...obstacleCount) {var obstacle:ObstacleTest = ObstacleArray[j];ObstacleUpdate(obstacle);}
			for (k in 0...treeCount) {var tree:ObstacleTest = TreeArray[k];ObstacleUpdate(tree);}
	}
		public function EnemyUpdate(enemy:EnemyTest):Void {
			if(enemy.active==true){enemy.NextFrame(vx, vz);
			collision.CheckEnemyToProjectile(proj.projArray3D, enemy.enemyArray3D);
			if(MoveBackwardsBool==false){MoveBackwardsBool = collision.CheckPlayerToEnemy(enemy.enemyArray3D);}}
		}
		public function ObstacleUpdate(obstacle:ObstacleTest):Void {
			if(obstacle.active==true){obstacle.NextFrame(vx, vz);
			if (MoveBackwardsBool == false) { MoveBackwardsBool = collision.CheckPlayerToObstacle(obstacle.obstacleArray3D); }}
		}
		public function onKeyDown(event:KeyboardEvent):Void{
			if(event.keyCode==37 || event.keyCode == 65){lDown=true;}
			else if(event.keyCode==39 || event.keyCode == 68){rDown = true;}
			if (event.keyCode == 32) { fDown = true;
				if (wiz.playerMP>0){
				proj.NewProj(); wiz.UpdateMP(); wiz.Shoot(); Main.HitSix.play(); }
			}
		}
		public function onKeyUp(event:KeyboardEvent):Void{
			if(event.keyCode==37 || event.keyCode == 65){lDown=false;}
			else if(event.keyCode==39 || event.keyCode == 68){rDown = false;}

			if (event.keyCode == 32) {fDown = false;}
		}
		function CreateObstacle():Void {
			var obstacle:ObstacleTest = new ObstacleTest(fl, objY, yOff, 0, lineColor, "random");addChild(obstacle);
			ObjArray.push(obstacle);ObstacleArray.push(obstacle);
		}
		function CreateEnemy():Void {
			var enemy:EnemyTest = new EnemyTest(fl, objY, yOff, 240, lineColor);addChild(enemy);
			ObjArray.push(enemy);EnemyArray.push(enemy);
		}
		function CreateTree():Void {
			var obstacle:ObstacleTest = new ObstacleTest(fl, objY, yOff, 0, lineColor, "tree");addChild(obstacle);
			ObjArray.push(obstacle);TreeArray.push(obstacle);
		}
		function CreateMushroom():Void {
			var obstacle:ObstacleTest = new ObstacleTest(fl, objY, yOff, 0, lineColor, "shroom");addChild(obstacle);
			ObjArray.push(obstacle);ShroomArray.push(obstacle);
		}
		function PlayerDead():Void {
			Stop();
			WonGame = false;
			
			dispatchEvent(new Event("GameOver", true));
		}
		public function BossDead(e:Event):Void {
			Stop();
			WonGame = true;
			dispatchEvent(new Event("GameOver", true));
		}
	}
	
