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
    ScriptFile    : MySQL.pwn
    Author        : XeonMaster
    Version       : 1.0
    License       : GNU General v3.0
    Developers    : None
*/

#define MYSQL_HOST        "localhost" 
#define MYSQL_USER        "root" 
#define MYSQL_PASS        ""
#define MYSQL_DATABASE    "sfserver"


forward CreateTables();
stock CreateTables()
{
	mysql_tquery(Database, "CREATE TABLE IF NOT EXISTS `PLAYERS` (`ID` int(11) NOT NULL AUTO_INCREMENT,`USERNAME` varchar(24) NOT NULL,`PASSWORD` char(65) NOT NULL,`SALT` char(11) NOT NULL, `SKIN` int(3) NOT NULL, PRIMARY KEY (`ID`), UNIQUE KEY `USERNAME` (`USERNAME`))");
	mysql_tquery(Database, "CREATE TABLE IF NOT EXISTS `CONNECTIONS` (`ID` INT(16) NOT NULL AUTO_INCREMENT,`USERNAME` VARCHAR(24) NOT NULL,`Date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,`IP` VARCHAR(16) NOT NULL, `CLEINTID` VARCHAR(41) NOT NULL, PRIMARY KEY (`ID`))");
	mysql_tquery(Database, "CREATE TABLE IF NOT EXISTS `PLAYERDATA` (`DataID` INT NOT NULL AUTO_INCREMENT, `ID` INT NOT NULL, `BANKMONEY` INT NOT NULL DEFAULT '0', `TIME` INT NOT NULL DEFAULT '0', `REGISTERDATE` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, `COUNTRY` VARCHAR(36) NOT NULL, `ADMIN` INT NOT NULL DEFAULT '0', `VIP` INT NOT NULL DEFAULT '0', `KILLS` INT NOT NULL DEFAULT '0', `DEATHS` INT DEFAULT '0', `MUTED` INT DEFAULT '0', `JAILED` INT DEFAULT '0', `LASTNAMECHANGE` INT DEFAULT '0', PRIMARY KEY (`DataID`))");
	return 1;
}

forward MySQLConnect();
stock MySQLConnect()
{
	new MySQLOpt: option_id = mysql_init_options();
	mysql_set_option(option_id, AUTO_RECONNECT, true); 

	Database = mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_PASS, MYSQL_DATABASE, option_id); 

	if(Database == MYSQL_INVALID_HANDLE || mysql_errno(Database) != 0) 
	{
		print("[SFMySQL]: Connection Aborted.");

		SendRconCommand("exit"); 
		return 1;
	}
	else
	{
		print("[SFMySQL]: Connected.");
		return 1;
	}
}

forward CreatePlayerData(playerid);
public CreatePlayerData(playerid)
{
	new string[110];
	cache_get_value_int(0, "ID", PlayerInfo[playerid][ID]);
	mysql_format(Database, string, sizeof(string), "INSERT INTO `PLAYERDATA`(`ID`, `COUNTRY`) VALUES (%d, '%e')", PlayerInfo[playerid][ID], PlayerInfo[playerid][Country]);
	mysql_tquery(Database, string);
	return 1;
}

forward LoadPlayerData(playerid);
public LoadPlayerData(playerid)
{
	cache_get_value_int(0, "BANKMONEY", PlayerInfo[playerid][BankMoney]);
	cache_get_value_int(0, "TIME", PlayerInfo[playerid][TimePlayed]);
	cache_get_value(0, "REGISTERDATE", PlayerInfo[playerid][RegisterDate], 24);
	cache_get_value_int(0, "ADMIN", PlayerInfo[playerid][Admin]);
	cache_get_value_int(0, "VIP", PlayerInfo[playerid][VIP]);
	cache_get_value_int(0, "KILLS", PlayerInfo[playerid][Kills]);
	cache_get_value_int(0, "DEATHS", PlayerInfo[playerid][Deaths]);
	cache_get_value_int(0, "MUTED", PlayerInfo[playerid][Muted]);
	cache_get_value_int(0, "JAILED", PlayerInfo[playerid][Jailed]);
	cache_get_value_int(0, "LASTNAMECHANGE", PlayerInfo[playerid][LastNameChange]);

	SetPVarInt(playerid, "FirstSpawn", 1);
	SpawnPlayer(playerid);
	return 1;
}

forward ShowLoginDialog(playerid);
public ShowLoginDialog(playerid)
{
	if(cache_num_rows() > 0)
	{
		cache_get_value(0, "PASSWORD", PlayerInfo[playerid][Password], 65);
		cache_get_value(0, "SALT", PlayerInfo[playerid][Salt], 11);

		PlayerInfo[playerid][Player_Cache] = cache_save();
		ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "{FF0000}SFS: {FFFFFF}Login", "\
			{FFFFFF}Welcome back, Good to see you again!\n\n\
			{FF0000}-{FFFFFF} Please insert your password below in order to continue.\n\n\
			Forgot your password? Here is some options for you:\n\n\
			{FF0000}-{FFFFFF} Ask one of our staff memebers in our IRC Channel #sfs.help\n\
			{FF0000}-{FFFFFF} Create a topic in our forum https://www.forum.com", "Login", "Quit");
	}
	else
	{
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
	return 1;
}