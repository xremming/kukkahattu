package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.HXP;
import entities.Player;
import entities.Laser;

class Bear extends Entity
{
	private var sprite:Spritemap;
	private var hp:Int;
	private var player:Entity;

	public function new() {
		super(HXP.width, (HXP.height * Math.random() - 60) );
		sprite = new Spritemap("graphics/bear.png", 96, 60);
		sprite.add("walk", [1, 2], 6);
		sprite.play("walk");
		graphic = sprite;

		setHitbox(96, 60);

		hp = 3;

		type = "bear";
	}

	public override function added() {
		player = HXP.scene.entitiesForType("player").first();
	}

	public override function update() {
		if (hp == 3) {
			moveTowards(-130, Math.random() * HXP.height, 80 * HXP.elapsed);
		} else {
			moveTowards(player.x, player.y, 150 * HXP.elapsed);
		}

		var nazi = collide("nazi", x, y);
		if (nazi != null) {
			HXP.scene.remove(nazi);
		}

		if (collide("player", x, y) != null) {
			HXP.scene = new scenes.GameOverScene();
		}

		var laser = collide("laser", x, y);

		if (laser != null) {
			hp--;
			HXP.scene.remove(laser);

			if (hp == 0) {
				HXP.scene.remove(this);
			}
		}

		super.update();

	}
}