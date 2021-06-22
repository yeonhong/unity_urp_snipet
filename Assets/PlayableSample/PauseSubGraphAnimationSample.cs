
using UnityEngine;
using UnityEngine.Animations;
using UnityEngine.Playables;

[RequireComponent(typeof(Animator))]
public class PauseSubGraphAnimationSample : MonoBehaviour
{
	public AnimationClip clip0;
	public AnimationClip clip1;
	private PlayableGraph playableGraph;
	private AnimationMixerPlayable mixerPlayable;

	private void Start() {
		// Creates the graph, the mixer and binds them to the Animator.
		playableGraph = PlayableGraph.Create();

		var playableOutput = AnimationPlayableOutput.Create(playableGraph, "Animation", GetComponent<Animator>());

		mixerPlayable = AnimationMixerPlayable.Create(playableGraph, 2);
		playableOutput.SetSourcePlayable(mixerPlayable);

		// Creates AnimationClipPlayable and connects them to the mixer.

		var clipPlayable0 = AnimationClipPlayable.Create(playableGraph, clip0);
		var clipPlayable1 = AnimationClipPlayable.Create(playableGraph, clip1);
		playableGraph.Connect(clipPlayable0, 0, mixerPlayable, 0);
		playableGraph.Connect(clipPlayable1, 0, mixerPlayable, 1);
		mixerPlayable.SetInputWeight(0, 1.0f);
		mixerPlayable.SetInputWeight(1, 1.0f);

		//clipPlayable1.SetPlayState(PlayState.Paused);
		clipPlayable1.Pause();

		// Plays the Graph.
		playableGraph.Play();
	}

	private void OnDisable() {

		// Destroys all Playables and Outputs created by the graph.

		playableGraph.Destroy();

	}

}