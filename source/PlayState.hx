package;

import LevelLoader;
import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.tile.FlxTilemap;

class PlayState extends FlxState
{
	public var map:FlxTilemap;
	public var player(default, null):FlxSprite;

	override public function create()
	{
		player = new Player(64, 16);
		LevelLoader.loadLevel(this, "Level1");

		add(player);

		FlxG.camera.follow(player, FlxCameraFollowStyle.PLATFORMER);
		FlxG.camera.setScrollBoundsRect(0, 0, map.width, map.height, true);

		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		FlxG.collide(map, player);
	}
}
