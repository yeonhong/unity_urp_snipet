using System;
using UnityEditor;
using UnityEngine;

public class UnlitCameraOffsetEditor : ShaderGUI
{
	public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] properties) {

		var targetMat = materialEditor.target as Material;

		//재질에 CAMOFFSET_ON 키워드가 있는지 검사하여 있으면 camOffset = true
		bool camOffset = Array.IndexOf(targetMat.shaderKeywords, "CAMOFFSET_ON") != -1;
		EditorGUI.BeginChangeCheck();
		camOffset = EditorGUILayout.Toggle("Use Camera Offset", camOffset);
		if (EditorGUI.EndChangeCheck()) {
			// 체크박스를 기반으로 키워드를 세팅
			if (camOffset) {
				targetMat.EnableKeyword("CAMOFFSET_ON");
			}
			else {
				targetMat.DisableKeyword("CAMOFFSET_ON");
			}
		}
		
		GUI.enabled = camOffset;
		{
			var offset = targetMat.GetFloat("_CameraOffset");
			EditorGUI.BeginChangeCheck();
			offset = EditorGUILayout.FloatField("Camera Offset", offset);
			if (EditorGUI.EndChangeCheck()) {
				Undo.RecordObject(targetMat, "Material Inspector Changed");
				targetMat.SetFloat("_CameraOffset", offset);
			}
		}
		GUI.enabled = true;

		base.OnGUI(materialEditor, properties);
	}
}
