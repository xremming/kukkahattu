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
	}

	public override function update()
	{
		if (collide("player", x, y) != null) {
			HXP.scene.remove(this);
			KH.recipeDroprate *= 1.1;
			KH.play(new Sfx("audio/plim.ogg"));
		}

		super.update();
	}
}