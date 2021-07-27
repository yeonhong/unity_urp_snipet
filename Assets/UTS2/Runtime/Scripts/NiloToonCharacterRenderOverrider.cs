using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.XR;

namespace NiloToon.NiloToonURP
{
	// Token: 0x02000002 RID: 2
	[ExecuteAlways]
	public class NiloToonCharacterRenderOverrider : MonoBehaviour
	{
		// Token: 0x06000001 RID: 1 RVA: 0x00002050 File Offset: 0x00000250
		private void OnValidate() {
			if (this.CustomPerspectiveRemovalOverridedCenterPosWS == null) {
				this.CustomPerspectiveRemovalOverridedCenterPosWS = base.transform;
			}
			this.CustomPerspectiveRemovalRadius = Mathf.Max(0f, this.CustomPerspectiveRemovalRadius);
		}

		// Token: 0x06000002 RID: 2 RVA: 0x00002082 File Offset: 0x00000282
		private void OnEnable() {
			this.LateUpdate();
		}

		// Token: 0x06000003 RID: 3 RVA: 0x0000208C File Offset: 0x0000028C
		private void LateUpdate() {
			foreach (NiloToonPerCharacterRenderController niloToonPerCharacterRenderController in this.targets) {
				if (niloToonPerCharacterRenderController) {
					niloToonPerCharacterRenderController.ExternalRenderOverrider = this;
				}
			}
		}

		// Token: 0x06000004 RID: 4 RVA: 0x000020E8 File Offset: 0x000002E8
		private void OnDisable() {
			foreach (NiloToonPerCharacterRenderController niloToonPerCharacterRenderController in this.targets) {
				if (niloToonPerCharacterRenderController) {
					niloToonPerCharacterRenderController.ExternalRenderOverrider = null;
				}
			}
		}

		// Token: 0x06000005 RID: 5 RVA: 0x00002144 File Offset: 0x00000344
		public bool ShouldOverridePerspectiveRemoval() {
			if (base.enabled && this.ShouldOverridePerspectiveRemovalSettings) {
				NiloToonCharacterRenderOverrider.SettingSource settingSource = this.settingSource;
				if (settingSource == NiloToonCharacterRenderOverrider.SettingSource.TargetCharacterRenderController) {
					return this.targetCharacterRenderController;
				}
				if (settingSource == NiloToonCharacterRenderOverrider.SettingSource.CustomSettings) {
					return this.CustomPerspectiveRemovalOverridedCenterPosWS;
				}
			}
			return false;
		}

		// Token: 0x06000006 RID: 6 RVA: 0x0000218C File Offset: 0x0000038C
		public float GetPerspectiveRemovalOverridedAmount() {
			NiloToonCharacterRenderOverrider.SettingSource settingSource = this.settingSource;
			if (settingSource != NiloToonCharacterRenderOverrider.SettingSource.TargetCharacterRenderController) {
				if (settingSource != NiloToonCharacterRenderOverrider.SettingSource.CustomSettings) {
					throw new NotImplementedException();
				}
				if (this.CustomDisablePerspectiveRemovalInXR && XRSettings.isDeviceActive) {
					return 0f;
				}
				return this.CustomPerspectiveRemovalAmount;
			} else {
				return this.targetCharacterRenderController.perspectiveRemovalAmount;
			}
		}

		// Token: 0x06000007 RID: 7 RVA: 0x000021F0 File Offset: 0x000003F0
		public float GetPerspectiveRemovalOverridedRadius() {
			NiloToonCharacterRenderOverrider.SettingSource settingSource = this.settingSource;
			if (settingSource == NiloToonCharacterRenderOverrider.SettingSource.TargetCharacterRenderController) {
				return this.targetCharacterRenderController.perspectiveRemovalRadius;
			}
			if (settingSource != NiloToonCharacterRenderOverrider.SettingSource.CustomSettings) {
				throw new NotImplementedException();
			}
			return this.CustomPerspectiveRemovalRadius;
		}

