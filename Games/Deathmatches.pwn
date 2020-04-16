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
    ScriptFile    : Deathmatches.pwn
    Author        : XeonMaster
    Version       : 1.0
    License       : GNU General v3.0
    Developers    : None
*/

new
	Float:RandomSpawnsDE[][] =
    {
        {242.5503,176.5623,1003.0300,93.6148},
        {240.5619,195.8680,1008.1719,91.7114},
        {253.4729,190.7446,1008.1719,115.2117},
        {288.745971, 169.350997, 1007.171875}
    },
    Float:RandomSpawnsRW[][] =
    {
        {1360.0864,-21.3368,1007.8828,183.3211},
        {1402.2295,-33.9128,1007.8819,273.5619},
        {253.4729,190.7446,1008.1719,115.2117}, 
        {1361.5745,-47.8980,1000.9238,104.6970}

    },
    Float:RandomSpawnsSOS[][] =
    {
        {-1053.9221,1022.5436,1343.1633,286.6894},
        {-975.975708,1060.983032,1345.671875},
        {-1131.4167,1042.4703,1345.7369,230.2888}
    },
    Float:RandomSpawnsSNIPE[][] =
    {
        {-2640.762939, 1406.682006, 906.460937},
        {-2664.6062,1392.3625,912.4063,60.4372},    
        {-2670.5549,1425.4402,912.4063,179.1681}
    },
    Float:RandomSpawnsSOS2[][] =
    {
        {1322.2629,2753.8525,10.8203,67.4993},
        {1197.6454,2795.0579,10.8203,13.2921},
        {1365.6454,2809.0579,10.8203,13.2921}
    },
    Float:RandomSpawnsSHOT[][] =
    {
        {2205.2983,1553.3098,1008.3852,275.1326},
        {2172.6226,1577.2854,999.9670,186.4819},
        {2188.4739,1619.3770,999.9766,0.0467},
        {2218.1841,1615.2228,999.9827,334.6665}
    },
    Float:RandomSpawnsSNIPE2[][] =
    {
        {2209.0427,1063.0984,71.3284,328.9798 },
        {2217.0649,1091.5931,29.5850,346.5500 },
        {2286.3674,1171.7701,85.9375,151.3414 },
        {2289.5737,1054.5160,26.7031,240.9556 }
    },
    Float:RandomSpawnsMINI[][] =
    {
        {-2356.9077,1539.1139,26.0469,84.7713 },
        {-2367.2000,1541.5798,17.3281,10.1972  },
        {-2388.3159,1543.0730,26.0469,185.8829 },
        {-2411.0122,1547.8350,26.0469,280.8965 },
        {-2423.4104,1547.9592,23.1406,96.9681},
        {-2434.5415,1544.7043,8.3984,289.0432},
        {-2392.1448,1548.3545,2.1172,183.7622 },
        {-2435.7583,1538.8330,11.7656,274.9664},
        {-2373.3687,1551.5563,2.1172,133.3617},
        {-2372.2913,1537.6198,10.8209,28.3940}
    },
    Float:RandomSpawnsWZ[][] =
    {
        {241.3928,1873.1758,11.4531,273.7038},
        {254.0595,1861.3322,8.7578,140.2225},
        {253.7986,1817.8022,4.7175,82.2553},
        {243.0909,1802.6503,7.4141,45.5949},
        {217.8072,1823.2727,6.4141,246.4435},
        {264.9873,1843.3636,7.5076,50.9452},
        {245.5841,1824.6747,7.5547,280.2840},
        {314.2634,1847.7885,7.7266,284.6707},
        {261.1926,1883.6488,8.4375,272.7639},
        {271.4502,1878.3483,-2.4125,41.3287},
        {267.2027,1878.4490,-22.9237,358.2578},
        {268.9091,1883.4457,-30.0938,224.7766},
        {273.5457,1855.9456,8.7649,61.2620},
        {274.8059,1871.2070,8.7578,227.9569},
        {296.7946,1865.6255,8.6411,223.1364}
    },
    Float:RandomSpawnsSHIP[][] =
    {
        {-1334.0657,512.9581,11.1953,51.5368},
        {-1342.2621,498.1203,11.1953,274.9456},
        {-1296.5226,505.3504,11.1953,133.9676},
        {-1368.6232,517.2023,11.1971,44.0400},
        {-1396.0570,498.9916,11.2026,322.5726}
    }
;

