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
    ScriptFile    : AdminCommands.pwn
    Author        : XeonMaster
    Version       : 1.0
    License       : GNU General v3.0
    Developers    : None
*/

// Moderator
CMD:acmds(playerid)
{
	if(PlayerInfo[playerid][Admin] < 1) return 0;
	if(PlayerInfo[playerid][Admin] < 2)
	{
		ShowPlayerDialog(playerid, DIALOG_INVALID, DIALOG_STYLE_MSGBOX, "{FF0000}SFS: {FFFFFF}Admin Commands", "\
			{CC6600}Moderator Commands:{FFFFFF}\n\n\
			/spec    \t{FF0000}-{FFFFFF} .\n\
			/specoff \t{FF0000}-{FFFFFF} .\n\
			/ann     \t{FF0000}-{FFFFFF} .\n\
			/warn    \t{FF0000}-{FFFFFF} .\n\
			/freeze  \t{FF0000}-{FFFFFF} .\n\
			/unfreeze\t{FF0000}-{FFFFFF} .\n\
			/explode \t{FF0000}-{FFFFFF} .\n\
			/disarm  \t{FF0000}-{FFFFFF} .\n\
			/slap    \t{FF0000}-{FFFFFF} .\n\
			/god     \t{FF0000}-{FFFFFF} .\n\
			/say     \t{FF0000}-{FFFFFF} .\n\
		", "Cancel", "");
	}
	else
	{
		ShowPlayerDialog(playerid, DIALOG_ACMDS_MOD, DIALOG_STYLE_MSGBOX, "{FF0000}SFS: {FFFFFF}Admin Commands", "\
			{CC6600}Moderator Commands:{FFFFFF}\n\n\
			/spec    \t{FF0000}-{FFFFFF} .\n\
			/specoff \t{FF0000}-{FFFFFF} .\n\
			/ann     \t{FF0000}-{FFFFFF} .\n\
			/warn    \t{FF0000}-{FFFFFF} .\n\
			/freeze  \t{FF0000}-{FFFFFF} .\n\
			/unfreeze\t{FF0000}-{FFFFFF} .\n\
			/explode \t{FF0000}-{FFFFFF} .\n\
			/disarm  \t{FF0000}-{FFFFFF} .\n\
			/slap    \t{FF0000}-{FFFFFF} .\n\
			/god     \t{FF0000}-{FFFFFF} .\n\
			/say     \t{FF0000}-{FFFFFF} .\n\
		", "Next", "Cancel");		
	}
	return 1;
}

CMD:spec(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 1) return 0; 
	new id;
	if(sscanf(params, "u", id)) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid Syntax, please use {CC6600}/spec [playerid/name]{C3C3C3}.");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid playerid, This player is not connected."); 
	if(PlayerInfo[id][IsSpectating]) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}This player is in spectate mode.");
	if(id == playerid) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid playerid, You can't spectate youself."); 
	if(!PlayerInfo[playerid][IsSpectating]) TogglePlayerSpectating(playerid, true);
	PlayerSpectatePlayer(playerid, id);
	PlayerInfo[playerid][IsSpectating] = true;

	new string[156];
	format(string, sizeof(string), "{%06x}%s (Id: %d){C3C3C3} is now spectating {%06x}%s (Id: %d)", GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid, GetPlayerColor(id) >>> 8, GetName(id), id);
	SendAdminMessage(1, string);
	return 1;
}

CMD:specoff(playerid)
{
	if(PlayerInfo[playerid][Admin] < 1) return 0; 
	if(!PlayerInfo[playerid][IsSpectating]) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}You are not in spectate mode.");
	PlayerInfo[playerid][IsSpectating] = false;
	TogglePlayerSpectating(playerid, false);
	return 1;
}

CMD:ann(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 1) return 0; 
	new string[156];
	if(sscanf(params, "s[56]", string)) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid Syntax, please use {CC6600}/ann [text]{C3C3C3}.");
	GameTextForAll(string, 3000, 3);

	format(string, sizeof(string), "{%06x}%s (Id: %d){C3C3C3} has just launched an announce: {FFFFFF}%s", GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid, string);
	SendAdminMessage(1, string);
	return 1;
}

