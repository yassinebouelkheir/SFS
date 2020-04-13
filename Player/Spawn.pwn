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
    ScriptFile    : Connections.pwn
    Author        : Spawn.pwn
    Version       : 1.0
    License       : GNU General v3.0
    Developers    : None
*/

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnPlayerSpawn(playerid)
{
    if(IsPlayerNPC(playerid))
    {
        if(!strcmp(GetName(playerid), "Bus[65][0]", true))
        {
            NPCText[0] = Create3DTextLabel("{FF0000}(LV) Pirates Ship <-> (SF) Pirates Ship\n --------\n 65 \n--------", -1, 30.0, 40.0, 50.0, 40.0, 0); 
            Attach3DTextLabelToPlayer(NPCText[0], playerid, 0.0, 0.0, 0.7);

            new Float:X, Float:Y, Float:Z, Float:Angle;
            GetPlayerPos(playerid, X, Y, Z);
            GetPlayerFacingAngle(playerid, Angle);
            DestroyVehicle(NPCBus[0]);
            NPCBus[0] = CreateVehicle(437, X, Y, Z, Angle, 0, 0, 0);
            PutPlayerInVehicle(playerid, NPCBus[0] ,0);
        }
        if(!strcmp(GetName(playerid), "Bus[52][0]", true))
        {
            NPCText[1] = Create3DTextLabel("{FF0000}(LV) Emerald Isle <-> (LS) Grouve Street\n --------\n 52 \n--------", -1, 30.0, 40.0, 50.0, 40.0, 0); // Red Country
            Attach3DTextLabelToPlayer(NPCText[1], playerid, 0.0, 0.0, 0.7);

            new Float:X, Float:Y, Float:Z, Float:Angle;
            GetPlayerPos(playerid, X, Y, Z);
            GetPlayerFacingAngle(playerid, Angle);
            DestroyVehicle(NPCBus[1]);
            NPCBus[1] = CreateVehicle(437, X, Y, Z, Angle, 0, 0, 0);
            PutPlayerInVehicle(playerid, NPCBus[1] ,0);
        }
        if(!strcmp(GetName(playerid), "Bus[07][0]", true))
        {
            NPCText[2] = Create3DTextLabel("{FF0000}(LV) Ammo Nation <-> (LV - SF) Area 69\n --------\n 07 \n--------", -1, 30.0, 40.0, 50.0, 40.0, 0); // Red Country
            Attach3DTextLabelToPlayer(NPCText[2], playerid, 0.0, 0.0, 0.7);

            new Float:X, Float:Y, Float:Z, Float:Angle;
            GetPlayerPos(playerid, X, Y, Z);
            GetPlayerFacingAngle(playerid, Angle);
            DestroyVehicle(NPCBus[2]);
            NPCBus[2] = CreateVehicle(437, X, Y, Z, Angle, 0, 0, 0);
            PutPlayerInVehicle(playerid, NPCBus[2] ,0);
        }
        if(!strcmp(GetName(playerid), "Bus[30][0]", true))
        {
            NPCText[3] = Create3DTextLabel("{FF0000}(LV) Police Departemment <-> (LS - SF) Mount Chilliad\n --------\n 30 \n--------", -1, 30.0, 40.0, 50.0, 40.0, 0); // Red Country
            Attach3DTextLabelToPlayer(NPCText[3], playerid, 0.0, 0.0, 0.7);

            new Float:X, Float:Y, Float:Z, Float:Angle;
            GetPlayerPos(playerid, X, Y, Z);
            GetPlayerFacingAngle(playerid, Angle);
            DestroyVehicle(NPCBus[3]);
            NPCBus[3] = CreateVehicle(437, X, Y, Z, Angle, 0, 0, 0);
            PutPlayerInVehicle(playerid, NPCBus[3] ,0);
        }
        if(!strcmp(GetName(playerid), "Bus[40][0]", true))
        {
            NPCText[4] = Create3DTextLabel("{FF0000}(T-LV) Las Venturas <-> (LV - SF) Las Barrancas\n --------\n 40 \n--------", -1, 30.0, 40.0, 50.0, 40.0, 0); // Red Country
            Attach3DTextLabelToPlayer(NPCText[4], playerid, 0.0, 0.0, 0.7);

            new Float:X, Float:Y, Float:Z, Float:Angle;
            GetPlayerPos(playerid, X, Y, Z);
            GetPlayerFacingAngle(playerid, Angle);
            DestroyVehicle(NPCBus[4]);
            NPCBus[4] = CreateVehicle(437, X, Y, Z, Angle, 0, 0, 0);
            PutPlayerInVehicle(playerid, NPCBus[4] ,0);
        }
        if(!strcmp(GetName(playerid), "Bus[18][0]", true))
        {
            NPCText[5] = Create3DTextLabel("{FF0000}(SF) Police Office <-> (LS Beach) Vachet Harbor\n --------\n 18 \n--------", -1, 30.0, 40.0, 50.0, 40.0, 0); // Red Country
            Attach3DTextLabelToPlayer(NPCText[5], playerid, 0.0, 0.0, 0.7);

            new Float:X, Float:Y, Float:Z, Float:Angle;
            GetPlayerPos(playerid, X, Y, Z);
            GetPlayerFacingAngle(playerid, Angle);
            DestroyVehicle(NPCBus[5]);
            NPCBus[5] = CreateVehicle(437, X, Y, Z, Angle, 0, 0, 0);
            PutPlayerInVehicle(playerid, NPCBus[5] ,0);
        }
        if(!strcmp(GetName(playerid), "Bus[57][0]", true))
        {
            NPCText[6] = Create3DTextLabel("{FF0000}(SF) Train Station <-> (SF-LV) The Small Village\n --------\n 57 \n--------", -1, 30.0, 40.0, 50.0, 40.0, 0); // Red Country
            Attach3DTextLabelToPlayer(NPCText[6], playerid, 0.0, 0.0, 0.7);

            new Float:X, Float:Y, Float:Z, Float:Angle;
            GetPlayerPos(playerid, X, Y, Z);
            GetPlayerFacingAngle(playerid, Angle);
            DestroyVehicle(NPCBus[6]);
            NPCBus[6] = CreateVehicle(437, X, Y, Z, Angle, 0, 0, 0);
            PutPlayerInVehicle(playerid, NPCBus[6] ,0);
        }
        if(!strcmp(GetName(playerid), "Bus[65][1]", true))
        {
            NPCText[7] = Create3DTextLabel("{FF0000}(LV) Pirates Ship <-> (SF) Pirates Ship\n --------\n 65 \n--------", -1, 30.0, 40.0, 50.0, 40.0, 0); 
            Attach3DTextLabelToPlayer(NPCText[7], playerid, 0.0, 0.0, 0.7);

            new Float:X, Float:Y, Float:Z, Float:Angle;
            GetPlayerPos(playerid, X, Y, Z);
            GetPlayerFacingAngle(playerid, Angle);
            DestroyVehicle(NPCBus[7]);
            NPCBus[7] = CreateVehicle(437, X, Y, Z, Angle, 0, 0, 0);
            PutPlayerInVehicle(playerid, NPCBus[7] ,0);
        }
        if(!strcmp(GetName(playerid), "Bus[52][1]", true))
        {
            NPCText[8] = Create3DTextLabel("{FF0000}(LV) Emerald Isle <-> (LS) Grouve Street\n --------\n 52 \n--------", -1, 30.0, 40.0, 50.0, 40.0, 0); 
            Attach3DTextLabelToPlayer(NPCText[8], playerid, 0.0, 0.0, 0.7);

            new Float:X, Float:Y, Float:Z, Float:Angle;
            GetPlayerPos(playerid, X, Y, Z);
            GetPlayerFacingAngle(playerid, Angle);
            DestroyVehicle(NPCBus[8]);
            NPCBus[8] = CreateVehicle(437, X, Y, Z, Angle, 0, 0, 0);
            PutPlayerInVehicle(playerid, NPCBus[8] ,0);
        }
        if(!strcmp(GetName(playerid), "Bus[07][1]", true))
        {
            NPCText[9] = Create3DTextLabel("{FF0000}(LV) Ammo Nation <-> (LV - SF) Area 69\n --------\n 07 \n--------", -1, 30.0, 40.0, 50.0, 40.0, 0); 
            Attach3DTextLabelToPlayer(NPCText[9], playerid, 0.0, 0.0, 0.7);

            new Float:X, Float:Y, Float:Z, Float:Angle;
            GetPlayerPos(playerid, X, Y, Z);
            GetPlayerFacingAngle(playerid, Angle);
            DestroyVehicle(NPCBus[9]);
            NPCBus[9] = CreateVehicle(437, X, Y, Z, Angle, 0, 0, 0);
            PutPlayerInVehicle(playerid, NPCBus[9] ,0);
        }
        if(!strcmp(GetName(playerid), "Bus[30][1]", true))
        {
            NPCText[10] = Create3DTextLabel("{FF0000}(LV) Police Departemment <-> (LS - SF) Mount Chilliad\n --------\n 30 \n--------", -1, 30.0, 40.0, 50.0, 40.0, 0); 
            Attach3DTextLabelToPlayer(NPCText[10], playerid, 0.0, 0.0, 0.7);

            new Float:X, Float:Y, Float:Z, Float:Angle;
            GetPlayerPos(playerid, X, Y, Z);
            GetPlayerFacingAngle(playerid, Angle);
            DestroyVehicle(NPCBus[10]);
            NPCBus[10] = CreateVehicle(437, X, Y, Z, Angle, 0, 0, 0);
            PutPlayerInVehicle(playerid, NPCBus[10] ,0);
        }
        if(!strcmp(GetName(playerid), "Bus[40][1]", true))
        {
            NPCText[11] = Create3DTextLabel("{FF0000}(T-LV) Las Venturas <-> (LV - SF) Las Barrancas\n --------\n 40 \n--------", -1, 30.0, 40.0, 50.0, 40.0, 0); 
            Attach3DTextLabelToPlayer(NPCText[11], playerid, 0.0, 0.0, 0.7);

            new Float:X, Float:Y, Float:Z, Float:Angle;
            GetPlayerPos(playerid, X, Y, Z);
            GetPlayerFacingAngle(playerid, Angle);
            DestroyVehicle(NPCBus[11]);
            NPCBus[11] = CreateVehicle(437, X, Y, Z, Angle, 0, 0, 0);
            PutPlayerInVehicle(playerid, NPCBus[11] ,0);
        }
        if(!strcmp(GetName(playerid), "Bus[18][1]", true))
        {
            NPCText[12] = Create3DTextLabel("{FF0000}(SF) Police Office <-> (LS Beach) Vachet Harbor\n --------\n 18 \n--------", -1, 30.0, 40.0, 50.0, 40.0, 0); 
            Attach3DTextLabelToPlayer(NPCText[12], playerid, 0.0, 0.0, 0.7);

            new Float:X, Float:Y, Float:Z, Float:Angle;
            GetPlayerPos(playerid, X, Y, Z);
            GetPlayerFacingAngle(playerid, Angle);
            DestroyVehicle(NPCBus[12]);
            NPCBus[12] = CreateVehicle(437, X, Y, Z, Angle, 0, 0, 0);
            PutPlayerInVehicle(playerid, NPCBus[12] ,0);
        }
        if(!strcmp(GetName(playerid), "Bus[57][1]", true))
        {
            NPCText[13] = Create3DTextLabel("{FF0000}(SF) Train Station <-> (SF-LV) The Small Village\n --------\n 57 \n--------", -1, 30.0, 40.0, 50.0, 40.0, 0); 
            Attach3DTextLabelToPlayer(NPCText[13], playerid, 0.0, 0.0, 0.7);

            new Float:X, Float:Y, Float:Z, Float:Angle;
            GetPlayerPos(playerid, X, Y, Z);
            GetPlayerFacingAngle(playerid, Angle);
            DestroyVehicle(NPCBus[13]);
            NPCBus[13] = CreateVehicle(437, X, Y, Z, Angle, 0, 0, 0);
            PutPlayerInVehicle(playerid, NPCBus[13] ,0);
        }
        if(!strcmp(GetName(playerid), "Ship[01]", true))
        {
            NPCText[14] = Create3DTextLabel("{FF0000}Stunt Freeroam Ship LV Pirates Ship\nFIGHTING / BOMBS / ABUSE\n are not allowed in the ship", -1, 30.0, 40.0, 50.0, 10.0, 0);
            Attach3DTextLabelToPlayer(NPCText[14], playerid, 0.0, 0.0, 0.7);
            SetPlayerSkin(playerid, 217);
            GivePlayerWeapon(playerid, 38, 19000);
        }
        if(!strcmp(GetName(playerid), "Ship[02]", true))
        {
            NPCText[15] = Create3DTextLabel("{FF0000}Stunt Freeroam Ship LV Pirates Ship\nCARS / PLANES / BIKES / BOATS\n are not allowed in the ship", -1, 30.0, 40.0, 50.0, 10.0, 0);
            Attach3DTextLabelToPlayer(NPCText[15], playerid, 0.0, 0.0, 0.7);
            SetPlayerSkin(playerid, 217);
            GivePlayerWeapon(playerid, 38, 19000);
        }
        return 1;
    }
    if(GetPVarInt(playerid, "FirstSpawn"))
    {
        if(PlayerInfo[playerid][VIP])
        {
            new
                weaponid,
                ammo,
                count;
            cache_get_row_count(count);

            for(new i, j = count; i < j; i++) 
            {
                cache_get_value_int(i, "WEAPONID", weaponid);
                cache_get_value_int(i, "AMMO", ammo);
                
                if(!(0 <= weaponid <= 46)) continue;
                
                GivePlayerWeapon(playerid, weaponid, ammo); 
            }
            new string[42];
            mysql_format(Database, string, sizeof(string), "DELETE FROM `WEAPONDATA` WHERE `ID` = %d", PlayerInfo[playerid][ID]);
            mysql_tquery(Database, string);
        }

    	StopAudioStreamForPlayer(playerid);
    	TextDrawHideForPlayer(playerid, Login[0]);
    	TextDrawHideForPlayer(playerid, Login[1]);
    	TextDrawHideForPlayer(playerid, Login[2]);
    	TextDrawHideForPlayer(playerid, Login[3]);
    	TextDrawHideForPlayer(playerid, Login[5]);
    	TextDrawHideForPlayer(playerid, Login[6]);
    	TextDrawHideForPlayer(playerid, Login[7]);
    	TextDrawShowForPlayer(playerid, Login[4]);

        PlayerInfo[playerid][PlayerTimer] = SetTimerEx("UpdatePlayerInfo", 1000, true, "i", playerid);
        DeletePVar(playerid, "FirstSpawn");
    }

	SetCameraBehindPlayer(playerid);
	TogglePlayerSpectating(playerid, 0);
	TogglePlayerControllable(playerid, 1);

	/*new
        Float:pos[3],
        x=random(4000)-2000,
        y=random(4000)-2000,
        Float:z;
               
    for(new a; a < 100; a++)
    {
        MapAndreas_FindZ_For2DCoord(x, y, z);
 
        if(z >= 5.0 && z < 30.0)
        {
            pos[0] = x;
            pos[1] = y;
            pos[2] = z;
            SetPlayerPos(playerid, x, y, z);
            break;
        }
    }*/

    new Random = random(sizeof(RandomSpawns));
    SetPlayerPos(playerid, RandomSpawns[Random][0], RandomSpawns[Random][1], RandomSpawns[Random][2]);
    SetPlayerFacingAngle(playerid, RandomSpawns[Random][3]);
	return 1;
}