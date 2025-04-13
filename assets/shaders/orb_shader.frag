#version 460 core

#include "common/common.glsl"
#include <flutter/runtime_effect.glsl>

uniform vec2 uResolution;
uniform float uTime;
uniform vec4 uColor;
uniform vec2 uMouse;

out vec4 oColor;

// Based on a circular glow effect with mouse interaction
float distanceToMouse(vec2 pos) {
  return length(pos - uMouse / uResolution);
}

float glow(float dist, float radius, float intensity) {
  return pow(radius / max(dist, 0.01), intensity);
}

void main() {
  // Normalized pixel coordinates (0.0 to 1.0)
  vec2 uv = vec2(FlutterFragCoord().xy) / uResolution;
  vec2 center = vec2(0.5, 0.5);

  // Base colors
  vec4 baseColor = uColor;

  // Distance from pixel to center and mouse
  float distToCenter = length(uv - center);
  float distToMouse = distanceToMouse(uv);

  // Create a pulsing effect based on time
  float pulseSpeed = 0.6;
  float pulseSize = 0.05 * sin(uTime * pulseSpeed) + 0.1;

  // Core orb
  float core = smoothstep(0.2, 0.19, distToCenter);

  // Outer glow
  float outerGlow = glow(distToCenter, 0.15, 1.5);
  outerGlow *= 1.0 + 0.5 * sin(uTime * 0.8);

  // Mouse interaction glow
  float mouseGlow = glow(distToMouse, 0.3, 1.2);
  mouseGlow *= 0.6;

  // Combine all effects
  float finalGlow = outerGlow + mouseGlow;
  finalGlow = min(finalGlow, 2.0); // Clamp glow intensity

  // Create subtle color variations based on position and time
  vec4 glowColor = mix(
    baseColor,
    vec4(baseColor.rgb * vec3(1.0, 0.8, 0.6), baseColor.a),
    sin(uTime * 0.2 + uv.x * 3.14) * 0.5 + 0.5
  );

  // Apply ripple effect
  float ripple = sin(20.0 * distToCenter - uTime * 1.5) * 0.05;
  float rippleMask = smoothstep(0.5, 0.0, distToCenter);
  finalGlow += ripple * rippleMask;

  // Final composition
  oColor = glowColor * finalGlow + core * glowColor * 2.0;
  oColor.a = min(oColor.a, 1.0); // Ensure alpha doesn't exceed 1.0
}