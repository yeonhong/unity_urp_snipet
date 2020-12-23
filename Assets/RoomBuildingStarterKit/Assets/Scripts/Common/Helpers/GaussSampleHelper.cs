namespace RoomBuildingStarterKit.Helpers
{
    using System;
    using UnityEngine;

    /// <summary>
    /// The GaussSamplesHelper class.
    /// </summary>
    public class GaussSamplesHelper
    {
        /// <summary>
        /// The gauss sample weights.
        /// </summary>
        private static float[][] gaussSamples;

        /// <summary>
        /// The sample count.
        /// </summary>
        private static int sampleCount = 16;

        /// <summary>
        /// Gets the gauss sample weights.
        /// </summary>
        /// <param name="width">The width.</param>
        /// <returns>The gauss sample weights array.</returns>
        public static float[] GetGaussSamples(int width)
        {
            var index = Mathf.Clamp(width, 1, sampleCount) - 1;
            
            if (gaussSamples is null)
            {
                gaussSamples = new float[sampleCount][];
            }

            if (gaussSamples[index] is null)
            {
                gaussSamples[index] = new float[sampleCount];
            }

            for (int i = 0; i < width; ++i)
            {
                var x = 2 * Mathf.Pow(width / 2, 2);
                gaussSamples[index][i] = 1 / Mathf.Sqrt(x * Mathf.PI) * Mathf.Pow((float)Math.E, -i * i / x);
            }

            return gaussSamples[index];
        }
    }
}