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
		
		addRecipes();

		KH.play(new Sfx("audio/lost.ogg"));

	}

	public override function update() {


		timer += HXP.elapsed;
		if (timer >= 10 || Input.released(Key.SPACE)) {
			KH.stopAllSounds();
			HXP.scene = new scenes.MenuScene();
		}
	}

	private function addRecipes() {
		var r = new Recipe(0, 0);

		score = KH.score;
		var recipesPerLine = Math.floor(HXP.width / r.width);
		var y = HXP.halfHeight;

		if (score > recipesPerLine) {
			var lines = Math.ceil(score / recipesPerLine);
			trace(lines);
			var recipesOnLastLine = score - (recipesPerLine * (lines - 1));
			trace(recipesOnLastLine);
			trace(recipesPerLine);

			for (i in 0 ... (lines - 1)) {
				addRecipeLine(recipesPerLine, y);
				y += r.height + 1;
			}
			addRecipeLine(recipesOnLastLine, y);
		} else {
			addRecipeLine(score, y);
		}

	}

	private function addRecipeLine(count:Int, y:Float) {
		var r = new Recipe(0,0);
		var x = HXP.halfWidth - ((r.width / 2) * count);
		for (i in 0 ... count) {
			r = new Recipe(x,y);
			add(r);
			x += r.width;
		}
	}

}