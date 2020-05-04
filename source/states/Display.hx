package states;

import flixel.FlxG;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;

class Display extends FlxSpriteGroup
{
	private var textScore:FlxText;
	private var textTime:FlxText;
	private var textLives:FlxText;
	private var textCoins:FlxText;
	private var textLevel:FlxText;

	public function new()
	{
		super();

		textScore = new FlxText(4, 4, 0);
		textCoins = new FlxText(FlxG.width * 0.33, 4, 0);
		textLives = new FlxText(FlxG.width * 0.66, 4, 0);

		scrollFactor.set(0, 0);
		add(textScore);
		add(textCoins);
		add(textLives);
	}

	override public function update(elapsed:Float)
	{
		textScore.text = "Score\n" + StringTools.lpad(Std.string(Reg.score), "0", 5);
		textCoins.text = "Coins\n" + StringTools.lpad(Std.string(Reg.coins), "0", 2);
		textLives.text = "Lives\n" + StringTools.lpad(Std.string(Reg.lives), "0", 2);
		super.update(elapsed);
	}
}
