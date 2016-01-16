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
        trace("GameScene starting...");
        addGraphic(new Image("graphics/background.png"));

        var player:Player = new Player(0, 0);
        player.x = HXP.halfWidth - 32;
        player.y = HXP.halfHeight - 32;
        add(player);

        spawnTimer = 1;
        KH.score = 0;

	}

    public override function update() 
    {
        spawnTimer -= HXP.elapsed;
        if (spawnTimer < 0) 
        {
            spawn();
        }

        super.update();
    }

    private function spawn()
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

        spawnTimer = (1 / KH.spawnRate) + (KH.spawnDeviation * Math.random());
    }

}
