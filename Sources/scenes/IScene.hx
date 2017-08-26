package scenes;

import kha.graphics2.Graphics;

interface IScene {
	public function update(): Void;
	public function render(g2: Graphics): Void;
}