package states;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class Display extends FlxSpriteGroup
{
	private var textScore:FlxText;
	private var textTime:FlxText;
	private var textCoins:FlxText;
	private var textLevel:FlxText;
	private var iconCoin:FlxSprite;

	public function new()
	{
		super();

		textScore = new FlxText(4, 4, 0);
		textCoins = new FlxText(FlxG.width * 0.33, 14, 0);
		textLevel = new FlxText(FlxG.width * 0.66, 4, 0);
		textTime = new FlxText(4, 4, FlxG.width - 4 * 2);

		scrollFactor.set(0, 0);
		add(textScore);
		add(textCoins);
		add(textLevel);
		add(textTime);

		textScore.alignment = FlxTextAlign.LEFT;
		textCoins.alignment = FlxTextAlign.CENTER;
		textLevel.alignment = FlxTextAlign.CENTER;
		textTime.alignment = FlxTextAlign.RIGHT;

		forEachOfType(FlxText, x -> x.setFormat(AssetPaths.pixel_font__ttf, 8, FlxColor.WHITE, FlxTextBorderStyle.OUTLINE, 0xff005784));

		iconCoin = new FlxSprite(FlxG.width * 0.33 - 4, 14 + 4);
		iconCoin.loadGraphic(AssetPaths.display__png, true, 8, 8);
		iconCoin.animation.add("coin", [0], 0);
		iconCoin.animation.play("coin");

		add(iconCoin);
	}

	override public function update(elapsed:Float)
	{
		textScore.text = "Score\n" + StringTools.lpad(Std.string(Reg.score), "0", 5);
		textCoins.text = "  x " + StringTools.lpad(Std.string(Reg.coins), "0", 2);
		textTime.text = "TIME\n" + StringTools.lpad(Std.string(Math.floor(Reg.time)), "0", 3);
		textLevel.text = "STAGE\n" + (Reg.level + 1);
		super.update(elapsed);
	}

	public function setCamera(camera:FlxCamera)
	{
		forEach(function(obj)
		{
			obj.scrollFactor.set(0, 0);
			obj.cameras = [camera];
		});
	}
}
