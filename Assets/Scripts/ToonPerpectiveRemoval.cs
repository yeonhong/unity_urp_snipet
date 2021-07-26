using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ToonPerpectiveRemoval : MonoBehaviour
{
	[SerializeField] Transform _tHead = null;
	Renderer[] _renderer = null;
	MaterialPropertyBlock _mpb = null;

	private void Awake() {
		_mpb = new MaterialPropertyBlock();
	}

	void Start() {
		if (_renderer == null) _renderer = transform.GetComponentsInChildren<Renderer>();
		_mpb.SetVector("_HeadBonePositionWS", _tHead.position);

		foreach(var rdr in _renderer) {
			rdr.SetPropertyBlock(_mpb);
		}
		
	}

    void LateUpdate()
    {
		_mpb.SetVector("_HeadBonePositionWS", _tHead.position);

		foreach (var rdr in _renderer) {
			rdr.SetPropertyBlock(_mpb);
		}
	}
}