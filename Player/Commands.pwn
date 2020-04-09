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
    ScriptFile    : Commands.pwn
    Author        : XeonMaster
    Version       : 1.0
    License       : GNU General v3.0
    Developers    : None
*/

CMD:pm(playerid, params[])
{
	if(PlayerInfo[playerid][PMDisabled]) return SendClientMessage(playerid, -1, "{CC6600}[SFPrivate]: {C3C3C3}You disabled pms, please use {CC6600}/dpms to enabled them back{C3C3C3}.");
	new string[256], message[144], id;
	if(sscanf(params, "us[144]", id, message)) return SendClientMessage(playerid, -1, "{CC6600}[SFPrivate]: {C3C3C3}Invalid Syntax, please use {CC6600}/pm [playerid/name] [message]{C3C3C3}.");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, -1, "{CC6600}[SFPrivate]: {C3C3C3}This player is not connected.");
	if(playerid == id) return SendClientMessage(playerid, -1, "{CC6600}[SFPrivate]: {C3C3C3}Invalid playerid, You can't message yourself.");

	if(PlayerInfo[id][PMDisabled] && !PlayerInfo[playerid][Admin]) return SendClientMessage(playerid, -1, "{CC6600}[SFPrivate]: {C3C3C3}This player have pms disabled.");

	format(string, sizeof(string), "{FFCC00}[SFPrivate]: New PM from {%06x}%s [%d]{FFCC00}: {FFFFFF}%s", GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid, message);
	SendClientMessage(id, -1, string);
	SendClientMessage(id, -1, "{FFCC00}[SFPrivate]: {C3C3C3}You can use /reply or /r to fast reply to this pm.");

	format(string, sizeof(string), "{FF9900}[SFPrivate]: Sent PM to {%06x}%s [%d]{FF9900}: {FFFFFF}%s", GetPlayerColor(id) >>> 8, GetName(id), id, message);
	SendClientMessage(playerid, -1, string);

	SetPVarInt(id, "LastPM", playerid);
	SetPVarInt(playerid, "LastPM", id);
	SendPMToAdmins(playerid, id, message);
	return 1;
}

CMD:reply(playerid, params[]) return cmd_r(playerid, params);
CMD:r(playerid, params[])
{
	if(PlayerInfo[playerid][PMDisabled]) return SendClientMessage(playerid, -1, "{CC6600}[SFPrivate]: {C3C3C3}You disabled pms, please use {CC6600}/dpms to enabled them back{C3C3C3}.");
	new string[256], message[144];
	if(sscanf(params, "s[144]", message)) return SendClientMessage(playerid, -1, "{CC6600}[SFPrivate]: {C3C3C3}Invalid Syntax, please use {CC6600}/r(eply) [message]{C3C3C3}.");
	
	new id = GetPVarInt(playerid, "LastPM");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, -1, "{CC6600}[SFPrivate]: {C3C3C3}This player is not connected.");
	if(playerid == id) return SendClientMessage(playerid, -1, "{CC6600}[SFPrivate]: {C3C3C3}Invalid playerid, You can't message yourself.");

	if(PlayerInfo[id][PMDisabled] && !PlayerInfo[playerid][Admin]) return SendClientMessage(playerid, -1, "{CC6600}[SFPrivate]: {C3C3C3}This player have pms disabled.");

	format(string, sizeof(string), "{FFCC00}[SFPrivate]: New PM from {%06x}%s [%d]{FFCC00}: {FFFFFF}%s", GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid, message);
	SendClientMessage(id, -1, string);
	SendClientMessage(id, -1, "{FFCC00}[SFPrivate]: {C3C3C3}You can use /reply or /r to fast reply to this pm.");

	format(string, sizeof(string), "{FF9900}[SFPrivate]: Sent PM to {%06x}%s [%d]{FF9900}: {FFFFFF}%s", GetPlayerColor(id) >>> 8, GetName(id), id, message);
	SendClientMessage(playerid, -1, string);

	SetPVarInt(id, "LastPM", playerid);
	SetPVarInt(playerid, "LastPM", id);
	SendPMToAdmins(playerid, id, message);
	return 1;
}

