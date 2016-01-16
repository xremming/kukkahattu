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
        sprite.add("walk_stop", [5], 6);

        sprite.play("walk_stop");

        graphic = sprite;

        setHitbox(34, 52, 8, 6);

        type = "player";
    }

    private var acc:Float = 64;
    private var maxAcc:Float = 128;
    private var friction:Float = 0.9;
    private var accX:Float = 0;
    private var accY:Float = 0;

    public override function update()
    {
        checkInput();

        move();

        setAnimations();

        shoot();
    }

    private var cUp:Bool = false;
    private var cRight:Bool = false;
    private var cDown:Bool = false;
    private var cLeft:Bool = false;
    private var cShoot:Bool = false;

    private function checkInput()
    {
        cUp = false;
        cRight = false;
        cDown = false;
        cLeft = false;
        cShoot = false;

        if (Input.check(Key.W))
            cUp = true;
        if (Input.check(Key.D))
            cRight = true;
        if (Input.check(Key.S))
            cDown = true;
        if (Input.check(Key.A))
            cLeft = true;
        if (Input.check(Key.SPACE))
            cShoot = true;
    }

    private function move()
    {
        if (cUp)
            accY -= acc * HXP.elapsed;
        if (cRight)
            accX += acc * HXP.elapsed;
        if (cDown)
            accY += acc * HXP.elapsed;
        if (cLeft)
            accX -= acc * HXP.elapsed;

        accX = Math.min(accX, maxAcc * HXP.elapsed);
        accX = Math.max(accX, -maxAcc * HXP.elapsed);
        accY = Math.min(accY, maxAcc * HXP.elapsed);
        accY = Math.max(accY, -maxAcc * HXP.elapsed);

        accX *= friction;
        accY *= friction;

        moveBy(accX, accY);
    }

    private function setAnimations()
    {
        if (Math.round(accX) == 0 && Math.round(accY) == 0)
            sprite.play("walk_stop");
        else if (cLeft) {
            sprite.flipped = true;
            sprite.play("walk_horiz");
        } else if (cRight) {
            sprite.flipped = false;
            sprite.play("walk_horiz");
        } else if (cDown)
            sprite.play("walk_down");
        else if (cUp)
            sprite.play("walk_up");
    }

    private function shoot()
    {
        if (cShoot) {
            if (cRight)
                HXP.scene.add(new Laser(1, x, y));
            else if (cLeft)
                HXP.scene.add(new Laser(3, x, y));
            else if (cDown)
                HXP.scene.add(new Laser(2, x, y));
            else if (cUp)
                HXP.scene.add(new Laser(0, x, y));
        }
    }
}
