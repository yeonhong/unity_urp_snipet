using System;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

public static class UIImageOptimization
{
	[MenuItem("GameObject/CustomMenu/Optimization/모든 Raycast Target 끄기", false)]
	static void RaycastTargetOff() {
		List<GameObject> rootObjects = new List<GameObject>();
		Scene scene = SceneManager.GetActiveScene();
		scene.GetRootGameObjects(rootObjects);

		for (int i = 0; i < rootObjects.Count; ++i) {
			GameObject gameObject = rootObjects[i];
			if (gameObject.transform.childCount > 0) {
				FindChild(gameObject.transform, (t) => {
					var img = t.GetComponent<Image>();
					if(img != null) {
						img.raycastTarget = false;
					}
				});
			}
		}
	}

	[MenuItem("GameObject/CustomMenu/Optimization/모든 Maskable 끄기", false)]
	static void Maskable() {
		List<GameObject> rootObjects = new List<GameObject>();
		Scene scene = SceneManager.GetActiveScene();
		scene.GetRootGameObjects(rootObjects);

		for (int i = 0; i < rootObjects.Count; ++i) {
			GameObject gameObject = rootObjects[i];
			if (gameObject.transform.childCount > 0) {
				FindChild(gameObject.transform, (t) => {
					var img = t.GetComponent<Image>();
					if (img != null) {
						img.maskable = false;
					}
				});
			}
		}
	}

	private static void FindChild(Transform tRoot, Action<Transform> action) {
		for (int f = 0; f < tRoot.childCount; f++) {
			var child = tRoot.GetChild(f);
			action(child);
			if (child.transform.childCount > 0) {
				FindChild(child, action);
			}
		}
	}
}
