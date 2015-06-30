package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.setInterval;
	import flash.utils.clearInterval;
	import flash.display.Graphics;
	import flash.display.Shape;
	
	public class Bullet extends MovieClip {
		//private var _root:*;
		//these two variables below must be set to public so that we can edit them outside the class
		public var targetMsg;//the targetMsg that this guy is moving towards
		public var ManyTargetMsg:Array;
		public var damage:int;//how much damage this guy inflicts on the enemy
		public var limit:Number;
		private var xSpeed:Number;//how fast it's moving horizontally
		private var ySpeed:Number;//how fast it's moving vertically
		private var maxSpeed:Number = 10;//how fast it can go
		private var bulletInterval;
		public var triggerX:Number;
		public var triggerY:Number;
		
		public function Bullet(){

			addEventListener(Event.ADDED,beginClass);//this will run every time this guy is made
		}
		private function beginClass(e:Event):void{
			this.removeEventListener(Event.ADDED,beginClass);
		}
		
		public function destroyThis():void{
			if(this != null && this.parent != null){
				clearInterval(bulletInterval); 
				if(this.parent != null)
				{
					this.parent.removeChild(this);
				}
			}
		}		
		public function bulletType1():void{
			bulletInterval = setInterval(bulletPlay,50);
		}
		public function bulletPlay():void{
		
			var yDist:Number=targetMsg.y - this.y;//how far this guy is from the enemy (x)
			var xDist:Number=targetMsg.x - this.x;//how far it is from the enemy (y)
			var angle:Number=Math.atan2(yDist,xDist);//the angle that it must move
			
			ySpeed=Math.sin(angle)* 8;//calculate how much it should move the enemy vertically
			xSpeed=Math.cos(angle)* 8;//calculate how much it should move the enemy horizontally
			//move the bullet towards the enemy
			
			this.rotation = angle/Math.PI*180-90;
			
			this.x+= xSpeed;
			this.y+= ySpeed;
			
			var distanceTwo:Number = Math.sqrt(Math.pow(yDist,2) + Math.pow(xDist,2));
			var outOfRange = limit - Math.sqrt(Math.pow((triggerX - this.x),2) + Math.pow((triggerY- this.y),2));

			if(targetMsg != null && distanceTwo <=12 && outOfRange >=0 && this!= null && this.parent != null){//if it touches the enemy12.5	

 				targetMsg.Health = targetMsg.Health - damage;
				destroyThis();//and destroy this guy
			}
			else if(targetMsg == null ||  outOfRange <0){//destroy it if game is over
				destroyThis();
			}
		}
	}
}