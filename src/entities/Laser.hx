package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;

class Laser extends Entity
{
	private var dir:Int;
    private var accX:Float;
    private var accY:Float;

    public function new(dir:Int, x:Float, y:Float, accX:Float, accY:Float)
    {
        super(x, y);

        this.accX = accX;
        this.accY = accY;

        this.dir = dir;

        var width:Int = 0;
        var height:Int = 0;

        if (dir == 0 || dir == 2) {
        	width = 4;
        	height = 8;
        } else if (dir == 1 || dir == 3) {
        	width = 8;
        	height = 4;
        }

        graphic = Image.createRect(width, height, 0xff0000);
        setHitbox(width, height);
        type = "laser";
    }

    private var speed:Float = 350;

    public override function update()
    {
    	switch (dir) {
    		case 0:
    			moveBy(accX, accY - (speed * HXP.elapsed));
    		case 1:
    			moveBy(accX + (speed * HXP.elapsed), accY);
    		case 2:
    			moveBy(accX, accY + (speed * HXP.elapsed));
    		case 3:
                moveBy(accX - (speed * HXP.elapsed), accY);
    	}

    	if (x > HXP.width || y > HXP.height || x < -width || y < -height)
    		HXP.scene.remove(this);
    }
}
