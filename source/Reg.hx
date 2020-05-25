import flixel.util.FlxSave;
import states.PlayState;

class Reg
{
	private static var _save:FlxSave;
	private static inline final SaveData:String = "GAMESAVE";

	public static var score:Int = 0;
	public static var coins:Int = 0;
	public static var lives:Int = 3;
	public static var level:Int = 0;
	public static var time:Float = 300;

	public static var state:PlayState;

	public static var paused:Bool = false;

	static public function saveHighScore()
	{
		_save = new FlxSave();

		if (_save.bind(SaveData))
		{
			if ((_save.data.score == null || _save.data.score < Reg.score))
			{
				_save.data.score = Reg.score;
			}
		}

		_save.flush();
	}

	static public function loadHighScore():Int
	{
		_save = new FlxSave();

		if (_save.bind(SaveData))
		{
			if (_save.data.score != null && _save.data.score != null)
			{
				return _save.data.score;
			}
		}

		return 0;
	}
}