CMD:warn(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 1) return 0;  
	new id, reason[50], string[186];
	if(sscanf(params, "us[50]", id, reason)) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid Syntax, please use {CC6600}/warn [playerid/name] [reason]{C3C3C3}.");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid playerid, This player is not connected."); 
	if(id == playerid) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid playerid, You can't warn yourself."); 

	format(string, sizeof(string), "{0000FF}[WARNING]: {C3C3C3}You have been warned by an administrator for: {FFFFFF}%s");
	SendClientMessage(id, -1, string);
	PlayerPlaySound(id, 1130, 0.0, 0.0, 10.0);

	format(string, sizeof(string), "{%06x}%s (Id: %d){C3C3C3} has been warned by {%06x}%s (Id: %d) {C3C3C3}for: {FFFFFF}%s", GetPlayerColor(id) >>> 8, GetName(id), id, GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid, string);
	SendAdminMessage(1, string);
	return 1;
}

CMD:freeze(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 1) return 0; 
	new id;
	if(sscanf(params, "u", id)) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid Syntax, please use {CC6600}/freeze [playerid/name]{C3C3C3}.");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid playerid, This player is not connected."); 

	TogglePlayerControllable(id, false);

	new string[156];
	format(string, sizeof(string), "{%06x}%s (Id: %d){C3C3C3} has been frozen by {%06x}%s (Id: %d).", GetPlayerColor(id) >>> 8, GetName(id), id, GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid);
	SendAdminMessage(1, string);
	return 1;
}

CMD:unfreeze(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 1) return 0; 
	new id;
	if(sscanf(params, "u", id)) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid Syntax, please use {CC6600}/unfreeze [playerid/name]{C3C3C3}.");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid playerid, This player is not connected."); 

	TogglePlayerControllable(id, true);
	return 1;
}

CMD:explode(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 1) return 0; 
	new id;
	if(sscanf(params, "u", id)) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid Syntax, please use {CC6600}/explode [playerid/name]{C3C3C3}.");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid playerid, This player is not connected."); 

	new Float:x, Float:y, Float:z;
	GetPlayerPos(id, x, y, z);
	CreateExplosion(x, y, z, 7, 10);

	new string[156];
	format(string, sizeof(string), "{%06x}%s (Id: %d){C3C3C3} has been exploded by {%06x}%s (Id: %d).", GetPlayerColor(id) >>> 8, GetName(id), id, GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid);
	SendAdminMessage(1, string);
	return 1;
}

CMD:disarm(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 1) return 0; 
	new id;
	if(sscanf(params, "u", id)) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid Syntax, please use {CC6600}/disarm [playerid/name]{C3C3C3}.");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid playerid, This player is not connected."); 

	ResetPlayerWeapons(id);

	new string[156];
	format(string, sizeof(string), "{%06x}%s (Id: %d){C3C3C3} has been disarmed by {%06x}%s (Id: %d).", GetPlayerColor(id) >>> 8, GetName(id), id, GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid);
	SendAdminMessage(1, string);
	return 1;
}

CMD:slap(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 1) return 0; 
	new id;
	if(sscanf(params, "u", id)) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid Syntax, please use {CC6600}/slap [playerid/name]{C3C3C3}.");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid playerid, This player is not connected."); 

	new Float:x, Float:y, Float:z;
	GetPlayerPos(id, x, y, z);
	SetPlayerPos(id, x, y, z+5.0);
	PlayerPlaySound(id, 1130, 0.0, 0.0, 10.0);

	new string[156];
	format(string, sizeof(string), "{%06x}%s (Id: %d){C3C3C3} has been slapped by {%06x}%s (Id: %d).", GetPlayerColor(id) >>> 8, GetName(id), id, GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid);
	SendAdminMessage(1, string);
	return 1;
}

CMD:god(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 1) return 0; 
	new id;
	if(sscanf(params, "u", id)) id = playerid;
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid playerid, This player is not connected."); 
	if(GetPVarInt(id, "IsGod"))
	{
		SetPlayerHealth(id, 99.0);
		SetPVarInt(id, "IsGod", 0);
	}
	else
	{
		SetPlayerHealth(id, 99999.0);
		SetPVarInt(id, "IsGod", 1);
	}

	new string[156];
	format(string, sizeof(string), "{%06x}%s (Id: %d){C3C3C3} is now in god mode by {%06x}%s (Id: %d).", GetPlayerColor(id) >>> 8, GetName(id), id, GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid);
	SendAdminMessage(1, string);
	return 1;	
}

