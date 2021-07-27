using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.XR;

namespace NiloToon.NiloToonURP
{
	// Token: 0x02000003 RID: 3
	[DisallowMultipleComponent]
	[ExecuteAlways]
	public class NiloToonPerCharacterRenderController : MonoBehaviour
	{
		// Token: 0x0600000C RID: 12 RVA: 0x0000230C File Offset: 0x0000050C
		private void LateUpdate() {
			if (this.ExternalRenderOverrider && !this.ExternalRenderOverrider.targets.Contains(this)) {
				this.ExternalRenderOverrider = null;
			}
			NiloToonAllInOneRendererFeature instance = NiloToonAllInOneRendererFeature.Instance;
			if (instance) {
				instance.AddCharIfNotExist(this);
			} else {
				Debug.LogError("You need to add NiloToonAllInOneRendererFeature to your ForwardRenderer.asset!");
			}
			if (this.allRenderers.Count == 0) {
				base.GetComponentsInChildren<Renderer>(this.allRenderers);
				this.allRenderers = this.allRenderers.FindAll(delegate (Renderer x) {
					foreach (Material material in x.sharedMaterials) {
						if (material && material.shader && material.shader.name.Contains("NiloToon")) {
							return true;
						}
					}
					return false;
				});
			}
			if (Application.isPlaying) {
				using (IEnumerator<Renderer> enumerator = this.AllRenderersIncludeAttachments().GetEnumerator()) {
					while (enumerator.MoveNext()) {
						Renderer renderer = enumerator.Current;
						if (renderer) {
							renderer.SetPropertyBlock(null);
							renderer.GetMaterials(this.tempMaterialList);
							foreach (Material input in this.tempMaterialList) {
								this.UpdateMaterial(input);
							}
						}
					}
					return;
				}
			}
			if (this.materialPropertyBlock == null) {
				this.materialPropertyBlock = new MaterialPropertyBlock();
			}
			foreach (Renderer renderer2 in this.AllRenderersIncludeAttachments()) {
				if (renderer2) {
					if (renderer2.HasPropertyBlock()) {
						renderer2.GetPropertyBlock(this.materialPropertyBlock);
					}
					this.UpdateMaterialPropertyBlock(this.materialPropertyBlock);
					renderer2.SetPropertyBlock(this.materialPropertyBlock);
				}
			}
		}

		// Token: 0x0600000D RID: 13 RVA: 0x000024CC File Offset: 0x000006CC
		private void OnDisable() {
			NiloToonAllInOneRendererFeature instance = NiloToonAllInOneRendererFeature.Instance;
			if (instance == null) {
				return;
			}
			instance.Remove(this);
		}

		// Token: 0x0600000E RID: 14 RVA: 0x000024DE File Offset: 0x000006DE
		public float GetCharacterBoundRadius() {
			return this.characterBoundRadius;
		}

		// Token: 0x0600000F RID: 15 RVA: 0x000024E6 File Offset: 0x000006E6
		public Vector3 GetPerspectiveRemovalCenter() {
			if (this.ExternalRenderOverrider && this.ExternalRenderOverrider.ShouldOverridePerspectiveRemoval()) {
				return this.ExternalRenderOverrider.GetPerspectiveRemovalOverridedCenterPosWS();
			}
			return this.GetSelfPerspectiveRemovalCenter();
		}

		// Token: 0x06000010 RID: 16 RVA: 0x00002514 File Offset: 0x00000714
		public Vector3 GetSelfPerspectiveRemovalCenter() {
			if (this.headBoneTransform) {
				return this.headBoneTransform.position;
			}
			return this.GetCharacterBoundCenter();
		}

