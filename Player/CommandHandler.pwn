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
    ScriptFile    : CommandHandler.pwn
    Author        : XeonMaster
    Version       : 1.0
    License       : GNU General v3.0
    Developers    : None
*/

public OnPlayerCommandReceived(playerid, cmdtext[])
{
	return 1;
}

public OnPlayerCommandPerformed(playerid, cmdtext[], success)
{
	if(!success) SendClientMessage(playerid, -1, "{FF0000}[SFServer]: {C3C3C3}Invalid Command, please use {CC6600}/cmds{C3C3C3} to see list of our commands.");
	else
	{
        if(PlayerInfo[playerid][Admin] > 0) return 1;
        if(PlayerInfo[playerid][InDM])
        {
            if(!strfind(cmdtext, "/leave")) return 1;
            SendClientMessage(playerid, -1, "{00FF40}[SFDeathmatches]:{C3C3C3} You can't use any commands while you are in deathmatches area.");
            return 0;
        }     
        if(PlayerInfo[playerid][Fighting])
        {
            SendClientMessage(playerid, -1, "{FF0000}[SFServer]: {C3C3C3}You can't use any commands after getting shot or shooting, you have to wait 10 seconds.");
            return 0;
        }
        printf("[Gamemode::Command]: Player %s, Command: %s", GetName(playerid), cmdtext);
	}
	return 1;
}