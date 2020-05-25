package objects;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxMath;
import flixel.util.FlxTimer;

class Player extends FlxSprite
{
	private static inline final ACCELERATION:Int = 320;
	private static inline final DRAG:Int = 320;
	private static inline final GRAVITY:Int = 600;
	private static inline final JUMP_FORCE:Int = -250;
	private static inline final WALK_SPEED:Int = 80;
	private static inline final RUN_SPEED:Int = 140;
	private static inline final FALLING_SPEED:Int = 300;

	private var stopAnimations = false;

	public var direction:Int = 1;

	public function new(?x:Float = 0, ?y:Float = 0)
	{
		super(x, y);
		health = 0; // Start out as normal squirrel!
		reloadGraphics();

		animation.add("dead", [6]);
		animation.add("change", [5, 12], 24);

		drag.x = DRAG;
		acceleration.y = GRAVITY;
		maxVelocity.set(WALK_SPEED, FALLING_SPEED);
	}

	override public function update(elapsed:Float)
	{
		move();

		if (!stopAnimations)
		{
			animate();
		}

		super.update(elapsed);
	}

	override public function kill()
	{
		if (alive)
		{
			alive = false;
			velocity.set(0, 0);
			acceleration.set(0, 0);
			Reg.lives -= 1;
			Reg.paused = true;
			FlxG.camera.shake();

			new FlxTimer().start(2.0, function(_)
			{
				acceleration.y = GRAVITY;
				jump();
			}, 1);
			new FlxTimer().start(5.0, function(_)
			{
				FlxG.resetState();
			}, 1);
		}
	}

	public function powerUp()
	{
		if (health == 1)
		{
			return;
		}

		Reg.paused = true;
		stopAnimations = true;
		animation.play("change");
		velocity.set(0, 0);
		acceleration.set(0, 0);

		new FlxTimer().start(1.0, function(_)
		{
			health++;
			reloadGraphics();
			Reg.paused = false;
			stopAnimations = false;
		});
	}

	private function reloadGraphics()
	{
		loadGraphic(AssetPaths.player_both__png, true, 16, 32);

		switch (health)
		{
			case 0:
				animation.add("idle", [0]);
				animation.add("walk", [1, 2, 3, 2], 12);
				animation.add("skid", [4]);
				animation.add("jump", [5]);
				animation.add("fall", [5]);

				setSize(8, 12);
				offset.set(4, 20);
			case 1:
				animation.add("idle", [7]);
				animation.add("walk", [8, 9, 10, 9], 12);
				animation.add("skid", [11]);
				animation.add("jump", [12]);
				animation.add("fall", [12]);

				setSize(8, 24);
				// offset.set(4, 8);
		}
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
				jump();
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

		// Cannot move off the left edge of map...
		if (x < 0)
		{
			x = 0;
		}

		// Fall off bottom of the map...
		if (y > Reg.state.map.height)
		{
			kill();
		}
	}

	public function jump()
	{
		if (FlxG.keys.pressed.C)
		{
			velocity.y = JUMP_FORCE;
		}
		else
		{
			velocity.y = JUMP_FORCE / 2;
		}
	}

	private function animate()
	{
		if (!alive)
		{
			animation.play("dead");
		}
		else if (velocity.y < 0 && !isTouching(FlxObject.FLOOR))
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
