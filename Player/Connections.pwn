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
    Author        : XeonMaster
    Version       : 1.0
    License       : GNU General v3.0
    Developers    : None
*/

public OnPlayerConnect(playerid)
{
    ResetPlayerVariables(playerid);

	new colour = 0xFFFFFF00;
    new red = random(255);
    new green = random(255);
    new blue = random(255);
    
    colour = (colour & 0x00FFFFFF) | (red << 24);
    colour = (colour & 0xFF00FFFF) | (green << 16);
    colour = (colour & 0xFFFF00FF) | (blue << 8);
    
    SetPlayerColor(playerid, colour);

    new string[100];
    GetPlayerIp(playerid, string, sizeof(string));
    mysql_format(Database, string, sizeof(string), "INSERT INTO `connections`(`USERNAME`, `IP`) VALUES ('%e', '%e')", GetName(playerid), string);
    mysql_tquery(Database, string);

    new string2[24];
    GetPlayerCountry(playerid, string2, sizeof(string2));
    PlayerInfo[playerid][Country] = string2;
    printf("country1: %s", string2);
    printf("country2: %s", PlayerInfo[playerid][Country]);
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	new string[230];

	SetCameraBehindPlayer(playerid);
	SetPlayerVirtualWorld(playerid, 0);
	TogglePlayerSpectating(playerid, 0);

	if(cache_is_valid(PlayerInfo[playerid][Player_Cache]))
	{
		cache_delete(PlayerInfo[playerid][Player_Cache]); 
		PlayerInfo[playerid][Player_Cache] = MYSQL_INVALID_CACHE; 
	}

	PlayerInfo[playerid][LoggedIn] = false;

	mysql_format(Database, string, sizeof(string), "UPDATE `PLAYERS` SET `USERNAME` = '%e', `PASSWORD` = '%e', `SKIN` = %d WHERE `ID` = %d", GetName(playerid), PlayerInfo[playerid][Password], PlayerInfo[playerid][Salt], PlayerInfo[playerid][Skin], PlayerInfo[playerid][ID]);
 	mysql_tquery(Database, string);

    mysql_format(Database, string, sizeof(string), "UPDATE `PLAYERDATA` SET `BANKMONEY` = %d, `TIME` = %d, `KILLS` = %d, `DEATHS` = %d, COUNTRY = '%e' WHERE `ID` = %d", PlayerInfo[playerid][BankMoney], PlayerInfo[playerid][TimePlayed], PlayerInfo[playerid][Kills], PlayerInfo[playerid][Deaths], PlayerInfo[playerid][Country], PlayerInfo[playerid][ID]);
    mysql_tquery(Database, string);

    if(PlayerInfo[playerid][VIP] == true)
    {
        for(new i; i < 13; i++) 
        {
            new
                weaponid,
                ammo
            ;

            GetPlayerWeaponData(playerid, i, weaponid, ammo); 

            if(!weaponid) continue; 
            
            mysql_format(Database, string, sizeof(string), "INSERT INTO WEAPONSDATA (`ID`, `WEAPONID`, `AMMO`) VALUES (%d, %d, %d) ON DUPLICATE KEY UPDATE `AMMO` = %d;", PlayerInfo[playerid][ID], weaponid, ammo, ammo);
            mysql_tquery(Database, string); 
        }
    }

    ResetPlayerVariables(playerid);
    format(string, sizeof(string), "{C3C3C3}*{FFFFFF}%s{C3C3C3}({FFFFFF}%d{C3C3C3}) has left {FF0000}Stunt Freeroam Server{C3C3C3}.", GetName(playerid), playerid);
	SendClientMessageToAll(-1, string);
	return 1;
}