		// Token: 0x06000011 RID: 17 RVA: 0x00002538 File Offset: 0x00000738
		public Vector3 GetCharacterBoundCenter() {
			if (this.customCharacterBoundCenter) {
				return this.customCharacterBoundCenter.position;
			}
			Bounds? bounds = null;
			foreach (Renderer renderer in this.allRenderers) {
				if (bounds == null) {
					bounds = new Bounds?(renderer.bounds);
				} else {
					bounds.Value.Encapsulate(renderer.bounds);
				}
			}
			if (bounds == null) {
				Debug.LogWarning("No NiloToon shader detected inside " + base.gameObject.name + ", Did you forget to change character's material to NiloToon's character shader?", this);
				return base.transform.position + Vector3.up;
			}
			return bounds.Value.center;
		}

		// Token: 0x06000012 RID: 18 RVA: 0x00002620 File Offset: 0x00000820
		private IEnumerable<Renderer> AllRenderersIncludeAttachments() {
			foreach (Renderer renderer in this.allRenderers) {
				yield return renderer;
			}
			List<Renderer>.Enumerator enumerator = default(List<Renderer>.Enumerator);
			foreach (Renderer renderer2 in this.attachmentRendererList) {
				yield return renderer2;
			}
			enumerator = default(List<Renderer>.Enumerator);
			yield break;
			yield break;
		}

		// Token: 0x06000013 RID: 19 RVA: 0x00002630 File Offset: 0x00000830
		private static void DrawArrow(Vector3 pos, Vector3 direction, Color color, float arrowHeadLength = 0.05f, float arrowHeadAngle = 22.5f) {
			direction *= 0.5f;
			Gizmos.color = color;
			Gizmos.DrawRay(pos, direction);
			Vector3 a = Quaternion.LookRotation(direction) * Quaternion.Euler(0f, 180f + arrowHeadAngle, 0f) * new Vector3(0f, 0f, 1f);
			Vector3 a2 = Quaternion.LookRotation(direction) * Quaternion.Euler(0f, 180f - arrowHeadAngle, 0f) * new Vector3(0f, 0f, 1f);
			Gizmos.DrawRay(pos + direction, a * arrowHeadLength);
			Gizmos.DrawRay(pos + direction, a2 * arrowHeadLength);
			Vector3 a3 = Quaternion.LookRotation(direction) * Quaternion.Euler(arrowHeadAngle, 180f, 0f) * new Vector3(0f, 0f, 1f);
			Vector3 a4 = Quaternion.LookRotation(direction) * Quaternion.Euler(-arrowHeadAngle, 180f, 0f) * new Vector3(0f, 0f, 1f);
			Gizmos.DrawRay(pos + direction, a3 * arrowHeadLength);
			Gizmos.DrawRay(pos + direction, a4 * arrowHeadLength);
		}

		// Token: 0x06000014 RID: 20 RVA: 0x00002788 File Offset: 0x00000988
		private void OnDrawGizmosSelected() {
			if (this.showBoundingSphereGizmo) {
				Gizmos.color = new Color(1f, 0f, 0f, 0.5f);
				Gizmos.DrawSphere(this.GetCharacterBoundCenter(), this.GetCharacterBoundRadius());
			}
			if (this.showFaceForwardDirectionGizmo && this.headBoneTransform) {
				NiloToonPerCharacterRenderController.DrawArrow(this.headBoneTransform.position, this.GetFinalFaceForwardDirectionWS(), new Color(0f, 0f, 1f, 1f), 0.05f, 22.5f);
			}
		}

		// Token: 0x06000015 RID: 21 RVA: 0x0000281C File Offset: 0x00000A1C
		private Vector3 GetFinalFaceForwardDirectionWS() {
			switch (this.faceForwardDirection) {
				case NiloToonPerCharacterRenderController.TransformDirection.X:
					return this.headBoneTransform.right;
				case NiloToonPerCharacterRenderController.TransformDirection.Y:
					return this.headBoneTransform.up;
				case NiloToonPerCharacterRenderController.TransformDirection.Z:
					return this.headBoneTransform.forward;
				case NiloToonPerCharacterRenderController.TransformDirection.negX:
					return -this.headBoneTransform.right;
				case NiloToonPerCharacterRenderController.TransformDirection.negY:
					return -this.headBoneTransform.up;
				case NiloToonPerCharacterRenderController.TransformDirection.negZ:
					return -this.headBoneTransform.forward;
				default:
					throw new NotImplementedException();
			}
		}

