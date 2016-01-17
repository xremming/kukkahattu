import com.haxepunk.Engine;
import com.haxepunk.HXP;
import com.haxepunk.utils.Key;
import com.haxepunk.utils.Input;
import com.haxepunk.Sfx;

class Main extends Engine
{

	public override function init()
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

    public override function update()
    {
    	if (Input.released(Key.M)) {
    		if (HXP.volume > 0)
    			HXP.volume = 0;
    		else
    			HXP.volume = 1;
    	}
    	super.update();
    }

}
