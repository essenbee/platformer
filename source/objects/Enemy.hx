package objects;

import flixel.FlxObject;
import flixel.FlxSprite;
import objects.Player;

class Enemy extends FlxSprite
{
	private static inline final GRAVITY:Int = 420;
	private static inline final WALK_SPEED:Int = 40;
	private static inline final SCORE_AMOUNT:Int = 100;
	private static inline final FALLING_SPEED:Int = 200;

	private var direction:Int = 1;
	private var appeared:Bool = false;

	public function new(x:Float, y:Float)
	{
		super(x, y);
		loadGraphic(AssetPaths.enemyA__png, true, 16, 16);
		animation.add("walk", [0, 1, 2], 12);
		animation.add("dead", [3], 12);
		animation.play("walk");

		setSize(12, 12);
		offset.set(2, 4);

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
			move();

			if (justTouched(FlxObject.WALL))
			{
				flipDirection();
			}
		}

		super.update(elapsed);
	}

	private function move()
	{
		velocity.x = direction * WALK_SPEED;
	}

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
}
