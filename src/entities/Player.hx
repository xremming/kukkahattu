package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.HXP;

class Player extends Entity
{
    public function new(x:Int, y:Int)
    {
        super(x, y);

        graphic = new Image("graphics/block.png");
    }

    private var accX:Float = 0;
    private var accY:Float = 0;
    private var jumping:Bool = false;
    private static var maxAccX:Float = 2;
    private static var maxAccY:Float = 5;

    public override function update()
    {
        if (Input.check(Key.W) || Input.check(Key.SPACE)) {
            accY -= 20;
            jumping = true;
        }
        if (Input.check(Key.D)) {
            accX += 2;
        }
        if (Input.check(Key.A)) {
            accX -= 2;
        }
        
        accY += 9.8;
        accX *= 0.9;

        if (accX > maxAccX) {
            accX = maxAccX;
        }
        if (accX < -maxAccX) {
            accX = -maxAccX;
        }

        moveBy(accX, accY);

        if (y > HXP.windowHeight) {
            accY = 0;
            y = HXP.windowHeight;
        }

        super.update();
    }
}
