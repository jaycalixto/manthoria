package config;

class Config {

	public var playerAnimationSpeed(default, null) : Float;
	public var playerMovementSpeed(default, null) : Float;

	public function new() {
		playerAnimationSpeed = 0.2;
		playerMovementSpeed = 180;
	}
}