		// Token: 0x06000008 RID: 8 RVA: 0x00002228 File Offset: 0x00000428
		public float GetPerspectiveRemovalOverridedStartHeight() {
			NiloToonCharacterRenderOverrider.SettingSource settingSource = this.settingSource;
			if (settingSource == NiloToonCharacterRenderOverrider.SettingSource.TargetCharacterRenderController) {
				return this.targetCharacterRenderController.perspectiveRemovalStartHeight;
			}
			if (settingSource != NiloToonCharacterRenderOverrider.SettingSource.CustomSettings) {
				throw new NotImplementedException();
			}
			return this.CustomPerspectiveRemovalStartHeightWorldSpace;
		}

		// Token: 0x06000009 RID: 9 RVA: 0x00002260 File Offset: 0x00000460
		public float GetPerspectiveRemovalOverridedEndHeight() {
			NiloToonCharacterRenderOverrider.SettingSource settingSource = this.settingSource;
			if (settingSource == NiloToonCharacterRenderOverrider.SettingSource.TargetCharacterRenderController) {
				return this.targetCharacterRenderController.perspectiveRemovalEndHeight;
			}
			if (settingSource != NiloToonCharacterRenderOverrider.SettingSource.CustomSettings) {
				throw new NotImplementedException();
			}
			return this.CustomPerspectiveRemovalEndHeightWorldSpace;
		}

		// Token: 0x0600000A RID: 10 RVA: 0x00002298 File Offset: 0x00000498
		public Vector3 GetPerspectiveRemovalOverridedCenterPosWS() {
			NiloToonCharacterRenderOverrider.SettingSource settingSource = this.settingSource;
			if (settingSource == NiloToonCharacterRenderOverrider.SettingSource.TargetCharacterRenderController) {
				return this.targetCharacterRenderController.GetSelfPerspectiveRemovalCenter();
			}
			if (settingSource != NiloToonCharacterRenderOverrider.SettingSource.CustomSettings) {
				throw new NotImplementedException();
			}
			return this.CustomPerspectiveRemovalOverridedCenterPosWS.position;
		}

		// Token: 0x0600000B RID: 11 RVA: 0x000022D2 File Offset: 0x000004D2
		public NiloToonCharacterRenderOverrider() {
		}

		// Token: 0x04000001 RID: 1
		public List<NiloToonPerCharacterRenderController> targets = new List<NiloToonPerCharacterRenderController>();

		// Token: 0x04000002 RID: 2
		[Header("Perspective Removal")]
		public bool ShouldOverridePerspectiveRemovalSettings = true;

		// Token: 0x04000003 RID: 3
		public NiloToonCharacterRenderOverrider.SettingSource settingSource;

		// Token: 0x04000004 RID: 4
		[Header("For Source = TargetCharacterRenderController")]
		public NiloToonPerCharacterRenderController targetCharacterRenderController;

		// Token: 0x04000005 RID: 5
		[Header("For Source = CustomSettings")]
		[Range(0f, 1f)]
		public float CustomPerspectiveRemovalAmount;

		// Token: 0x04000006 RID: 6
		public float CustomPerspectiveRemovalRadius = 1f;

		// Token: 0x04000007 RID: 7
		[Space(10f)]
		[Range(0f, 1f)]
		public float CustomPerspectiveRemovalWorldSpaceHeightFadeoutUsage;

		// Token: 0x04000008 RID: 8
		public float CustomPerspectiveRemovalStartHeightWorldSpace;

		// Token: 0x04000009 RID: 9
		public float CustomPerspectiveRemovalEndHeightWorldSpace = 1f;

		// Token: 0x0400000A RID: 10
		[Space(10f)]
		public bool CustomDisablePerspectiveRemovalInXR = true;

		// Token: 0x0400000B RID: 11
		public Transform CustomPerspectiveRemovalOverridedCenterPosWS;

		// Token: 0x02000013 RID: 19
		public enum SettingSource
		{
			// Token: 0x040000EB RID: 235
			TargetCharacterRenderController,
			// Token: 0x040000EC RID: 236
			CustomSettings
		}
	}
}
