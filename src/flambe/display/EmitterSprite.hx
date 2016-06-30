//
// Flambe - Rapid game development
// https://github.com/aduros/flambe/blob/master/LICENSE.txt

package flambe.display;

import flambe.animation.AnimatedFloat;
import flambe.display.EmitterMold;
import flambe.math.FMath;

using flambe.util.Arrays;

/**
 * A sprite that displays a particle system.
 */
class EmitterSprite extends Sprite
{
	/** The particle texture, must be square. */
	public var texture :Texture;

	/** The current number of particles being shown. */
	public var numParticles (default, null) :Int = 0;

	public var maxParticles (get, set) :Int;

	public var type :EmitterType;

	/** How long the emitter should remain enabled, or <= 0 to never expire. */
	public var duration :Float;

	/** Whether new particles are being actively emitted. */
	public var enabled :Bool = true;

	public var emitX (default, null) :AnimatedFloat;
	public var emitXVariance (default, null) :AnimatedFloat;

	public var emitY (default, null) :AnimatedFloat;
	public var emitYVariance (default, null) :AnimatedFloat;

	public var startColorAlpha (default, null) :AnimatedFloat;
	public var startColorRed (default, null) :AnimatedFloat;
	public var startColorGreen (default, null) :AnimatedFloat;
	public var startColorBlue (default, null) :AnimatedFloat;

	public var startColorVarianceAlpha (default, null) :AnimatedFloat;
	public var startColorVarianceRed (default, null) :AnimatedFloat;
	public var startColorVarianceGreen (default, null) :AnimatedFloat;
	public var startColorVarianceBlue (default, null) :AnimatedFloat;

	public var finishColorAlpha (default, null) :AnimatedFloat;
	public var finishColorRed (default, null) :AnimatedFloat;
	public var finishColorGreen (default, null) :AnimatedFloat;
	public var finishColorBlue (default, null) :AnimatedFloat;
	
	public var finishColorVarianceAlpha (default, null) :AnimatedFloat;
	public var finishColorVarianceRed (default, null) :AnimatedFloat;
	public var finishColorVarianceGreen (default, null) :AnimatedFloat;
	public var finishColorVarianceBlue (default, null) :AnimatedFloat;

	public var angle (default, null) :AnimatedFloat;
	public var angleVariance (default, null) :AnimatedFloat;

	public var gravityX (default, null) :AnimatedFloat;
	public var gravityY (default, null) :AnimatedFloat;

	public var maxRadius (default, null) :AnimatedFloat;
	public var maxRadiusVariance (default, null) :AnimatedFloat;

	public var minRadius (default, null) :AnimatedFloat;

	public var lifespanVariance (default, null) :AnimatedFloat;
	public var lifespan (default, null) :AnimatedFloat;

	public var rotatePerSecond (default, null) :AnimatedFloat;
	public var rotatePerSecondVariance (default, null) :AnimatedFloat;

	public var rotationStart (default, null) :AnimatedFloat;
	public var rotationStartVariance (default, null) :AnimatedFloat;

	public var rotationEnd (default, null) :AnimatedFloat;
	public var rotationEndVariance (default, null) :AnimatedFloat;

	public var sizeStart (default, null) :AnimatedFloat;
	public var sizeStartVariance (default, null) :AnimatedFloat;

	public var sizeEnd (default, null) :AnimatedFloat;
	public var sizeEndVariance (default, null) :AnimatedFloat;

	public var speed (default, null) :AnimatedFloat;
	public var speedVariance (default, null) :AnimatedFloat;

	public var radialAccel (default, null) :AnimatedFloat;
	public var radialAccelVariance (default, null) :AnimatedFloat;

	public var tangentialAccel (default, null) :AnimatedFloat;
	public var tangentialAccelVariance (default, null) :AnimatedFloat;

