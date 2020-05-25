package states;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import js.html.AbortController;
import openfl.system.System;
import states.MenuState;

class Intro extends FlxSubState
{
	private var text:FlxText;
	private var iconLives:FlxSprite;
	private var textLives:FlxText;

	private var gameOver:Bool;

	override function create()
	{
		super.create();

		if (Reg.lives == 0)
		{
			gameOver = true;
		}

		text = new FlxText(0, FlxG.height / 2 + 8, FlxG.width, "Get Ready!");
		textLives = new FlxText(FlxG.width / 2, FlxG.height / 2 - 8, FlxG.width, "x " + Reg.lives);

		iconLives = new FlxSprite(FlxG.width / 2 - 20, FlxG.height / 2 - 4);
		iconLives.loadGraphic(AssetPaths.display__png, true, 8, 8);
		iconLives.animation.add("lives", [1], 8);
		iconLives.animation.play("lives");

		add(text);

		if (gameOver)
		{
			text.text = "Game Over!";
			text.setPosition(0, FlxG.height / 2);
		}
		else
		{
			add(iconLives);
			add(textLives);
		}

		forEachOfType(FlxObject, function(obj)
		{
			obj.scrollFactor.set(0, 0);
		});

		forEachOfType(FlxText, function(obj)
		{
			obj.setFormat(AssetPaths.pixel_font__ttf, 8, FlxColor.WHITE, FlxTextBorderStyle.OUTLINE, 0xff005784);
		});

		text.alignment = FlxTextAlign.CENTER;

		new FlxTimer().start(3.0, function(_)
		{
			if (gameOver)
			{
				Reg.saveHighScore();
				Reg.lives = 3;
				Reg.score = 0;
				FlxG.switchState(new MenuState());
			}
			else
			{
				close();
			}
		});
	}
}
