package scenes;

import com.haxepunk.Scene;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

class MenuScene extends Scene {
	private var timer:Float = 0;
	private var play:Image;

	public function new() {
		super();
	}

	public override function begin() {

		var logo:Image = new Image("graphics/logo.png");
		addGraphic(logo);
		logo.x = HXP.halfWidth - (logo.width / 2);
		logo.y = HXP.halfHeight - (logo.height / 2);

		play = new Image("graphics/play.png");
		addGraphic(play);
		play.x = HXP.halfWidth - (play.width / 2);
		play.y = HXP.halfHeight - (play.height / 2);

	}

	public override function update() {
		timer += HXP.elapsed;
		if (timer > 0.7) {
			timer -= 0.7;
			play.visible = !play.visible;
		}

		if(Input.released(Key.SPACE)) {
			HXP.scene = new scenes.GameScene();
		}

		super.update();
	}

}