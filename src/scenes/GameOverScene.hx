package scenes;

import com.haxepunk.Scene;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import entities.Recipe;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.Sfx;


class GameOverScene extends Scene
{
	private var timer:Float;
	private var score:Int;

	function new() {
		super();
	}

	public override function begin() {
		addGraphic(new Image("graphics/gameover.png"));
		timer = 0;
		var r = new Recipe(0, 0);
		var y = HXP.halfHeight;
		var x = HXP.halfWidth - ((r.width / 2) * KH.score );

		score = KH.score;

		for (i in 0 ... KH.score) {
			var recipe = new Recipe(0, 0);
			recipe.x = x;
			recipe.y = y;
			add(recipe);
			x += recipe.width;
		}

		KH.play(new Sfx("audio/lost.ogg"));

	}

	public override function update() {


		timer += HXP.elapsed;
		if (timer >= 10 || Input.released(Key.SPACE)) {
			KH.stopAllSounds();
			HXP.scene = new scenes.MenuScene();
		}
	}
}