CMD:say(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 1) return 0; 
	new string[214]; 
	if(sscanf(params, "s[214]", string)) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid Syntax, please use {CC6600}/say [text]{C3C3C3}.");
	
	format(string, sizeof(string), "{C3C3C3}*%s {%06x}%s{C3C3C3}:{FFFFFF} %s", GetLevelName(PlayerInfo[playerid][Admin]), GetPlayerColor(playerid) >>> 8, GetName(playerid), string);
	SendClientMessageToAll(-1, string);
	return 1;	
}

CMD:usay(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 1) return 0;
	new string[194]; 
	if(sscanf(params, "s[194]", string)) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid Syntax, please use {CC6600}/usay [text]{C3C3C3}.");
	
	format(string, sizeof(string), "{C3C3C3}*%s{C3C3C3}:{FFFFFF} %s", GetLevelName(PlayerInfo[playerid][Admin]), string);
	SendClientMessageToAll(-1, string);
	return 1;	
}

CMD:kick(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 1) return 0;
	new id, reason[50];
	if(sscanf(params, "us[50]", id, reason)) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid Syntax, please use {CC6600}/kick [playerid/name] [reason]{C3C3C3}.");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid playerid, This player is not connected."); 

	for(new i = 0; i < 20; i++) SendClientMessage(id, -1, " ");

	SetPlayerVirtualWorld(id, WORLD_KICK);

	new string[216];
	format(string, sizeof(string), "{C3C3C3}You have been kicked from {FF0000}Stunt Freeroam Server{C3C3C3}by: {%06x}%s (Id: %d){C3C3C3}.", GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid);
	SendClientMessage(id, -1, string);

	format(string, sizeof(string), "{C3C3C3}Reason: {FFFFFF}%s", reason);
	SendClientMessage(id, -1, string);
		
	new Year, Month, Day, Hour, Minute, Second;
	getdate(Year, Month, Day);
	gettime(Hour, Minute, Second);

	format(string, sizeof(string), "{C3C3C3}Date: {FFFFFF}%s %d %s %d at %02d:%02d:%02d", GetWeekDay(), Day, GetMonthName(Month), Year, Hour, Minute, Second);
	SendClientMessage(id, -1, string);

	SendClientMessage(id, -1, "{C3C3C3}If you think that you are kicked wrongfully, you can fill up a report in our forum.");
	SendClientMessage(id, -1, "{C3C3C3}Forum Link: {FFFFFF}https://forum.com");

	format(string, sizeof(string), "{%06x}%s (Id: %d){C3C3C3} kicked {%06x}%s (Id: %d){C3C3C3} for: {FFFFFF}%s.", GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid, GetPlayerColor(id) >>> 8, GetName(id), id, reason);
	SendAdminMessage(1, string);

	SetTimerEx("KickTimer", 200, false, "ii", 0, id);
	return 1;
}

// Administrator
CMD:cc(playerid)
{
	if(PlayerInfo[playerid][Admin] < 2) return 0; 
	for(new i = 0; i < 50; i++) SendClientMessageToAll(-1, " ");
	SendClientMessageToAll(-1, "{0000FF}[SFAdmin]: {C3C3C3}Main chat was cleared by an administrator.");
	return 1;
}