		// Token: 0x06000016 RID: 22 RVA: 0x000028AC File Offset: 0x00000AAC
		private float GetPerspectiveRemovalAmount() {
			if (this.ExternalRenderOverrider && this.ExternalRenderOverrider.ShouldOverridePerspectiveRemoval()) {
				return this.ExternalRenderOverrider.GetPerspectiveRemovalOverridedAmount();
			}
			
			return this.perspectiveRemovalAmount;
		}

		// Token: 0x06000017 RID: 23 RVA: 0x000028FC File Offset: 0x00000AFC
		private float GetPerspectiveRemovalRadius() {
			if (this.ExternalRenderOverrider && this.ExternalRenderOverrider.ShouldOverridePerspectiveRemoval()) {
				return Mathf.Max(0.01f, this.ExternalRenderOverrider.GetPerspectiveRemovalOverridedRadius());
			}
			return Mathf.Max(0.01f, this.perspectiveRemovalRadius);
		}

		// Token: 0x06000018 RID: 24 RVA: 0x00002949 File Offset: 0x00000B49
		private float GetPerspectiveRemovalStartHeight() {
			if (this.ExternalRenderOverrider && this.ExternalRenderOverrider.ShouldOverridePerspectiveRemoval()) {
				return this.ExternalRenderOverrider.GetPerspectiveRemovalOverridedStartHeight();
			}
			return this.perspectiveRemovalStartHeight;
		}

		// Token: 0x06000019 RID: 25 RVA: 0x00002977 File Offset: 0x00000B77
		private float GetPerspectiveRemovalEndHeight() {
			if (this.ExternalRenderOverrider && this.ExternalRenderOverrider.ShouldOverridePerspectiveRemoval()) {
				return this.ExternalRenderOverrider.GetPerspectiveRemovalOverridedEndHeight();
			}
			return this.perspectiveRemovalEndHeight;
		}

