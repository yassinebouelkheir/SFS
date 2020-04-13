/**
 * Copyright (c) 2020 Stunt Freeroam Server (SFS)
 *
 * This program is free software: you can redistribute it and/or modify it under the terms of the
 * GNU General Public License as published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without
 * even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along with this program.
 * If not, see <http://www.gnu.org/licenses/>.
*/

 /* 
    ScriptFile    : Connections.pwn
    Author        : Spawn.pwn
    Version       : 1.0
    License       : GNU General v3.0
    Developers    : None
*/

public OnPlayerUpdate(playerid)
{
	if(IsPlayerInRangeOfPoint(playerid, 20.0, 2003.82617, 1545.35437, 12.59410) && GetPVarInt(playerid, "Safezone") == 0)
	{
		if(!GetPVarInt(playerid, "Radio"))
		{
			PlayAudioStreamForPlayer(playerid, "http://uk7.internet-radio.com:8040/listen.pls");
			SetPVarInt(playerid, "Radio", 1);
			SendClientMessage(playerid, -1, "{F2C80C}[SFS Radio]: {C3C3C3}Now playing '{FFFFFF}Top 100 Music Pop{C3C3C3}' {C3C3C3}by '{FFFFFF}Merge 104.8{C3C3C3}'.");
		}
		if(IsPlayerInAnyVehicle(playerid)) { SetVehicleToRespawn(GetPlayerVehicleID(playerid)); }
		SendClientMessage(playerid, -1, "{FF1493}[SFSafezone]: {C3C3C3}Welcome to Stunt Freeroam Server Safe Zone! You can safely idle here, have fun.");
		new Float:health;
		GetPlayerHealth(playerid, health);
		SetPlayerHealth(playerid, 999999);
		SetPVarInt(playerid, "Safezone", 1);
	}
	else if(!IsPlayerInRangeOfPoint(playerid, 20.0, 2003.82617, 1545.35437, 12.59410) && GetPVarInt(playerid, "Safezone") == 1)
	{
		if(GetPVarInt(playerid, "Radio"))
		{
			StopAudioStreamForPlayer(playerid);
			SetPVarInt(playerid, "Radio", 0);
		}
		SetPlayerHealth(playerid, 99.0);
		SetPVarInt(playerid, "Safezone", 0);
	}
	return 1;
}