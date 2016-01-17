package entities.powerups;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.Sfx;
import com.haxepunk.graphics.Image;

class Boot extends Entity
{
	public function new()
	{
		super((HXP.width - 32) * Math.random(), (HXP.height - 32) * Math.random());

		graphic = new Image("graphics/clover.png");

		type = "powerup";
		setHitbox(32, 32);
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