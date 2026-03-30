stock ShowStats(playerid,targetid)
{
	if(IsPlayerConnected(targetid))
	{
		new resultline[2048], header[64], vipdate[128], org[128], iGroupID, employer[GROUP_MAX_NAME_LEN], rank[GROUP_MAX_RANK_LEN], division[GROUP_MAX_DIV_LEN];
		new sext[16], leader[24], nation[24], viplvl[24], adminlvl[24], helperlvl[24], conslvl[24], pnumber[20];
		new nxtlevel = PlayerInfo[targetid][pLevel]+1, giochoilevel = nxtlevel*nxtlevel+2;
		new datestring[32], doanhnghiep[32];

		datestring = date(PlayerInfo[targetid][pVIPTime], 4);
		if(PlayerInfo[targetid][pVIP] >= 1)
		{
			format(vipdate, sizeof(vipdate), "Thoi han: %s", datestring);
		}
		else format(vipdate, sizeof(vipdate), "Thoi han: Khong ton tai");

		if(PlayerInfo[targetid][pPnumber] == 0) pnumber = "None"; else format(pnumber, sizeof(pnumber), "%d", PlayerInfo[targetid][pPnumber]);
		if(PlayerInfo[targetid][pSex] == 1) { sext = "Nam"; } else { sext = "Nu"; }
		if(PlayerInfo[targetid][pLeader] == iGroupID) { leader = "Enable"; } else { leader = "Disable"; }

		if(PlayerInfo[targetid][pMember] != INVALID_GROUP_ID)
		{
			GetPlayerGroupInfo(targetid, rank, division, employer);
			format(org, sizeof(org), "|  Faction: %s  |  Rank:  %s  |  Division:  %s (%d)", employer,PlayerInfo[targetid][pFRankName], division, PlayerInfo[targetid][pDivision]);
		}
		else if(PlayerInfo[targetid][pFMember] < INVALID_FAMILY_ID)
		{
			if(0 <= PlayerInfo[targetid][pDivision] < 5) format(division, sizeof(division), "%s", FamilyDivisionInfo[PlayerInfo[targetid][pFMember]][PlayerInfo[targetid][pDivision]]);
			else division = "Khong ro";
			format(org, sizeof(org), "|  Group: %s  |  Rank:  %s (%d)  |  Division:  %s (%d)",FamilyInfo[PlayerInfo[targetid][pFMember]][FamilyName], FamilyRankInfo[PlayerInfo[targetid][pFMember]][PlayerInfo[targetid][pRank]], PlayerInfo[targetid][pRank], division, PlayerInfo[targetid][pDivision]);
		}
		else format(org, sizeof(org), "|  Rank:  Khong ro (-1)  |  Division:  Khong ro (-1)");

		new leveljob1, leveljob2, leveljob3, leveljob4;
		leveljob1 = PlayerInfo[targetid][pLevelJob][0]*100;
		leveljob2 = PlayerInfo[targetid][pLevelJob][1]*200;
		leveljob3 = PlayerInfo[targetid][pLevelJob][2]*100;
		leveljob4 = PlayerInfo[targetid][pLevelJob][3]*100;
		switch(PlayerInfo[targetid][pQuocGia])
		{
			case 1: nation = "Los Santos";
			case 2: nation = "San Fierro";
		}
		switch(PlayerInfo[targetid][pVIP])
		{
			case 0: viplvl = "Khong co";
			case 1: viplvl = "Silver Card";
			case 2: viplvl = "Golden Card";
		}
		if(PlayerInfo[playerid][pBiz][0] > 0)
		{
			doanhnghiep = "Pizza Stacks";
		}
		else if(PlayerInfo[playerid][pBiz][1] > 0)
		{
			doanhnghiep = "Bar Pigpen";
		}
		else if(PlayerInfo[playerid][pBiz][2] > 0)
		{
			doanhnghiep = "24/7 Idllewood";
		}
		else if(PlayerInfo[playerid][pBiz][3] > 0)
		{
			doanhnghiep = "Car Dealership";
		}
		else if(PlayerInfo[playerid][pBiz][4] > 0)
		{
			doanhnghiep = "Binco & Pizza";
		}
		else if(PlayerInfo[playerid][pMechanic] == 1){
			doanhnghiep = "Garage Mechanic";
		}
		else doanhnghiep = "Khong co";
		switch(PlayerInfo[targetid][pAdmin])
		{
			case 0: adminlvl = "Khong co";
			case 1: adminlvl = "Level 1";
			case 2: adminlvl = "Level 2";
			case 3: adminlvl = "Level 3";
			case 4: adminlvl = "Level 4";
			case 1337: adminlvl = "Level 5";
			case 1338: adminlvl = "Level 6";
			case 99999: adminlvl = "Level 7";
		}
		switch(PlayerInfo[targetid][pHelper])
		{
			case 0: conslvl = "Khong co";
			case 1: conslvl = "Level 1";
		}
		switch(PlayerInfo[targetid][pHelperRank])
		{
			case 0: helperlvl = "Khong co";
			case 1: helperlvl = "Level 1";
			case 2: helperlvl = "Level 2";
		}
		//new exp = ((50 * (PlayerInfo[targetid][pLevel]) * (PlayerInfo[targetid][pLevel]) * (PlayerInfo[targetid][pLevel]) - 150 * (PlayerInfo[targetid][pLevel]) * (PlayerInfo[targetid][pLevel]) + 600 * (PlayerInfo[targetid][pLevel])) / 5) - PlayerInfo[playerid][pXP];
		new Float:health;
		health = PlayerInfo[targetid][pMau];
		new zone[MAX_ZONE_NAME];
		GetPlayer3DZone(targetid, zone, sizeof(zone));
		SetPVarInt(playerid, "ShowStats", targetid);
		format(resultline, sizeof(resultline),"\
		\\cCharacter Name:  %s  |  Level:  %d  |  Da online:  %d gio |  Len cap: %d/%d  |  Gioi tinh:  %s  |  Do tuoi:  %d\n\
		\\cQuoc tich:  %s  |  Admin Rank:  %s  |  Consultant:  %s  |  Helper:  %s  |  C-HP:  %.1f  |  C-AR: 0\n\
		\\cS-Coin:  %s  |  VIP:  %s (%s)  |  Voucher Toys:  %s  |  Voucher Name:  %s\n\
		\n\
		\\cCurrent Job:  %s  |  CEO Business:  %s  |  Leader Power:  %s   %s\n\
		\n\
		\\c\t------------------- Money Resources -------------------\n\
		\\cTien tren nguoi:  $%s  |  Bank: $%s  |  So tiet kiem:  $%s (Interest rate: 0,2 phan tram)\n\
		\n\
		\\cSo dien thoai:  %s  |  Radio Channel:  %dhz  |  GPS:  %dc |  Boombox:  %dc  |  Rimkit:  %dc\n\
		\\cWeed:  %dg  |  Weed Seeds:  %d  |  Cocaine:  %dg  |  LSD:  %d tem  |  Heroin:  %d | Ecstasy: %d \n\
		\n\
		\\c\t-------------------- Job Statistics --------------------\n\
		\\cDelivery  [Level: %d (%d/%d)]  |  Lumberjack  [Level: %d (%d/%d)]  |  San nai  [Level %d (%d/%d)]  |  Khai thac  [Level %d (%d/%d)] \n\
		\n\
		\\c\t\t\t\t------------------ Item Resources ------------------\n\
		\\cCopper Ore: %d (g)  |  Thach Anh: %d (g)  |  Iron Ore: %d (g)  |  Gold Ore: %d (g)  |  Thuoc sung: %d (g)  |  Go: %d (kg) | Cocaine Powder: %d\n\
		\\c\t\t\t\tTeaspoon: %d | Measuring Cup: %d | Baking Soda: %d | Lua mi: %d (g) | Thit: %d (g) | Token: %d\n\
		\\c----------------------------------------------------------------------------------------------------------------------------------------------------",

		// STATS
	  //Line 1
	    GetPlayerNameEx(targetid), // Character Name
		PlayerInfo[targetid][pLevel], // Cap do
		PlayerInfo[targetid][pConnectHours], // Da online
		PlayerInfo[targetid][pConnectHours], giochoilevel, // Len cap
		sext, // Gioi tinh
		PlayerInfo[targetid][pDoTuoi], // Do tuoi
		nation, // Quoc tich
	  //Line 2
		adminlvl, // Admin Level
		conslvl, // Consultant Level
		helperlvl, // Helper Level
		health, // C-HP // C-AR
	  //Line 3
		number_format(PlayerInfo[targetid][pCredits]), // S-Coin
		viplvl,
		vipdate, // VIP Level
		number_format(PlayerInfo[targetid][pVIPToysLimit]),
		number_format(PlayerInfo[targetid][pVIPNameLimit]),
	  //Line 4
		GetJobName(PlayerInfo[targetid][pJob]), // Characater Role
		doanhnghiep, // CEO Business
		leader, // Leader Power
		//employer, // Faction:
		org,
	// INVENTORY
	  //Line 5	
		number_format(PlayerInfo[targetid][pSoTien]), // Tien tren nguoi
		number_format(PlayerInfo[targetid][pAccount]), // Bank
		number_format(PlayerInfo[targetid][pSaving]), // So tiet kiem
      //Line 6
		pnumber, // So dien thoai
		PlayerInfo[targetid][pRadioFreq], // Radio Channel
		PlayerInfo[targetid][pGPS], // GPS // Balo
		PlayerInfo[targetid][pBoombox], //
		PlayerInfo[targetid][pRimMod],
		PlayerInfo[targetid][pWeed],
        PlayerInfo[targetid][pHatWeed],
        PlayerInfo[targetid][pCocaine],
        PlayerInfo[targetid][pLSD],
        PlayerInfo[targetid][pHeroin],
        PlayerInfo[targetid][pEcstasy],
      //Line 7
		PlayerInfo[targetid][pLevelJob][0], PlayerInfo[targetid][pFarmJob][0],leveljob1,
		PlayerInfo[targetid][pLevelJob][1], PlayerInfo[targetid][pFarmJob][1],leveljob2,
		PlayerInfo[targetid][pLevelJob][2], PlayerInfo[targetid][pFarmJob][2],leveljob3,
		PlayerInfo[targetid][pLevelJob][3], PlayerInfo[targetid][pFarmJob][3],leveljob4,
	  //Line 8
		PlayerInfo[targetid][pKhaiThac][1], // Copper
		PlayerInfo[targetid][pKhaiThac][2], // Thach Anh
		PlayerInfo[targetid][pKhaiThac][3], // Iron
		PlayerInfo[targetid][pKhaiThac][4], // Vang
		PlayerInfo[targetid][pThuocSung],
		PlayerInfo[targetid][pGo],
		PlayerInfo[targetid][pDrug][0],
		PlayerInfo[targetid][pDrug][1],
		PlayerInfo[targetid][pDrug][2],
		PlayerInfo[targetid][pDrug][3],
		PlayerInfo[targetid][pLuaMi],
		PlayerInfo[targetid][pThit],
		PlayerInfo[targetid][pToken]);
		ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "Character Information | SAGMP.VN", resultline, "Dong lai", "");
	}
	return 1;
}