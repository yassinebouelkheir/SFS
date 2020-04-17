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
    ScriptFile    : IRCommands.pwn
    Author        : XeonMaster
    Version       : 1.0
    License       : GNU General v3.0
    Developers    : None
*/

#define ERROR 0
#define WARNING 1
#define USAGE 2
#define SUCCESS 3

IRCCMD:cmds(botid, channel[], user[], host[], params[])
{
    IRC_GroupSay(groupID , channel, "Players: !pm !players !say !getid !stats !uptime");
    if(IRC_IsHalfop(botid, channel, user)) IRC_GroupSay(groupID , channel, "Moderator: !kick !freeze !unfreeze");
    if(IRC_IsOp(botid, channel, user)) IRC_GroupSay(groupID , channel, "Administrator: !akill");
    if(IRC_IsAdmin(botid, channel, user)) IRC_GroupSay(groupID , channel, "Manager: !setvip");
    if(IRC_IsOwner(botid, channel, user)) IRC_GroupSay(groupID , channel, "Server Owner: !rcon !setlevel");
    return 1;
}

// Player Commands
/*
IRCCMD:stats(botid, channel[], user[], host[], params[])
{
	new str[160], name[MAX_PLAYER_NAME], time, kills, deaths, admin, vip, userid, skin, money, h, m, s, color;
	if(sscanf(params, "s[24]", name)) return IRC_Reply(USAGE, channel, "!stats [name]");
	new int = GetPlayerStats(name, userid, time, kills, deaths, admin, vip, skin, money, color);
    secs2hms(time, h, m, s);
	if(!int) return IRC_Reply(ERROR, channel, "this account not exists");
    switch(admin)
    {
        case 0: str = "Regular Player";
        case 1: str = "Moderator";
        case 1: str = "Administrator";
        case 2: str = "Management";
        case 4: str = "Server Owner";
    }
	format(str, sizeof(str), "*%s is an %s, he was online for %d hours, %d minutes and %d seconds.", name, str, h, m, s);
	IRC_Say(groupID , channel, str);
	format(str, sizeof(str), "*he wasted %d players, and got wasted %d too far. ", kills, deaths);
	if(vip > 0) strcat(str, "and he is an Very Important Player.");
	IRC_Say(groupID , channel, str);
	return 1;
}*/

IRCCMD:uptime(botid, channel[], user[], host[], params[])
{
	new msg[128], h, m, s, uptime = gettime() - starttime;
	secs2hms(uptime, h, m, s);
	format(msg, sizeof(msg), "Server uptime: %d hour(s) %d minute(s) %d second(s).", h, m, s);
	IRC_Reply(SUCCESS, channel, msg);
	return 1;
}

IRCCMD:getid(botid, channel[], user[], host[], params[])
{
	new name[24], msg[128];
	if (sscanf(params, "s[24]", name)) return IRC_Reply(USAGE, channel, "!getid [name or part of name]");
	if (strlen(params) > 20) return IRC_Reply(ERROR, channel, "No matches");
	for(new i = 0; i < GetPlayerPoolSize(); i++)
	{
		if (strfind(GetName(i), name, true) == -1) continue;
		if (strlen(msg) + 30 > 128) break;
		format(msg, sizeof(msg), "%s(%d),", GetName(i), i);
	}
	if (strlen(msg) < 12) return IRC_Reply(ERROR, channel, "No matches");
	strdel(msg, strlen(msg)-1, strlen(msg));
	IRC_Reply(SUCCESS, channel, msg);
	return 1;
}

