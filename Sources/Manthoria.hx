package;

import kha.Framebuffer;
import kha.Scheduler;
import kha.System;
import kha.Image;
import kha.Color;
import kha.Scaler;
import config.Config;
import scenes.IScene;
import scenes.GameplayScreen;

class Manthoria {

	public static inline var WIDTH = 960;
	public static inline var HEIGHT = 480;
	public static var config:Config;

	private var backbuffer: Image;
	private var scene: IScene;

	public function new() {
		System.notifyOnRender(render);
		Scheduler.addTimeTask(update, 0, 1 / 60);

		config = new Config();

		backbuffer = Image.createRenderTarget(WIDTH, HEIGHT);
		scene = new GameplayScreen();
	}

	private function renderBackbuffer() {
		backbuffer.g2.begin(Color.White);
		scene.render(backbuffer.g2);

		backbuffer.g2.end();
	}

	function update() {
		scene.update();
	}

	function render(framebuffer: Framebuffer) {
		renderBackbuffer();

		framebuffer.g2.begin();
		Scaler.scale(backbuffer, framebuffer, System.screenRotation);
		framebuffer.g2.end();
	}
}
