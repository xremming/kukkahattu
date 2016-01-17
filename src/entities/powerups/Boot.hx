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
		layer = 2;
	}

	private var age:Float = 0;

	public override function update()
	{
		if (age >= 15)
			HXP.scene.remove(this);
		else
			age += HXP.elapsed;

		if (age > 0.8 * 15 && Math.round(age * age * 8) % 2 == 0)
			visible = !visible;

		if (collide("player", x, y) != null) {
			HXP.scene.remove(this);
			KH.maxAcc *= 1.1;
			KH.play(new Sfx("audio/plim.ogg"));
		}

		super.update();
	}
}