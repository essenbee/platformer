package utils;

import flixel.addons.editors.tiled.TiledMap;
import flixel.addons.editors.tiled.TiledObject;
import flixel.addons.editors.tiled.TiledObjectLayer;
import flixel.addons.editors.tiled.TiledTileLayer;
import flixel.tile.FlxTilemap;
import objects.Coin;
import objects.Enemy;
import states.PlayState;

class LevelLoader
{
	public static function loadLevel(state:PlayState, level:String)
	{
		var tiledMap = new TiledMap("assets/data/" + level + ".tmx");

		var mainLayer:TiledTileLayer = cast tiledMap.getLayer("main");
		state.map = new FlxTilemap();
		state.map.loadMapFromArray(mainLayer.tileArray, tiledMap.width, tiledMap.height, AssetPaths.tiles__png, 16, 16, 1);

		var backLayer:TiledTileLayer = cast tiledMap.getLayer("background");
		var backMap = new FlxTilemap();
		backMap.loadMapFromArray(backLayer.tileArray, tiledMap.width, tiledMap.height, AssetPaths.tiles__png, 16, 16, 1);
		backMap.solid = false;

		state.add(backMap);
		state.add(state.map);

		for (coin in getLevelObjects(tiledMap, "coins"))
		{
			state.items.add(new Coin(coin.x, coin.y - 16));
		}

		for (enemy in getLevelObjects(tiledMap, "enemies"))
		{
			state.enemies.add(new Enemy(enemy.x, enemy.y - 16));
		}

		var playerPos:TiledObject = getLevelObjects(tiledMap, "player")[0];
		state.player.setPosition(playerPos.x, playerPos.y - 16); // Adjust for Tiled origin
	}

	public static function getLevelObjects(map:TiledMap, layer:String):Array<TiledObject>
	{
		if (map != null && (map.getLayer(layer) != null))
		{
			var objLayer:TiledObjectLayer = cast map.getLayer(layer);
			return objLayer.objects;
		}
		else
		{
			trace("Object layer " + layer + " was not found!");
			return [];
		}
	}
}
