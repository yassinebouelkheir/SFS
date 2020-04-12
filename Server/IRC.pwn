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
    ScriptFile    : IRC.pwn
    Author        : XeonMaster
    Version       : 1.0
    License       : GNU General v3.0
    Developers    : None
*/

#define BOT_1_MAIN_NICKNAME "Galaxy"
#define BOT_1_ALTERNATE_NICKNAME "Galaxy`"
#define BOT_1_REALNAME "Galaxy Smith"
#define BOT_1_USERNAME "Galaxy"

#define BOT_2_MAIN_NICKNAME "Malfoy"
#define BOT_2_ALTERNATE_NICKNAME "Malfoy`"
#define BOT_2_REALNAME "Malfoy Oscar"
#define BOT_2_USERNAME "Malfoy"

#define BOT_3_MAIN_NICKNAME "Rune"
#define BOT_3_ALTERNATE_NICKNAME "Rune`"
#define BOT_3_REALNAME "Rune Eric"
#define BOT_3_USERNAME "Rune"

#define BOT_4_MAIN_NICKNAME "SFServer"
#define BOT_4_ALTERNATE_NICKNAME "SFServer`"
#define BOT_4_REALNAME "SA-MP Bot"
#define BOT_4_USERNAME "Rune"


#define IRC_SERVER "pool.irc.tl"
#define IRC_PORT (6667)
#define IRC_ECHO "#sfs.echo"
#define IRC_MAIN "#sfs"


forward IRC_Init();
stock IRC_Init()
{
	botIDs[0] = IRC_Connect(IRC_SERVER, IRC_PORT, BOT_1_MAIN_NICKNAME, BOT_1_REALNAME, BOT_1_USERNAME);
	IRC_SetIntData(botIDs[0], E_IRC_CONNECT_DELAY, 20);

	botIDs[1] = IRC_Connect(IRC_SERVER, IRC_PORT, BOT_2_MAIN_NICKNAME, BOT_2_REALNAME, BOT_2_USERNAME);
	IRC_SetIntData(botIDs[1], E_IRC_CONNECT_DELAY, 30);

	botIDs[2] = IRC_Connect(IRC_SERVER, IRC_PORT, BOT_3_MAIN_NICKNAME, BOT_3_REALNAME, BOT_3_USERNAME);
	IRC_SetIntData(botIDs[2], E_IRC_CONNECT_DELAY, 30);

	botIDs[3] = IRC_Connect(IRC_SERVER, IRC_PORT, BOT_4_MAIN_NICKNAME, BOT_4_REALNAME, BOT_4_USERNAME);
	IRC_SetIntData(botIDs[3], E_IRC_CONNECT_DELAY, 30);

	groupID = IRC_CreateGroup();

	IRC_Say(botIDs[3], IRC_MAIN, "Global gamemode initialization...");
	IRC_Say(botIDs[3], IRC_ECHO, "Global gamemode initialization...");
	return 1;
}

public IRC_OnConnect(botid, const ip[], port)
{
	printf("*** IRC_OnConnect: Bot ID %d connected to %s:%d", botid, ip, port);
	IRC_JoinChannel(botid, IRC_ECHO);
	IRC_JoinChannel(botid, IRC_MAIN);
	if(botid != 3) IRC_AddToGroup(groupID, botid);
	return 1;
}

public IRC_OnDisconnect(botid, const ip[], port, const reason[])
{
	printf("*** IRC_OnDisconnect: Bot ID %d disconnected from %s:%d (%s)", botid, ip, port, reason);
	IRC_RemoveFromGroup(groupID, botid);
	return 1;
}

public IRC_OnConnectAttempt(botid, const ip[], port)
{
	printf("*** IRC_OnConnectAttempt: Bot ID %d attempting to connect to %s:%d...", botid, ip, port);
	return 1;
}


public IRC_OnConnectAttemptFail(botid, const ip[], port, const reason[])
{
	printf("*** IRC_OnConnectAttemptFail: Bot ID %d failed to connect to %s:%d (%s)", botid, ip, port, reason);
	return 1;
}

public IRC_OnJoinChannel(botid, const channel[])
{
	printf("*** IRC_OnJoinChannel: Bot ID %d joined channel %s", botid, channel);
	return 1;
}

public IRC_OnLeaveChannel(botid, const channel[], const message[])
{
	printf("*** IRC_OnLeaveChannel: Bot ID %d left channel %s (%s)", botid, channel, message);
	return 1;
}

public IRC_OnInvitedToChannel(botid, const channel[], const invitinguser[], const invitinghost[])
{
	printf("*** IRC_OnInvitedToChannel: Bot ID %d invited to channel %s by %s (%s)", botid, channel, invitinguser, invitinghost);
	IRC_JoinChannel(botid, channel);
	return 1;
}

public IRC_OnKickedFromChannel(botid, const channel[], const oppeduser[], const oppedhost[], const message[])
{
	printf("*** IRC_OnKickedFromChannel: Bot ID %d kicked by %s (%s) from channel %s (%s)", botid, oppeduser, oppedhost, channel, message);
	IRC_JoinChannel(botid, channel);
	return 1;
}