CMD:dpms(playerid) return cmd_disablepms(playerid);
CMD:disablepms(playerid)
{
	if(PlayerInfo[playerid][Admin] != 0) return 0;
	if(PlayerInfo[playerid][PMDisabled])
	{
		PlayerInfo[playerid][PMDisabled] = false;
		SendClientMessage(playerid, -1, "{FFCC00}[SFPrivate]: {C3C3C3}You {00FF00}enabled{C3C3C3} pms, now you can send & recieve private messages.");
		return 1;
	}
	else
	{
		PlayerInfo[playerid][PMDisabled] = true;
		SendClientMessage(playerid, -1, "{FFCC00}[SFPrivate]: {C3C3C3}You {FF0000}disabled{C3C3C3} pms, from now on you can't recieve nor send private messages.");
		return 1;
	}
}

CMD:skin(playerid, params[]) return cmd_skins(playerid, params);
CMD:skins(playerid, params[]) 
{
	new skinid;
	if(!sscanf(params, "i", skinid)) return OnDialogResponse(playerid, DIALOG_SKIN, true, skinid, "");

    const MAX_SKINS = 312;
    new subString[16];
    static string[MAX_SKINS * sizeof(subString)];

    if (string[0] == EOS) 
    {
        for (new i; i < MAX_SKINS; i++) 
        {
            format(subString, sizeof(subString), "%i\tID: %i\n", i, i);
            strcat(string, subString);
        }
    }

    ShowPlayerDialog(playerid, DIALOG_SKIN, DIALOG_STYLE_PREVIEW_MODEL, "SFS: Skins", string, "Select", "Cancel");
    return 1;
}

CMD:change(playerid, params[])
{
	new param[20];
    if (sscanf(params, "s[20]", param)) return SendClientMessage(playerid, -1, "{FF0000}[SFServer]: {C3C3C3}Invalid Syntax, please use {CC6600}/change [password/name]{C3C3C3}.");
    if (!strcmp(param, "password", true, 8))
    {
    	ShowPlayerDialog(playerid, DIALOG_CHANGE_PASS, DIALOG_STYLE_PASSWORD, "{FF0000}SFS: {FFFFFF}Change your password", "{FFFFFF}Please enter your new password below:{FFFFFF}", "Finish", "Cancel");
    	return 1;
    }
    else if(!strcmp(param, "name", true, 4))
    {	
    	ShowPlayerDialog(playerid, DIALOG_CHANGE_NAME, DIALOG_STYLE_INPUT, "{FF0000}SFS: {FFFFFF}Change your nickname", "{FFFFFF}Please enter your new nickname below:\n\n\
    		{FF0000}- {FFFFFF}Please choose nickname between and 3-20 characters.\n\
    		{FF0000}- {FFFFFF}Please use only a-z, A-Z, 0-9.\n\
    		{FF0000}- {FFFFFF}Note that you won't be able to change your nickname for the next 7 days.\n", "Finish", "Cancel");
    	return 1;
    }
    else SendClientMessage(playerid, -1, "{FF0000}[SFServer]: {C3C3C3}Invalid Syntax, please use {CC6600}/change [password/name]{C3C3C3}.");
	return 1;
}