		// Token: 0x0600001A RID: 26 RVA: 0x000029A8 File Offset: 0x00000BA8
		private void UpdateMaterial(Material input) {
			//input.SetInt(NiloToonPerCharacterRenderController._AverageShadowMapRTSampleIndex, this.shadowTestIndex);
			//input.SetVector(NiloToonPerCharacterRenderController._PerCharEffectTintColor, this.perCharacterTintColor);
			//input.SetVector(NiloToonPerCharacterRenderController._PerCharEffectAddColor, this.perCharacterAddColor);
			//input.SetFloat(NiloToonPerCharacterRenderController._PerCharEffectDesaturatePercentage, this.perCharacterDesaturationUsage);
			//input.SetVector(NiloToonPerCharacterRenderController._PerCharEffectLerpColor, new Color(this.perCharacterLerpColor.r, this.perCharacterLerpColor.g, this.perCharacterLerpColor.b, this.perCharacterLerpUsage));
			//input.SetColor(NiloToonPerCharacterRenderController._PerCharEffectRimColor, this.usePerCharacterRimLightIntensity ? (this.perCharacterRimLightIntensity * this.perCharacterRimLightColor) : Color.clear);
			if (this.headBoneTransform) {
				input.SetVector(NiloToonPerCharacterRenderController._FaceForwardDirection, this.GetFinalFaceForwardDirectionWS());
				input.SetFloat(NiloToonPerCharacterRenderController._FixFaceNormalAmount, this.faceNormalFixAmount);
			} else {
				input.SetFloat(NiloToonPerCharacterRenderController._FixFaceNormalAmount, 0f);
			}
			//input.SetColor(NiloToonPerCharacterRenderController._ExtraThickOutlineColor, this.extraThickOutlineColor);
			//input.SetFloat(NiloToonPerCharacterRenderController._ExtraThickOutlineWidth, this.extraThickOutlineWidth);
			//input.SetFloat(NiloToonPerCharacterRenderController._ExtraThickOutlineMaxFinalWidth, this.extraThickOutlineMaxiumuFinalWidth);
			//input.SetVector(NiloToonPerCharacterRenderController._ExtraThickOutlineViewSpacePosOffset, this.extraThickOutlineViewSpacePosOffset);
			//input.SetInt(NiloToonPerCharacterRenderController._ExtraThickOutlineZTest, this.extraThickOutlineRendersBlockedArea ? 8 : 4);
			//input.SetInt(NiloToonPerCharacterRenderController._ExtraThickOutlineStencilID, this.extraThickOutlineStencilID);
			//input.SetFloat(NiloToonPerCharacterRenderController._ExtraThickOutlineZOffset, this.extraThickOutlineZOffset);
			//input.SetVector(NiloToonPerCharacterRenderController._CharacterBoundCenterPosWS, this.GetCharacterBoundCenter());
			input.SetFloat(NiloToonPerCharacterRenderController._PerspectiveRemovalAmount, this.GetPerspectiveRemovalAmount());
			input.SetFloat(NiloToonPerCharacterRenderController._PerspectiveRemovalRadius, this.GetPerspectiveRemovalRadius());
			input.SetFloat(NiloToonPerCharacterRenderController._PerspectiveRemovalStartHeight, this.GetPerspectiveRemovalStartHeight());
			input.SetFloat(NiloToonPerCharacterRenderController._PerspectiveRemovalEndHeight, this.GetPerspectiveRemovalEndHeight());
			input.SetVector(NiloToonPerCharacterRenderController._HeadBonePositionWS, this.GetPerspectiveRemovalCenter());
			//input.SetVector(NiloToonPerCharacterRenderController._PerCharacterBaseColorTint, this.perCharacterBaseColorTint * this.perCharacterBaseColorMultiply);
			//input.SetFloat(NiloToonPerCharacterRenderController._PerCharacterOutlineWidthMultiply, this.perCharacterOutlineWidthMultiply);
			//input.SetVector(NiloToonPerCharacterRenderController._PerCharacterOutlineColorTint, this.perCharacterOutlineColorTint * this.perCharacterOutlineEffectTintColor);
			//input.SetVector(NiloToonPerCharacterRenderController._PerCharacterOutlineColorLerp, this.perCharacterOutlineEffectLerpColor);
			//input.SetShaderPassEnabled("NiloToonOutline", this.shouldRenderSelfOutline);
			//input.SetShaderPassEnabled("NiloToonExtraThickOutline", this.extraThickOutlineColor.a > 0f && this.shouldRenderExtraThickOutline);
			//if (this.ditherOpacity < 0.99f) {
			//	input.EnableKeyword("_NILOTOON_DITHER_FADEOUT");
			//	input.SetFloat("_DitherOpacity", this.ditherOpacity);
			//	return;
			//}
			//input.DisableKeyword("_NILOTOON_DITHER_FADEOUT");
		}

