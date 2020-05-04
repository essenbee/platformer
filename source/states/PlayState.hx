package states;

import flixel.FlxBasic;
import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tile.FlxTilemap;
import objects.Coin;
import objects.Enemy;
import objects.Player;
import utils.LevelLoader;

class PlayState extends FlxState
{
	public var map:FlxTilemap;
	public var player(default, null):FlxSprite;
	public var items(default, null):FlxTypedGroup<FlxSprite>;
	public var enemies(default, null):FlxTypedGroup<Enemy>;

	private var display:Display;

	override public function create()
	{
		player = new Player();
		items = new FlxTypedGroup<FlxSprite>();
		enemies = new FlxTypedGroup<Enemy>();
		display = new Display();

		LevelLoader.loadLevel(this, "Level1");

		add(player);
		add(items);
		add(enemies);
		add(display);

		FlxG.camera.follow(player, FlxCameraFollowStyle.PLATFORMER);
		FlxG.camera.setScrollBoundsRect(0, 0, map.width, map.height, true);

		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		FlxG.collide(map, player);
		FlxG.collide(map, enemies);
		FlxG.overlap(items, player, collideItems);
		FlxG.overlap(enemies, player, collideEnemies);
		FlxG.collide(enemies, enemies);
	}

	function collideItems(coin:Coin, player:Player):Void
	{
		coin.collect();
	}

	function collideEnemies(enemy:Enemy, player:Player):Void
	{
		enemy.interact(player);
	}
}
