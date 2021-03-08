using UnityEngine;
using UnityEngine.U2D;
using UnityEngine.UI;

public class SpriteAtlasTest : MonoBehaviour
{
	[SerializeField] private SpriteAtlas AtlasA = null;
	[SerializeField] private SpriteAtlas AtlasB = null;
	[SerializeField] private SpriteAtlas AtlasC = null;

	[SerializeField] private Image imageA = null;
	[SerializeField] private Image imageB = null;
	[SerializeField] private Image imageC = null;

	private void Update() {
		if (Input.GetKeyDown(KeyCode.Alpha1)) {
			if (imageA.sprite == null) {
				imageA.sprite = AtlasA.GetSprite("1"); // sprite clone.
			} else {
				Destroy(imageA.sprite);
				imageA.sprite = null;
			}
		} else if (Input.GetKeyDown(KeyCode.Alpha2)) {
			if (imageB.sprite == null) {
				imageB.sprite = AtlasB.GetSprite("1");
			} else {
				Destroy(imageB.sprite);
				imageB.sprite = null;
			}
		} else if (Input.GetKeyDown(KeyCode.Alpha3)) {
			if (imageC.sprite == null) {
				imageC.sprite = AtlasC.GetSprite("1");
			} else {
				Destroy(imageC.sprite);
				imageC.sprite = null;
			}
		} else if (Input.GetKeyDown(KeyCode.Alpha4)) {
			System.GC.Collect();
		}
	}
}
