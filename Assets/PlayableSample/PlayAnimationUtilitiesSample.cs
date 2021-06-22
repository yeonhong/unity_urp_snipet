using UnityEngine;
using UnityEngine.Playables;

[RequireComponent(typeof(Animator))]
public class PlayAnimationUtilitiesSample : MonoBehaviour
{
	public AnimationClip clip;
	private PlayableGraph playableGraph;

	private void Start() {
		AnimationPlayableUtilities.PlayClip(GetComponent<Animator>(), clip, out playableGraph);
	}

	private void OnDisable() {
		// Destroys all Playables and Outputs created by the graph.
		playableGraph.Destroy();
	}
}