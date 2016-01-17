package entities.powerups;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.Sfx;
import com.haxepunk.graphics.Image;

class Boot extends Entity
{
	public function new(x:Float, y:Float)
	{
		super(x, y);

		graphic = new Image("graphics/boot.png");

		type = "powerup";
		setHitbox(32, 32);
	}

	public override function update()
	{
		if (collide("player", x, y) != null) {
			HXP.scene.remove(this);
			KH.maxAcc *= 1.1;
			KH.play(new Sfx("audio/plim.ogg"));
		}

		super.update();
	}
}