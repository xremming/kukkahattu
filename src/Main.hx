import com.haxepunk.Engine;
import com.haxepunk.HXP;
import com.haxepunk.utils.Key;
import com.haxepunk.Sfx;

class Main extends Engine
{

	override public function init()
	{
#if debug
		HXP.console.enable();
		HXP.console.toggleKey = Key.K;
#end
		
		var theme = new Sfx("audio/theme.ogg");
		theme.loop(0.5);

        HXP.scene = new scenes.MenuScene();
	}

	public static function main() {
        new Main();
    }

}
