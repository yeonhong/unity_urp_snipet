using System;
using UnityEngine;

/* - unsupport.
namespace UnityStandardAssets.ImageEffects
{
    [ExecuteInEditMode]
    [RequireComponent (typeof(Camera))]
	[AddComponentMenu ("Image Effects/Bloom and Glow/Radialblur2)")]
	public class Radialblur2 : PostEffectsBase
    {
        public enum BlurType
		{
            Standard = 0,
            Sgx = 1,
        }

        [Range(0.0f, 2.0f)]
		public float fSampleDist = 1.0f;
        [Range(0.0f, 10.0f)]
		public float fSampleStrength = 1.0f;
        public Shader fastBloomShader = null;
        private Material fastBloomMaterial = null;

        public override bool CheckResources ()
		{
            CheckSupport (false);

            fastBloomMaterial = CheckShaderAndCreateMaterial (fastBloomShader, fastBloomMaterial);

            if (!isSupported)
                ReportAutoDisable ();
            return isSupported;
        }

        void OnDisable ()
		{
            if (fastBloomMaterial)
                DestroyImmediate (fastBloomMaterial);
        }

        void OnRenderImage (RenderTexture source, RenderTexture destination)
		{
            if (CheckResources() == false)
			{
                Graphics.Blit (source, destination);
                return;
            }

			fastBloomMaterial.SetFloat ("fSampleDist", fSampleDist);
			fastBloomMaterial.SetFloat ("fSampleStrength", fSampleStrength);
			source.filterMode = FilterMode.Bilinear;

            // downsample
			RenderTexture rt = RenderTexture.GetTemporary (source.width/2, source.height/2, 0, source.format);
            rt.filterMode = FilterMode.Bilinear;
			Graphics.Blit (source, rt);
			Graphics.Blit (rt, destination, fastBloomMaterial);
            RenderTexture.ReleaseTemporary (rt);
        }
    }
}
*/