CMD:stats(playerid, params[])
{
	new string[1512], hours = 0, minutes = 0, seconds = 0;
	format(string, sizeof(string), "{FFFFFF}\t{%06x}%s [%d]{FFFFFF} Statistics:\n\n", GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid);

	format(string, sizeof(string), "{FFFFFF}%s\t{0B98D4}General Statistics:\n\n", string);
	format(string, sizeof(string), "{FFFFFF}%s\t{FF0000}- {C3C3C3}Nickname: {FFFFFF}%s\n", string, GetName(playerid));
	format(string, sizeof(string), "{FFFFFF}%s\t{FF0000}- {C3C3C3}Country: {FFFFFF}%s\n", string, PlayerInfo[playerid][Country]);
	format(string, sizeof(string), "{FFFFFF}%s\t{FF0000}- {C3C3C3}Skin: {FFFFFF}%d\n", string, GetPlayerSkin(playerid));
	format(string, sizeof(string), "{FFFFFF}%s\t{FF0000}- {C3C3C3}Cash: {FFFFFF}%d\n", string, PlayerInfo[playerid][Cash]);
	format(string, sizeof(string), "{FFFFFF}%s\t{FF0000}- {C3C3C3}Bank Money: {FFFFFF}%d\n", string, PlayerInfo[playerid][BankMoney]);
	format(string, sizeof(string), "{FFFFFF}%s\t{FF0000}- {C3C3C3}Level: {FFFFFF}%s\n", string, GetLevelName(PlayerInfo[playerid][Admin]));
	format(string, sizeof(string), "{FFFFFF}%s\t{FF0000}- {C3C3C3}VIP: {FFFFFF}%s\n\n\n", string, (PlayerInfo[playerid][VIP] ? ("{00FF00}Yes{C3C3C3}") : ("{FF0000}No{C3C3C3}")));

	format(string, sizeof(string), "{FFFFFF}%s\t{0B98D4}Gameplay Statistics:\n\n", string);
	
	minutes = PlayerInfo[playerid][TimePlayed] / 60;
  	seconds = PlayerInfo[playerid][TimePlayed] % 60;
  	hours = minutes / 60;
  	minutes = minutes % 60;
	
	format(string, sizeof(string), "{FFFFFF}%s\t{FF0000}-{C3C3C3}Time played: {FFFFFF}%02d {C3C3C3}hours,{FFFFFF} %02d {C3C3C3}minutes,{FFFFFF} %02d {C3C3C3}seconds{FFFFFF}\n", string, hours, minutes, seconds);

	format(string, sizeof(string), "{FFFFFF}%s\t{FF0000}- {C3C3C3}Registration Date: {FFFFFF}%s\n", string, PlayerInfo[playerid][RegisterDate]);
	format(string, sizeof(string), "{FFFFFF}%s\t{FF0000}- {C3C3C3}Kills: {FFFFFF}%d\n", string, PlayerInfo[playerid][Kills]);
	format(string, sizeof(string), "{FFFFFF}%s\t{FF0000}- {C3C3C3}Deaths: {FFFFFF}%d\n", string, PlayerInfo[playerid][Deaths]);

	if(PlayerInfo[playerid][Kills] == 0 && PlayerInfo[playerid][Deaths] == 0) format(string, sizeof(string), "{FFFFFF}%s\t{FF0000}- {C3C3C3}Ratio: {FFFFFF}0.00\n\n\n\n", string);
	else format(string, sizeof(string), "{FFFFFF}%s\t{FF0000}- {C3C3C3}Ratio: {FFFFFF}%0.2f\n\n\n", string, (PlayerInfo[playerid][Kills]/PlayerInfo[playerid][Deaths]));

	format(string, sizeof(string), "{FFFFFF}%s\t{0B98D4}Administrative Statistics:\n\n", string);
	format(string, sizeof(string), "{FFFFFF}%s\t{FF0000}- {C3C3C3}PMDisabled: {FFFFFF}%s\n", string, (PlayerInfo[playerid][PMDisabled] ? ("{00FF00}Yes{C3C3C3}") : ("{FF0000}No{C3C3C3}")));
	format(string, sizeof(string), "{FFFFFF}%s\t{FF0000}- {C3C3C3}Jailed: {FFFFFF}%s\n", string, (PlayerInfo[playerid][Jailed] ? ("{00FF00}Yes{C3C3C3}") : ("{FF0000}No{C3C3C3}")));
	format(string, sizeof(string), "{FFFFFF}%s\t{FF0000}- {C3C3C3}Muted: {FFFFFF}%s\n\n", string, (PlayerInfo[playerid][Muted] ? ("{00FF00}Yes{C3C3C3}") : ("{FF0000}No{C3C3C3}")));

	ShowPlayerDialog(playerid, DIALOG_INVALID, DIALOG_STYLE_MSGBOX, "{FF0000}SFS: {FFFFFF}Statistics", string, "Cancel", "");
	return 1;
}

CMD:help(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] != 0) return 0;
	new message[144], string[256];
	if(sscanf(params, "s[144]", message)) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid Syntax, please use {CC6600}/help [message] or @ [message]{C3C3C3}.");
	
	format(string, sizeof(string), "{%06x}%s [%d]{C3C3C3} is asking: {FFFFFF}%s", GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid, message);
	SendAdminMessage(1, string);

	SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Your question has been sent to our connected staff in IRC/Discord/Server.");
	return 1;
}

