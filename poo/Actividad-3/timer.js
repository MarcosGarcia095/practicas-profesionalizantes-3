function tick() {
	self.postMessage("tick");
	setTimeout(tick, 900);
}
tick();