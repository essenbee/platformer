package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import openfl.system.System;
import states.PlayState;

class MenuState extends FlxState
{
	private var _background:FlxSprite;
	private var _cursor:FlxSprite;
	private var _selected:Int;
	private var _highScore:FlxText;
	private var _menuPosition:FlxPoint;
	private var _scorePosition:FlxPoint;

	private static var _menuEntries:Array<String> = ["NEW GAME", "EXIT"];

	private static inline final Offset:Int = 16;

	override public function create()
	{
		_menuPosition = new FlxPoint(116, 112);
		_scorePosition = new FlxPoint(4, 4);

		_background = new FlxSprite(0, 0);
		_background.loadGraphic(AssetPaths.title__png, false, 320, 180);

		_cursor = new FlxSprite(_menuPosition.x, _menuPosition.y);
		_cursor.loadGraphic(AssetPaths.display__png, true, 8, 8);
		_cursor.animation.add("cursor", [1]);
		_cursor.animation.play("cursor");

		_highScore = new FlxText(_scorePosition.x, _scorePosition.y, 0);
		_highScore.text = "HIGH\n" + StringTools.lpad(Std.string(Reg.loadHighScore()), "0", 5);

		add(_background);
		add(_cursor);
		add(_highScore);

		for (i in 0..._menuEntries.length)
		{
			var entry:FlxText = new FlxText(_menuPosition.x + Offset, _menuPosition.y + (Offset * i));
			entry.text = _menuEntries[i];
			add(entry);
		}

		forEachOfType(FlxText, x -> x.setFormat(AssetPaths.pixel_font__ttf, 8, FlxColor.WHITE, FlxTextBorderStyle.OUTLINE, 0xff005784));

		super.create();
	}

	override public function update(elapsed:Float)
	{
		if (FlxG.keys.justPressed.UP)
		{
			_selected--;
		}

		if (FlxG.keys.justPressed.DOWN)
		{
			_selected++;
		}

		_selected = FlxMath.wrap(_selected, 0, _menuEntries.length - 1);
		_cursor.y = 112 + (16 * _selected);

		if (FlxG.keys.justPressed.ENTER)
		{
			switch (_selected)
			{
				case 0:
					FlxG.switchState(new PlayState());
				case 1:
					System.exit(0);
			}
		}
	}
}