CMD:rules(playerid)
{
	ShowPlayerDialog(playerid, DIALOG_INVALID, DIALOG_STYLE_MSGBOX, "{FF0000}SFS: {FFFFFF}Rules", "\
		{FFFFFF}Welcome to {FF0000}Stunt Freeroam Server{FFFFFF}!\n\n\
		By playing in our server you should respect our rules, Please read them carefuly:\n\n\
		{FF0000}-{FFFFFF} No cheating.\n\
		{FF0000}-{FFFFFF} No mods that give you a handicap over other users.\n\
		{FF0000}-{FFFFFF} No bug abusing (except c-bug & 2-shot).\n\
		{FF0000}-{FFFFFF} No spamming text areas and advertising.\n\
		{FF0000}-{FFFFFF} No insulting other players. Racism and other vulgar remarks will not be tolerated.\n\
		{FF0000}-{FFFFFF} No pausing to avoid death to gain an advantage.\n\
		{FF0000}-{FFFFFF} No mini-mod use /report instead.\n\
		{FF0000}-{FFFFFF} No /q jokes or using /q to avoid death.\n\
		{FF0000}-{FFFFFF} No ban evading or jailed/mute evading.\n\
		{FF0000}-{FFFFFF} Respect admins and managements as they should respect you too.\n\
		{FF0000}-{FFFFFF} No pausing to avoid death to gain an advantage.\n\n\
		{FFFFFF}If you need help by anything you can ask our staff using: @ [text] or /help [text].\n\
		Thank you for joining us, we wish you have fun.\
		", "Cancel", "");
	return 1;
}

CMD:veh(playerid, params[]) return cmd_v(playerid, params);
CMD:v(playerid, params[])
{
	new vehid;
	if(!sscanf(params, "i", vehid)) return OnDialogResponse(playerid, DIALOG_VEH, true, vehid-400, "");

	const MAX_VEH = 605;
    new subString[16];
    static string[MAX_VEH * sizeof(subString)];

    if (string[0] == EOS) 
    {
        for (new i = 400; i < MAX_VEH; i++) 
        {
            format(subString, sizeof(subString), "%i\tID: %i\n", i, i);
            strcat(string, subString);
        }
    }

    ShowPlayerDialog(playerid, DIALOG_VEH, DIALOG_STYLE_PREVIEW_MODEL, "SFS: Vehicles", string, "Select", "Cancel");
	return 1;
}

CMD:report(playerid, params[])
{
	if(PlayerInfo[playerid][Admin] != 0) return 0;
	new id, message[144], string[256];
	if(sscanf(params, "us[144]", id, message)) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid Syntax, please use {CC6600}/report [playerid/name] [reason]{C3C3C3}.");
	if(playerid == id) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Invalid playerid, You can't report yourself.");
	if(!IsPlayerConnected(!id)) return SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}This player is not connected.");

	format(string, sizeof(string), "{%06x}%s [%d]{C3C3C3} is reporting {%06x}%s [%d]{C3C3C3} for {FFFFFF}%s",  GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid, GetPlayerColor(id) >>> 8, GetName(id), id, message);
	SendAdminMessage(1, string);

	SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Your report has been sent to our connected staff in IRC/Discord/Server.");
	return 1;
}

CMD:weather(playerid, params[])
{
	new weatherid;
	if(sscanf(params, "i", weatherid)) return SendClientMessage(playerid, -1, "{FF0000}[SFServer]: {C3C3C3}Invalid Syntax, please use {CC6600}/weather [0-12]{C3C3C3}.");
	if(weatherid > 12 || weatherid < 0) return SendClientMessage(playerid, -1, "{FF0000}[SFServer]: {C3C3C3}Invalid Weather id, please use {CC6600}/weather [0-12]{C3C3C3}.");

	SetPlayerWeather(playerid, 0);
	new string[75];
	format(string, sizeof(string), "{FF0000}[SFServer]: {C3C3C3}Your weather has been changed to weatherid %d", weatherid);
	SendClientMessage(playerid, -1, string);
	return 1;
}

CMD:time(playerid, params[])
{
	new timeid;
	if(sscanf(params, "i", timeid)) return SendClientMessage(playerid, -1, "{FF0000}[SFServer]: {C3C3C3}Invalid Syntax, please use {CC6600}/time [0-24]{C3C3C3}.");
	if(timeid > 24 || timeid < 0) return SendClientMessage(playerid, -1, "{FF0000}[SFServer]: {C3C3C3}Invalid Time, please use {CC6600}/time [0-24]{C3C3C3}.");

	SetPlayerTime(playerid, timeid, 0);
	new string[65];
	format(string, sizeof(string), "{FF0000}[SFServer]: {C3C3C3}Your time has been changed to %02d:00", timeid);
	SendClientMessage(playerid, -1, string);
	return 1;
}

