package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;

class Recipe extends Entity
{
	public function new(x:Int, y:Int) {
		super(x, y);
		graphic = new Image("graphics/recipe.png");
		setHitbox(23, 29);
	}

	public override function update() {
		if (collide("player", x, y) != null) {
			KH.score++;
			HXP.scene.remove(this);
		}

		super.update();
	}
}