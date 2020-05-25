package objects;

import flixel.FlxObject;
import flixel.FlxSprite;

class PowerUp extends FlxSprite
{
	private static inline final SPEED = 40;
	private static inline final GRAVITY = 420;
	private static inline final SCORE_AMOUNT = 50;

	private var direction:Int = -1;
	private var isMoving:Bool = false;

	public function new(x:Float, y:Float)
	{
		super(x, y);
		loadGraphic(AssetPaths.items__png, true, 16, 16);
		animation.add("idle", [5]);
		animation.play("idle");

		velocity.y = -16;
	}

	override public function update(elapsed:Float)
	{
		if (!Reg.paused)
		{
			if (!isMoving && (Math.floor(y) % 16 == 0))
			{
				velocity.y = 0;
				acceleration.y = GRAVITY;
				isMoving = true;
			}

			if (isMoving)
			{
				velocity.x = direction * SPEED;

				if (justTouched(FlxObject.WALL))
				{
					direction = -direction;
				}
			}
		}

		super.update(elapsed);
	}

	public function collect(player:Player)
	{
		kill();
		if (player.health == 0)
		{
			player.powerUp();
		}
		else
		{
			Reg.score += SCORE_AMOUNT;
		}
	}
}
