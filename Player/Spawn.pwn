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

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnPlayerSpawn(playerid)
{
    if(GetPVarInt(playerid, "FirstSpawn"))
    {
        if(PlayerInfo[playerid][VIP])
        {
            new
                weaponid,
                ammo,
                count;
            cache_get_row_count(count);

            for(new i, j = count; i < j; i++) 
            {
                cache_get_value_int(i, "WEAPONID", weaponid);
                cache_get_value_int(i, "AMMO", ammo);
                
                if(!(0 <= weaponid <= 46)) continue;
                
                GivePlayerWeapon(playerid, weaponid, ammo); 
            }
            new string[42];
            mysql_format(Database, string, sizeof(string), "DELETE FROM `WEAPONDATA` WHERE `ID` = %d", PlayerInfo[playerid][ID]);
            mysql_tquery(Database, string);
        }

    	StopAudioStreamForPlayer(playerid);
    	TextDrawHideForPlayer(playerid, Login[0]);
    	TextDrawHideForPlayer(playerid, Login[1]);
    	TextDrawHideForPlayer(playerid, Login[2]);
    	TextDrawHideForPlayer(playerid, Login[3]);
    	TextDrawHideForPlayer(playerid, Login[5]);
    	TextDrawHideForPlayer(playerid, Login[6]);
    	TextDrawHideForPlayer(playerid, Login[7]);
    	TextDrawShowForPlayer(playerid, Login[4]);

        PlayerInfo[playerid][PlayerTimer] = SetTimerEx("UpdatePlayerInfo", 1000, true, "i", playerid);
        DeletePVar(playerid, "FirstSpawn");
    }

	SetCameraBehindPlayer(playerid);
	TogglePlayerSpectating(playerid, 0);
	TogglePlayerControllable(playerid, 1);

	new
        Float:pos[3],
        x=random(4000)-2000,
        y=random(4000)-2000,
        Float:z;
               
    for(new a; a < 100; a++)
    {
        MapAndreas_FindZ_For2DCoord(x, y, z);
 
        if(z >= 5.0 && z < 30.0)
        {
            pos[0] = x;
            pos[1] = y;
            pos[2] = z;
            SetPlayerPos(playerid, x, y, z);
            break;
        }
    }
	return 1;
}