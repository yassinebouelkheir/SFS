#include <a_npc>

NextPlayBack()
{
	StartRecordingPlayback(PLAYER_RECORDING_TYPE_ONFOOT, "[LV]Ship[01]");
}

public OnRecordingPlaybackEnd()
{
	NextPlayBack();
}
public OnNPCSpawn()
{
	NextPlayBack();
}
public OnNPCExitVehicle()
{
	StopRecordingPlayback();
}