using System;
using UnityEngine;
using UnityEngine.AdaptivePerformance;

public class AdaptivePerformanceController : MonoBehaviour
{
	private IAdaptivePerformance ap = null;

	void Start() {
		ap = Holder.Instance;
		if (!ap.Active) // 해당 디바이스가 ap를 지원하는지 체크.
			return;

		QualitySettings.lodBias = 1.0f;
		ap.ThermalStatus.ThermalEvent += OnThermalEvent;
		ap.PerformanceStatus.PerformanceBottleneckChangeEvent += OnBottleneckChange;
	}

	private void OnBottleneckChange(PerformanceBottleneckChangeEventArgs ev) {
		var ctrl = ap.DevicePerformanceControl;
		switch (ev.PerformanceBottleneck) {
			case PerformanceBottleneck.TargetFrameRate:
				if (ctrl.CpuLevel > 0) {
					ctrl.CpuLevel--;
				}
				if (ctrl.GpuLevel > 0) {
					ctrl.GpuLevel--;
				}
				break;
			case PerformanceBottleneck.GPU:
				if (ctrl.GpuLevel < ctrl.MaxGpuPerformanceLevel) {
					ctrl.GpuLevel++;
				}
				break;
			case PerformanceBottleneck.CPU:
				if (ctrl.CpuLevel < ctrl.MaxCpuPerformanceLevel) {
					ctrl.CpuLevel++;
				}
				break;
		}
	}

	void OnThermalEvent(ThermalMetrics ev) {

		//frame time을 얻거나 설정할때 사용.
		//ap.PerformanceStatus.FrameTiming.CurrentFrameTime

		// warninglevel에 따라 lod조정 예.
		switch (ev.WarningLevel) {
			case WarningLevel.NoWarning:
				QualitySettings.lodBias = 1;
				break;
			case WarningLevel.ThrottlingImminent:
				if (ev.TemperatureLevel > 0.8f)
					QualitySettings.lodBias = 0.75f;
				else
					QualitySettings.lodBias = 1.0f;
				break;
			case WarningLevel.Throttling:
				QualitySettings.lodBias = 0.5f;
				break;
		}
	}

	public void EnterMenu_Automatic() {
		if (!ap.Active)
			return;

		Application.targetFrameRate = 30;
		// Enable automatic regulation of CPU and GPU level by Adaptive Performance
		var ctrl = ap.DevicePerformanceControl;
		ctrl.AutomaticPerformanceControl = true;
	}

	// manual로 설정하는것은 권장하지는 않음.
	public void EnterMenu_Manually() {
		if (!ap.Active)
			return;

		var ctrl = ap.DevicePerformanceControl;
		// Set low CPU and GPU level in menu  
		ctrl.CpuLevel = 0;
		ctrl.GpuLevel = 0;
		// Set low target FPS  
		Application.targetFrameRate = 15;
	}

	public void ExitMenu() {
		if (!ap.Active)
			return;

		var ctrl = ap.DevicePerformanceControl;
		// Set higher CPU and GPU level when going back into the game  
		ctrl.CpuLevel = ctrl.MaxCpuPerformanceLevel;
		ctrl.GpuLevel = ctrl.MaxGpuPerformanceLevel;
	}
}