CMD:de(playerid)
{
    new str[100];
    format(str,sizeof(str), "{00FF40}[SFDeathmatches]: {%06x}%s (%d) {C3C3C3}has joined Deagle dm at /de", GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid);
    SendClientMessageToAll(-1, str);
	new xRandom = random(sizeof(RandomSpawnsDE));
	createdm(playerid,RandomSpawnsDE[xRandom][0], RandomSpawnsDE[xRandom][1], RandomSpawnsDE[xRandom][2], RandomSpawnsDE[xRandom][3],3,1,1,24,25,100,"~r~DEAGLE DM");
	return 1;
}

CMD:rw(playerid)
{
    new str[100];
    format(str,sizeof(str), "{00FF40}[SFDeathmatches]: {%06x}%s (%d) {C3C3C3}has joined Running Weapons dm at /rw", GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid);
    SendClientMessageToAll(-1, str);
	new xRandom = random(sizeof(RandomSpawnsRW));
	createdm(playerid,RandomSpawnsRW[xRandom][0], RandomSpawnsRW[xRandom][1], RandomSpawnsRW[xRandom][2], RandomSpawnsRW[xRandom][3],1,2,2,26,28,100,"~r~Running Weapons DM!");
	return 1;
}

CMD:sos(playerid)
{
    new str[100];
    format(str,sizeof(str), "{00FF40}[SFDeathmatches]: {%06x}%s (%d) {C3C3C3}has joined Sawn-Off dm at /sos", GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid);
    SendClientMessageToAll(-1, str);
	new xRandom = random(sizeof(RandomSpawnsSOS));
	createdm(playerid,RandomSpawnsSOS[xRandom][0], RandomSpawnsSOS[xRandom][1], RandomSpawnsSOS[xRandom][2], RandomSpawnsSOS[xRandom][3],10,3,3,26,32,100,"~r~Sawn-Off DM!");
	return 1;
}

CMD:snipedm(playerid)
{
    new str[100];
    format(str,sizeof(str), "{00FF40}[SFDeathmatches]: {%06x}%s (%d) {C3C3C3}has joined Sniper dm at /snipe", GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid);
    SendClientMessageToAll(-1, str);
	new xRandom = random(sizeof(RandomSpawnsSNIPE));
	createdm(playerid,RandomSpawnsSNIPE[xRandom][0], RandomSpawnsSNIPE[xRandom][1], RandomSpawnsSNIPE[xRandom][2], RandomSpawnsSNIPE[xRandom][3],3,4,4,25,34,100,"~r~Sniper DM!");
	return 1;
}

CMD:sos2(playerid)
{
    new str[100];
    format(str,sizeof(str), "{00FF40}[SFDeathmatches]: {%06x}%s (%d) {C3C3C3}has joined Sawn-off 2 dm at /sos2", GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid);
    SendClientMessageToAll(-1, str);
	new xRandom = random(sizeof(RandomSpawnsSOS2));
	createdm(playerid,RandomSpawnsSOS2[xRandom][0], RandomSpawnsSOS2[xRandom][1], RandomSpawnsSOS2[xRandom][2], RandomSpawnsSOS2[xRandom][3],0,5,5,26,0,100, "~r~Sawn Off DM 2");
	return 1;
}

CMD:shotdm(playerid)
{
    new str[100];
    format(str,sizeof(str), "{00FF40}[SFDeathmatches]: {%06x}%s (%d) {C3C3C3}has joined ShotGUN dm at /shotdm", GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid);
    SendClientMessageToAll(-1, str);
	new xRandom = random(sizeof(RandomSpawnsSHOT));
	createdm(playerid,RandomSpawnsSHOT[xRandom][0], RandomSpawnsSHOT[xRandom][1], RandomSpawnsSHOT[xRandom][2], RandomSpawnsSHOT[xRandom][3],1,6,6,27,0,100, "~r~Shot GUN DM");
	return 1;
}

CMD:snipedm2(playerid)
{
    new str[100];
    format(str,sizeof(str), "{00FF40}[SFDeathmatches]: {%06x}%s (%d) {C3C3C3}has joined Sniper 2 dm at /snipedm2", GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid);
    SendClientMessageToAll(-1, str);
	new xRandom = random(sizeof(RandomSpawnsSNIPE2));
	createdm(playerid,RandomSpawnsSNIPE2[xRandom][0], RandomSpawnsSNIPE2[xRandom][1], RandomSpawnsSNIPE2[xRandom][2], RandomSpawnsSNIPE2[xRandom][3],0,7,7,34,0,100,"~r~Sniper Off DM 2");
	return 1;
}