	public function new (mold :EmitterMold)
	{
		super();

		texture = mold.texture;
		blendMode = mold.blendMode;
		type = mold.type;
		pipeline = flambe.platform.kha.KhaPipeline.imagePipeline;

		startColorAlpha = new AnimatedFloat(mold.startColorAlpha);
		startColorRed = new AnimatedFloat(mold.startColorRed);
		startColorGreen = new AnimatedFloat(mold.startColorGreen);
		startColorBlue = new AnimatedFloat(mold.startColorBlue);

		startColorVarianceAlpha = new AnimatedFloat(mold.startColorVarianceAlpha);
		startColorVarianceRed = new AnimatedFloat(mold.startColorVarianceRed);
		startColorVarianceGreen = new AnimatedFloat(mold.startColorVarianceGreen);
		startColorVarianceBlue = new AnimatedFloat(mold.startColorVarianceBlue);

		finishColorAlpha = new AnimatedFloat(mold.finishColorAlpha);
		finishColorRed = new AnimatedFloat(mold.finishColorRed);
		finishColorGreen = new AnimatedFloat(mold.finishColorGreen);
		finishColorBlue = new AnimatedFloat(mold.finishColorBlue);

		finishColorVarianceAlpha = new AnimatedFloat(mold.finishColorVarianceAlpha);
		finishColorVarianceRed = new AnimatedFloat(mold.finishColorVarianceRed);
		finishColorVarianceGreen = new AnimatedFloat(mold.finishColorVarianceGreen);
		finishColorVarianceBlue = new AnimatedFloat(mold.finishColorVarianceBlue);

		angle = new AnimatedFloat(mold.angle);
		angleVariance = new AnimatedFloat(mold.angleVariance);
		duration = mold.duration;
		emitXVariance = new AnimatedFloat(mold.emitXVariance);
		emitYVariance = new AnimatedFloat(mold.emitYVariance);
		gravityX = new AnimatedFloat(mold.gravityX);
		gravityY = new AnimatedFloat(mold.gravityY);
		maxRadius = new AnimatedFloat(mold.maxRadius);
		maxRadiusVariance = new AnimatedFloat(mold.maxRadiusVariance);
		minRadius = new AnimatedFloat(mold.minRadius);
		lifespan = new AnimatedFloat(mold.lifespan);
		lifespanVariance = new AnimatedFloat(mold.lifespanVariance);
		radialAccel = new AnimatedFloat(mold.radialAccel);
		radialAccelVariance = new AnimatedFloat(mold.radialAccelVariance);
		rotatePerSecond = new AnimatedFloat(mold.rotatePerSecond);
		rotatePerSecondVariance = new AnimatedFloat(mold.rotatePerSecondVariance);
		rotationEnd = new AnimatedFloat(mold.rotationEnd);
		rotationEndVariance = new AnimatedFloat(mold.rotationEndVariance);
		rotationStart = new AnimatedFloat(mold.rotationStart);
		rotationStartVariance = new AnimatedFloat(mold.rotationStartVariance);
		sizeEnd = new AnimatedFloat(mold.sizeEnd);
		sizeEndVariance = new AnimatedFloat(mold.sizeEndVariance);
		sizeStart = new AnimatedFloat(mold.sizeStart);
		sizeStartVariance = new AnimatedFloat(mold.sizeStartVariance);
		speed = new AnimatedFloat(mold.speed);
		speedVariance = new AnimatedFloat(mold.speedVariance);
		tangentialAccel = new AnimatedFloat(mold.tangentialAccel);
		tangentialAccelVariance = new AnimatedFloat(mold.tangentialAccelVariance);

		emitX = new AnimatedFloat(0);
		emitY = new AnimatedFloat(0);

		_particles = Arrays.create(mold.maxParticles);
		var ii = 0, ll = _particles.length;
		while (ii < ll) {
			_particles[ii] = new Particle();
			++ii;
		}
	}

	public function restart ()
	{
		enabled = true;
		_totalElapsed = 0;
	}

