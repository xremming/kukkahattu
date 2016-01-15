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

    private var acc:Float = 64;
    private var maxAcc:Float = 128;
    private var friction:Float = 0.9;
    private var accX:Float = 0;
    private var accY:Float = 0;

    public override function update()
    {
        if (Input.check(Key.W)) {
            accY -= acc * HXP.elapsed;
        }
        if (Input.check(Key.D)) {
            accX += acc * HXP.elapsed;
        }
        if (Input.check(Key.S)) {
            accY += acc * HXP.elapsed;
        }
        if (Input.check(Key.A)) {
            accX -= acc * HXP.elapsed;
        }

        if (accX > maxAcc * HXP.elapsed)
            accX = maxAcc * HXP.elapsed;
        if (accX < -maxAcc * HXP.elapsed)
            accX = -maxAcc * HXP.elapsed;
        if (accY > maxAcc * HXP.elapsed)
            accY = maxAcc * HXP.elapsed;
        if (accY < -maxAcc * HXP.elapsed)
            accY = -maxAcc * HXP.elapsed;

        accX *= friction;
        accY *= friction;

        moveBy(accX, accY);

        super.update();
    }
}
