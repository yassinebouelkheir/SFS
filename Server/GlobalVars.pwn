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

// Natives
native gpci(playerid, serial[], len);

// Constants - Dialogs
#define DIALOG_INVALID     (0)
#define DIALOG_LOGIN       (1)
#define DIALOG_REGISTER    (2)
#define DIALOG_SKIN 	   (3)
#define DIALOG_VEH 		   (4)
#define DIALOG_CHANGE_NAME (5)
#define DIALOG_CHANGE_PASS (6)
#define DIALOG_ACMDS_MOD   (7)
#define DIALOG_ACMDS_ADMIN (8)
#define DIALOG_DM          (9)

// Constants - Worlds
#define WORLD_LOGIN 	   (1)
#define WORLD_KICK		   (2)
#define WORLD_DM           (3)

// Macros
#define PRESSED(%0) \
    (((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))

// Variables
new 
	GlobalTimer,
	TotalVeh,
	Text: Login[8],
    MySQL: Database,
    bool: GlobalChat = true,
    NPCBus[14],
    Text3D: NPCText[16],
    botIDs[4], 
    groupID,
    ShipRails[9],
    XeonGarage,
    XeonVeh[2],
    GuardVeh[3],
    bool: GarageOpen = false,
    Text: Death[3]
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
    bool: PMDisabled,
    VirtualCar,

    LastNameChange,
    ClientID[41],
    bool: IsSpectating,
    bool: InDM,
    DmZone,

    bool: Fighting
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

new Float:RandomSpawns[][] = 
{
	{1608.072509, 1818.844970, 10.820312, 357.025268},
    {1582.040893, 1768.947753, 10.820312, 80.059234},
    {1465.603515, 1895.265747, 11.460937, 270.219512},
    {2031.781494, 2160.468994, 10.820312, 179.300857},
    {2063.606201, 2209.664306, 10.820312, 15.903598},
    {1910.226318, 2350.844726, 10.979915, 191.105514},
    {2295.663574, 2468.275146, 10.820312, 93.344581},
    {1663.515136, 2750.059814, 10.820312, 179.228729},
    {1644.108886, 2749.604248, 10.820312, 180.795013},
    {1600.998291, 2712.172119, 10.820312, 1.903411},
    {1029.821166, 1848.373901, 11.468292, 83.660774},
    {2556.753906, 2023.815063, 10.825762, 9.086769},
    {2478.968261, 1927.325683, 10.522821, 5.013446},
    {2620.452880, 1903.202880, 11.023437, 178.915191},
    {2557.232421, 1869.211303, 11.023437, 272.892639},
    {1958.378295, 1343.157226, 15.374607, 269.142486},
    {2023.895141, 1918.461547, 12.339057, 260.689514},
    {2449.092041, 1282.140747, 10.828012, 174.340469},
    {1639.812133, 2724.698974, 10.820312, 0.198810},
    {1719.928100, 2704.602539, 10.820312, 348.355224},
    {1914.670654, 2765.742431, 10.812517, 89.832992},
    {2020.691772, 2734.256103, 10.820312, 2.564298},
    {2157.271728, 2797.019287, 10.820312, 168.337753},
    {2387.108642, 2754.420898, 10.820312, 175.211563},
    {2511.301757, 2522.634033, 10.820312, 91.624038},
    {2212.352783, 2524.958496, 10.820312, 175.014999},
    {2285.133300, 2452.154541, 10.820312, 88.229957},
    {2316.892089, 2367.656250, 10.820312, 359.274505},
    {2636.319335, 2333.397949, 10.921875, 177.972991},
    {2816.735107, 2203.515625, 11.023437, 89.368957},
    {2832.446044, 2399.576171, 11.062500, 162.807937},
    {2846.666992, 1290.704711, 11.390625, 87.375198},
    {2550.034912, 1045.755615, 13.931572, 235.299743},
    {2490.522460, 928.148559, 10.827999, 55.735519},
    {2029.884521, 999.349792, 10.813100, 269.467590},
    {2180.507080, 1116.628540, 12.648437, 62.588356},
    {2220.301025, 1286.439331, 10.820312, 89.892646},
    {2313.768066, 1385.303955, 10.987514, 119.364303},
    {2181.640869, 1682.999145, 11.065552, 89.700912},
    {2022.200683, 1915.542968, 12.327183, 272.256256},
    {2089.902343, 2062.444580, 10.820312, 269.732788},
    {2570.483398, 2035.885986, 10.820312, 136.070892},
    {2127.587158, 2364.285888, 10.820312, 179.460403},
    {1886.602172, 2339.798095, 10.820312, 269.885833},
    {1636.620483, 2252.149902, 11.062500, 27.358898},
    {1466.589843, 2260.648437, 11.023437, 274.521057},
    {1570.164550, 2055.814453, 10.820312, 131.846511},
    {1477.166503, 2003.983764, 11.023437, 357.562805},
    {1584.635620, 1800.229492, 10.828001, 0.120331},
    {1701.743408, 1723.828979, 10.825574, 182.847167},
    {1675.771484, 1448.843139, 10.786431, 267.721649},
    {1319.229736, 1253.695678, 10.820312, 357.126007},
    {1716.398437, 1307.252807, 10.827939, 263.411895},
    {1653.468261, 1071.760986, 10.820312, 179.214157},
    {1713.591430, 914.049072, 10.820312, 354.610626},
    {1406.559326, 1077.218750, 10.929687, 181.239700},
    {1490.943603, 700.243652, 10.820312, 355.475311},
    {1705.102905, 746.693237, 10.820312, 91.594612},
    {1902.332153, 703.285644, 10.820312, 89.471618},
    {2054.463623, 665.470581, 10.820312, 359.466979},
    {2220.987548, 685.294006, 11.460479, 0.382572},
    {2453.983886, 706.540893, 11.468292, 89.439926},
    {2663.129638, 746.349609, 14.739588, 90.116600},
    {2814.524902, 971.769958, 10.750000, 174.470214},
    {2637.249755, 1128.209960, 11.179687, 173.317504},
    {2020.063232, 1343.167236, 10.812978, 267.228393},
    {1419.398193, 1948.158325, 11.453125, 359.781494},
    {1136.138916, 2072.431396, 11.062500, 141.639144},
    {983.649475, 1986.294677, 11.468292, 267.929046},
    {1098.312500, 2300.467285, 10.820312, 86.879104},
    {1349.838378, 2575.064208, 10.820312, 0.942323},
    {1433.120117, 2619.763183, 11.392614, 180.000000},
    {1830.752441, 2616.000000, 10.820312, 94.727127},
    {2604.138916, 2194.136230, 10.812986, 179.535629},
    {2334.500976, 2190.509033, 10.818303, 267.891448},
    {2506.731689, 2130.954345, 10.820312, 1.462194},
    {2322.011230, 2116.649414, 10.828125, 310.355072},
    {1889.005737, 2072.461669, 11.062500, 221.849990},
    {1886.530273, 947.461181, 10.820312, 339.230590},
    {2107.478759, 1001.560058, 11.034668, 359.739044},
    {2172.555908, 1408.814697, 11.062500, 91.920883},
    {2495.903076, 1405.570434, 11.132812, 175.614608},
    {2481.976318, 1525.890136, 11.626489, 321.839263},
    {2622.802978, 1716.891723, 11.023437, 89.948135},
    {2441.149902, 2059.714111, 10.820312, 180.000000},
    {2063.154785, 2471.962402, 10.820312, 175.019119},
    {2445.729492, 2376.328369, 12.163512, 88.564323},
    {2219.647949, 1838.794921, 10.820312, 87.327117},
    {693.479675, 1953.186401, 5.539062, 180.767715},
    {1171.563720, 1352.462158, 10.921875, 19.191267},
    {1098.600219, 1386.900878, 10.820312, 0.945639},
    {1097.698974, 1705.114135, 10.820312, 182.616897},
    {1031.635742, 1025.352661, 11.000000, 309.254577},
    {1527.187622, 1043.612304, 10.820312, 185.256668},
    {2497.326904, 1285.076782, 10.812500, 359.805175},
    {2480.153320, 1662.935546, 10.976562, 185.389953},
    {1698.768310, 2082.504882, 10.820312, 271.557220},
    {965.152709, 1684.009887, 8.851562, 266.984375},
    {2291.005126, 2044.278442, 11.062500, 90.522262},
    {2270.561279, 1518.114624, 17.223411, 193.475967},
    {2441.339843, 1124.069580, 10.820312, 91.881225},
    {2839.378906, 1379.909423, 10.895205, 157.849105},
    {2914.924316, 2481.234130, 11.068956, 163.778793},
    {2459.717041, 2547.373535, 22.078125, 90.702987},
    {1960.114990, 1770.363769, 18.933877, 199.168289},
    {2263.696044, 2776.988525, 10.820312, 90.181236},
    {1487.720825, 2808.067138, 10.832091, 179.367874},
    {1504.215209, 2365.565673, 10.820312, 358.128204},
    {1307.713623, 2064.305664, 10.820312, 175.690109}
};

// Functions
forward OnPlayerFinishFight(playerid);
public OnPlayerFinishFight(playerid)
{
    PlayerInfo[playerid][Fighting] = false;
    return 1;
}

forward KickTimer(type, playerid);
public KickTimer(type, playerid)
{
    switch(type)
    {
    	case 0: Kick(playerid);
    	case 1: Ban(playerid);
    }
    return 1;
}

forward ConnectSecondNPCs();
public ConnectSecondNPCs()
{
	ConnectNPC("Bus[65][1]", "Gunthers");
    ConnectNPC("Bus[52][1]", "Guntherss");
    ConnectNPC("Bus[07][1]", "SAP07");
    ConnectNPC("Bus[30][1]", "SAP30");
    ConnectNPC("Bus[40][1]", "SAP40");
    ConnectNPC("Bus[57][1]", "SAP57");
    ConnectNPC("Bus[18][1]", "SAP18");
	return 1;
}

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
		case 4: strcat(string, "{FF0000}Owner{FFFFFF}");
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
	DeletePVar(playerid, "IsGod");
	DeletePVar(playerid, "Radio");
	DeletePVar(playerid, "Safezone");

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
    PlayerInfo[playerid][IsSpectating] = false;

}

