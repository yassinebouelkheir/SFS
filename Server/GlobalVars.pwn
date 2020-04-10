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
    ScriptFile    : GlobalVars.pwn
    Author        : XeonMaster
    Version       : 1.0
    License       : GNU General v3.0
    Developers    : None
*/

// Constants - Dialogs
#define DIALOG_INVALID     (0)
#define DIALOG_LOGIN       (1)
#define DIALOG_REGISTER    (2)
#define DIALOG_SKIN 	   (3)
#define DIALOG_VEH 		   (4)
#define DIALOG_CHANGE_NAME (5)
#define DIALOG_CHANGE_PASS (6)

// Constants - Worlds
#define WORLD_LOGIN 	   (1)

// Macros
#define PRESSED(%0) \
    (((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))

// Variables
new 
	GlobalTimer,
	TotalVeh,
	Text: Login[8],
    MySQL: Database
;

enum ENUM_PLAYER_DATA
{
    ID,
    
    Password[65],
    Salt[11],
    
    PasswordFails,
    Skin,

	Cash,
	BankMoney,

    TimePlayed,
    RegisterDate[24],
  	Country[24],

    Admin,
    bool: VIP,

    Kills,
    Deaths,

    bool: Muted,
    bool: Jailed,

    Cache: Player_Cache,
    bool: LoggedIn,

    PlayerTimer,
    bool:PMDisabled,
    VirtualCar,

    LastNameChange
}

new PlayerInfo[MAX_PLAYERS][ENUM_PLAYER_DATA]; 

new VehicleNames[][] =
{
    "Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel",
    "Dumper", "Firetruck", "Trashmaster", "Stretch", "Manana", "Infernus",
    "Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam",
    "Esperanto", "Taxi", "Washington", "Bobcat", "Whoopee", "BF Injection",
    "Hunter", "Premier", "Enforcer", "Securicar", "Banshee", "Predator", "Bus",
    "Rhino", "Barracks", "Hotknife", "Trailer", "Previon", "Coach", "Cabbie",
    "Stallion", "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral",
    "Squalo", "Seasparrow", "Pizzaboy", "Tram", "Trailer", "Turismo", "Speeder",
    "Reefer", "Tropic", "Flatbed", "Yankee", "Caddy", "Solair", "Berkley's RC Van",
    "Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale",
    "Oceanic","Sanchez", "Sparrow", "Patriot", "Quad", "Coastguard", "Dinghy",
    "Hermes", "Sabre", "Rustler", "ZR-350", "Walton", "Regina", "Comet", "BMX",
    "Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick", "News Chopper",
    "Rancher", "FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking",
    "Blista Compact", "Police Maverick", "Boxville", "Benson", "Mesa", "RC Goblin",
    "Hotring Racer A", "Hotring Racer B", "Bloodring Banger", "Rancher", "Super GT",
    "Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropduster", "Stunt",
    "Tanker", "Roadtrain", "Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra",
    "FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Tow Truck", "Fortune",
    "Cadrona", "FBI Truck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer",
    "Remington", "Slamvan", "Blade", "Freight", "Streak", "Vortex", "Vincent",
    "Bullet", "Clover", "Sadler", "Firetruck", "Hustler", "Intruder", "Primo",
    "Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada", "Yosemite",
    "Windsor", "Monster", "Monster", "Uranus", "Jester", "Sultan", "Stratium",
    "Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma", "Savanna", "Bandito",
    "Freight Flat", "Streak Carriage", "Kart", "Mower", "Dune", "Sweeper",
    "Broadway", "Tornado", "AT-400", "DFT-30", "Huntley", "Stafford", "BF-400",
    "News Van", "Tug", "Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club",
    "Freight Box", "Trailer", "Andromada", "Dodo", "RC Cam", "Launch", "Police Car",
    "Police Car", "Police Car", "Police Ranger", "Picador", "S.W.A.T", "Alpha",
    "Phoenix", "Glendale", "Sadler", "Luggage", "Luggage", "Stairs", "Boxville",
    "Tiller", "Utility Trailer"
};

// Functions
forward NameExists(name[]);
stock NameExists(name[])
{
	new Cache:result, count, string[85];
	mysql_format(Database, string, sizeof(string), "SELECT `USERNAME` FROM `PLAYERS` WHERE `USERNAME` = '%e' LIMIT 1", name);
	result = mysql_query(Database, string);
	cache_get_row_count(count);
	cache_delete(result);
	if(count) return true;
	else return false;
}

forward GetLevelName(level);
stock GetLevelName(level)
{
	new string[32];
	switch(level)
	{
		case 0: strcat(string, "{FFFFFF}Player{FFFFFF}");
		case 1: strcat(string, "{CC6600}Moderator{FFFFFF}");
		case 2: strcat(string, "{FFFF00}Administrator{FFFFFF}");
		case 3: strcat(string, "{339933}Manager{FFFFFF}");
		case 4: strcat(string, "{0000FF}Owner{FFFFFF}");
	}
	return string;
}

forward GetVehicleName(vehicleid);
stock GetVehicleName(vehicleid)
{
	new string[24];
    format(string, sizeof(string), "%s", VehicleNames[GetVehicleModel(vehicleid) - 400]);
    return string;
}

forward UpdatePlayerInfo(playerid);
public UpdatePlayerInfo(playerid)
{
	PlayerInfo[playerid][TimePlayed]++;
}

forward ResetPlayerVariables(playerid);
stock ResetPlayerVariables(playerid)
{
	DeletePVar(playerid, "FirstSpawn");
	DeletePVar(playerid, "LastPM");

	PlayerInfo[playerid][ID] = -1;
	PlayerInfo[playerid][PasswordFails] = 0;
	PlayerInfo[playerid][Skin] = 0;
	PlayerInfo[playerid][Cash] = 0;
	PlayerInfo[playerid][BankMoney] = 0;
	PlayerInfo[playerid][TimePlayed] = 0;
	PlayerInfo[playerid][RegisterDate] = 0;
	PlayerInfo[playerid][Admin] = 0;
	PlayerInfo[playerid][VIP] = false;
	PlayerInfo[playerid][Kills] = 0;
	PlayerInfo[playerid][Deaths] = 0;
	PlayerInfo[playerid][Jailed] = false;
	PlayerInfo[playerid][Muted] = false;
	PlayerInfo[playerid][LoggedIn] = false;
	PlayerInfo[playerid][PMDisabled] = false;
	DestroyVehicle(PlayerInfo[playerid][VirtualCar]);
	PlayerInfo[playerid][VirtualCar] = -1;
	PlayerInfo[playerid][LastNameChange] = -1;
	KillTimer(PlayerInfo[playerid][PlayerTimer]);
}

forward SendAdminMessage(level, message[]);
stock SendAdminMessage(level, message[])
{
	new string[256];
	format(string, sizeof(string), "{0000FF}[SFAdmin]: {C3C3C3} %s", message);
	foreach(new i : Player)
	{
		if(PlayerInfo[i][Admin] >= level)
		{	
			SendClientMessage(i, -1, string);
		}	
	}
	return 1;
}

forward SendPMToAdmins(playerid, targetid, message[]);
stock SendPMToAdmins(playerid, targetid, message[])
{
	new string[256];
	format(string, sizeof(string), "{0000FF}[SFAdmin.Private]: %s to %s:{C3C3C3} %s", GetName(playerid), GetName(targetid), message);
	foreach(new i : Player)
	{
		if(PlayerInfo[i][Admin] > 1)
		{
			SendClientMessage(i, -1, string);
		}
	}
	return 1;
}

forward UpdateServInfo();
public UpdateServInfo()
{
	SetGameModeText("SFS v1.0");
	switch(random(3))
	{
		case 0: SendRconCommand("hostname | SFS | Welcome to Stunt Freeroam Server ");
		case 1: SendRconCommand("hostname | SFS | Freeroam/DM/TDM/Parkours/Stunts ");
		case 2: SendRconCommand("hostname | SFS | Best International Mixed Server  ");
	}
	SendRconCommand("mapname SFS Maps v1.0");
	return 1;
}

forward SendWelcomeMessage(playerid);
stock SendWelcomeMessage(playerid)
{
	new string[93];
	format(string, sizeof(string), "{FF0000}[SFServer]: {C3C3C3}Welcome to our server {FFFFFF}%s{C3C3C3}!", GetName(playerid));
	SendClientMessage(playerid, -1, string);
	SendClientMessage(playerid, -1, "{FF0000}[SFServer]: {C3C3C3}We wish you have fun here, you can use {FFFFFF}/cmds{C3C3C3} to learn more about what you can do!");
	SendClientMessage(playerid, -1, "{FF0000}[SFServer]: {C3C3C3}Note that by registering in our server that means that you are accepting our rules.");
	SendClientMessage(playerid, -1, "{FF0000}[SFServer]: {C3C3C3}You can learn more about our rules right here {FFFFFF}/rules{C3C3C3}.");
	SendClientMessage(playerid, -1, "{FF0000}[SFServer]: {C3C3C3}Thank you and have fun.");
	return 1;
}

forward PlayIntroMusic(playerid);
stock PlayIntroMusic(playerid)
{
	switch(random(3))
	{
		case 0: {
			PlayAudioStreamForPlayer(playerid, "https://ia801407.us.archive.org/0/items/rockstar_20200406/rockstar.mp3");
			for(new i = 0; i < 20; i++) SendClientMessage(playerid, -1, "");

			SendWelcomeMessage(playerid);
			SendClientMessage(playerid, -1, "{F2C80C}[SFS Radio]: {C3C3C3}Now playing '{FFFFFF}Rockstar (Remix){C3C3C3}' {C3C3C3}by '{FFFFFF}Post Malone x Ilkay Sencan{C3C3C3}'.");
		}
		case 1: {
			PlayAudioStreamForPlayer(playerid, "https://ia601504.us.archive.org/25/items/lacasadepapelbellaciaoemsiremixmp3cut.net/La%20Casa%20De%20Papel%20-%20Bella%20Ciao%20%28EMSI%20Remix%29%20%28mp3cut.net%29.mp3");
			for(new i = 0; i < 20; i++) SendClientMessage(playerid, -1, "");

			SendWelcomeMessage(playerid);
			SendClientMessage(playerid, -1, "{F2C80C}[SFRadio]: {C3C3C3}Now playing '{FFFFFF}Bella Caio (Remix){C3C3C3}' {C3C3C3}by '{FFFFFF}Netflix (Money Heist) x EMSI{C3C3C3}'.");
		}
		case 2: {
			PlayAudioStreamForPlayer(playerid, "https://ia601402.us.archive.org/34/items/gtaiv_202004/gtaiv.mp3");
			for(new i = 0; i < 20; i++) SendClientMessage(playerid, -1, "");

			SendWelcomeMessage(playerid);
			SendClientMessage(playerid, -1, "{F2C80C}[SFRadio]: {C3C3C3}Now playing '{FFFFFF}GTA TBOGT Theme Song{C3C3C3}' {C3C3C3}by '{FFFFFF}Rockstar Games{C3C3C3}'.");
		}
	}
	return 1;
}

forward GetName(playerid);
stock GetName(playerid)
{
	new tmp[24];
	GetPlayerName(playerid, tmp, sizeof(tmp));
	return tmp;
}

forward LoadStaticVehiclesFromFile(const filename[]);
stock LoadStaticVehiclesFromFile(const filename[])
{
	new File:file_ptr;
	new line[256];
	new var_from_line[64];
	new vehicletype;
	new Float:SpawnX;
	new Float:SpawnY;
	new Float:SpawnZ;
	new Float:SpawnRot;
	new Color1, Color2;
	new index;
	new vehicles_loaded;

	file_ptr = fopen(filename,filemode:io_read);
	if(!file_ptr) return 0;

	vehicles_loaded = 0;

	while(fread(file_ptr,line,256) > 0)
	{
	  	index = 0;
 		index = token_by_delim(line,var_from_line,',',index);
 		if(index == (-1)) continue;
 		vehicletype = strval(var_from_line);
  		if(vehicletype < 400 || vehicletype > 611) continue;

 		index = token_by_delim(line,var_from_line,',',index+1);
 		if(index == (-1)) continue;
 		SpawnX = floatstr(var_from_line);

 		index = token_by_delim(line,var_from_line,',',index+1);
 		if(index == (-1)) continue;
 		SpawnY = floatstr(var_from_line);

 		index = token_by_delim(line,var_from_line,',',index+1);
 		if(index == (-1)) continue;
 		SpawnZ = floatstr(var_from_line);

 		index = token_by_delim(line,var_from_line,',',index+1);
 		if(index == (-1)) continue;
 		SpawnRot = floatstr(var_from_line);

 		index = token_by_delim(line,var_from_line,',',index+1);
 		if(index == (-1)) continue;
 		Color1 = strval(var_from_line);

 		index = token_by_delim(line,var_from_line,';',index+1);
 		Color2 = strval(var_from_line);
		AddStaticVehicleEx(vehicletype,SpawnX,SpawnY,SpawnZ,SpawnRot,Color1,Color2,-1);

		vehicles_loaded++;
	}

	fclose(file_ptr);
	printf("Loaded %d vehicles from: %s",vehicles_loaded,filename);
	return vehicles_loaded;
}

forward token_by_delim(const string[], return_str[], delim, start_index);
stock token_by_delim(const string[], return_str[], delim, start_index)
{
	new x=0;
	while(string[start_index] != EOS && string[start_index] != delim) 
	{
		return_str[x] = string[start_index];
		x++;
		start_index++;
	}
	return_str[x] = EOS;
	if(string[start_index] == EOS) start_index = (-1);
	return start_index;
}