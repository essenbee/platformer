package objects;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.tweens.FlxTween;

class BonusBlock extends FlxSprite
{
	private var _isEmpty:Bool;

	public var contains:String;

	private static inline final BlockMovePixels:Int = 2;

	public function new(x:Float, y:Float)
	{
		super(x, y);

		_isEmpty = false;
		solid = true;
		immovable = true;

		loadGraphic(AssetPaths.items__png, true, 16, 16);
		animation.add("full", [7]);
		animation.add("empty", [8]);
		animation.play("full");
	}

	private function createItem()
	{
		switch (contains)
		{
			default:
				var coin:Coin = new Coin(Std.int(x), Std.int(y) - 16);
				coin.setFromBlock();
				Reg.state.add(coin);
			case "powerup":
				var powerUp:PowerUp = new PowerUp(Std.int(x), Std.int(y));
				Reg.state.items.add(powerUp);
		}
	}

	private function giveReward(_)
	{
		_isEmpty = true;
		animation.play("empty");
		createItem();
	}

	public function hit(player:Player)
	{
		FlxObject.separate(this, player);
		if (isTouching(FlxObject.DOWN))
		{
			FlxTween.tween(this, {y: y - BlockMovePixels}, 0.05, {onComplete: giveReward});
		}
	}
}
