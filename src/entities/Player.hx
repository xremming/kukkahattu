package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.HXP;
import com.haxepunk.Sfx;

import entities.Laser;

class Player extends Entity
{
    private var sprite:Spritemap;

    public function new(x:Float, y:Float)
    {
        super(x, y);

        sprite = new Spritemap("graphics/player.png", 24, 52);

        sprite.add("walk_horiz", [0, 1, 2, 1], 6);
        sprite.add("walk_down", [3, 4], 6);
        sprite.add("walk_up", [6, 7], 6);
        sprite.add("walk_stop", [5], 6);

        sprite.add("shoot_horiz", [1]);
        sprite.add("shoot_up", [8]);
        sprite.add("shoot_down", [5]);

        sprite.play("walk_stop");

        graphic = sprite;

        setHitbox(12, 36, -6, -4);

        type = "player";
    }

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
            accY -= KH.acc * HXP.elapsed;
        if (cRight)
            accX += KH.acc * HXP.elapsed;
        if (cDown)
            accY += KH.acc * HXP.elapsed;
        if (cLeft)
            accX -= KH.acc * HXP.elapsed;

        // Clamp to max acceleration
        accX = HXP.clamp(accX, -KH.maxAcc * HXP.elapsed, KH.maxAcc * HXP.elapsed);
        accY = HXP.clamp(accY, -KH.maxAcc * HXP.elapsed, KH.maxAcc * HXP.elapsed);

        // Move player
        moveBy(accX, accY);

        // Apply friction
        accX *= KH.friction;
        accY *= KH.friction;

        // Clamp to screen
        x = HXP.clamp(x, 0, HXP.width - width);
        y = HXP.clamp(y, 0, HXP.height - height);
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

    private var canShoot:Bool = true;
    private var sinceShoot:Float = 0;
    private var shootSounds = [new Sfx("audio/laser0.ogg"),
                               new Sfx("audio/laser1.ogg"),
                               new Sfx("audio/laser2.ogg")];
    private var xOffset = [10, 14, 10, 4];
    private var yOffset = [-8, 6, 8, 6];

    private function shoot()
    {
        if (canShoot) {
            if (sDirection >= 0 && sDirection <= 3) {
                HXP.scene.add(new Laser(sDirection, x+xOffset[sDirection], y+yOffset[sDirection], accX, accY));
                canShoot = false;
                KH.play(HXP.choose(shootSounds));
            }
        } else {
            if (sinceShoot >= 1 / KH.playerFireRate) {
                sinceShoot = 0;
                canShoot = true;
            } else {
                sinceShoot += HXP.elapsed;
            }
        }
    }
}