IRCCMD:say(botid, channel[], user[], host[], params[])
{
	if(isnull(params)) return IRC_Reply(USAGE, channel, "!say [message]");
	new msg[128];
    if (IRC_IsOwner(botid, channel, user))
    {
        format(msg, sizeof(msg), "02Owner(%s) on IRC: %s", user, params);
        IRC_GroupSay(groupID , channel, msg);
        format(msg, sizeof(msg), "*Owner(%s): %s", user, params);
        SendClientMessageToAll(-1, msg);
        return 1;
    }
    if (IRC_IsAdmin(botid, channel, user))
    {
        format(msg, sizeof(msg), "02Co-Owner(%s) on IRC: %s", user, params);
        IRC_GroupSay(groupID , channel, msg);
        format(msg, sizeof(msg), "*Co-Owner(%s): %s", user, params);
        SendClientMessageToAll(-1, msg);
        return 1;
    }
    if (IRC_IsOp(botid, channel, user))
    {
        format(msg, sizeof(msg), "02Manager(%s) on IRC: %s", user, params);
        IRC_GroupSay(groupID , channel, msg);
        format(msg, sizeof(msg), "*Manager(%s): %s", user, params);
        SendClientMessageToAll(-1, msg);
        return 1;
    }
    if (IRC_IsHalfop(botid, channel, user))
    {
        format(msg, sizeof(msg), "02Admin(%s) on IRC: %s", user, params);
        IRC_GroupSay(groupID , channel, msg);
        format(msg, sizeof(msg), "*Admin(%s): %s", user, params);
        SendClientMessageToAll(-1, msg);
        return 1;
    }
    if (IRC_IsVoice(botid, channel, user))
    {
        format(msg, sizeof(msg), "02*VIP(%s) on IRC: %s", user, params);
        IRC_GroupSay(groupID , channel, msg);
        format(msg, sizeof(msg), "*VIP(%s): %s", user, params);
        SendClientMessageToAll(-1, msg);
        return 1;
    }
    else
    {
        format(msg, sizeof(msg), "02[-] 07%s: %s", user, params);
        IRC_GroupSay(groupID , channel, msg);
        format(msg, sizeof(msg), "[IRC][-] %s: %s", user, params);
        SendClientMessageToAll(-1, msg);
		return 1;
    }
}

IRCCMD:pm(botid, channel[], user[], host[], params[])
{
    new str[256], msg[120], id;
    if(sscanf(params, "us[100]", id, msg)) return IRC_Reply(USAGE, channel, "!pm [playerid] [message]");
    if(!IsPlayerConnected(id)) return IRC_Say(groupID , channel, "Invalid Player ID.");
    format(str, sizeof(str), "{FFCC00}[SFPrivate]: New PM from {FFFFFF}%s [IRC]{FFCC00}: {FFFFFF}%s", user, msg);
    SendClientMessage(id, -1, str);

    format(str, sizeof(str), "{C3C3C3}Private Message from %s [IRC] to %s (Id: %d): {FFFFFF}%s", user, GetName(id), id, msg);
    SendAdminMessage(1, str);
    return 1;
}

IRCCMD:players(botid, channel[], user[], host[], params[])
{
    new count, PlayerNames[512], string[256];
    for(new i = 0; i <= MAX_PLAYERS; i++)
    {
        if(IsPlayerConnected(i) && !IsPlayerNPC(i))
        {
            if(count == 0)
            {
                format(PlayerNames, sizeof(PlayerNames),"2%s1", GetName(i));
                count++;
            }
            else format(PlayerNames, sizeof(PlayerNames),"%s, 2%s1", PlayerNames, GetName(i)); count++;
        }
    }
    if(count == 0) format(PlayerNames, sizeof(PlayerNames), "1there no players in server at moment.");

    new counter = 0;
    for(new i = 0; i <= MAX_PLAYERS; i++) if(IsPlayerConnected(i)) counter++;

    format(string, 256, "5Connected Players[%d]:1 %s", counter, PlayerNames);
    IRC_GroupSay(groupID , channel, string);

    return true;
}

// Moderator commands
IRCCMD:admin(botid, channel[], user[], host[], params[])
{
    new str[256];
    if(!IRC_IsHalfop(botid, channel, user)) return 1;
    if(isnull(params)) return IRC_Reply(USAGE, channel, "!admin [message]");

    if(IRC_IsHalfop(botid, channel, user)) format(str, sizeof(str), "{FFFF00}*Admin({FFFFFF}%s{FFFF00})on IRC: {FFFFFF}%s", user, params);
    if(IRC_IsOp(botid, channel, user)) format(str, sizeof(str), "{FFFF00}*Manager({FFFFFF}%s{FFFF00})on IRC: {FFFFFF}%s", user, params);
    if(IRC_IsAdmin(botid, channel, user)) format(str, sizeof(str), "{FFFF00}*Server Co-Owner({FFFFFF}%s{FFFF00})on IRC: {FFFFFF}%s", user, params);
    if(IRC_IsOwner(botid, channel, user)) format(str, sizeof(str), "{FFFF00}*Server Owner({FFFFFF}%s{FFFF00})on IRC: {FFFFFF}%s", user, params);

    for(new i = 0; i < GetPlayerPoolSize(); i++)
    {
        if(PlayerInfo[i][Admin] > 0)
        {
            SendClientMessage(i, -1, str);
        }
    }
    return 1;
}

