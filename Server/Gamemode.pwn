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
    ScriptFile    : Gamemode.pwn
    Author        : XeonMaster
    Version       : 1.0
    License       : GNU General v3.0
    Developers    : None
*/

main() { }

public OnGameModeInit()
{
	printf("Initialization of 'SEF Global Gamemode'..");

	// Textdraws
	Login[0] = TextDrawCreate(1025.000000, 0.000000, ".");
	TextDrawBackgroundColor(Login[0], 255);
	TextDrawFont(Login[0], 0);
	TextDrawLetterSize(Login[0], 0.500000, 53.700000);
	TextDrawColor(Login[0], -1);
	TextDrawSetOutline(Login[0], 0);
	TextDrawSetProportional(Login[0], 1);
	TextDrawSetShadow(Login[0], 1);
	TextDrawUseBox(Login[0], 1);
	TextDrawBoxColor(Login[0], 168430280);
	TextDrawTextSize(Login[0], -65.000000, 3.000000);
	TextDrawSetSelectable(Login[0], 0);

	Login[1] = TextDrawCreate(238.000000, 111.000000, "Stunt Freeroam Server");
	TextDrawBackgroundColor(Login[1], 0);
	TextDrawFont(Login[1], 0);
	TextDrawLetterSize(Login[1], 0.579999, 2.299999);
	TextDrawColor(Login[1], -16776961);
	TextDrawSetOutline(Login[1], 1);
	TextDrawSetProportional(Login[1], 1);
	TextDrawSetSelectable(Login[1], 0);

	Login[2] = TextDrawCreate(20.000000, 421.000000, "Version 1.0");
	TextDrawBackgroundColor(Login[2], 255);
	TextDrawFont(Login[2], 2);
	TextDrawLetterSize(Login[2], 0.270000, 1.600000);
	TextDrawColor(Login[2], -1);
	TextDrawSetOutline(Login[2], 1);
	TextDrawSetProportional(Login[2], 1);
	TextDrawSetSelectable(Login[2], 0);

	Login[3] = TextDrawCreate(438.000000, 421.000000, "Freeroam/DM/TDM/Minigames");
	TextDrawBackgroundColor(Login[3], 255);
	TextDrawFont(Login[3], 2);
	TextDrawLetterSize(Login[3], 0.260000, 1.600000);
	TextDrawColor(Login[3], -1);
	TextDrawSetOutline(Login[3], 1);
	TextDrawSetProportional(Login[3], 1);
	TextDrawSetSelectable(Login[3], 0);

	Login[4] = TextDrawCreate(545.000000, 22.000000, "SFServer");
	TextDrawBackgroundColor(Login[4], 255);
	TextDrawFont(Login[4], 0);
	TextDrawLetterSize(Login[4], 0.490000, 1.400000);
	TextDrawColor(Login[4], -1);
	TextDrawSetOutline(Login[4], 1);
	TextDrawSetProportional(Login[4], 1);
	TextDrawSetSelectable(Login[4], 0);

	Login[5] = TextDrawCreate(190.000000, 204.000000, "New Textdraw");
	TextDrawBackgroundColor(Login[5], 168430080);
	TextDrawFont(Login[5], 5);
	TextDrawLetterSize(Login[5], 1.320000, 11.100000);
	TextDrawColor(Login[5], -1);
	TextDrawSetOutline(Login[5], 1);
	TextDrawSetProportional(Login[5], 0);
	TextDrawUseBox(Login[5], 1);
	TextDrawBoxColor(Login[5], 255);
	TextDrawTextSize(Login[5], -101.000000, 140.000000);
	TextDrawSetSelectable(Login[5], 0);
	TextDrawSetPreviewModel(Login[5], 411);
	TextDrawSetPreviewRot(Login[5], -10.0, 0.0, -20.0, 1.0);

	Login[6] = TextDrawCreate(202.000000, 147.000000, "New Textdraw");
	TextDrawBackgroundColor(Login[6], 168430080);
	TextDrawFont(Login[6], 5);
	TextDrawLetterSize(Login[6], 1.320000, 11.100000);
	TextDrawColor(Login[6], -1);
	TextDrawSetOutline(Login[6], 1);
	TextDrawSetProportional(Login[6], 0);
	TextDrawUseBox(Login[6], 1);
	TextDrawBoxColor(Login[6], 255);
	TextDrawTextSize(Login[6], -101.000000, 140.000000);
	TextDrawSetSelectable(Login[6], 0);
	TextDrawSetPreviewModel(Login[6], 470);
	TextDrawSetPreviewRot(Login[6], -10.0, 0.0, -20.0, 1.0);

	Login[7] = TextDrawCreate(456.000000, 137.000000, "New Textdraw");
	TextDrawBackgroundColor(Login[7], 168430080);
	TextDrawFont(Login[7], 5);
	TextDrawLetterSize(Login[7], 0.500000, 1.000000);
	TextDrawColor(Login[7], -1);
	TextDrawSetOutline(Login[7], 0);
	TextDrawSetProportional(Login[7], 1);
	TextDrawSetShadow(Login[7], 1);
	TextDrawUseBox(Login[7], 1);
	TextDrawBoxColor(Login[7], 255);
	TextDrawTextSize(Login[7], 176.000000, 176.000000);
	TextDrawSetSelectable(Login[7], 0);
	TextDrawSetPreviewModel(Login[7], 18749);
	TextDrawSetPreviewRot(Login[7], 0.0, 0.0, 1980.0, 1.0);

	TotalVeh += LoadStaticVehiclesFromFile("vehicles/trains.txt");
    TotalVeh += LoadStaticVehiclesFromFile("vehicles/pilots.txt");

       // LAS VENTURAS
    TotalVeh += LoadStaticVehiclesFromFile("vehicles/lv_law.txt");
    TotalVeh += LoadStaticVehiclesFromFile("vehicles/lv_airport.txt");
    TotalVeh += LoadStaticVehiclesFromFile("vehicles/lv_gen.txt");
    
    // SAN FIERRO
    TotalVeh += LoadStaticVehiclesFromFile("vehicles/sf_law.txt");
    TotalVeh += LoadStaticVehiclesFromFile("vehicles/sf_airport.txt");
    TotalVeh += LoadStaticVehiclesFromFile("vehicles/sf_gen.txt");
    
    // LOS SANTOS
    TotalVeh += LoadStaticVehiclesFromFile("vehicles/ls_law.txt");
    TotalVeh += LoadStaticVehiclesFromFile("vehicles/ls_airport.txt");
    TotalVeh += LoadStaticVehiclesFromFile("vehicles/ls_gen_inner.txt");
    TotalVeh += LoadStaticVehiclesFromFile("vehicles/ls_gen_outer.txt");
    
    // OTHER AREAS
    TotalVeh += LoadStaticVehiclesFromFile("vehicles/whetstone.txt");
    TotalVeh += LoadStaticVehiclesFromFile("vehicles/bone.txt");
    TotalVeh += LoadStaticVehiclesFromFile("vehicles/flint.txt");
    TotalVeh += LoadStaticVehiclesFromFile("vehicles/tierra.txt");
    TotalVeh += LoadStaticVehiclesFromFile("vehicles/red_county.txt"); 

    UsePlayerPedAnims();
    
    ConnectNPC("[SAP]Bus[65][0]", "Gunthers");
    ConnectNPC("[SAP]Bus[52][0]", "Guntherss");
    ConnectNPC("[SAP]Bus[07][0]", "SAP07");
    ConnectNPC("[SAP]Bus[30][0]", "SAP30");
    ConnectNPC("[SAP]Bus[40][0]", "SAP40");
    ConnectNPC("[SAP]Bus[57][0]", "SAP57");
    ConnectNPC("[SAP]Bus[18][0]", "SAP18");


	SetTimer("ConnectSecondNPCs", 60*1000, false);

	IRC_Init();
	
	printf("Completed... (1/4)");
	printf("Initialization of 'MySQL Connection'..");

	MySQLConnect();
	CreateTables();

	printf("Completed... (2/4)");
	printf("Initialization of 'Discord Connection'..");

	printf("Completed... (3/4)");
	printf("Initialization of 'IRC Connection'..");

	printf("Completed... (4/5)");
	printf("Initialization of 'Other startup plugins'..");

	MapAndreas_Init(MAP_ANDREAS_MODE_FULL);

	printf("Completed... (5/5)");
	printf("-------------------------------------------------------------");
	printf("	Everything Loaded, Welcome to.");
	printf("-------------------------------------------------------------");
	printf("-------------------------------------------------------------");
	printf("     #####                            ");
	printf("    #     #  #####  #    #  #    #  ##### "); 
	printf("    #          #    #    #  ##   #    #   ");
 	printf("     #####     #    #    #  # #  #    #   ");
    printf("          #    #    #    #  #  # #    #   ");
    printf("    #     #    #    #    #  #   ##    #   ");
    printf("     #####     #     ####   #    #    #   ");

	printf("    #######                                                  ");
	printf("    #       #####  ###### ###### #####   ####    ##   #    # ");
	printf("    #       #    # #      #      #    # #    #  #  #  ##  ## ");
	printf("    #####   #    # #####  #####  #    # #    # #    # # ## # ");
	printf("    #       #####  #      #      #####  #    # ###### #    # ");
	printf("    #       #   #  #      #      #   #  #    # #    # #    # ");
	printf("    #       #    # ###### ###### #    #  ####  #    # #    # ");

	printf("     #####                                     ");
	printf("    #     #  ######  #####   #    #  ######  #####  ");
	printf("    #        #       #    #  #    #  #       #    # ");
    printf("     #####   #####   #    #  #    #  #####   #    # ");
    printf("          #  #       #####   #    #  #       #####  ");
    printf("    #     #  #       #   #    #  #   #       #   #  ");
    printf("     #####   ######  #    #    ##    ######  #    # ");
    printf("\n");
    printf("-------------------------------------------------------------");
	printf("-------------------------------------------------------------");
	printf("	Version: 1.0 | Author: XeonMaster   ");
	printf("-------------------------------------------------------------");

	GlobalTimer = SetTimerEx("UpdateServInfo", 500, true, "");
	return 1;
}

