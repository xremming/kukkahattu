import com.haxepunk.Sfx;

class KH
{
	public static var score:Int = 0;
	public static var highScore:Int = 0;


	public static var _playerFireRate:Float = 3;
	public static var playerFireRate:Float = _playerFireRate;

	public static var _acc:Float = 64;
	public static var acc:Float = _acc;

	public static var _maxAcc:Float = 128;
	public static var maxAcc:Float = _maxAcc;

	public static var _friction:Float = 0.75;
	public static var friction:Float = _friction;


	public static var _recipeDropRate:Float = 0.3;
	public static var recipeDroprate:Float = _recipeDropRate;

	public static var _recipeMaxAge:Float = 10;
	public static var recipeMaxAge:Float = _recipeMaxAge;

	public static var _spawnRate:Float = 0.5;
	public static var spawnRate:Float = _spawnRate;
	public static var _spawnRateDifficulty:Float = 0.02;

	public static var _spawnDeviation:Float = 0.2;
	public static var spawnDeviation:Float = _spawnDeviation;
	public static var _spawnDeviationDifficulty:Float = 0.01;

	private static var sounds = new Array();
	public static function play(sound:Sfx)
	{
		sound.play();
		sounds.push(sound);
	}

	public static function stopAllSounds()
	{
		for (i in sounds) {
			i.stop();
		}
		sounds = [];
	}
}