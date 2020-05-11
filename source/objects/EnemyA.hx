package objects;

class EnemyA extends Enemy
{
	private static inline final WALK_SPEED:Int = 40;
	private static inline final SCORE_AMOUNT:Int = 100;

	public function new(x:Float, y:Float)
	{
		super(x, y);
		loadGraphic(AssetPaths.enemyA__png, true, 16, 16);
		animation.add("walk", [0, 1, 2], 12);
		animation.add("dead", [3], 12);
		animation.play("walk");

		setSize(12, 12);
		offset.set(2, 4);
	}

	override function move()
	{
		velocity.x = direction * WALK_SPEED;
	}
}
