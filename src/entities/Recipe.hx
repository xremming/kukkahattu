package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;

class Recipe extends Entity
{
	public function new(x:Float, y:Float) {
		super(x, y);
		graphic = new Image("graphics/recipe.png");
		setHitbox(23, 29);
		layer = 2;
	}

	private var age:Float = 0;

	public override function update() {
		if (age >= KH.recipeMaxAge)
			HXP.scene.remove(this);
		else
			age += HXP.elapsed;

		if (age > 0.8 * KH.recipeMaxAge && Math.round(age * age * 8) % 2 == 0)
			visible = !visible;

		if (collide("player", x, y) != null) {
			KH.score++;
			HXP.scene.remove(this);
		}

		super.update();
	}
}