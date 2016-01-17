package scenes;

import com.haxepunk.Scene;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import entities.Player;
import entities.NeoNazi;
import entities.Bear;
import com.haxepunk.Sfx;

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
        if (spawnTimer <= 0) 
        {
            var prob = Math.random();
            if (prob < 0.1) {
                add(new Bear());
            } else {
                add(new NeoNazi());
            }
            // Set spawn timer for next enemy
            spawnTimer = (1 / KH.spawnRate) + ((1 / KH.spawnDeviation) * Math.random());
        }

        cloverTimer -= HXP.elapsed
        if (cloverTimer <= 0) {
            add(new Clover());
        }

        // Increase enemy spawn rate
        KH.spawnRate += KH._spawnRateDifficulty * HXP.elapsed;
        KH.spawnDeviation += KH._spawnDeviationDifficulty * HXP.elapsed;

        super.update();
    }

}
