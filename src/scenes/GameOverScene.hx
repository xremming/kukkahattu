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
	private var win:Bool;

	function new(win:Bool) {
		super();
		this.win = win;
	}

	public override function begin() {
		if (win) {
			addGraphic(new Image("graphics/win.png"));
			KH.play(new Sfx("audio/win.ogg"));
		} else {
			addGraphic(new Image("graphics/gameover.png"));
			KH.play(new Sfx("audio/lost.ogg"));
		}

		timer = 0;
		
		addRecipes();
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
			var recipesOnLastLine = score - (recipesPerLine * (lines - 1));
			
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