	override public function onUpdate (dt :Float)
	{
		super.onUpdate(dt);

		startColorAlpha.update(dt);
		startColorRed.update(dt);
		startColorGreen.update(dt);
		startColorBlue.update(dt);

		startColorVarianceAlpha.update(dt);
		startColorVarianceRed.update(dt);
		startColorVarianceGreen.update(dt);
		startColorVarianceBlue.update(dt);

		finishColorAlpha.update(dt);
		finishColorRed.update(dt);
		finishColorGreen.update(dt);
		finishColorBlue.update(dt);

		finishColorVarianceAlpha.update(dt);
		finishColorVarianceRed.update(dt);
		finishColorVarianceGreen.update(dt);
		finishColorVarianceBlue.update(dt);

		angle.update(dt);
		angleVariance.update(dt);
		emitX.update(dt);
		emitXVariance.update(dt);
		emitY.update(dt);
		emitYVariance.update(dt);
		gravityX.update(dt);
		gravityY.update(dt);
		lifespan.update(dt);
		lifespanVariance.update(dt);
		maxRadius.update(dt);
		maxRadiusVariance.update(dt);
		minRadius.update(dt);
		radialAccel.update(dt);
		radialAccelVariance.update(dt);
		rotatePerSecond.update(dt);
		rotatePerSecondVariance.update(dt);
		rotationEnd.update(dt);
		rotationEndVariance.update(dt);
		rotationStart.update(dt);
		rotationStartVariance.update(dt);
		sizeEnd.update(dt);
		sizeEndVariance.update(dt);
		sizeStart.update(dt);
		sizeStartVariance.update(dt);
		speed.update(dt);
		speedVariance.update(dt);
		tangentialAccel.update(dt);
		tangentialAccelVariance.update(dt);

		// Update existing particles
		var gravityType = (type == Gravity);
		var ii = 0;
		while (ii < numParticles) {
			var particle = _particles[ii];
			if (particle.life > dt) {
				if (gravityType) {
					particle.x += particle.velX * dt;
					particle.y += particle.velY * dt;

					var accelX = gravityX._;
					var accelY = -gravityY._;

					if (particle.radialAccel != 0 || particle.tangentialAccel != 0) {
						var dx = particle.x - particle.emitX;
						var dy = particle.y - particle.emitY;
						var distance = Math.sqrt(dx*dx + dy*dy);

						// Apply radial force
						var radialX = dx / distance;
						var radialY = dy / distance;
						accelX += radialX * particle.radialAccel;
						accelY += radialY * particle.radialAccel;

						// Apply tangential force
						var tangentialX = -radialY;
						var tangentialY = radialX;
						accelX += tangentialX * particle.tangentialAccel;
						accelY += tangentialY * particle.tangentialAccel;
					}

					particle.velX += accelX * dt;
					particle.velY += accelY * dt;

				} else {
					particle.radialRotation += particle.velRadialRotation * dt;
					particle.radialRadius += particle.velRadialRadius * dt;

					var radius = particle.radialRadius;
					particle.x = emitX._ - Math.cos(particle.radialRotation) * radius;
					particle.y = emitY._ - Math.sin(particle.radialRotation) * radius;

					if (radius < minRadius._) {
						particle.life = 0; // Kill it
					}
				}

				particle.scale += particle.velScale * dt;
				particle.rotation += particle.velRotation * dt;
				particle.alpha += particle.velAlpha * dt;
				particle.red += particle.velRed * dt;
				particle.green += particle.velGreen * dt;
				particle.blue += particle.velBlue * dt;

				particle.life -= dt;
				++ii;

			} else {
				// Kill it, and swap it with the last living particle, so that alive particles are
				// packed to the front of the pool
				--numParticles;
				if (ii != numParticles) {
					_particles[ii] = _particles[numParticles];
					_particles[numParticles] = particle;
				}
			}
		}

		// Check whether we should continue to the emit step
		if (!enabled) {
			return;
		}
		if (duration > 0) {
			_totalElapsed += dt;
			if (_totalElapsed >= duration) {
				enabled = false;
				return;
			}
		}

		// Emit new particles
		var emitDelay = lifespan._ / _particles.length;
		_emitElapsed += dt;
		while (_emitElapsed >= emitDelay) {
			if (numParticles < _particles.length) {
				var particle = _particles[numParticles];
				if (initParticle(particle)) {
					++numParticles;
				}
			}
			_emitElapsed -= emitDelay;
		}
	}

	override public function draw (g :Graphics)
	{
		// Assumes that the texture is always square
		var offset = -texture.width/2;

		var ii = 0, ll = numParticles;
		while (ii < ll) {
			var particle = _particles[ii];
			g.save();
			g.translate(particle.x, particle.y);
			if (particle.alpha < 1) {
				g.multiplyAlpha(particle.alpha);
			}
			if (particle.rotation != 0) {
				g.rotate(particle.rotation);
			}
			if (particle.scale != 1) {
				g.scale(particle.scale, particle.scale);
			}

			var color = kha.Color.fromFloats(particle.red, particle.green, particle.blue, 1);

			g.drawTexture(texture, offset, offset, color);
			g.restore();

			++ii;
		}
	}

