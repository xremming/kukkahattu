package scenes;

import com.haxepunk.Scene;
import com.haxepunk.graphics.Image;

class GameScene extends Scene
{
    public function new()
    {
        super();
    }

	public override function begin()
	{
        trace("GameScene starting...");
        add(new entities.Player(0, 0));
	}
}
