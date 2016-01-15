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

        sprite = new Spritemap("graphics/hahmo.png", 64, 64);

        sprite.add("walk_horiz", [0, 1, 2, 1], 6);
        sprite.add("walk_down", [3, 4], 6);
        sprite.add("walk_up", [6, 7], 6);

        sprite.play("walk_down");

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

        if (Math.abs(accY) > Math.abs(accX)) {
            sprite.flipped = false;
            if (accY > 0) {
                sprite.play("walk_down");
            } else {
                sprite.play("walk_up");
            }
        } else {
            sprite.play("walk_horiz");
            if (accX > 0) {
                sprite.flipped = false;
            } else {
                sprite.flipped = true;
            }
        }

        super.update();
    }
}
