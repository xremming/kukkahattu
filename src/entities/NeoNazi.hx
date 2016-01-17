package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Spritemap;
import entities.Player;
import com.haxepunk.HXP;
import com.haxepunk.Scene;
import scenes.GameScene;
import com.haxepunk.graphics.Image;
import entities.Recipe;
import com.haxepunk.Sfx;
import entities.Bear;

class NeoNazi extends Entity {
	private var sprite:Spritemap;
	private var player:Entity;
	private var argh = [new Sfx("audio/naziargh0.ogg"), new Sfx("audio/naziargh1.ogg"), new Sfx("audio/naziargh2.ogg")];
	private var arghSound:Sfx;
	private var deathSound:Sfx;

	public function new() {


		var direction = Math.random();
        var x = Math.random() * HXP.width;
        var y = Math.random() * HXP.height;

        if (direction < (1/4)) {
            // spawn from above
            y = 0 - 58;
        } else if (direction < (2/4)) {
            // spawn from right
            x = HXP.width;
        } else if (direction < (3/4)) {
            // spawn from below
            y = HXP.height;
        } else if (direction < 1) {
            // spawn from left
            x = 0 - 36;
        }


		super(x, y);

		sprite = new Spritemap("graphics/neonazi.png", 36, 58);
		sprite.add("walk", [1, 2], 6);
		sprite.play("walk");

		graphic = sprite;

		setHitbox(36, 58);

		deathSound = new Sfx("audio/nazidead.ogg");
		arghSound = HXP.choose(argh);

		type = "nazi";
		layer = 1;
	}

	public override function added() {
		player = HXP.scene.entitiesForType("player").first();
		
		KH.play(arghSound);
	}

	public override function update() {
		moveTowards(player.x, player.y, 100 * HXP.elapsed);

		if (collide("player", x, y) != null) {
			var entities = new Array<Entity>();
			HXP.scene.getAll(entities);
			for (i in entities) {
				HXP.scene.remove(i);	
			}
			KH.stopAllSounds();
			HXP.scene = new scenes.GameOverScene(false);
		}

		var laser = collide("laser", x, y);
		if (laser != null) {
			var prob = Math.random();

			if (prob < KH.recipeDroprate) {
				var recipe = new Recipe(0, 0);
				recipe.x = x + halfWidth - recipe.halfWidth;
				recipe.y = y + halfHeight - recipe.halfHeight;

				HXP.scene.add(recipe);
			}

			if (arghSound.playing) {
				arghSound.stop();
			}

			deathSound.play();

			HXP.scene.remove(laser);
			HXP.scene.remove(this);
		}

		if (collide("bear", x, y) != null) {

			if (arghSound.playing) {
				arghSound.stop();
			}

			var sound = new Sfx("audio/nazidead.ogg");
			sound.play();

			HXP.scene.remove(this);

		}

	}



}