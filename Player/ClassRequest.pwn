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
    ScriptFile    : ClassRequest.pwn
    Author        : XeonMaster
    Version       : 1.0
    License       : GNU General v3.0
    Developers    : None
*/

public OnPlayerRequestClass(playerid, classid)
{
	if(PlayerInfo[playerid][LoggedIn]) return SpawnPlayer(playerid);
	
	PlayIntroMusic(playerid);
	new string[121];
	format(string, sizeof(string), "{C3C3C3}*{FFFFFF}%s{C3C3C3}({FFFFFF}%d{C3C3C3}) has joined {FF0000}Stunt Freeroam Server{C3C3C3}.", GetName(playerid), playerid);
	SendClientMessageToAll(-1, string);

	TextDrawShowForPlayer(playerid, Login[0]);
	TextDrawShowForPlayer(playerid, Login[1]);
	TextDrawShowForPlayer(playerid, Login[2]);
	TextDrawShowForPlayer(playerid, Login[3]);
	TextDrawShowForPlayer(playerid, Login[5]);
	TextDrawShowForPlayer(playerid, Login[6]);
	TextDrawShowForPlayer(playerid, Login[7]);

	SetPlayerVirtualWorld(playerid, WORLD_LOGIN);
	TogglePlayerSpectating(playerid, 1);
	InterpolateCameraLookAt(playerid, 0,0,0, 3000, 102, 100, 30*1000, CAMERA_MOVE);
	InterpolateCameraPos(playerid, 406.1719, 1900.1484, 35.8438, 3000, 102, 100, (1*60*1000)+30000, CAMERA_MOVE);

	PlayerInfo[playerid][PasswordFails] = 0;	
	mysql_format(Database, string, sizeof(string), "SELECT * FROM `PLAYERS` WHERE `USERNAME` = '%e' LIMIT 1", GetName(playerid));
	if(IsPlayerConnected(playerid)) mysql_tquery(Database, string, "ShowLoginDialog", "i", playerid);
	return 1;
}