		// Token: 0x0600001B RID: 27 RVA: 0x00002C78 File Offset: 0x00000E78
		private void UpdateMaterialPropertyBlock(MaterialPropertyBlock input) {
			//input.SetInt(NiloToonPerCharacterRenderController._AverageShadowMapRTSampleIndex, this.shadowTestIndex);
			//input.SetVector(NiloToonPerCharacterRenderController._PerCharEffectTintColor, this.perCharacterTintColor);
			//input.SetVector(NiloToonPerCharacterRenderController._PerCharEffectAddColor, this.perCharacterAddColor);
			//input.SetFloat(NiloToonPerCharacterRenderController._PerCharEffectDesaturatePercentage, this.perCharacterDesaturationUsage);
			//input.SetVector(NiloToonPerCharacterRenderController._PerCharEffectLerpColor, new Color(this.perCharacterLerpColor.r, this.perCharacterLerpColor.g, this.perCharacterLerpColor.b, this.perCharacterLerpUsage));
			//input.SetColor(NiloToonPerCharacterRenderController._PerCharEffectRimColor, this.usePerCharacterRimLightIntensity ? (this.perCharacterRimLightIntensity * this.perCharacterRimLightColor) : Color.clear);
			if (this.headBoneTransform) {
				input.SetVector(NiloToonPerCharacterRenderController._FaceForwardDirection, this.GetFinalFaceForwardDirectionWS());
				input.SetFloat(NiloToonPerCharacterRenderController._FixFaceNormalAmount, this.faceNormalFixAmount);
			} else {
				input.SetFloat(NiloToonPerCharacterRenderController._FixFaceNormalAmount, 0f);
			}
			//input.SetColor(NiloToonPerCharacterRenderController._ExtraThickOutlineColor, this.extraThickOutlineColor);
			//input.SetFloat(NiloToonPerCharacterRenderController._ExtraThickOutlineWidth, this.extraThickOutlineWidth);
			//input.SetFloat(NiloToonPerCharacterRenderController._ExtraThickOutlineMaxFinalWidth, this.extraThickOutlineMaxiumuFinalWidth);
			//input.SetVector(NiloToonPerCharacterRenderController._ExtraThickOutlineViewSpacePosOffset, this.extraThickOutlineViewSpacePosOffset);
			//input.SetInt(NiloToonPerCharacterRenderController._ExtraThickOutlineZTest, this.extraThickOutlineRendersBlockedArea ? 8 : 4);
			//input.SetInt(NiloToonPerCharacterRenderController._ExtraThickOutlineStencilID, this.extraThickOutlineStencilID);
			//input.SetFloat(NiloToonPerCharacterRenderController._ExtraThickOutlineZOffset, this.extraThickOutlineZOffset);
			//input.SetVector(NiloToonPerCharacterRenderController._CharacterBoundCenterPosWS, this.GetCharacterBoundCenter());
			input.SetFloat(NiloToonPerCharacterRenderController._PerspectiveRemovalAmount, this.GetPerspectiveRemovalAmount());
			input.SetFloat(NiloToonPerCharacterRenderController._PerspectiveRemovalRadius, this.GetPerspectiveRemovalRadius());
			input.SetFloat(NiloToonPerCharacterRenderController._PerspectiveRemovalStartHeight, this.GetPerspectiveRemovalStartHeight());
			input.SetFloat(NiloToonPerCharacterRenderController._PerspectiveRemovalEndHeight, this.GetPerspectiveRemovalEndHeight());
			input.SetVector(NiloToonPerCharacterRenderController._HeadBonePositionWS, this.GetPerspectiveRemovalCenter());
			//input.SetVector(NiloToonPerCharacterRenderController._PerCharacterBaseColorTint, this.perCharacterBaseColorTint * this.perCharacterBaseColorMultiply);
			//input.SetFloat(NiloToonPerCharacterRenderController._PerCharacterOutlineWidthMultiply, this.perCharacterOutlineWidthMultiply);
			//input.SetVector(NiloToonPerCharacterRenderController._PerCharacterOutlineColorTint, this.perCharacterOutlineColorTint * this.perCharacterOutlineEffectTintColor);
			//input.SetVector(NiloToonPerCharacterRenderController._PerCharacterOutlineColorLerp, this.perCharacterOutlineEffectLerpColor);
		}

		// Token: 0x0600001C RID: 28 RVA: 0x00002EDC File Offset: 0x000010DC
		public NiloToonPerCharacterRenderController() {
		}

		// Token: 0x0600001D RID: 29 RVA: 0x00003060 File Offset: 0x00001260
		// Note: this type is marked as 'beforefieldinit'.
		static NiloToonPerCharacterRenderController() {
		}

		//// Token: 0x0400000C RID: 12
		[Header("Make attachment renderers sync with this script's setting (e.g. drag weapon/microphone/stencil effect...renderer here)")]
		[Tooltip("Drag any number of attachments(e.g. weapon/microphone/stencil effect...renderer) here, to make these renderers render using this script's settings.\n(these renderer's shader need to support perspective removal)")]
		public List<Renderer> attachmentRendererList = new List<Renderer>();