IRCCMD:freeze(botid, channel[], user[], host[], params[])
{
    if (!IRC_IsHalfop(botid, channel, user)) return 1;
    new playerid, reason[64];
    if (sscanf(params, "dS(No reason)[64]", playerid, reason)) return IRC_Reply(USAGE, channel, "!freeze [playerid] [reason]");
    if (!IsPlayerConnected(playerid)) return IRC_Reply(ERROR, channel, "this player is not connected.");
    new msg[128];
    format(msg, sizeof(msg), "{%06x}%s (Id: %d){C3C3C3} has been frozen by {FFFFFF}%s (IRC){C3C3C3}.", GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid, user);
    SendAdminMessage(1, msg);
    TogglePlayerControllable(playerid, 0);
    return 1;
}

IRCCMD:unfreeze(botid, channel[], user[], host[], params[])
{
    if (!IRC_IsHalfop(botid, channel, user)) return 1;
    new playerid, reason[64];
    if (sscanf(params, "dS(No reason)[64]", playerid, reason)) return IRC_Reply(USAGE, channel, "!unfreeze [playerid] [reason]");
    if (!IsPlayerConnected(playerid)) return IRC_Reply(ERROR, channel, "this player is not connected.");
    new msg[152];
    format(msg, sizeof(msg), "{%06x}%s (Id: %d){C3C3C3} has been unfrozen by {FFFFFF}%s (IRC){C3C3C3}.", GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid, user);
    SendAdminMessage(1, msg);
    TogglePlayerControllable(playerid, 1);
    return 1;
}

IRCCMD:kick(botid, channel[], user[], host[], params[])
{
    if (!IRC_IsHalfop(botid, channel, user)) return 1;

    new id, reason[20], string[216];
    if(sscanf(params,"us[178]", id, reason)) return IRC_Reply(USAGE, channel, "!kick [playerid] [reason]");
    if (!IsPlayerConnected(id)) return IRC_Reply(ERROR, channel, "this player is not connected.");

    for(new i = 0; i < 50; i++) SendClientMessage(id, -1,"");
    TogglePlayerControllable(id, 0);

    for(new i = 0; i < 20; i++) SendClientMessage(id, -1, " ");

    SetPlayerVirtualWorld(id, WORLD_KICK);

    format(string, sizeof(string), "{C3C3C3}You have been kicked from {FF0000}Stunt Freeroam Server{C3C3C3} by {FFFFFF}%s (IRC){C3C3C3}.", user);
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

    format(string, sizeof(string), "{FFFFFF}%s (IRC){C3C3C3} kicked {%06x}%s (Id: %d){C3C3C3} for: {FFFFFF}%s.", user, GetPlayerColor(id) >>> 8, GetName(id), id,  reason);
    SendAdminMessage(1, string);

    SetTimerEx("KickTimer", 1000, false, "i", id);
    return 1;
}

// Administrator commands
IRCCMD:akill(botid, channel[], user[], host[], params[])
{
    if (!IRC_IsOp(botid, channel, user)) return 1;
    new playerid;
    if (sscanf(params, "u", playerid)) return IRC_Reply(USAGE, channel, "!akill [playerid]");
    if (!IsPlayerConnected(playerid)) return IRC_Reply(ERROR, channel, "this player is not connected.");
    new msg[152];
    format(msg, sizeof(msg), "{%06x}%s (Id: %d){C3C3C3} has been killed by {FFFFFF}%s (IRC){C3C3C3}.", GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid, user);
    SendAdminMessage(1, msg);
    SetPlayerHealth(playerid, 0);
    return 1;
}

