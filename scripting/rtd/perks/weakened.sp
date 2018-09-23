/**
* Weakened perk.
* Copyright (C) 2018 Filip Tomaszewski
*
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/


float g_fWeakenedMultiplayer = 2.5;

void Weakened_Perk(int client, const char[] sPref, bool apply){

	if(apply)
		Weakened_ApplyPerk(client, StringToFloat(sPref));
	
	else
		SDKUnhook(client, SDKHook_OnTakeDamage, Weakened_OnTakeDamage);

}

void Weakened_ApplyPerk(int client, float fMultiplayer){

	g_fWeakenedMultiplayer = fMultiplayer;
	SDKHook(client, SDKHook_OnTakeDamage, Weakened_OnTakeDamage);

}

public Action Weakened_OnTakeDamage(int iVic, int &iAttacker, int &iInflictor, float &fDamage, int &iDamageType){//, int &weapon, float damageForce[3], float damagePosition[3]){

	if(iVic == iAttacker)	
		return Plugin_Continue;
	
	fDamage *= g_fWeakenedMultiplayer;
	
	return Plugin_Changed;

}