CMD:ban(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 2) return 0; 
	new id, reason[50], days;
	if(sscanf(params, "uis[50]", id, days, reason)) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid Syntax, please use {CC6600}/ban [playerid/name] [days] [reason]{C3C3C3}.");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid playerid, This player is not connected."); 
	if(days <= 0) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid days entry, you should ban for atleast a day.");

	for(new i = 0; i < 20; i++) SendClientMessage(id, -1, " ");

	SetPlayerVirtualWorld(id, WORLD_KICK);

	new string[216];
	format(string, sizeof(string), "{C3C3C3}You have been banned from {FF0000}Stunt Freeroam Server{C3C3C3}by: {%06x}%s (Id: %d){C3C3C3}.", GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid);
	SendClientMessage(id, -1, string);

	format(string, sizeof(string), "{C3C3C3}Reason: {FFFFFF}%s", reason);
	SendClientMessage(id, -1, string);

	format(string, sizeof(string), "{C3C3C3}Duration: {FFFFFF}%d days", days);
	SendClientMessage(id, -1, string);

	new Year, Month, Day, Hour, Minute, Second;
	getdate(Year, Month, Day);
	gettime(Hour, Minute, Second);

	format(string, sizeof(string), "{C3C3C3}Date: {FFFFFF}%s %d %s %d at %02d:%02d:%02d", GetWeekDay(), Day, GetMonthName(Month), Year, Hour, Minute, Second);
	SendClientMessage(id, -1, string);

	SendClientMessage(id, -1, "{C3C3C3}If you think that you are banned, you can fill up a report in our forum.");
	SendClientMessage(id, -1, "{C3C3C3}Forum Link: {FFFFFF}https://forum.com");

	new ip[16];
	GetPlayerIp(id, ip, sizeof(ip));

	BanPlayer(GetName(id), GetName(playerid), days, reason, PlayerInfo[id][ClientID], ip);
	
	format(string, sizeof(string), "{%06x}%s (Id: %d){C3C3C3} banned {%06x}%s (Id: %d){C3C3C3} for: {FFFFFF}%s.", GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid, GetPlayerColor(id) >>> 8, GetName(id), id, reason);
	SendAdminMessage(1, string);

	SetTimerEx("KickTimer", 200, false, "ii", 1, id);
	return 1;
}

CMD:unban(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 2) return 0; 
	new string[24]; 
	if(sscanf(params, "s[24]", string)) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid Syntax, please use {CC6600}/unban [name]{C3C3C3}.");

	mysql_format(Database, string, sizeof(string), "DELETE FROM `BANINFO` WHERE `USERNAME` = '%e'", string);
	mysql_tquery(Database, string);

	SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}For security reasons, all bans records associated with this name has been deleted.");
	return 1;
}

CMD:aka(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 2) return 0; 
	new id;
	if(sscanf(params, "u", id)) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid Syntax, please use {CC6600}/aka [playerid/name]{C3C3C3}.");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid playerid, This player is not connected.");
	new ip[16], clientid[40], string[160];
	gpci(id, clientid, sizeof(clientid));
	GetPlayerIp(id, ip, sizeof(ip));
	mysql_format(Database, string, sizeof(string), "SELECT `USERNAME`, `DATE` FROM `CONNECTIONS` WHERE `IP` = '%e' OR `CLEINTID` = '%e'", ip, clientid);
	mysql_tquery(Database, string, "GetPlayerAKA", "i", playerid);
	return 1;	
}

CMD:oaka(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 2) return 0; 
	new ip[16], string[80];
	if(sscanf(params, "s[16]", ip)) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid Syntax, please use {CC6600}/oaka [IP]{C3C3C3}.");
	mysql_format(Database, string, sizeof(string), "SELECT `USERNAME`, `DATE` FROM `CONNECTIONS` WHERE `IP` = '%e'", ip);
	mysql_tquery(Database, string, "GetPlayerAKA", "i", playerid);
	return 1;
}

CMD:akill(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 2) return 0; 
	new id;
	if(sscanf(params, "u", id)) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid Syntax, please use {CC6600}/akill [playerid/name]{C3C3C3}.");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid playerid, This player is not connected.");
	
	SetPlayerHealth(id, 0.0);
	SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Player is dead.");

	new string[150]; 
	format(string, sizeof(string), "{%06x}%s (Id: %d){C3C3C3} has been killed by {%06x}%s (Id: %d){C3C3C3}.", GetPlayerColor(id) >>> 8, GetName(id), id, GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid);
	SendAdminMessage(1, string);
	return 1;
}

CMD:givecash(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 2) return 0;
	new id, cash;
	if(sscanf(params, "ii", id, cash)) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid Syntax, please use {CC6600}/givecash [playerid] [cash]{C3C3C3}.");
	if(!IsPlayerConnected(id) && id != -1) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid playerid, This player is not connected.");

	if(id == -1)
	{
		foreach(new i : Player) { GivePlayerMoney(i, cash); SetPlayerScore(id, GetPlayerMoney(id)); }
		SendClientMessageToAll(-1, "{0000FF}[SFAdmin]: {C3C3C3}You have been given some cash by an administrator.");
		new string[150]; 
		format(string, sizeof(string), "{%06x}%s (Id: %d){C3C3C3} gave $%s to everyone.", GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid, FormatNumber(cash));
		SendAdminMessage(1, string);
	}
	else
	{
		GivePlayerMoney(id, cash);
		SetPlayerScore(id, GetPlayerMoney(id));
		SendClientMessage(id, -1, "{0000FF}[SFAdmin]: {C3C3C3}You have been given some cash by an administrator.");  

		new string[160]; 
		format(string, sizeof(string), "{%06x}%s (Id: %d){C3C3C3} gave $%s to {%06x}%s (Id: %d){C3C3C3}.",GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid, FormatNumber(cash), GetPlayerColor(id) >>> 8, GetName(id), id);
		SendAdminMessage(1, string);
	}
	return 1;
}