CMD:admins(playerid)
{
	new string[512];
	strcat(string, "{FFFFFF}List of {FF0000}Stunt Freeroam Server{FFFFFF} connected administrators:\n\n");

	foreach(new i : Player)
	{
		if(PlayerInfo[i][Admin] > 0) format(string, sizeof(string), "%s{%06x}%s [%d]{FF0000}-%s\n", string, GetPlayerColor(i) >>> 8, GetName(i), i, GetLevelName(PlayerInfo[i][Admin]));
	}

	strcat(string, "\n{FFFFFF}If you need help by anything you can ask our staff using: @ [text] or /help [text].");

	ShowPlayerDialog(playerid, DIALOG_INVALID, DIALOG_STYLE_MSGBOX, "{FF0000}SFS: {FFFFFF}Administrators", string, "Cancel", "");
	return 1;
}

CMD:vips(playerid)
{
	new string[512];
	strcat(string, "{FFFFFF}List of {FF0000}Stunt Freeroam Server{FFFFFF} connected vips:\n\n");

	foreach(new i : Player)
	{
		if(PlayerInfo[i][Admin] == 0 && PlayerInfo[i][VIP]) format(string, sizeof(string), "%s{%06x}%s [%d]{FF0000}-{6600CC}VIP\n", string, GetPlayerColor(playerid) >>> 8, GetName(i), i);
	}

	strcat(string, "\n{FFFFFF}If you need help by anything you can ask our staff using: @ [text] or /help [text].");

	ShowPlayerDialog(playerid, DIALOG_INVALID, DIALOG_STYLE_MSGBOX, "{FF0000}SFS: {FFFFFF}Very Important Players", string, "Cancel", "");
	return 1;
}

CMD:credits(playerid)
{
	ShowPlayerDialog(playerid, DIALOG_INVALID, DIALOG_STYLE_MSGBOX, "{FF0000}SFS: {FFFFFF}Credits", "\
		{FFFFFF}Welcome to {FF0000}Stunt Freeroam Server{FFFFFF}!\n\n\
		Here you can find our developers and owners:\n\n\
		{FF0000}-{FFFFFF} XeonMaster - Developer & Owner of SFS.\n\
		{FF0000}-{FFFFFF} BlueG and maddinator for MySQL plugin.\n\
		{FF0000}-{FFFFFF} Kar for foreach plugin.\n\
		{FF0000}-{FFFFFF} Gammix for Dialog Styles.\n\
		{FF0000}-{FFFFFF} Zeex for ZCMD.\n\
		{FF0000}-{FFFFFF} SAMP Team for MapAndreas and SAMP Modification.\n\
		{FF0000}-{FFFFFF} Rockstar games for GTA: San Andreas Game.\n\n\
		{FFFFFF}If you need help by anything you can ask our staff using: @ [text] or /help [text].\n\
		Thank you for joining us, we wish you have fun.\
		", "Cancel", "");
	return 1;
}
	
CMD:kill(playerid)
{
	SetPlayerHealth(playerid, 0);
	return 1;
}

CMD:goto(playerid, params[]) return cmd_tp(playerid, params);
CMD:tp(playerid, params[])
{
	new id, string[128], seatid; 
	if(sscanf(params, "i", id)) return SendClientMessage(playerid, -1, "{FF0000}[SFServer]: {C3C3C3}Invalid Syntax, please use {CC6600}/tp [playerid/name]{C3C3C3}."); 
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, -1, "{FF0000}[SFServer]: {C3C3C3}This player is not connected");
	if(playerid == id) return SendClientMessage(playerid, -1, "{FF0000}[SFServer]: {C3C3C3}Invalid playerid, you can't teleport to yourself.");

	new Float:x, Float:y, Float:z; 

	GetPlayerPos(id, x, y, z); 
	SetPlayerPos(playerid, x+1, y+1, z+1); 

	if(IsPlayerInAnyVehicle(playerid))
	{
		GetPlayerPos(id, x, y, z);
		new vehid = GetPlayerVehicleID(playerid);
		SetVehiclePos(vehid, x+1, y+1, z+1);
		PutPlayerInVehicle(playerid, vehid, seatid);
	}

	format(string, sizeof(string), "{FF0000}[SFServer]: {C3C3C3}You have been teleported to %s [%d].", GetName(id), id); 
	SendClientMessage(playerid, -1, string); 

	format(string, sizeof(string), "{FF0000}[SFServer]: {C3C3C3}%s [%d] has teleported to you.", GetName(playerid), playerid); 
	SendClientMessage(id, -1, string); 

	format(string, sizeof(string), "{%06x}%s [%d] has teleported to {%06x}%s [%d].", GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid,  GetPlayerColor(playerid) >>> 8, GetName(id), id); 
	SendAdminMessage(1, string);
	return 1;
}	

