package scenes;

import com.haxepunk.Scene;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import entities.Player;
import entities.NeoNazi;

class GameScene extends Scene
{
    private var spawnTimer:Float;

    public function new()
    {
        super();
    }

	public override function begin()
	{
        // Init global values
        initValues();

        // Add background
        addGraphic(new Image("graphics/background.png"));

        // Add player to middle of screen
        add(new Player(HXP.halfWidth - 12, HXP.halfHeight - 26));

        // Don't add NeoNazis right at the beginning
        spawnTimer = 1;
	}

    private function initValues()
    {
        KH.score = 0;

        KH.playerFireRate = KH._playerFireRate;
        KH.maxAcc = KH._maxAcc;
        KH.friction = KH._friction;

        KH.recipeDroprate = KH._recipeDropRate;
        KH.recipeMaxAge = KH._recipeMaxAge;
        KH.spawnRate = KH._spawnRate;
        KH.spawnDeviation = KH._spawnDeviation;
    }

    public override function update() 
    {
        spawnTimer -= HXP.elapsed;
        if (spawnTimer < 0) 
        {
            spawnNazi();
        }

        // Increase enemy spawn rate
        KH.spawnRate += KH._spawnRateDifficulty * HXP.elapsed;
        KH.spawnDeviation += KH._spawnDeviationDifficulty * HXP.elapsed;

        super.update();
    }

    private function spawnNazi()
    {
        var nazi = new NeoNazi(0, 0);

        var direction = Math.random();
        var x = Math.random() * HXP.width;
        var y = Math.random() * HXP.height;

        if (direction <= (1/4)) {
            // spawn from above
            nazi.x = x;
            nazi.y = 0 - nazi.height;
        } else if (direction <= (2/4)) {
            // spawn from right
            nazi.x = HXP.width;
            nazi.y = y;
        } else if (direction <= (3/4)) {
            // spawn from below
            nazi.x = x;
            nazi.y = HXP.height;
        } else if (direction <= 1) {
            // spawn from left
            nazi.x = 0 - nazi.width;
            nazi.y = y;
        }

        add(nazi);

        spawnTimer = (1 / KH.spawnRate) + ((1 / KH.spawnDeviation) * Math.random());
    }

}
