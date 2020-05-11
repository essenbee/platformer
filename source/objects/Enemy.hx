package objects;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxTimer;
import objects.Player;

class Enemy extends FlxSprite
{
	private static inline final GRAVITY:Int = 420;
	private static inline final WALK_SPEED:Int = 40;
	private static inline final FALLING_SPEED:Int = 200;
	private static inline final SCORE_AMOUNT:Int = 100;

	private var direction:Int = -1;
	private var appeared:Bool = false;

	public function new(x:Float, y:Float)
	{
		super(x, y);
		acceleration.y = GRAVITY;
		maxVelocity.y = FALLING_SPEED;
	}

	override public function update(elapsed:Float)
	{
		if (!inWorldBounds())
		{
			exists = false;
		}

		if (isOnScreen())
		{
			appeared = true;
		}

		if (appeared && alive)
		{
			if (!Reg.paused)
			{
				move();
			}

			if (justTouched(FlxObject.WALL))
			{
				flipDirection();
			}
		}

		super.update(elapsed);
	}

	private function move() {}

	private function flipDirection()
	{
		flipX = !flipX;
		direction = -direction;
	}

	public function interact(player:Player)
	{
		if (!alive)
		{
			return;
		}

		FlxObject.separateY(this, player);

		if (player.velocity.y > 0 && isTouching(FlxObject.UP))
		{
			kill();
			player.jump();
		}
		else
		{
			player.kill();
		}
	}

	override public function kill()
	{
		alive = false;
		Reg.score += SCORE_AMOUNT;
		velocity.x = 0;
		acceleration.x = 0;
		animation.play("dead");

		new FlxTimer().start(1.0, function(_)
		{
			exists = false;
			visible = false;
		});
	}
}
