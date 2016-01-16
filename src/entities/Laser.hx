package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;

class Laser extends Entity
{
	private var dir:Int;

    public function new(dir:Int, x:Float, y:Float)
    {
        super(x, y);

        this.dir = dir;

        var width:Int = 0;
        var height:Int = 0;

        if (dir == 0 || dir == 2) {
        	width = 2;
        	height = 6;
        } else if (dir == 1 || dir == 3) {
        	width = 6;
        	height = 2;
        }

        graphic = Image.createRect(width, height, 0xff0000);
        setHitbox(width, height);
        type = "laser";
    }

    private var speed:Float = 256;

    public override function update()
    {
    	switch (dir) {
    		case 0:
    			moveBy(0, -speed * HXP.elapsed);
    		case 1:
    			moveBy(speed * HXP.elapsed, 0);
    		case 2:
    			moveBy(0, speed * HXP.elapsed);
    		case 3:
    			moveBy(-speed * HXP.elapsed, 0);
    	}

    	if (x > HXP.width || y > HXP.height || x < -width || y < -height)
    		HXP.scene.remove(this);
    }
}