		//// Token: 0x0400000D RID: 13
		//[Header("Gameplay per character effects - Tint")]
		//[ColorUsage(false, true)]
		//public Color perCharacterTintColor = Color.white;

		//// Token: 0x0400000E RID: 14
		//[Header("Gameplay per character effects - Add")]
		//[ColorUsage(false, true)]
		//public Color perCharacterAddColor = Color.black;

		//// Token: 0x0400000F RID: 15
		//[Header("Gameplay per character effects - Desaturate")]
		//[Range(0f, 1f)]
		//public float perCharacterDesaturationUsage;

		//// Token: 0x04000010 RID: 16
		//[Header("Gameplay per character effects - Lerp")]
		//[Range(0f, 1f)]
		//public float perCharacterLerpUsage;

		//// Token: 0x04000011 RID: 17
		//[ColorUsage(true, true)]
		//public Color perCharacterLerpColor = new Color(1f, 1f, 0f);

		//// Token: 0x04000012 RID: 18
		//[Header("Gameplay per character effects - Rim Light")]
		//public bool usePerCharacterRimLightIntensity;

		//// Token: 0x04000013 RID: 19
		//[Range(0f, 100f)]
		//public float perCharacterRimLightIntensity = 2f;

		//// Token: 0x04000014 RID: 20
		//[ColorUsage(false, true)]
		//public Color perCharacterRimLightColor = new Color(1f, 0f, 0f);

		//// Token: 0x04000015 RID: 21
		//[Header("Gameplay per character effects - Outline")]
		//[ColorUsage(false, true)]
		//public Color perCharacterOutlineEffectTintColor = new Color(1f, 1f, 1f);

		//// Token: 0x04000016 RID: 22
		//[ColorUsage(true, true)]
		//public Color perCharacterOutlineEffectLerpColor = new Color(1f, 1f, 1f, 0f);

		//// Token: 0x04000017 RID: 23
		//[Header("Dither fadeout (only works if in playmode and DebugWindow SRP Batching = on)")]
		//[Tooltip("Keep it at 1 will improve performance a lot, since we can turn it off completely in shader")]
		//[Range(0f, 1f)]
		//public float ditherOpacity = 1f;

		//// Token: 0x04000018 RID: 24
		//[Header("Outline (only works if in playmode and DebugWindow SRP Batching = on)")]
		//public bool shouldRenderSelfOutline = true;

		//// Token: 0x04000019 RID: 25
		//[Header("Extra Outline (only works if in playmode and DebugWindow SRP Batching = on)")]
		//[Tooltip("Usually for selection outline in gameplay, or for any artistic need like a thick white outline")]
		//public bool shouldRenderExtraThickOutline;

		//// Token: 0x0400001A RID: 26
		//public Color extraThickOutlineColor = Color.white;

		//// Token: 0x0400001B RID: 27
		//[Range(0f, 100f)]
		//public float extraThickOutlineWidth = 3f;

		//// Token: 0x0400001C RID: 28
		//[Range(0f, 100f)]
		//public float extraThickOutlineMaxiumuFinalWidth = 100f;

		//// Token: 0x0400001D RID: 29
		//public Vector3 extraThickOutlineViewSpacePosOffset = Vector3.zero;

		//// Token: 0x0400001E RID: 30
		//public bool extraThickOutlineRendersBlockedArea;

		//// Token: 0x0400001F RID: 31
		//[Tooltip("usually for render better outline when outline is occluded by opaque ground, set it to 0 and you will see the difference")]
		//public float extraThickOutlineZOffset = -0.1f;

		//// Token: 0x04000020 RID: 32
		//[Range(0f, 255f)]
		//[Tooltip("can be any number, but 199 is not that common, so it will lead to less conflict by default")]
		//public int extraThickOutlineStencilID = 199;

