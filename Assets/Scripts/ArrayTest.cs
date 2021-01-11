using UnityEngine;

[ExecuteInEditMode]
public class ArrayTest : MonoBehaviour
{
	public Material material;

	// Initalize Array
	// This should have the same length as in the shader!
	private float[] points = new float[] {
		1, 0, 0, 0.1f,
		0, 1, 0, 0.2f,
		0, 0, 1, 0.4f,
		-1, 0, 0, 0.5f,
		0, -1, 0, 0.6f,
		0, 0, -1, 0.8f,
	};

	private void Update() {
		if (material == null) return;

		for (int i = 0; i < points.Length; i += 4) {
			float t = points[i + 3];
			t += Time.deltaTime;
			if (t > 1) {
				// Lifetime Complete
				// Create a new random point
				t = 0;
				Vector3 sphere = Random.onUnitSphere;

				// Keep it in the top hemisphere - leave this out for a sphere!
				if (sphere.y < 0) sphere.y = -sphere.y;

				// Set position
				points[i] = sphere.x;
				points[i + 1] = sphere.y;
				points[i + 2] = sphere.z;
			}

			// Set lifetime
			points[i + 3] = t;
		}
		
		material.SetFloatArray("_Points", points);
	}
}