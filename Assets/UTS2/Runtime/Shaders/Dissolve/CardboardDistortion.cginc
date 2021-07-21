// Copyright 2015 Google Inc. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.


// To use in a surface shader, add the following text to the code:
//
// #pragma surface ... vertex:vert         <-- add "vertex:vert" to this line
// #include "CardboardDistortion.cginc"    <-- copy the next 4 lines
// void vert (inout appdata_base v) {
//   v.vertex = undistortSurface(v.vertex);
// }

// To use in a vertex shader, modify it as follows:
//
// #include "CardboardDistortion.cginc"  <-- add this
//
// v2f vert (appdata_blah v) {
//   v2f o;
//   o.vertex = undistortVertex(v.vertex);    <-- replace "mul(UNITY_MATRIX_MVP, v.vertex)"
//   ...
//   return o;
// }

float	  _UnDistortOffset;
float     _MaxRadSq;

float4    _Undistortion;

// Convert point from world space to undistorted camera space.
float4 undistort(float4 pos) {

	_Undistortion.x = .4;
	_Undistortion.y = .4;
	_MaxRadSq = 0.08;
	float nearClip = _ProjectionParams.y;

	// Go to camera space.
	pos = mul(UNITY_MATRIX_MV, pos);
	if (pos.z <= -nearClip) {
		// Reminder: Forward is -Z.
		// Undistort the point's coordinates in XY.
		float r2 = clamp(dot(pos.xy, pos.xy) / (pos.z*pos.z), 0, _MaxRadSq);
		pos.xy *= 1 + (_Undistortion.x + _Undistortion.y*r2)*r2;
	}
	return pos;
}

// Multiply by no-lens projection matrix after undistortion.
float4 undistortVertex(float4 pos) {
  return mul(UNITY_MATRIX_P, undistort(pos));
}
