package objects;

import flixel.FlxSprite;
import flixel.util.FlxTimer;

class Coin extends FlxSprite
{
	private static var SCORE_AMOUNT:Int = 20;

	public function new(x:Float, y:Float)
	{
		super(x, y);
		loadGraphic(AssetPaths.items__png, true, 16, 16);

		animation.add("spin", [0, 1, 2, 3, 4], 16);
		animation.play("spin");
	}

	override function update(elapsed:Float)
	{
		if (!Reg.paused)
		{
			super.update(elapsed);
		}
	}

	public function collect()
	{
		Reg.score += SCORE_AMOUNT;
		Reg.coins++;

		if (Reg.coins >= 100)
		{
			Reg.coins = 0;
			Reg.lives++;
		}

		kill();
	}

	public function setFromBlock()
	{
		solid = false;
		acceleration.y = 420;
		velocity.y = 90;
		new FlxTimer().start(0.3, function(_)
		{
			collect();
		});
	}
}
