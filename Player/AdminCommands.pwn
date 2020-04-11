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
	new string[56];
	if(sscanf(params, "s[56]", string)) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid Syntax, please use {CC6600}/ann [text]{C3C3C3}.");
	GameTextForAll(string, 3000, 3);
	return 1;
}

CMD:warn(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 1) return 0;  
	new id, reason[50], string[122];
	if(sscanf(params, "us[50]", id, reason)) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid Syntax, please use {CC6600}/warn [playerid/name] [reason]{C3C3C3}.");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid playerid, This player is not connected."); 
	if(id == playerid) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid playerid, You can't warn yourself."); 

	format(string, sizeof(string), "{0000FF}[WARNING]: {C3C3C3}You have been warned by an administrator for: {FFFFFF}%s");
	SendClientMessage(id, -1, string);
	PlayerPlaySound(id, 1130, 0.0, 0.0, 10.0);
	return 1;
}

CMD:freeze(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 1) return 0; 
	new id;
	if(sscanf(params, "u", id)) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid Syntax, please use {CC6600}/freeze [playerid/name]{C3C3C3}.");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid playerid, This player is not connected."); 

	TogglePlayerControllable(id, false);
	return 1;
}

CMD:unfreeze(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 1) return 0; 
	new id;
	if(sscanf(params, "u", id)) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid Syntax, please use {CC6600}/freeze [playerid/name]{C3C3C3}.");
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
	return 1;
}

CMD:disarm(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 1) return 0; 
	new id;
	if(sscanf(params, "u", id)) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid Syntax, please use {CC6600}/disarm [playerid/name]{C3C3C3}.");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid playerid, This player is not connected."); 

	ResetPlayerWeapons(id);
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
	return 1;
}

CMD:oban(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 2) return 0; 
	return 1;
}

CMD:unban(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 2) return 0; 
	return 1;
}

CMD:aka(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 2) return 0; 
	return 1;	
}

CMD:akill(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 2) return 0; 
	return 1;
}

CMD:givecash(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 2) return 0; 
	return 1;
}

CMD:giveweapon(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 2) return 0; 
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
	if(sscanf(params, "d", id)) return 1;

	SetWeather(id);
	return 1;
}

CMD:settime(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 3) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid Syntax, please use {CC6600}/settime [time]{C3C3C3}."); 
	new id;
	if(sscanf(params, "d", id)) return 1;
	
	SetWorldTime(id);
	return 1;
}

CMD:fakedeath(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 3) return 0; 
	return 1;
}

CMD:setkills(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 3) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid Syntax, please use {CC6600}/setkills [playerid/name] [count]{C3C3C3}."); 
	new id, count;
	if(sscanf(params, "ud", id, count)) return 1;
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid playerid, This player is not connected.");

	PlayerInfo[id][Kills] = count;
	return 1;
}

CMD:setdeaths(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] < 3) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid Syntax, please use {CC6600}/setdeaths [playerid/name] [deaths]{C3C3C3}.");
	new id, count;
	if(sscanf(params, "ud", id, count)) return 1;
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid playerid, This player is not connected.");

	PlayerInfo[id][Deaths] = count;
	return 1;
}

// Owner
CMD:setlevel(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] != 4 && !IsPlayerAdmin(playerid)) return 0; 
	new id, level;
	if(sscanf(params, "ud", id, level)) return 1;
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
	return 1;
}

CMD:fakepm(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] != 4) return 0; 
	return 1;
}

CMD:fakecmd(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] != 4) return 0; 
	return 1;
}

CMD:exit(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] != 4) return 0;
	return 1;
} 