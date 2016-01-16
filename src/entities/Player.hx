package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.HXP;

import entities.Laser;

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

        sprite.add("shoot_horiz", [1]);
        sprite.add("shoot_up", [8]);
        sprite.add("shoot_down", [5]);

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

    private var sDirection:Int = -1;

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

        sDirection = -1;

        if (Input.check(Key.UP))
            sDirection = 0;
        if (Input.check(Key.RIGHT))
            sDirection = 1;
        if (Input.check(Key.DOWN))
            sDirection = 2;
        if (Input.check(Key.LEFT))
            sDirection = 3;
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
        var notMoving:Bool = false;
        if (Math.round(accX) == 0 && Math.round(accY) == 0)
            notMoving = true;

        if (sDirection != -1) {
            if (notMoving) {
                switch (sDirection) {
                    case 0:
                        sprite.play("shoot_up");
                    case 1:
                        sprite.flipped = false;
                        sprite.play("shoot_horiz");
                    case 2:
                        sprite.play("shoot_down");
                    case 3:
                        sprite.flipped = true;
                        sprite.play("shoot_horiz");
                }
            } else {
                switch (sDirection) {
                    case 0:
                        sprite.play("walk_up");
                    case 1:
                        sprite.flipped = false;
                        sprite.play("walk_horiz");
                    case 2:
                        sprite.play("walk_down");
                    case 3:
                        sprite.flipped = true;
                        sprite.play("walk_horiz");
                }
            }
        } else {
            if (notMoving)
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
    }

    private function shoot()
    {
        switch (sDirection) {
            case 0:
                HXP.scene.add(new Laser(sDirection, x, y));
            case 1:
                HXP.scene.add(new Laser(sDirection, x, y));
            case 2:
                HXP.scene.add(new Laser(sDirection, x, y));
            case 3:
                HXP.scene.add(new Laser(sDirection, x, y));
        }
    }
}