		// Token: 0x04000021 RID: 33
		[Header("Perspective removal")]
		[Range(0f, 1f)]
		public float perspectiveRemovalAmount;

		// Token: 0x04000022 RID: 34
		[Header("Perspective removal (Sphere, using head transform as sphere center)")]
		public float perspectiveRemovalRadius = 1f;

		// Token: 0x04000023 RID: 35
		[Header("Perspective removal (world height)")]
		public float perspectiveRemovalStartHeight;

		// Token: 0x04000024 RID: 36
		public float perspectiveRemovalEndHeight = 1f;

		//// Token: 0x04000025 RID: 37
		//[Header("Perspective removal (XR)")]
		//public bool disablePerspectiveRemovalInXR = true;

		// Token: 0x04000026 RID: 38
		[Header("Setup - Override Bounding Sphere (affect average shadow result)")]
		[Tooltip("You can assign hip / Pelvis bone (any transform that is center of character\nuseful if default realtime bound from all renderers is not working for your character, or realtime bound is too slow")]
		public Transform customCharacterBoundCenter;

		// Token: 0x04000027 RID: 39
		public float characterBoundRadius = 1f;

		// Token: 0x04000028 RID: 40
		public bool showBoundingSphereGizmo;

		// Token: 0x04000029 RID: 41
		[Header("Setup - Head Bone and Face forward direction (affect face lighting and perspective removal)")]
		public Transform headBoneTransform;

		// Token: 0x0400002A RID: 42
		public NiloToonPerCharacterRenderController.TransformDirection faceForwardDirection = NiloToonPerCharacterRenderController.TransformDirection.Z;

		// Token: 0x0400002B RID: 43
		[Tooltip("If headBoneTransform is none, this will treat as 0")]
		[Range(0f, 1f)]
		public float faceNormalFixAmount = 1f;

		// Token: 0x0400002C RID: 44
		public bool showFaceForwardDirectionGizmo = true;

		// Token: 0x0400002D RID: 45
		[Header("Setup - Renderers")]
		public List<Renderer> allRenderers = new List<Renderer>();

		//// Token: 0x0400002E RID: 46
		//[Header("Setup - BaseColor control")]
		//public float perCharacterBaseColorMultiply = 1f;

		//// Token: 0x0400002F RID: 47
		//[ColorUsage(true, true)]
		//public Color perCharacterBaseColorTint = Color.white;

		//// Token: 0x04000030 RID: 48
		//[Header("Setup - Outline control")]
		//public float perCharacterOutlineWidthMultiply = 1f;

		//// Token: 0x04000031 RID: 49
		//[ColorUsage(false, true)]
		//public Color perCharacterOutlineColorTint = Color.white;

		//// Token: 0x04000032 RID: 50
		//[NonSerialized]
		//public int shadowTestIndex;

		// Token: 0x04000033 RID: 51
		private MaterialPropertyBlock materialPropertyBlock;

		// Token: 0x04000034 RID: 52
		[NonSerialized]
		public bool reimportDone;

		// Token: 0x04000035 RID: 53
		[NonSerialized]
		public NiloToonCharacterRenderOverrider ExternalRenderOverrider;

		// Token: 0x04000036 RID: 54
		private List<Material> tempMaterialList = new List<Material>();

		// Token: 0x04000037 RID: 55
		private static readonly int _AverageShadowMapRTSampleIndex = Shader.PropertyToID("_AverageShadowMapRTSampleIndex");

		// Token: 0x04000038 RID: 56
		private static readonly int _PerCharEffectTintColor = Shader.PropertyToID("_PerCharEffectTintColor");

		// Token: 0x04000039 RID: 57
		private static readonly int _PerCharEffectAddColor = Shader.PropertyToID("_PerCharEffectAddColor");

		// Token: 0x0400003A RID: 58
		private static readonly int _PerCharEffectDesaturatePercentage = Shader.PropertyToID("_PerCharEffectDesaturatePercentage");

		// Token: 0x0400003B RID: 59
		private static readonly int _PerCharEffectLerpColor = Shader.PropertyToID("_PerCharEffectLerpColor");

