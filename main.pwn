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
    ScriptFile    : main.pwn
    Author        : XeonMaster
    Version       : 1.0
    License       : GNU General v3.0
    Developers    : None
*/


// Server 
#include "Server/Includes.pwn"
#include "Server/GlobalVars.pwn"
#include "Server/Gamemode.pwn"
#include "Server/Dialogs.pwn"
#include "Server/IRC.pwn"
#include "Server/Discord.pwn"
#include "Server/MySQL.pwn"

// Player
#include "Player/Connections.pwn"
#include "Player/ClassRequest.pwn"
#include "Player/Spawn.pwn"
#include "Player/ChatHandler.pwn"
#include "Player/VehicleHandler.pwn"
#include "Player/Commands.pwn"