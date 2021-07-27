using System;
using System.Collections.Generic;
using UnityEngine.Rendering.Universal;

namespace NiloToon.NiloToonURP
{
	// Token: 0x02000005 RID: 5
	public class NiloToonAllInOneRendererFeature : ScriptableRendererFeature
	{
		// Token: 0x0600001F RID: 31 RVA: 0x00003224 File Offset: 0x00001424
		public override void Create() {
		}

		// Token: 0x06000020 RID: 32 RVA: 0x000032BF File Offset: 0x000014BF
		public override void AddRenderPasses(ScriptableRenderer renderer, ref RenderingData renderingData) {
		}

		// Token: 0x06000021 RID: 33 RVA: 0x000032FD File Offset: 0x000014FD
		public NiloToonAllInOneRendererFeature() {
			this.CheckInit();
			NiloToonAllInOneRendererFeature._instance = this;
		}

		// Token: 0x17000001 RID: 1
		// (get) Token: 0x06000022 RID: 34 RVA: 0x0000331C File Offset: 0x0000151C
		public static NiloToonAllInOneRendererFeature Instance {
			get {
				return NiloToonAllInOneRendererFeature._instance;
			}
		}

		// Token: 0x06000023 RID: 35 RVA: 0x00003323 File Offset: 0x00001523
		public void AddCharIfNotExist(NiloToonPerCharacterRenderController controller) {
			this.CheckInit();
			if (!this.characterList.Contains(controller)) {
				this.characterList.Add(controller);
				this.UpdateCharacterControllerIndex();
			}
		}

		// Token: 0x06000024 RID: 36 RVA: 0x0000334B File Offset: 0x0000154B
		public void Remove(NiloToonPerCharacterRenderController controller) {
			this.CheckInit();
			if (this.characterList.Contains(controller)) {
				this.characterList.Remove(controller);
				this.UpdateCharacterControllerIndex();
			}
		}

		// Token: 0x06000025 RID: 37 RVA: 0x00003374 File Offset: 0x00001574
		private void UpdateCharacterControllerIndex() {
			//for (int i = 0; i < this.characterList.Count; i++) {
			//	NiloToonPerCharacterRenderController niloToonPerCharacterRenderController = this.characterList[i];
			//	if (!(niloToonPerCharacterRenderController == null)) {
			//		niloToonPerCharacterRenderController.shadowTestIndex = i;
			//	}
			//}
		}

		// Token: 0x06000026 RID: 38 RVA: 0x000033B4 File Offset: 0x000015B4
		private void CheckInit() {
			if (this.characterList == null) {
				this.characterList = new List<NiloToonPerCharacterRenderController>();
			}
		}

		// Token: 0x0400005B RID: 91
		private static NiloToonAllInOneRendererFeature _instance;

		// Token: 0x0400005C RID: 92
		[NonSerialized]
		public List<NiloToonPerCharacterRenderController> characterList;
	}
}
