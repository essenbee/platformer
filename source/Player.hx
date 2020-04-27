package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxMath;

class Player extends FlxSprite
{
	private static inline final ACCELERATION:Int = 320;
	private static inline final DRAG:Int = 320;
	private static inline final GRAVITY:Int = 600;
	private static inline final JUMP_FORCE:Int = -250;
	private static inline final WALK_SPEED:Int = 80;
	private static inline final RUN_SPEED:Int = 140;
	private static inline final FALLING_SPEED:Int = 300;

	public var direction:Int = 1;

	public function new(x:Float, y:Float)
	{
		super(x, y);
		loadGraphic(AssetPaths.player__png, true, 16, 16);

		animation.add("idle", [0]);
		animation.add("walk", [1, 2, 3, 2], 12);
		animation.add("skid", [4]);
		animation.add("jump", [5]);
		animation.add("fall", [5]);
		animation.add("dead", [6]);

		setSize(8, 12);
		offset.set(4, 4);

		drag.x = DRAG;
		acceleration.y = GRAVITY;
		maxVelocity.set(WALK_SPEED, FALLING_SPEED);
	}

	override public function update(elapsed:Float)
	{
		move();
		animate();
		super.update(elapsed);
	}

	private function move()
	{
		acceleration.x = 0;

		if (FlxG.keys.pressed.LEFT)
		{
			flipX = true;
			direction = -1;
			acceleration.x -= ACCELERATION;
		}
		else if (FlxG.keys.pressed.RIGHT)
		{
			flipX = false;
			direction = 1;
			acceleration.x += ACCELERATION;
		}

		if (velocity.y == 0)
		{
			if (FlxG.keys.justPressed.C && isTouching(FlxObject.FLOOR))
			{
				velocity.y = JUMP_FORCE;
			}

			if (FlxG.keys.pressed.X)
			{
				maxVelocity.x = RUN_SPEED;
			}
			else
			{
				maxVelocity.x = WALK_SPEED;
			}
		}
	}

	private function animate()
	{
		if (velocity.y < 0 && !isTouching(FlxObject.FLOOR))
		{
			animation.play("jump");
		}
		else if (velocity.y > 0)
		{
			animation.play("fall");
		}
		else if (velocity.x == 0)
		{
			animation.play("idle");
		}
		else
		{
			if (FlxMath.signOf(velocity.x) != FlxMath.signOf(direction))
			{
				animation.play("skid");
			}
			else
			{
				animation.play("walk");
			}
		}
	}
}
