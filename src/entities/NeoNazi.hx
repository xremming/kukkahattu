package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Spritemap;
import entities.Player;
import com.haxepunk.HXP;
import com.haxepunk.Scene;
import scenes.GameScene;
import com.haxepunk.graphics.Image;
import entities.Recipe;

class NeoNazi extends Entity {
	private var sprite:Spritemap;
	private var player:Entity;

	public function new(x:Int, y:Int) {
		super(x, y);

		sprite = new Spritemap("graphics/neonazi.png", 36, 58);
		sprite.add("walk", [1, 2], 6);
		sprite.play("walk");

		graphic = sprite;

		setHitbox(36, 58);

		type = "nazi";
	}

	public override function added() {
		player = HXP.scene.entitiesForType("player").first();
	}

	public override function update() {
		moveTowards(player.x, player.y, 100 * HXP.elapsed);

		if (collide("player", x, y) != null) {
			HXP.scene = new scenes.GameOverScene();
		}

		var laser = collide("laser", x, y);
		if (laser != null) {
			var prob = Math.random();

			if (prob >= 0.3) {
				trace("Recipe dropped!");
				var recipe = new Recipe(0, 0);
				recipe.x = x + halfWidth - recipe.halfWidth;
				recipe.y = y + halfHeight - recipe.halfHeight;

				HXP.scene.add(recipe);
			}

			HXP.scene.remove(laser);
			HXP.scene.remove(this);
		}

	}



}