package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.HXP;

class Player extends Entity
{
    private var sprite:Spritemap;

    public function new(x:Int, y:Int)
    {
        super(x, y);

        sprite = new Spritemap("graphics/hahmo.png", 32, 32);

        sprite.add("walk", [0, 1, 2], 8);

        sprite.play("walk");

        graphic = sprite;
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

        accX = Math.min(accX, maxAcc * HXP.elapsed);
        accX = Math.max(accX, -maxAcc * HXP.elapsed);
        accY = Math.min(accY, maxAcc * HXP.elapsed);
        accY = Math.max(accY, -maxAcc * HXP.elapsed);

        accX *= friction;
        accY *= friction;

        moveBy(accX, accY);

        if (accX > 0) {
            sprite.flipped = false;
        } else {
            sprite.flipped = true;
        }

        super.update();
    }
}
