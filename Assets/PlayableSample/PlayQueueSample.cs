using UnityEngine;
using UnityEngine.Animations;
using UnityEngine.Playables;

[RequireComponent(typeof(Animator))]
public class PlayQueueSample : MonoBehaviour
{
	public AnimationClip[] clipsToPlay;
	private PlayableGraph _playableGraph;

	private void Start() {

		_playableGraph = PlayableGraph.Create();
		var playQueuePlayable = ScriptPlayable<PlayQueuePlayable>.Create(_playableGraph);
		var playQueue = playQueuePlayable.GetBehaviour();
		playQueue.Initialize(clipsToPlay, playQueuePlayable, _playableGraph);

		var playableOutput = AnimationPlayableOutput.Create(
			_playableGraph, "Animation", GetComponent<Animator>());
		playableOutput.SetSourcePlayable(playQueuePlayable, 0);

		_playableGraph.Play();
	}

	private void OnDisable() {
		// Destroys all Playables and Outputs created by the graph.
		_playableGraph.Destroy();
	}
}

public class PlayQueuePlayable : PlayableBehaviour
{
	// https://docs.unity3d.com/ScriptReference/Playables.PlayableBehaviour.html

	private int _currentClipIndex = -1;
	private float _timeToNextClip;
	private Playable _mixer;

	/*
	 * OnPlayableCreate
	 * OnGraphStart
	 * OnBehaviourPlay
	 * PrepareFrame (each frame)
	 */

	public void Initialize(AnimationClip[] clipsToPlay, Playable owner, PlayableGraph graph) {

		owner.SetInputCount(1);

		_mixer = AnimationMixerPlayable.Create(graph, clipsToPlay.Length);

		graph.Connect(_mixer, 0, owner, 0);

		owner.SetInputWeight(0, 1);

		for (int clipIndex = 0; clipIndex < _mixer.GetInputCount(); ++clipIndex) {
			graph.Connect(AnimationClipPlayable.Create(graph, clipsToPlay[clipIndex]), 0, _mixer, clipIndex);
			_mixer.SetInputWeight(clipIndex, 1.0f);
		}
	}

	public override void PrepareFrame(Playable owner, FrameData info) {

		if (_mixer.GetInputCount() == 0) {
			return;
		}

		// Advance to next clip if necessary
		_timeToNextClip -= info.deltaTime;

		if (_timeToNextClip <= 0.0f) {
			_currentClipIndex++;
			if (_currentClipIndex >= _mixer.GetInputCount()) {
				_currentClipIndex = 0;
			}
			var currentClip = (AnimationClipPlayable)_mixer.GetInput(_currentClipIndex);
			// Reset the time so that the next clip starts at the correct position
			currentClip.SetTime(0);
			_timeToNextClip = currentClip.GetAnimationClip().length;

			// Adjust the weight of the inputs
			for (int clipIndex = 0; clipIndex < _mixer.GetInputCount(); ++clipIndex) {

				if (clipIndex == _currentClipIndex) {
					_mixer.SetInputWeight(clipIndex, 1.0f);
				}
				else {
					_mixer.SetInputWeight(clipIndex, 0.0f);
				}
			}
		}

		Debug.Log(":: PrepareFrame");
	}

	public override void OnBehaviourPause(Playable playable, FrameData info) {
		base.OnBehaviourPause(playable, info);

		Debug.Log(":: OnBehaviourPause");
	}

	public override void OnBehaviourPlay(Playable playable, FrameData info) {
		base.OnBehaviourPlay(playable, info);

		Debug.Log(":: OnBehaviourPlay");
	}

	public override void OnGraphStart(Playable playable) {
		base.OnGraphStart(playable);

		Debug.Log(":: OnGraphStart");
	}

	public override void OnGraphStop(Playable playable) {
		base.OnGraphStop(playable);

		Debug.Log(":: OnGraphStop");
	}

	public override void OnPlayableCreate(Playable playable) {
		base.OnPlayableCreate(playable);

		Debug.Log(":: OnPlayableCreate");
	}

	public override void OnPlayableDestroy(Playable playable) {
		base.OnPlayableDestroy(playable);

		Debug.Log(":: OnPlayableDestroy");
	}

	public override void PrepareData(Playable playable, FrameData info) {
		base.PrepareData(playable, info);

		Debug.Log(":: PrepareData");
	}

	public override void ProcessFrame(Playable playable, FrameData info, object playerData) {
		base.ProcessFrame(playable, info, playerData);

		Debug.Log(":: ProcessFrame");
	}
}