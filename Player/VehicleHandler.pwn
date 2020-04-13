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
    ScriptFile    : VehicleHandler.pwn
    Author        : XeonMaster
    Version       : 1.0
    License       : GNU General v3.0
    Developers    : None
*/

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(PRESSED(KEY_FIRE))
    {
        if (IsPlayerInAnyVehicle(playerid))
        {
            AddVehicleComponent(GetPlayerVehicleID(playerid), 1010);
        }
    }
    return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    PlayAudioStreamForPlayer(playerid, "http://uk7.internet-radio.com:8040/listen.pls");
    SetPVarInt(playerid, "Radio", 1);
    SendClientMessage(playerid, -1, "{F2C80C}[SFS Radio]: {C3C3C3}Now playing '{FFFFFF}Top 100 Music Pop{C3C3C3}' {C3C3C3}by '{FFFFFF}Merge 104.8{C3C3C3}'.");
    return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
    StopAudioStreamForPlayer(playerid);
    SetPVarInt(playerid, "Radio", 0);
    return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
    return 1;
}

public OnVehicleDamageStatusUpdate(vehicleid, playerid)
{
    if(GetPVarInt(playerid, "IsGod"))
    {
        RepairVehicle(vehicleid);
        SetVehicleHealth(vehicleid, 1000);
    }
    return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
    if(vehicleid == XeonVeh[0] || vehicleid == XeonVeh[1])
    {
        if(PlayerInfo[forplayerid][Admin] != 4) SetVehicleParamsForPlayer(vehicleid, forplayerid, 0, 1);
    }
    if(vehicleid == GuardVeh[0] || vehicleid == GuardVeh[1] || vehicleid == GuardVeh[2])
    {
        if(PlayerInfo[forplayerid][Admin] < 3) SetVehicleParamsForPlayer(vehicleid, forplayerid, 0, 1);
    }
    return 1;
}