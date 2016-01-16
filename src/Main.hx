import com.haxepunk.Engine;
import com.haxepunk.HXP;
import com.haxepunk.utils.Key;

class Main extends Engine
{

	override public function init()
	{
#if debug
		HXP.console.enable();
		HXP.console.toggleKey = Key.K;
#end
        HXP.scene = new scenes.MenuScene();
	}

	public static function main() {
        new Main();
    }

}
