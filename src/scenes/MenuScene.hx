package scenes;

import com.haxepunk.Scene;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

class MenuScene extends Scene {

	public function new() {
		super();
	}

	public override function begin() {

		var logo:Image = new Image("graphics/logo.png");
		addGraphic(logo);
		logo.x = HXP.halfWidth - (logo.width / 2);
		logo.y = HXP.halfHeight - (logo.height / 2);

		var play:Image = new Image("graphics/play.png");
		addGraphic(play);

	}

	public override function update() {
		if(Input.check(Key.ENTER)) {
			HXP.scene = new scenes.GameScene();
		}

		super.update();
	}

}