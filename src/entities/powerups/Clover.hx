package entities.powerups;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.Sfx;
import com.haxepunk.graphics.Image;

class Clover extends Entity
{
	public function new()
	{
		super((HXP.width - 23) * Math.random(), (HXP.height - 30) * Math.random());

		graphic = new Image("graphics/clover.png");

		type = "powerup";
		setHitbox(23, 30);
		layer = 2;
	}

	private var age:Float = 0;

	public override function update()
	{
		if (age >= 5)
			HXP.scene.remove(this);
		else
			age += HXP.elapsed;

		if (age > 0.8 * 5 && Math.round(age * age * 8) % 2 == 0)
			visible = !visible;

		if (collide("player", x, y) != null) {
			HXP.scene.remove(this);
			KH.recipeDroprate *= 1.1;
			KH.play(new Sfx("audio/plim.ogg"));
		}

		super.update();
	}
}