CMD:mini(playerid)
{
    new str[100];
    format(str,sizeof(str), "{00FF40}[SFDeathmatches]: {%06x}%s (%d) {C3C3C3}has joined Minigun dm at /mini", GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid);
    SendClientMessageToAll(-1, str);
	new xRandom = random(sizeof(RandomSpawnsMINI));
	createdm(playerid,RandomSpawnsMINI[xRandom][0], RandomSpawnsMINI[xRandom][1], RandomSpawnsMINI[xRandom][2], RandomSpawnsMINI[xRandom][3],0,8,8,38,0,100,"~r~MINIGUN DM");
	return 1;
}

CMD:wz(playerid)
{
    new str[100];
    format(str,sizeof(str), "{00FF40}[SFDeathmatches]: {%06x}%s (%d) {C3C3C3}has joined War Zone dm at /wz", GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid);
    SendClientMessageToAll(-1, str);
	new xRandom = random(sizeof(RandomSpawnsWZ));
	createdm(playerid,RandomSpawnsWZ[xRandom][0], RandomSpawnsWZ[xRandom][1], RandomSpawnsWZ[xRandom][2], RandomSpawnsWZ[xRandom][3],0,9,9,31,16,100,"~r~War Zone");
	return 1;
}

CMD:shipdm(playerid)
{
    new str[100];
    format(str,sizeof(str), "{00FF40}[SFDeathmatches]: {%06x}%s (%d) {C3C3C3}has joined Ship dm at /shipdm", GetPlayerColor(playerid) >>> 8, GetName(playerid), playerid);
    SendClientMessageToAll(-1, str);
	new xRandom = random(sizeof(RandomSpawnsSHIP));
	createdm(playerid,RandomSpawnsSHIP[xRandom][0], RandomSpawnsSHIP[xRandom][1], RandomSpawnsSHIP[xRandom][2], RandomSpawnsSHIP[xRandom][3],0,10,10,23,29,100,"~r~Ship DM");
	return 1;
}

CMD:leave(playerid)
{
	if (!PlayerInfo[playerid][InDM]) return SendClientMessage(playerid, -1, "{00FF40}[SFDeathmatches]:{C3C3C3} Invalid Usage, You are not in a deathmatch area." );
    PlayerInfo[playerid][InDM] = false;
    PlayerInfo[playerid][DmZone] = 0;
    SetPlayerVirtualWorld(playerid, 0);
    SpawnPlayer(playerid);
    SetPlayerInterior(playerid,0);
    SendClientMessage(playerid, -1, "{00FF40}[SFDeathmatches]:{C3C3C3} You have left the deathmatch arena." );
    StopAudioStreamForPlayer(playerid);
    SetCameraBehindPlayer(playerid);
	return 1;
}

CMD:dm(playerid)
{
	new string[900],pde,prw,psos,psnipe,psos2,psnipe2,pshot,pmini,pwz,pship;

	for(new i=0;i<MAX_PLAYERS;i++)
	{
		if(IsPlayerConnected(i))
		{
			switch(PlayerInfo[i][DmZone])
			{

				case 1:pde++;
				case 2:prw++;
				case 3:psos++;
				case 4:psnipe++;
				case 5:psos2++;
				case 6:pshot++;
				case 7:psnipe2++;
				case 8:pmini++;
				case 9:pwz++;
				case 10:pship++;
			}
		}
	}

	format(string,sizeof(string),
	"{DC143C}Map\t{DC143C}Players\n\
	{FFFFFF}Deagle (/de)\t%d\n\
	Running Weapons (/rw)\t%d\n\
	Sawn-Off Shotgun (/sos)\t%d\n\
	Sniper (/sniperdm)\t%d\n\
	Sawn-Off Shotgun 2(/sos2)\t%d\n\
	Sniper DM 2 (/snipedm2)\t%d\n\
	ShotGun DM (/shotdm)\t%d\n\
	MiniGun DM (/mini)\t%d\n\
	War Zone (/wz)\t%d\n\
	Ship DM (/shipdm)\t%d\n",pde,prw,psos,psnipe,psos2,psnipe2,pshot,pmini,pwz,pship);

	ShowPlayerDialog(playerid, DIALOG_DM, DIALOG_STYLE_TABLIST_HEADERS, "{FF0000}SFS:{FFFFFF} Deathmatches",string, "Select","Cancel");
	return 1;
}

forward SetPlayerPosition(playerid, Float:X, Float:Y, Float:Z, Float:A);
stock SetPlayerPosition(playerid, Float:X, Float:Y, Float:Z, Float:A)
{
	SetPlayerPos(playerid, X, Y, Z);
	SetPlayerFacingAngle(playerid, A);
    return 1;
}

