package;

import kha.Framebuffer;
import kha.Scheduler;
import kha.System;

class Manthoria {

	public static inline var WIDTH = 960;
	public static inline var HEIGHT = 480;

	public function new() {
		System.notifyOnRender(render);
		Scheduler.addTimeTask(update, 0, 1 / 60);
	}

	function update(): Void {
		
	}

	function render(framebuffer: Framebuffer): Void {		
	}
}