	private function initParticle (particle :Particle) :Bool
	{
		particle.life = random(lifespan._, lifespanVariance._);
		if (particle.life <= 0) {
			return false; // Dead on arrival
		}

		// Don't include the variance here
		particle.emitX = emitX._;
		particle.emitY = emitY._;

		var angle = -FMath.toRadians(random(angle._, angleVariance._));
		var speed = random(speed._, speedVariance._);
		particle.velX = speed * Math.cos(angle);
		particle.velY = speed * Math.sin(angle);

		particle.radialAccel = random(radialAccel._, radialAccelVariance._);
		particle.tangentialAccel = random(tangentialAccel._, tangentialAccelVariance._);

		particle.radialRadius = random(maxRadius._, maxRadiusVariance._);
		particle.velRadialRadius = -particle.radialRadius / particle.life;
		particle.radialRotation = angle;
		particle.velRadialRotation = FMath.toRadians(random(rotatePerSecond._, rotatePerSecondVariance._));

		if (type == Gravity) {
			particle.x = random(emitX._, emitXVariance._);
			particle.y = random(emitY._, emitYVariance._);

		} else { // type == Radial
			var radius = particle.radialRadius;
			particle.x = emitX._ - Math.cos(particle.radialRotation) * radius;
			particle.y = emitY._ - Math.sin(particle.radialRotation) * radius;
		}

		// Assumes that the texture is always square
		var width = texture.width;
		var scaleStart = random(sizeStart._, sizeStartVariance._) / width;
		var scaleEnd = random(sizeEnd._, sizeEndVariance._) / width;
		particle.scale = scaleStart;
		particle.velScale = (scaleEnd-scaleStart) / particle.life;

		var rotationStart = random(rotationStart._, rotationStartVariance._);
		var rotationEnd = random(rotationEnd._, rotationEndVariance._);
		particle.rotation = rotationStart;
		particle.velRotation = (rotationEnd-rotationStart) / particle.life;

		var alphaStart = random(startColorAlpha._, startColorVarianceAlpha._);
		var alphaEnd = random(finishColorAlpha._, finishColorVarianceAlpha._);
		particle.alpha = alphaStart;
		particle.velAlpha = (alphaEnd-alphaStart) / particle.life;

		var redStart = random(startColorRed._, startColorVarianceRed._);
		var redEnd = random(finishColorRed._, finishColorVarianceRed._);
		particle.red = redStart;
		particle.velRed = (redEnd-redStart) / particle.life;

		var greenStart = random(startColorGreen._, startColorVarianceGreen._);
		var greenEnd = random(finishColorGreen._, finishColorVarianceGreen._);
		particle.green = greenStart;
		particle.velGreen = (greenEnd-greenStart) / particle.life;

		var blueStart = random(startColorBlue._, startColorVarianceBlue._);
		var blueEnd = random(finishColorBlue._, finishColorVarianceBlue._);
		particle.blue = blueStart;
		particle.velBlue = (blueEnd-blueStart) / particle.life;

		return true;
	}

	inline private function get_maxParticles () :Int
	{
		return _particles.length;
	}

	private function set_maxParticles (maxParticles :Int) :Int
	{
		// Grow the pool
		var oldLength = _particles.length;
		_particles.resize(maxParticles);
		while (oldLength < maxParticles) {
			_particles[oldLength] = new Particle();
			++oldLength;
		}

		if (numParticles > maxParticles) {
			numParticles = maxParticles;
		}

		return maxParticles;
	}

	private static function random (base :Float, variance :Float)
	{
		if (variance != 0) {
			base += variance * (2*Math.random()-1);
		}
		return base;
	}

	// The particle pool
	private var _particles :Array<Particle>;

	// Time passed since the last emission
	private var _emitElapsed :Float = 0;

	private var _totalElapsed :Float = 0;
}

private class Particle
{
	// Where the emitter was when the particle was spawned
	public var emitX :Float = 0;
	public var emitY :Float = 0;

	public var x :Float = 0;
	public var velX :Float = 0;

	public var y :Float = 0;
	public var velY :Float = 0;

	public var radialRadius :Float = 0;
	public var velRadialRadius :Float = 0;

	public var radialRotation :Float = 0;
	public var velRadialRotation :Float = 0;

	public var radialAccel :Float = 0;
	public var tangentialAccel :Float = 0;

	public var scale :Float = 0;
	public var velScale :Float = 0;

	public var rotation :Float = 0;
	public var velRotation :Float = 0;

	public var alpha :Float = 0;
	public var velAlpha :Float = 0;

	public var red :Float = 0;
	public var velRed :Float = 0;

	public var green :Float = 0;
	public var velGreen :Float = 0;

	public var blue :Float = 0;
	public var velBlue :Float = 0;

	public var life :Float = 0;

	public function new () {}
}