		// Token: 0x0400003C RID: 60
		private static readonly int _PerCharEffectRimColor = Shader.PropertyToID("_PerCharEffectRimColor");

		// Token: 0x0400003D RID: 61
		private static readonly int _FaceForwardDirection = Shader.PropertyToID("_FaceForwardDirection");

		// Token: 0x0400003E RID: 62
		private static readonly int _FixFaceNormalAmount = Shader.PropertyToID("_FixFaceNormalAmount");

		// Token: 0x0400003F RID: 63
		private static readonly int _ExtraThickOutlineColor = Shader.PropertyToID("_ExtraThickOutlineColor");

		// Token: 0x04000040 RID: 64
		private static readonly int _ExtraThickOutlineWidth = Shader.PropertyToID("_ExtraThickOutlineWidth");

		// Token: 0x04000041 RID: 65
		private static readonly int _ExtraThickOutlineMaxFinalWidth = Shader.PropertyToID("_ExtraThickOutlineMaxFinalWidth");

		// Token: 0x04000042 RID: 66
		private static readonly int _ExtraThickOutlineViewSpacePosOffset = Shader.PropertyToID("_ExtraThickOutlineViewSpacePosOffset");

		// Token: 0x04000043 RID: 67
		private static readonly int _ExtraThickOutlineZTest = Shader.PropertyToID("_ExtraThickOutlineZTest");

		// Token: 0x04000044 RID: 68
		private static readonly int _ExtraThickOutlineStencilID = Shader.PropertyToID("_ExtraThickOutlineStencilID");

		// Token: 0x04000045 RID: 69
		private static readonly int _ExtraThickOutlineZOffset = Shader.PropertyToID("_ExtraThickOutlineZOffset");

		// Token: 0x04000046 RID: 70
		private static readonly int _CharacterBoundCenterPosWS = Shader.PropertyToID("_CharacterBoundCenterPosWS");

		// Token: 0x04000047 RID: 71
		private static readonly int _PerspectiveRemovalAmount = Shader.PropertyToID("_PerspectiveRemovalAmount");

		// Token: 0x04000048 RID: 72
		private static readonly int _PerspectiveRemovalRadius = Shader.PropertyToID("_PerspectiveRemovalRadius");

		// Token: 0x04000049 RID: 73
		private static readonly int _PerspectiveRemovalStartHeight = Shader.PropertyToID("_PerspectiveRemovalStartHeight");

		// Token: 0x0400004A RID: 74
		private static readonly int _PerspectiveRemovalEndHeight = Shader.PropertyToID("_PerspectiveRemovalEndHeight");

		// Token: 0x0400004B RID: 75
		private static readonly int _HeadBonePositionWS = Shader.PropertyToID("_HeadBonePositionWS");

		// Token: 0x0400004C RID: 76
		private static readonly int _PerCharacterBaseColorTint = Shader.PropertyToID("_PerCharacterBaseColorTint");

		// Token: 0x0400004D RID: 77
		private static readonly int _PerCharacterOutlineWidthMultiply = Shader.PropertyToID("_PerCharacterOutlineWidthMultiply");

		// Token: 0x0400004E RID: 78
		private static readonly int _PerCharacterOutlineColorTint = Shader.PropertyToID("_PerCharacterOutlineColorTint");

		// Token: 0x0400004F RID: 79
		private static readonly int _PerCharacterOutlineColorLerp = Shader.PropertyToID("_PerCharacterOutlineColorLerp");

		// Token: 0x02000014 RID: 20
		public enum TransformDirection
		{
			// Token: 0x040000EE RID: 238
			X,
			// Token: 0x040000EF RID: 239
			Y,
			// Token: 0x040000F0 RID: 240
			Z,
			// Token: 0x040000F1 RID: 241
			negX,
			// Token: 0x040000F2 RID: 242
			negY,
			// Token: 0x040000F3 RID: 243
			negZ
		}
	}
}
