package entities.powerups;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;

class Carrot extends Entity
{
	public function new(x:Float, y:Float)
	{
		super(x, y);

		graphic = new Image("graphics/carrot.png");

		type = "powerup";
		setHitbox(32, 32);
	}

	public override function update()
	{
		if (collide("player", x, y) != null) {
			HXP.scene.remove(this);
			KH.playerFireRate += 1;
		}

		super.update();
	}
}