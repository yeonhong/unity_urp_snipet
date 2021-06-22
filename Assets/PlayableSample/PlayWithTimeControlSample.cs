using UnityEngine;
using UnityEngine.Animations;
using UnityEngine.Playables;

[RequireComponent(typeof(Animator))]
public class PlayWithTimeControlSample : MonoBehaviour
{
	public AnimationClip clip;
	public float time;

	private PlayableGraph playableGraph;
	private AnimationClipPlayable playableClip;

	private void Start() {

		playableGraph = PlayableGraph.Create();

		var playableOutput = AnimationPlayableOutput.Create(playableGraph, "Animation", GetComponent<Animator>());

		// Wrap the clip in a playable
		playableClip = AnimationClipPlayable.Create(playableGraph, clip);

		// Connect the Playable to an output
		playableOutput.SetSourcePlayable(playableClip);

		// Plays the Graph.
		playableGraph.Play();

		// Stops time from progressing automatically.
		//playableClip.SetPlayState(PlayState.Paused);
		playableClip.Pause();
	}

	private void Update() {
		// Control the time manually
		playableClip.SetTime(time);
	}

	private void OnDisable() {
		// Destroys all Playables and Outputs created by the graph.
		playableGraph.Destroy();
	}
}