CMD:sync(playerid, params[])
{
	new Float: rPos[4], rPosEx[2];
	GetPlayerPos(playerid, rPos[0], rPos[1], rPos[2]);
	GetPlayerFacingAngle(playerid, rPos[3]);
	rPosEx[0] = GetPlayerInterior(playerid);
	rPosEx[1] = GetPlayerVirtualWorld(playerid);
	PutPlayerInVehicle(playerid, 0, 0);
	SetPlayerPos(playerid, rPos[0], rPos[1], rPos[2]);
	SetPlayerFacingAngle(playerid, rPos[3]);
	SetPlayerInterior(playerid, rPosEx[0]);
	SetPlayerVirtualWorld(playerid, rPosEx[1]);
	SendClientMessage(playerid, -1, "{FF0000}[SFServer]: {C3C3C3}You have been synced, if you didn't please relog.");
	return 1;
}

CMD:cmds(playerid, params[])
{
	ShowPlayerDialog(playerid, DIALOG_INVALID, DIALOG_STYLE_MSGBOX, "{FF0000}SFS: {FFFFFF}Commands", "\
		{FF0000}Player Commands:{FFFFFF}!\n\n\
		/credits   \t{FF0000}-{FFFFFF} Show you list of our developers and owners.\n\
		/pm        \t{FF0000}-{FFFFFF} Send another player a private message.\n\
		/r            \t{FF0000}-{FFFFFF} Fast-reply to private message.\n\
		/dpms      \t{FF0000}-{FFFFFF} You can disable pms using this command.\n\
		/skins     \t{FF0000}-{FFFFFF} Change your skin.\n\
		/change    \t{FF0000}-{FFFFFF} Change your name or your password.\n\
		/stats     \t{FF0000}-{FFFFFF} Shows you a summary of your stats or other player stats.\n\
		/help      \t{FF0000}-{FFFFFF} Sends administrators message if you need help with something.\n\
		/rules     \t{FF0000}-{FFFFFF} Shows you a list of rules of our server.\n\
		/v            \t{FF0000}-{FFFFFF} Spawn a vehicle.\n\
		/report    \t{FF0000}-{FFFFFF} Report someone for breaking rules.\n\
		/weather   \t{FF0000}-{FFFFFF} Change your own weather.\n\
		/time 	   \t{FF0000}-{FFFFFF} Change your own time.\n\
		/admins    \t{FF0000}-{FFFFFF} Shows you list of connected Administrators\n\
		/vips      \t{FF0000}-{FFFFFF} Shows you list of connected VIPs.\n\
		/kill 	   \t{FF0000}-{FFFFFF} Kill yourself.\n\
		/tp           \t{FF0000}-{FFFFFF} Teleport to another player in openworld or freeroam mode.\n\
		/sync 	   \t{FF0000}-{FFFFFF} Tries to fix your desync bug using this command.\n\
		/anims 	   \t{FF0000}-{FFFFFF} Coming soon.\n\
		/dm 	   \t{FF0000}-{FFFFFF} Coming soon..\n\
		/freeroam  \t{FF0000}-{FFFFFF} Coming soon..\n\
		/openworld \t{FF0000}-{FFFFFF} Coming soon.\n\
		/parkours  \t{FF0000}-{FFFFFF} Coming soon..\n\
		/tdm 	   \t{FF0000}-{FFFFFF} Coming soon..\n\
		/event 	   \t{FF0000}-{FFFFFF} Coming soon..\n\n\
		Thank you for joining us, we wish you have fun.\
	", "Cancel", "");
	return 1;
}