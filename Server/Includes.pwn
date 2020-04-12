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
    ScriptFile    : Includes.pwn
    Author        : XeonMaster
    Version       : 1.0
    License       : GNU General v3.0
    Developers    : None
*/

#include <a_samp> 
#include <foreach>

#if defined MAX_PLAYERS
    #undef MAX_PLAYERS
    #define MAX_PLAYERS 50
#endif
        
#include <a_mysql>
#include <irc>
#include <izcmd>
#include <sscanf2>
#include <GeoIP>
#include <mapandreas>
#include <timestamp>
#include <DialogStyles>