package;

import kha.System;

class Main {
	public static function main() {
		var initializer = {
			title: "Manthoria", 
			width: Manthoria.WIDTH, 
			height: Manthoria.HEIGHT
		};
		
		System.init(initializer, function () {
			new Manthoria();
		});
	}
}