forward GetWeekDay(day=0, month=0, year=0);
stock GetWeekDay(day=0, month=0, year=0) // thanks to yom (https://forum.sa-mp.com/showthread.php?t=66545)
{
  if (!day)
    getdate(year, month, day);

  new
    weekday_str[10],
    j,
    e
  ;

  if (month <= 2)
  {
    month += 12;
    --year;
  }

  j = year % 100;
  e = year / 100;

  switch ((day + (month+1)*26/10 + j + j/4 + e/4 - 2*e) % 7)
  {
    case 0: weekday_str = "Saturday";
    case 1: weekday_str = "Sunday";
    case 2: weekday_str = "Monday";
    case 3: weekday_str = "Tuesday";
    case 4: weekday_str = "Wednesday";
    case 5: weekday_str = "Thursday";
    case 6: weekday_str = "Friday";
  }

  return weekday_str;
}

forward FormatNumber(iNum, const szChar[] = ",");
stock FormatNumber(iNum, const szChar[] = ",") // thanks to RyDeR
{
    new
        szStr[16]
    ;
    format(szStr, sizeof(szStr), "%d", iNum);
    
    for(new iLen = strlen(szStr) - 3; iLen > 0; iLen -= 3)
    {
        strins(szStr, szChar, iLen);
    }
    return szStr;
}

forward GetMonthName(month);
stock GetMonthName(month)
{
    new ma[20];
    switch(month)
    {
        case 1: ma = "January";
        case 2: ma = "February";
        case 3: ma = "March";
        case 4: ma = "April";
        case 5: ma = "May";
        case 6: ma = "June";
        case 7: ma = "July";
        case 8: ma = "August";
        case 9: ma = "September";
        case 10: ma = "October";
        case 11: ma = "November";
        case 12: ma = "December";
    }
    return ma;
}
forward SendAdminMessage(level, message[]);
stock SendAdminMessage(level, message[])
{
	new string[256];
	format(string, sizeof(string), "{0000FF}[SFAdmin]: {C3C3C3}%s", message);
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
	format(string, sizeof(string), "{0000FF}[SFAdmin.Private]:{C3C3C3} %s to %s:{FFFFFF} %s", GetName(playerid), GetName(targetid), message);
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