IRCCMD:ban(botid, channel[], user[], host[], params[])
{
    if (IRC_IsHalfop(botid, channel, user))
    {
		new id, reason[20], string[250];
		if(sscanf(params,"us[178]", id, reason)) return IRC_Reply(USAGE, channel, "!ban [playerid] [reason]");
        if (!IsPlayerConnected(id)) return IRC_Reply(ERROR, channel, "this player is not connected.");
        for(new i = 0; i < 20; i++) SendClientMessage(id, -1, " ");

        SetPlayerVirtualWorld(id, WORLD_KICK);
        format(string, sizeof(string), "{C3C3C3}You have been banned from {FF0000}Stunt Freeroam Server{C3C3C3} by {FFFFFF}%s (IRC){C3C3C3}.", user);
        SendClientMessage(id, -1, string);

        format(string, sizeof(string), "{C3C3C3}Reason: {FFFFFF}%s", reason);
        SendClientMessage(id, -1, string);

        format(string, sizeof(string), "{C3C3C3}Duration: {FFFFFF}3 days");
        SendClientMessage(id, -1, string);

        new Year, Month, Day, Hour, Minute, Second;
        getdate(Year, Month, Day);
        gettime(Hour, Minute, Second);

        format(string, sizeof(string), "{C3C3C3}Date: {FFFFFF}%s %d %s %d at %02d:%02d:%02d", GetWeekDay(), Day, GetMonthName(Month), Year, Hour, Minute, Second);
        SendClientMessage(id, -1, string);

        SendClientMessage(id, -1, "{C3C3C3}If you think that you are banned wrongfully, you can fill up a report in our forum.");
        SendClientMessage(id, -1, "{C3C3C3}Forum Link: {FFFFFF}https://forum.com");

        new ip[16];
        GetPlayerIp(id, ip, sizeof(ip));

        BanPlayer(GetName(id), user, 3, reason, PlayerInfo[id][ClientID], ip);
        
        format(string, sizeof(string), "{FFFFFF}%s (IRC){C3C3C3} banned {%06x}%s (Id: %d){C3C3C3} for: {FFFFFF}%s.", user, GetPlayerColor(id) >>> 8, GetName(id), id, reason);
        SendAdminMessage(1, string);

        SetTimerEx("KickTimer", 200, false, "ii", 1, id);
    }
    return 1;
}

IRCCMD:unban(botid, channel[], user[], host[], params[])
{
    if(!IRC_IsHalfop(botid, channel, user)) return IRC_Reply(USAGE, channel, "!unban [name]");
    if(isnull(params)) return IRC_Reply(USAGE, channel, "!unban [name]");
    new string[80];
    mysql_format(Database, string, sizeof(string), "DELETE FROM `BANINFO` WHERE `USERNAME` = '%e'", params);
    mysql_tquery(Database, string);
    return 1;
}

// Manager Commands
// Owner Commands
IRCCMD:rcon(botid, channel[], user[], host[], params[])
{
    if (!IRC_IsOwner(botid, channel, user)) return 1;
    if (isnull(params)) return IRC_Reply(USAGE, channel, "!rcon [command] (params)");
    if (!strcmp(params, "exit", true)) return IRC_Reply(ERROR, channel, "You can't shutdown server from irc.");
	if (!strcmp(params, "gmx", true, 3)) return IRC_Reply(ERROR, channel, "You can use !restart instand.");

    new msg[40];
    format(msg, sizeof(msg), "RCON command %s has been executed.", params);
    IRC_Reply(SUCCESS, channel, msg);
    SendRconCommand(params);
    return 1;
}

IRCCMD:setlevel(botid, channel[], user[], host[], params[])
{
    if(!IRC_IsOwner(botid, channel, user)) return 1;
    new id, level;

    if(sscanf(params,"ii", id, level)) return IRC_Reply(USAGE, channel, "!setlevel [playerid] [Level]");
    if(PlayerInfo[id][Admin] == level) return IRC_Reply(ERROR, channel, "This player already have this level.");
    if(!IsPlayerConnected(id)) return IRC_Reply(ERROR, channel, "this player is not connected.");
    if(level > 4 || level < 0) return IRC_Reply(ERROR, channel, "Invalid level entred (Levels are 0 - 4).");

    new string[128];
    if(PlayerInfo[id][Admin] < level) format(string, sizeof(string), "{0000FF}[SFAdmin]: {C3C3C3}You have been promoted to an %s{C3C3C3}.", GetLevelName(level));
    else format(string, sizeof(string), "{0000FF}[SFAdmin]: {C3C3C3}You have been demoted to an %s{C3C3C3}.", GetLevelName(level));

    PlayerInfo[id][Admin] = level;
    SendClientMessage(id, -1, string);

    mysql_format(Database, string, sizeof(string), "UPDATE `PLAYERDATA` SET `ADMIN` = %d WHERE `ID` = %d", level, PlayerInfo[id][ID]);
    mysql_tquery(Database, string);
    return 1;
}

forward stock IRC_Reply(reponseid, channel[], str[]);
stock IRC_Reply(reponseid, channel[], str[])
{
    new string[250];
    switch(reponseid)
    {
        case ERROR:  format(string, sizeof(string), "4Error: 1%s", str);
        case USAGE:  format(string, sizeof(string), "7Usage: 1%s", str);
        case SUCCESS: format(string, sizeof(string), "3Success: 1%s", str);
    }
    IRC_GroupSay(groupID, channel, string);
    return 1;
}
