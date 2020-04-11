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
    ScriptFile    : ChatHandler.pwn
    Author        : XeonMaster
    Version       : 1.0
    License       : GNU General v3.0
    Developers    : None
*/

public OnPlayerText(playerid, text[])
{
	switch(text[0])
	{
		case '#':
		{
			if(PlayerInfo[playerid][Admin] > 2)
			{
				text[0] = ' ';
				new string[168];
				format(string, sizeof(string), "{339933}[SFAdmin.SMChat] %s [%d]: {FFFFFF}%s", GetName(playerid), playerid, text);
				foreach(new i : Player)
				{
					if(PlayerInfo[i][Admin] > 2)
					{	
						SendClientMessage(i, -1, string);
					}	
				}
			}
			return 0;
		}
		case '@':
		{
			if(PlayerInfo[playerid][Admin] > 1)
			{
				text[0] = ' ';
				new string[168];
				format(string, sizeof(string), "{FFFF00}[SFAdmin.AChat] %s [%d]: {FFFFFF}%s", GetName(playerid), playerid, text);
				foreach(new i : Player)
				{
					if(PlayerInfo[i][Admin] > 1)
					{	
						SendClientMessage(i, -1, string);
					}	
				}
			}
			else
			{
				text[0] = ' ';
				cmd_help(playerid, text);
			}
			return 0;
		}
		case '!':
		{
			if(PlayerInfo[playerid][Admin] > 0)
			{
				text[0] = ' ';
				new string[168];
				format(string, sizeof(string), "{CC6600}[SFAdmin.MChat] %s [%d]: {FFFFFF}%s", GetName(playerid), playerid, text);
				foreach(new i : Player)
				{
					if(PlayerInfo[i][Admin] > 0)
					{	
						SendClientMessage(i, -1, string);
					}	
				}
			}
			return 0;
		}
		case ';':
		{
			if(PlayerInfo[playerid][VIP])
			{
				text[0] = ' ';
				new string[168];
				format(string, sizeof(string), "{6600CC}[SFVIP.Chat] %s [%d]: {FFFFFF}%s", GetName(playerid), playerid, text);
				foreach(new i : Player)
				{
					if(PlayerInfo[i][VIP])
					{	
						SendClientMessage(i, -1, string);
					}	
				}
			}
		}
		case '$':
		{
			// Gangs chat
		}
	}
	if(!GlobalChat && !PlayerInfo[playerid][Admin])
	{
		SendClientMessage(playerid, -1, "{0000FF}[SFAdmin]: {C3C3C3}Global Chat is disabled at the moment.");
	}
	else 
	{
		new string[168];
		format(string, sizeof(string), "{%06x}%s [%d]: {FFFFFF}%s", GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid, text);
		SendClientMessageToAll(-1, string);
	}
	return 0;
}