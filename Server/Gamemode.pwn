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

	Death[0] = TextDrawCreate(650.000000, 0.000000, ".");
	TextDrawBackgroundColor(Death[0], 255);
	TextDrawFont(Death[0], 1);
	TextDrawLetterSize(Death[0], 0.500000, 51.000000);
	TextDrawColor(Death[0], -1);
	TextDrawSetOutline(Death[0], 0);
	TextDrawSetProportional(Death[0], 1);
	TextDrawSetShadow(Death[0], 1);
	TextDrawUseBox(Death[0], 1);
	TextDrawBoxColor(Death[0], 5111928);
	TextDrawTextSize(Death[0], -3.000000, -23.000000);
	TextDrawSetSelectable(Death[0], 0);

	Death[1] = TextDrawCreate(641.000000, 160.000000, ".");
	TextDrawBackgroundColor(Death[1], 255);
	TextDrawFont(Death[1], 1);
	TextDrawLetterSize(Death[1], 0.500000, 8.100000);
	TextDrawColor(Death[1], -1);
	TextDrawSetOutline(Death[1], 0);
	TextDrawSetProportional(Death[1], 1);
	TextDrawSetShadow(Death[1], 1);
	TextDrawUseBox(Death[1], 1);
	TextDrawBoxColor(Death[1], 100);
	TextDrawTextSize(Death[1], -20.000000, 3.000000);
	TextDrawSetSelectable(Death[1], 0);

	Death[2] = TextDrawCreate(317.000000, 172.000000, "WASTED");
	TextDrawAlignment(Death[2], 2);
	TextDrawBackgroundColor(Death[2], 131272);
	TextDrawFont(Death[2], 3);
	TextDrawLetterSize(Death[2], 1.410000, 4.099999);
	TextDrawColor(Death[2], -16776961);
	TextDrawSetOutline(Death[2], 0);
	TextDrawSetProportional(Death[2], 1);
	TextDrawSetShadow(Death[2], 0);
	TextDrawSetSelectable(Death[2], 0);
	
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
    
    ConnectNPC("Bus[65][0]", "Gunthers");
    ConnectNPC("Bus[52][0]", "Guntherss");
    ConnectNPC("Bus[07][0]", "SAP07");
    ConnectNPC("Bus[30][0]", "SAP30");
    ConnectNPC("Bus[40][0]", "SAP40");
    ConnectNPC("Bus[57][0]", "SAP57");
    ConnectNPC("Bus[18][0]", "SAP18");
    ConnectNPC("Ship[01]", "[LV]Ship[01]");
    ConnectNPC("Ship[02]", "[LV]Ship[02]");

	SetTimer("ConnectSecondNPCs", 60*1000, false);

	IRC_Init();
	
	ShipRails[0] = CreateObject(3524, 2023.45972, 1541.43933, 11.38302,   3.14159, 0.00000, 1.57080);
	ShipRails[1] = CreateObject(3524, 2023.51624, 1547.25098, 12.36296,   3.14159, 0.00000, 1.57080);
	ShipRails[2] = CreateObject(3524, 2023.49573, 1548.34265, 11.56833,   3.14159, 0.00000, 1.57080);
	ShipRails[3] = CreateObject(3524, 2023.53564, 1542.54260, 12.26828,   3.14159, 0.00000, 1.57080);
	ShipRails[4] = CreateObject(3524, 2023.53918, 1544.79309, 12.68826,   3.14159, 0.00000, 1.57080);
	ShipRails[5] = CreateObject(3524, 2023.42017, 1540.56287, 10.42307,   3.14159, 0.00000, 1.57080);
	ShipRails[6] = CreateObject(3524, 2023.48474, 1549.26758, 10.33944,   3.14159, 0.00000, 1.57080);
	ShipRails[7] = CreateObject(3524, 2023.55640, 1543.60962, 12.68826,   3.14159, 0.00000, 1.57080);
	ShipRails[8] = CreateObject(3524, 2023.50391, 1546.05151, 12.68826,   3.14159, 0.00000, 1.57080);
	CreateObject(3498, 2023.49695, 1550.67798, 7.60156,   356.85840, 0.00000, 3.14159);
	CreateObject(3498, 2023.47888, 1550.05127, 7.60156,   356.85840, 0.00000, 3.14159);
	CreateObject(11480, 2018.85010, 1533.96082, 11.90202,   0.00000, 0.00000, -85.00000);
	CreateObject(11313, 2015.78540, 1533.74109, 10.25980,   0.00000, 0.00000, 4.62000);
	XeonGarage = CreateObject(11313, 2021.93188, 1534.29663, 10.12620, -0.08000, -0.02000, 4.96000); // Open 2021.93188, 1534.29663, 7.82620, -0.08000, -0.02000, 4.96000

	CreateObject(3031, 2003.34277, 1545.09900, 14.09494,   0.00000, 0.00000, 0.00000);
	CreateObject(2103, 2003.82617, 1545.35437, 12.59410,   0.06000, 0.06000, 92.04010);
	
	CreateActor(227, 2028.5239, 1540.0095, 10.8203, 272.5999);
	CreateActor(228, 2030.4471, 1550.7480, 10.8203, 268.2366);
	CreateActor(208, 2015.8784, 1549.6310, 10.8392, 181.1758);
	CreateActor(165, 2015.4298, 1540.9355, 10.8412, 1.6575);
	CreateActor(164, 2006.1057, 1540.6879, 13.4395, 290.0718);
	CreateActor(163, 2005.5284, 1548.9258, 13.5550, 253.0747);
	CreateActor(294, 2000.5347, 1569.3536, 15.3672, 184.9124);
	CreateActor(228, 2000.9805, 1518.7699, 17.0625, 359.440);

	Create3DTextLabel("{FF0000}SFServer Live Radio\nPowered by: InternetRadio.com", -1, 2003.82617, 1545.35437, 12.59410, 5.0, 0); 

	XeonVeh[0] = CreateVehicle(411, 2018.6184, 1531.8802, 10.4505, 277.1270, 166, 166, 60, 0); // xeoninf
	new Text3D: tmp =Create3DTextLabel("{FF0000}XeonTM's Vehicle\nSuper, Infernus", -1, 2003.82617, 1545.35437, 12.59410, 5.0, 0);
	Attach3DTextLabelToVehicle(tmp, XeonVeh[0], 0, 0, 0);

	XeonVeh[1] = CreateVehicle(451, 2018.7941, 1536.1827, 10.4271, 275.8228, 166, 166, 60, 0); // turinf
	tmp = Create3DTextLabel("{FF0000}XeonTM's Vehicle\nSuper, Turismo", -1, 2003.82617, 1545.35437, 12.59410, 5.0, 0);
	Attach3DTextLabelToVehicle(tmp, XeonVeh[1], 0, 0, 0);

	GuardVeh[0] = CreateVehicle(560, 2019.4111, 1527.9119, 10.4288, 270.8874, 0, 0, 60, 1); 
	GuardVeh[1] = CreateVehicle(560, 2028.6774, 1552.8107, 10.4964, 259.7928, 0, 0, 60, 1); 
	GuardVeh[2] = CreateVehicle(560, 2028.1538, 1532.2986, 10.4506, 317.4567, 0, 0, 60, 1); 

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