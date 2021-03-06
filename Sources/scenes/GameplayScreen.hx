package scenes;

import kha.Assets;
import kha.graphics2.Graphics;
import mankha.gfx.AnimatedSprite;
import mankha.input.InputHandler;
import mankha.utils.Rectangle;

class GameplayScreen implements IScene {

	private static inline var totalAssetsToLoad = 1;
	private var assetsLoaded = 0;

	private var playerSprite: AnimatedSprite;
	private var inputHandler: InputHandler;

	private var playerSpeed:Float;
	private var deltaTime:Float;
	private var totalTime:Float;

	public function new() {
		inputHandler = new InputHandler();
		
		load();
	}

	function load() {
		Assets.loadImageFromPath("img/sprites/base.png", false, function(image) {
			var sprW = 24;
			var sprH = 32;
			
			playerSprite = new AnimatedSprite(image, sprW, sprH);
			playerSprite.animationRate = Manthoria.config.playerAnimationSpeed;
			playerSpeed = Manthoria.config.playerMovementSpeed;

			playerSprite.framesDown = [
				new Rectangle(0, 0, sprW, sprH),
				new Rectangle(sprW, 0, sprW, sprH),
				new Rectangle(0, 0, sprW, sprH),
				new Rectangle(sprW * 2, 0, sprW, sprH)
			];

			playerSprite.framesUp = [
				new Rectangle(0, sprH, sprW, sprH),
				new Rectangle(sprW, sprH, sprW, sprH),
				new Rectangle(0, sprH, sprW, sprH),
				new Rectangle(sprW * 2, sprH, sprW, sprH)
			];

			playerSprite.framesRight = [
				new Rectangle(0, sprH * 2, sprW, sprH),
				new Rectangle(sprW, sprH * 2, sprW, sprH),
				new Rectangle(0, sprH * 2, sprW, sprH),
				new Rectangle(sprW * 2, sprH * 2, sprW, sprH)
			];

			playerSprite.framesLeft = [
				new Rectangle(0, sprH * 3, sprW, sprH),
				new Rectangle(sprW, sprH * 3, sprW, sprH),
				new Rectangle(0, sprH * 3, sprW, sprH),
				new Rectangle(sprW * 2, sprH * 3, sprW, sprH)
			];

			doneLoading();
		});
	}

	function doneLoading() {
		assetsLoaded++;
	}

	public function render(g2:Graphics) {
		if (assetsLoaded != totalAssetsToLoad) {
			return;
		}

		playerSprite.draw(g2);
	}

	public function update() {
		if (assetsLoaded != totalAssetsToLoad) {
			return;
		}

		playerSprite.velocity.x = 0;
		playerSprite.velocity.y = 0;

		deltaTime = kha.Scheduler.time() - totalTime;
		totalTime = kha.Scheduler.time();

		if (inputHandler.up) {
			playerSprite.velocity.y -= 10;
			playerSprite.changeDirection(Direction.UP);
		} else if (inputHandler.down) {
			playerSprite.velocity.y += 10;
			playerSprite.changeDirection(Direction.DOWN);
		}

		if(inputHandler.left) {
			playerSprite.velocity.x -= 10;
			playerSprite.changeDirection(Direction.LEFT);
		} else if (inputHandler.right) {
			playerSprite.velocity.x += 10;
			playerSprite.changeDirection(Direction.RIGHT);
		}

		playerSprite.velocity.normalize();

		playerSprite.position.x += playerSprite.velocity.x * deltaTime * playerSpeed;
		playerSprite.position.y += playerSprite.velocity.y * deltaTime * playerSpeed;

		if (playerSprite.position.x < 0) {
			playerSprite.position.x = 0;
		} else if ((playerSprite.position.x +playerSprite.frameW) > Manthoria.WIDTH) {
			playerSprite.position.x = Manthoria.WIDTH - playerSprite.frameW;
		}

		if(playerSprite.position.y < 0) {
			playerSprite.position.y = 0;
		} else if ((playerSprite.position.y + playerSprite.frameH) > Manthoria.HEIGHT) {
			playerSprite.position.y = Manthoria.HEIGHT - playerSprite.frameH;
		}
	}
}