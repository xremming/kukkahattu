package scenes;

import com.haxepunk.Scene;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import entities.Player;

class GameScene extends Scene
{
    public function new()
    {
        super();
    }

	public override function begin()
	{
        trace("GameScene starting...");
        var player:Player = new Player(0, 0);
        player.x = HXP.halfWidth - 32;
        player.y = HXP.halfHeight - 32;
        add(player);
	}
}
