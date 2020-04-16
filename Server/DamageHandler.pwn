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
    ScriptFile    : DeathHandler.pwn
    Author        : XeonMaster
    Version       : 1.0
    License       : GNU General v3.0
    Developers    : None
*/


public OnPlayerTakeDamage(playerid, issuerid, Float: amount, weaponid, bodypart)
{
	if(IsPlayerConnected(issuerid))
	{
		if(weaponid == 24 || weaponid == 34)
		{
			if(bodypart == 9)
			{
				SetPlayerHealth(playerid, 0);
				GameTextForPlayer(issuerid,"~r~Headshot",2000,3);
				GameTextForPlayer(playerid,"Ouch, ~r~Headshot",2000,3);
				PlayAudioStreamForPlayer(playerid, "http://crew.sa-mp.nl/jay/radio/headshot.mp3");
				PlayAudioStreamForPlayer(issuerid, "http://crew.sa-mp.nl/jay/radio/headshot.mp3");
				PlayerPlaySound(issuerid, 17802, 0.0, 0.0, 0.0);
				PlayerPlaySound(playerid, 17802, 0.0, 0.0, 0.0);
			}
		}
	}
    return 1;
}

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
    if(PlayerInfo[playerid][Fighting]) return 1;
    PlayerInfo[playerid][Fighting] = true;
    SetTimerEx("OnPlayerFinishFight", 10*1000, false, "i", playerid);
    return 1;
}