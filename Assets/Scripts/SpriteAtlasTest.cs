using System.Collections.Generic;
using System.Linq;
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

	[SerializeField] private Dictionary<SpriteAtlas, List<Sprite>> _dic;
	[SerializeField] private List<Sprite> sprList = null;

	private Sprite GetSprite(SpriteAtlas atlas, string name) {
		if (_dic == null) {
			_dic = new Dictionary<SpriteAtlas, List<Sprite>>();
		}

		if (!_dic.ContainsKey(atlas)) {
			_dic.Add(atlas, new List<Sprite>());
		}

		var ret = _dic[atlas].Where(o => o.name == name).FirstOrDefault();

		if (ret == null) {
			
			ret = atlas.GetSprite(name); // sprite clone.
			ret.name = name;

			if (ret != null) {
				_dic[atlas].Add(ret);
			}
		}

		return ret;
	}

	private void Update() {
		if (Input.GetKeyDown(KeyCode.Alpha1)) {
			if (imageA.sprite == null) {
				imageA.sprite = GetSprite(AtlasA, "1");
			} else {
				imageA.sprite = null;
			}
		} else if (Input.GetKeyDown(KeyCode.Alpha2)) {
			if (imageB.sprite == null) {
				imageB.sprite = GetSprite(AtlasB, "1");
			} else {
				imageB.sprite = null;
			}
		} else if (Input.GetKeyDown(KeyCode.Alpha3)) {
			if (imageC.sprite == null) {
				imageC.sprite = GetSprite(AtlasC, "1");
			} else {
				imageC.sprite = null;
			}
		} else if (Input.GetKeyDown(KeyCode.Alpha4)) {

			Debug.Log("dispose");

			foreach(var data in _dic) {
				foreach(var spr in data.Value) {
					Destroy(spr);
				}
				data.Value.Clear();
			}

			Resources.UnloadUnusedAssets(); //System.GC.Collect(); include
		}
	}
}