CMD:giveweapon(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 2) return 0; 
	new id, weaponid, ammo;
	if(sscanf(params, "iii", id, weaponid, ammo)) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid Syntax, please use {CC6600}/giveweapon [playerid] [weaponid] [ammo]{C3C3C3}.");
	if(!IsPlayerConnected(id) && id != -1) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid playerid, This player is not connected.");
	if(weaponid <= 0 && weaponid >= 39) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid weaponid, please try again.");
	if(id == -1)
	{
		foreach(new i : Player) GivePlayerWeapon(i, weaponid, ammo);
		SendClientMessageToAll(-1, "{0000FF}[SFAdmin]: {C3C3C3}You have been given some weapons by an administrator.");
		new string[150]; 
		format(string, sizeof(string), "{%06x}%s (Id: %d){C3C3C3} gave weapon id %d to everyone.", GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid, weaponid);
		SendAdminMessage(1, string);
	}
	else
	{
		GivePlayerWeapon(id, weaponid, ammo);
		SendClientMessage(id, -1, "{0000FF}[SFAdmin]: {C3C3C3}You have been given some weapons by an administrator."); 

		new string[160]; 
		format(string, sizeof(string), "{%06x}%s (Id: %d){C3C3C3} gave weapon id %d to {%06x}%s (Id: %d){C3C3C3}.", GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid, weaponid, GetPlayerColor(id) >>> 8, GetName(id), id);
		SendAdminMessage(1, string);
	}
	return 1;
}


// Manager
CMD:givevip(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 3) return 0;
	new id;
	if(sscanf(params, "u", id)) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid Syntax, please use {CC6600}/givevip [playerid/name]{C3C3C3}.");
	if(PlayerInfo[id][VIP]) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}This player already has this level.");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid playerid, This player is not connected.");

	PlayerInfo[id][VIP] = true;
	SendClientMessage(id, -1, "{0000FF}[SFAdmin]: {C3C3C3}You have been given a VIP Status, Congratulations.");

	new string[82];
	mysql_format(Database, string, sizeof(string), "UPDATE `PLAYERDATA` SET `VIP` = 1 WHERE `ID` = %d", PlayerInfo[id][ID]);
	mysql_tquery(Database, string);
	return 1;
}

CMD:remvip(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 3) return 0;
	new id;
	if(sscanf(params, "u", id)) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid Syntax, please use {CC6600}/remvip [playerid/name]{C3C3C3}.");
	if(!PlayerInfo[id][VIP]) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}This player already has this level.");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid playerid, This player is not connected.");

	PlayerInfo[id][VIP] = false;
	SendClientMessage(id, -1, "{0000FF}[SFAdmin]: {C3C3C3}An manager has removed your vip status.");

	new string[82];
	mysql_format(Database, string, sizeof(string), "UPDATE `PLAYERDATA` SET `VIP` = 0 WHERE `USERNAME` = '%e'", GetName(id));
	mysql_tquery(Database, string);
	return 1;
}

CMD:dchat(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 3) return 0; 
	if(GlobalChat)
	{
		GlobalChat = false;
		SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Chat has been disabled successfully.");
		SendClientMessageToAll(-1, "{0000FF}[SFAdmin]: {C3C3C3}Chat was disabled by an administrator.");
	}
	else
	{
		GlobalChat = true;
		SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Chat has been enabled successfully.");
		SendClientMessageToAll(-1, "{0000FF}[SFAdmin]: {C3C3C3}Chat was enabled by an administrator.");
	}
	return 1;
}

CMD:setweather(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 3) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid Syntax, please use {CC6600}/setweather [weatherid]{C3C3C3}."); 
	new id;
	if(sscanf(params, "i", id)) return 1;

	SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}World weather has been updated.");
	return 1;
}

