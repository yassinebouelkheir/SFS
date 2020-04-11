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
    ScriptFile    : Dialogs.pwn
    Author        : XeonMaster
    Version       : 1.0
    License       : GNU General v3.0
    Developers    : None
*/

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		case DIALOG_REGISTER:
		{
			if(!response) return Kick(playerid);
			if(strlen(inputtext) <= 4 || strlen(inputtext) > 60)
			{
		    	SendClientMessage(playerid, -1, "{FF0000}[SFServer]: {C3C3C3}Invalid password length, Please try again (should between 4 - 60 characters).");
		    	
				ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "{FF0000}SFS: {FFFFFF}Register", "\
					{FFFFFF}Welcome to {FF0000}Stunt Freeroam Server{FFFFFF}!\n\n\
					{FF0000}-{FFFFFF} Please insert your password below in order to continue.\n\
					Note: Your password length must be atleast 4 characters.\n\n\
					By registering in our server, you are accepting our rules, Please read them carefuly:\n\n\
					{FF0000}-{FFFFFF} No cheating.\n\
					{FF0000}-{FFFFFF} No mods that give you a handicap over other users.\n\
					{FF0000}-{FFFFFF} No bug abusing (except c-bug & 2-shot).\n\
					{FF0000}-{FFFFFF} No spamming text areas and advertising.\n\
					{FF0000}-{FFFFFF} No insulting other players. Racism and other vulgar remarks will not be tolerated.\n\
					{FF0000}-{FFFFFF} No pausing to avoid death to gain an advantage.\n\n\
					Thank you for joining us, we wish you have fun.\
					", "Register", "Quit");
			}
			else
			{			
                for (new i = 0; i < 10; i++)
                {
                    PlayerInfo[playerid][Salt][i] = random(79) + 47;
	    		}
	    		
	    		PlayerInfo[playerid][Salt][10] = 0;
		    	SHA256_PassHash(inputtext, PlayerInfo[playerid][Salt], PlayerInfo[playerid][Password], 65);

		    	PlayerInfo[playerid][Skin] = random(311);
		    	SetPlayerSkin(playerid, PlayerInfo[playerid][Skin]);	

		    	PlayerInfo[playerid][RegisterDate] = gettime();

		    	new string[225];
		    	mysql_format(Database, string, sizeof(string), "INSERT INTO `PLAYERS` (`USERNAME`, `PASSWORD`, `SALT`, `SKIN`)\
		    	VALUES ('%e', '%s', '%e', %d)", GetName(playerid), PlayerInfo[playerid][Password], PlayerInfo[playerid][Salt], PlayerInfo[playerid][Skin]);
		     	mysql_tquery(Database, string);


		     	mysql_format(Database, string, sizeof(string), "SELECT `ID` FROM `PLAYERS` WHERE `USERNAME` = '%e' LIMIT 1", GetName(playerid));
		     	mysql_tquery(Database, string, "CreatePlayerData", "i", playerid);

				format(string, sizeof(string), "{C3C3C3}*{FFFFFF}%s{C3C3C3}({FFFFFF}%d{C3C3C3}) have registered in {FF0000}Stunt Freeroam Server{C3C3C3}.", GetName(playerid), playerid);
				SendClientMessageToAll(-1, string);

				TogglePlayerSpectating(playerid, 0);
				SetCameraBehindPlayer(playerid);
				SetPlayerVirtualWorld(playerid, 0);
				SetSpawnInfo(playerid, 0, PlayerInfo[playerid][Skin], 1958.33, 1343.12, 15.36, 269.15, 26, 36, 28, 150, 24, 150);
				SetPVarInt(playerid, "FirstSpawn", 1);
				SpawnPlayer(playerid);
		    }
		    return 1;
		}
		case DIALOG_LOGIN:
		{
			if(!response) return Kick(playerid);

			new Salted_Key[65];
			SHA256_PassHash(inputtext, PlayerInfo[playerid][Salt], Salted_Key, 65);

			if(strcmp(Salted_Key, PlayerInfo[playerid][Password]) == 0)
			{
				
				cache_set_active(PlayerInfo[playerid][Player_Cache]);

            	cache_get_value_int(0, "ID", PlayerInfo[playerid][ID]);
            	cache_get_value_int(0, "SKIN", PlayerInfo[playerid][Skin]);
				
				cache_delete(PlayerInfo[playerid][Player_Cache]);
				PlayerInfo[playerid][Player_Cache] = MYSQL_INVALID_CACHE;
				PlayerInfo[playerid][LoggedIn] = true;

				new string[119];
				format(string, sizeof(string), "{C3C3C3}*{FFFFFF}%s{C3C3C3}({FFFFFF}%d{C3C3C3}) has logged in to {FF0000}Stunt Freeroam Server{C3C3C3}.", GetName(playerid), playerid);
				SendClientMessageToAll(-1, string);

				TogglePlayerSpectating(playerid, 0);
				SetCameraBehindPlayer(playerid);
				SetPlayerVirtualWorld(playerid, 0);
				SetSpawnInfo(playerid, 0, PlayerInfo[playerid][Skin], 1958.33, 1343.12, 15.36, 269.15, 26, 36, 28, 150, 24, 150);
				SetPVarInt(playerid, "FirstSpawn", 1);

				mysql_format(Database, string, sizeof(string), "SELECT * FROM `PLAYERDATA` WHERE `ID` = %d LIMIT 1", PlayerInfo[playerid][ID]);
				mysql_tquery(Database, string, "LoadPlayerData", "i", playerid);
			}
			else
			{
			    new string[150];
					
				PlayerInfo[playerid][PasswordFails] += 1;
				printf("%s has been failed to login. (%d)", GetName(playerid), PlayerInfo[playerid][PasswordFails]);

				if (PlayerInfo[playerid][PasswordFails] >= 3) Kick(playerid);
				else
				{
					format(string, sizeof(string), "{FF0000}[SFServer]: {C3C3C3}Wrong password, please try again. (%d tries left)", (3-PlayerInfo[playerid][PasswordFails]));
					SendClientMessage(playerid, -1, string);
					
					ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "{FF0000}SFS: {FFFFFF}Login", "\
						{FFFFFF}Welcome back, Good to see you again!\n\n\
						{FF0000}-{FFFFFF} Please insert your password below in order to continue.\n\n\
						Forgot your password? Here is some options for you:\n\n\
						{FF0000}-{FFFFFF} Ask one of our staff memebers in our IRC Channel #sfs.help\n\
						{FF0000}-{FFFFFF} Create a topic in our forum https://www.forum.com", "Login", "Quit");
				}
			}
			return 1;
		}
		case DIALOG_SKIN:
		{
			if(!response) return 1;
			else if (listitem < 0 || listitem > 312) return SendClientMessage(playerid, -1, "{FF0000}[SFServer]: {C3C3C3}Invalid skin id, please us /skins to see all vehicles models ids.");
			else
			{
				SetPlayerSkin(playerid, listitem);
				PlayerInfo[playerid][Skin] = listitem;
				new string[62];
            	format(string, sizeof(string), "{FF0000}[SFServer]: {C3C3C3}Your skin has been changed to %d", listitem);
            	SendClientMessage(playerid, -1, string);
            }
            return 1;
		}
		case DIALOG_VEH:
		{
			if(!response) return 1;
			else if(400+listitem < 400 || 400+listitem > 611) return SendClientMessage(playerid, -1, "{FF0000}[SFServer]: {C3C3C3}Invalid vehicle id, please us /v to see all vehicles models ids.");
			else 
			{
				if(PlayerInfo[playerid][VirtualCar] != -1)
				{
				    DestroyVehicle(PlayerInfo[playerid][VirtualCar]);
				}
				new Float:x, Float:y, Float:z;
				GetPlayerPos(playerid, x, y, z);
				PlayerInfo[playerid][VirtualCar] = CreateVehicle(400+listitem, x + 3, y, z, 0, GetPlayerColor(playerid), GetPlayerColor(playerid), -1);
				PutPlayerInVehicle(playerid, PlayerInfo[playerid][VirtualCar], 0);

				new string[77];
				format(string, sizeof(string), "{FF0000}[SFServer]: {C3C3C3}You spawned %s (Id: %d).", GetVehicleName(PlayerInfo[playerid][VirtualCar]), 400+listitem);
				SendClientMessage(playerid, -1, string);
			}
			return 1;
		}
		case DIALOG_CHANGE_PASS:
		{
			if(strlen(inputtext) < 4) return SendClientMessage(playerid, -1, "{FF0000}[SFServer]: {C3C3C3}Invalid password length, password length should be atleast 4 characters.");
			new string[154];

			SHA256_PassHash(inputtext, PlayerInfo[playerid][Salt], PlayerInfo[playerid][Password], 65);

			mysql_format(Database, string, sizeof(string), "UPDATE `PLAYERS` SET `PASSWORD` = '%e' WHERE `USERNAME` = '%e'", PlayerInfo[playerid][Password], GetName(playerid));
			mysql_tquery(Database, string);
			SendClientMessage(playerid, -1, "{FF0000}[SFServer]: {C3C3C3}Your password have been changed successfuly.");
			return 1;
		}
		case DIALOG_CHANGE_NAME:
		{
			if(strlen(inputtext) < 3 || strlen(inputtext) > 20) return SendClientMessage(playerid, -1, "{FF0000}[SFServer]: {C3C3C3}Invalid name length, name length should be between 3 and 20 characters.");
			if(NameExists(inputtext)) return SendClientMessage(playerid, -1, "{FF0000}[SFServer]: {C3C3C3}Invalid name, this name is already taken.");
			new name[24];
			name = GetName(playerid);
			if(SetPlayerName(playerid, inputtext) != 1) return SendClientMessage(playerid, -1, "{FF0000}[SFServer]: {C3C3C3}Invalid name, Please try again.");
			new string[107];
			mysql_format(Database, string, sizeof(string), "UPDATE `PLAYERS` SET `USERNAME` = '%e' WHERE `USERNAME` = '%e'", inputtext, name);
			mysql_tquery(Database, string);

			PlayerInfo[playerid][LastNameChange] = gettime();

			mysql_format(Database, string, sizeof(string), "UPDATE `PLAYERDATA` SET `LASTNAMECHANGE` = %d WHERE `ID` = '%e'", PlayerInfo[playerid][LastNameChange], PlayerInfo[playerid][ID]);
			mysql_tquery(Database, string);

		 	SendClientMessage(playerid, -1, "{FF0000}[SFServer]: {C3C3C3}Your name have been changed successfuly.");
			return 1;
		}
		case DIALOG_ACMDS_MOD:
		{
			if(response)
			{
				if(PlayerInfo[playerid][Admin] < 3)
				{
					ShowPlayerDialog(playerid, DIALOG_INVALID, DIALOG_STYLE_MSGBOX, "{FF0000}SFS: {FFFFFF}Admin Commands", "\
						{FFFF00}Administrator Commands:{FFFFFF}\n\n\
						/cc        \t{FF0000}-{FFFFFF} .\n\
						/ban       \t{FF0000}-{FFFFFF} .\n\
						/oban      \t{FF0000}-{FFFFFF} .\n\
						/unban     \t{FF0000}-{FFFFFF} .\n\
						/aka       \t{FF0000}-{FFFFFF} .\n\
						/akill     \t{FF0000}-{FFFFFF} .\n\
						/givecash  \t{FF0000}-{FFFFFF} .\n\
						/giveweapon\t{FF0000}-{FFFFFF} .\n\
					", "Cancel", "");
				}
				else
				{
					ShowPlayerDialog(playerid, DIALOG_ACMDS_ADMIN, DIALOG_STYLE_MSGBOX, "{FF0000}SFS: {FFFFFF}Admin Commands", "\
						{FFFF00}Administrator Commands:{FFFFFF}\n\n\
						/cc        \t{FF0000}-{FFFFFF} .\n\
						/ban       \t{FF0000}-{FFFFFF} .\n\
						/oban      \t{FF0000}-{FFFFFF} .\n\
						/unban     \t{FF0000}-{FFFFFF} .\n\
						/aka       \t{FF0000}-{FFFFFF} .\n\
						/akill     \t{FF0000}-{FFFFFF} .\n\
						/givecash  \t{FF0000}-{FFFFFF} .\n\
						/giveweapon\t{FF0000}-{FFFFFF} .\n\
					", "Next", "Cancel");		
				}
			}
			return 1;
		}
		case DIALOG_ACMDS_ADMIN:
		{
			if(response)
			{
				ShowPlayerDialog(playerid, DIALOG_INVALID, DIALOG_STYLE_MSGBOX, "{FF0000}SFS: {FFFFFF}Admin Commands", "\
					{339933}Manager Commands:{FFFFFF}\n\n\
					/givevip   \t{FF0000}-{FFFFFF} .\n\
					/dchat 	   \t{FF0000}-{FFFFFF} .\n\
					/setweather\t{FF0000}-{FFFFFF} .\n\
					/settime   \t{FF0000}-{FFFFFF} .\n\
					/fakedeath \t{FF0000}-{FFFFFF} .\n\
					/setkills  \t{FF0000}-{FFFFFF} .\n\
					/setdeath  \t{FF0000}-{FFFFFF} .\n\
				", "Cancel", "");
			}
		}
	}
	return 1;
}