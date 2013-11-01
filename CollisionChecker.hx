package ;
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Point;
import flash.geom.Vector3D;
import flash.Vector.Vector;


	/**
	 * ...
	 * @author E
	 */
	class CollisionChecker extends Sprite
	{
		var zOff:Int = 5;
		public function new() {
			super();
		}
		public function CheckEnemyToProjectile(projArray:Array<ProjObj>, enemyArray:Array<EnemyObj>):Void {
			var projLength:Int = projArray.length;
			var enemyLength:Int = enemyArray.length;
			var projPoint:Point;
			var enemyPoint:Point;
			var projVector:Vector3D;
			var enemyVector:Vector3D;
			var enemyObj:EnemyObj;
			var projObj:ProjObj;
			for (i in 0...projLength) {
				projObj = projArray[i];
				if (projObj.active == true) {
					projPoint = projObj.vec2D;
					projVector = projObj.vec3D;
					for (j in 0...enemyLength) {
						enemyObj = enemyArray[j];
						if (enemyObj.active == true) {
							enemyPoint = enemyObj.vec2D;
							enemyVector = enemyObj.vec3D;
							if(projVector.z> enemyVector.z-zOff && projVector.z < enemyVector.z+zOff){
								if (projPoint.x +(projVector.w / 2) > (enemyPoint.x - enemyVector.w / 2)
								&& projPoint.x-(projVector.w/2) < enemyPoint.x+enemyVector.w/2)
								{
									projObj.Stop();
									enemyObj.Stop();
									Main.HitFour.play();
									dispatchEvent(new Event("EnemyKilled", true));
									break;
								}
							}	
						}
					}
				}
			}
		}
		public function CheckPlayerToObstacle(obstacleArray:Array<ObstacleObj>):Bool {
			var b:Bool = false;
			var obstacleObj:ObstacleObj;
			var arrayLength:Int = obstacleArray.length;
			var obstacleVec:Vector3D;
			var obstaclePoint:Point;
			//20 is radius of wizard
			//35 
			//GET WIDTH OF OBSTACLE
			for (i in 0...arrayLength) {
				obstacleObj = obstacleArray[i];
				obstacleVec = obstacleObj.vec3D;
				obstaclePoint = obstacleObj.vec2D;
				if(obstacleObj.active==true){
				if (obstacleVec.z < -90 && obstacleVec.z > -95) {
					if (obstaclePoint.x+obstacleObj.uniqueWidth > -20 && obstaclePoint.x - obstacleObj.uniqueWidth < 20) {
						b = true;
							if (obstacleObj.type == "mushroom") {
								obstacleObj.Stop();
								Main.HitTwo.play();
								dispatchEvent(new Event("PlayerHit", true));
							}
							else {
								Main.HitThree.play();
							}
						break;
					}
				}
				}
			}
			return b;
		}
		public function CheckPlayerToEnemy(enemyArray:Array<EnemyObj>):Bool {
			var b:Bool = false;
			var enemyObj:EnemyObj;
			var arrayLength:Int = enemyArray.length;
			var enemyVec:Vector3D;
			var enemyPoint:Point;
			//20 is radius of wizard
			//35 
			//GET WIDTH OF OBSTACLE
			for (i in 0...arrayLength) {
				enemyObj = enemyArray[i];
				enemyVec = enemyObj.vec3D;
				enemyPoint = enemyObj.vec2D;
				if(enemyObj.active==true){
					if (enemyVec.z < -90 && enemyVec.z > -95) {
						if (enemyPoint.x+enemyObj.uniqueWidth > -20 && enemyPoint.x - enemyObj.uniqueWidth < 20) {
							b = true;
							enemyObj.Stop();
							Main.HitOne.play();
							dispatchEvent(new Event("PlayerHit", true));
							break;
						}
					}
				}
			}
			return b;
		}
		public function CheckProjectileToBoss(projArray:Array<ProjObj>, _boss:BossObj):Void {
			var boss:BossObj = _boss;
			var bossPoint:Point = boss.location;
			var projObj:ProjObj;
			var projPoint:Point;
			var projVec:Vector3D;
			var arrayLength:Int = projArray.length;
			for (i in 0...arrayLength) {
				projObj = projArray[i];
				if (projObj.active == true) {
					projPoint = projObj.vec2D;
					if (projPoint.y < 65) {
						if (projPoint.x > bossPoint.x - 20 && projPoint.x < bossPoint.x + 20) {
							boss.Hit();
							Main.HitSix.play();
							projObj.Stop();
							break;
						}
					}
					//trace(bossPoint + "|" + projPoint);
				}
			}
		}
		
		
	}