forward createdm(playerid,Float:X,Float:Y,Float:Z,Float:A,interior,virtualworld,zone,weapon1,weapon2,health,text[]);
stock createdm(playerid,Float:X,Float:Y,Float:Z,Float:A,interior,virtualworld,zone,weapon1,weapon2,health,text[]) // SS DM
{

	PlayerInfo[playerid][InDM] = true;
	PlayerInfo[playerid][DmZone] = zone;

	if (IsPlayerInAnyVehicle(playerid))
	{
		RemovePlayerFromVehicle(playerid);
	}
	SetPlayerPosition(playerid, X,Y,Z,A);
	SetPlayerInterior(playerid, interior);
	ResetPlayerWeapons(playerid);
	GameTextForPlayer(playerid, text, 2000, 3);
	SetPlayerFacingAngle(playerid, A);
	SetPlayerHealth(playerid, health);
	GivePlayerWeapon(playerid, weapon1, 100000);
	GivePlayerWeapon(playerid, weapon2, 100000);
	SetPlayerVirtualWorld(playerid, WORLD_DM+virtualworld);

	return 1;
}

forward respawnindm(playerid);
stock respawnindm(playerid) // SS DM
{
	switch (PlayerInfo[playerid][DmZone])
	{
		case 1:
		{
			new xRandom = random(sizeof(RandomSpawnsDE));
			createdm(playerid,RandomSpawnsDE[xRandom][0], RandomSpawnsDE[xRandom][1], RandomSpawnsDE[xRandom][2], RandomSpawnsDE[xRandom][3],3,1,1,24,25,100,"");
		}

		case 2:
		{
			new xRandom = random(sizeof(RandomSpawnsRW));
			createdm(playerid,RandomSpawnsRW[xRandom][0], RandomSpawnsRW[xRandom][1], RandomSpawnsRW[xRandom][2], RandomSpawnsRW[xRandom][3],1,2,2,26,28,100,"");
			return 1;
		}
		case 3:
		{
			new xRandom = random(sizeof(RandomSpawnsSOS));
			createdm(playerid,RandomSpawnsSOS[xRandom][0], RandomSpawnsSOS[xRandom][1], RandomSpawnsSOS[xRandom][2], RandomSpawnsSOS[xRandom][3],10,3,3,26,32,100,"");
		}
		case 4:
		{
			new xRandom = random(sizeof(RandomSpawnsSNIPE));
			createdm(playerid,RandomSpawnsSNIPE[xRandom][0], RandomSpawnsSNIPE[xRandom][1], RandomSpawnsSNIPE[xRandom][2], RandomSpawnsSNIPE[xRandom][3],3,4,4,25,34,100,"");
		}
		case 5:
		{
			new xRandom = random(sizeof(RandomSpawnsSOS2));
			createdm(playerid,RandomSpawnsSOS2[xRandom][0], RandomSpawnsSOS2[xRandom][1], RandomSpawnsSOS2[xRandom][2], RandomSpawnsSOS2[xRandom][3],0,5,5,31,16,100,"");
		}
		case 6:
		{
			new xRandom = random(sizeof(RandomSpawnsSHOT));
			createdm(playerid,RandomSpawnsSHOT[xRandom][0], RandomSpawnsSHOT[xRandom][1], RandomSpawnsSHOT[xRandom][2], RandomSpawnsSHOT[xRandom][3],1,6,6,27,0,100, "");
		}
		case 7:
		{
			new xRandom = random(sizeof(RandomSpawnsSNIPE2));
			createdm(playerid,RandomSpawnsSNIPE2[xRandom][0], RandomSpawnsSNIPE2[xRandom][1], RandomSpawnsSNIPE2[xRandom][2], RandomSpawnsSNIPE2[xRandom][3],0,7,7,34,0,100,"");
		}
		case 8:
		{
			new xRandom = random(sizeof(RandomSpawnsMINI));
			createdm(playerid,RandomSpawnsMINI[xRandom][0], RandomSpawnsMINI[xRandom][1], RandomSpawnsMINI[xRandom][2], RandomSpawnsMINI[xRandom][3],0,8,8,38,0,100,"");
		}
		case 9:
		{
			new xRandom = random(sizeof(RandomSpawnsWZ));
			createdm(playerid,RandomSpawnsWZ[xRandom][0], RandomSpawnsWZ[xRandom][1], RandomSpawnsWZ[xRandom][2], RandomSpawnsWZ[xRandom][3],0,9,9,31,16,100,"");
		}
		case 10:
		{
			new xRandom = random(sizeof(RandomSpawnsSHIP));
			createdm(playerid,RandomSpawnsSHIP[xRandom][0], RandomSpawnsSHIP[xRandom][1], RandomSpawnsSHIP[xRandom][2], RandomSpawnsSHIP[xRandom][3],0,10,10,23,29,100,"");
		}
	}
	return 1;
}