CMD:settime(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 3) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid Syntax, please use {CC6600}/settime [time]{C3C3C3}."); 
	new id;
	if(sscanf(params, "i", id)) return 1;
	
	SetWorldTime(id);
	SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}World time has been updated.");
	return 1;
}

CMD:fakedeath(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 3) return 0; 
	new id1, id2;
	if(sscanf(params, "uu", id1, id2)) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid Syntax, please use {CC6600}/fakedeath [playerid/name] [killerid/name]{C3C3C3}."); 
	if(!IsPlayerConnected(id1)) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid playerid, player is not connected.");
	if(!IsPlayerConnected(id2)) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid killerid, killer is not connected.");
	if(id1 == id2) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid playerid, playerid is killerid.");

	SendDeathMessage(id2, id1, 12);
	SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Fake Death sent.");
	return 1;
}

CMD:setkills(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 3) return 0; 
	new id, count;
	if(sscanf(params, "ui", id, count)) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid Syntax, please use {CC6600}/setkills [playerid/name] [count]{C3C3C3}."); 
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid playerid, This player is not connected.");

	PlayerInfo[id][Kills] = count;
	SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Kills value has been updated for this player.");
	return 1;
}

CMD:setdeaths(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 3) return 0;
	new id, count;
	if(sscanf(params, "ui", id, count)) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid Syntax, please use {CC6600}/setdeaths [playerid/name] [deaths]{C3C3C3}.");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid playerid, This player is not connected.");

	PlayerInfo[id][Deaths] = count;
	SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Deaths value has been updated for this player.");
	return 1;
}

// Owner
CMD:setlevel(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] != 4 && !IsPlayerAdmin(playerid)) return 0; 
	new id, level;
	if(sscanf(params, "ui", id, level)) return 1;
	if(PlayerInfo[id][Admin] == level) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}This player already has this level.");
	if(level < 0 || level > 4) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid level, Please try again.");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid playerid, This player is not connected.");

	new string[128];
	if(PlayerInfo[id][Admin] < level) format(string, sizeof(string), "{0000FF}[SFAdmin]: {C3C3C3}You have been promoted to an %s{C3C3C3}.", GetLevelName(level));
	else format(string, sizeof(string), "{0000FF}[SFAdmin]: {C3C3C3}You have been demoted to an %s{C3C3C3}.", GetLevelName(level));

	PlayerInfo[id][Admin] = level;
	SendClientMessage(id, -1, string);

	mysql_format(Database, string, sizeof(string), "UPDATE `PLAYERDATA` SET `ADMIN` = %d WHERE `ID` = %d", level, PlayerInfo[id][ID]);
	mysql_tquery(Database, string);
	return 1;
}

CMD:fakechat(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] != 4) return 0; 
	new id, message[150];
	if(sscanf(params, "us[144]", id, message)) return 0;
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid playerid, player 1 is not connected.");
	OnPlayerText(id, message);
	SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Fake Message sent.");
	return 1;
}

CMD:fakepm(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] != 4) return 0; 
	new id1, id2, message[150];
	if(sscanf(params, "uus[144]", id1, id2, message)) return 0;
	if(!IsPlayerConnected(id1)) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid playerid, player 1 is not connected.");
	if(!IsPlayerConnected(id2)) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid playerid, player 2 is not connected.");
	if(id1 == id2) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid playerid, player1 is player2.");

	format(message, sizeof(message), "%d %s", id2, message);
	cmd_pm(id1, message);
	SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Fake Private message sent.");
	return 1;
}

CMD:fakecmd(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] != 4) return 0;
	new id, cmdParams[50], cmdToForce[50];
    if(sscanf(params, "us[50]s[50]()", id, cmdToForce, cmdParams)) return 0; 
    if(!IsPlayerConnected(id)) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid playerid, This player is not connected.");
    
    format(cmdToForce, sizeof(cmdToForce), "cmd_%s", cmdToForce);
    if(funcidx(cmdToForce) != -1)
    {
        if(isnull(cmdParams)) CallLocalFunction(cmdToForce, "i", id);
        else CallLocalFunction(cmdToForce, "is", id, cmdParams);
        SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Fake Command sent.");
    }
    else SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid Command, Please try again.");
	return 1;
}

CMD:exit(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] != 4) return 0;
	SendRconCommand("exit");
	return 1;
} 