public OnGameModeExit()
{
	printf("-------------------------------------------------------------");
	printf("	Unloading the gamemode.");
	printf("-------------------------------------------------------------");

	for(new i = 0; i < 8; i++) TextDrawDestroy(Login[i]);

	foreach(new i : Player)
    {
		if(IsPlayerConnected(i))
		{
			OnPlayerDisconnect(i, 1); 
		}
	}
	mysql_close(Database);
	KillTimer(GlobalTimer);
	
	for(new i = 0; i < 14; i++) Delete3DTextLabel(NPCText[i]);
	for(new i = 0; i < 14; i++) DestroyVehicle(NPCBus[i]);

	IRC_Quit(botIDs[1], "Gamemode exiting.");
	IRC_DestroyGroup(groupID);

	printf("-------------------------------------------------------------");
	printf("     #####                            ");
	printf("    #     #  #####  #    #  #    #  ##### "); 
	printf("    #          #    #    #  ##   #    #   ");
 	printf("     #####     #    #    #  # #  #    #   ");
    printf("          #    #    #    #  #  # #    #   ");
    printf("    #     #    #    #    #  #   ##    #   ");
    printf("     #####     #     ####   #    #    #   ");

	printf("    #######                                                  ");
	printf("    #       #####  ###### ###### #####   ####    ##   #    # ");
	printf("    #       #    # #      #      #    # #    #  #  #  ##  ## ");
	printf("    #####   #    # #####  #####  #    # #    # #    # # ## # ");
	printf("    #       #####  #      #      #####  #    # ###### #    # ");
	printf("    #       #   #  #      #      #   #  #    # #    # #    # ");
	printf("    #       #    # ###### ###### #    #  ####  #    # #    # ");

	printf("     #####                                     ");
	printf("    #     #  ######  #####   #    #  ######  #####  ");
	printf("    #        #       #    #  #    #  #       #    # ");
    printf("     #####   #####   #    #  #    #  #####   #    # ");
    printf("          #  #       #####   #    #  #       #####  ");
    printf("    #     #  #       #   #    #  #   #       #   #  ");
    printf("     #####   ######  #    #    ##    ######  #    # ");
    printf("\n");
    printf("-------------------------------------------------------------");
	printf("-------------------------------------------------------------");
	printf("	See you later!  ");
	printf("-------------------------------------------------------------");
	return 0;
}