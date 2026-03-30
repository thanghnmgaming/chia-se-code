// Một số hàm hay thiếu trong Gamemode
public OnPlayerExitedMenu(playerid)
{
    TogglePlayerControllable(playerid,1); // unfreeze the player when they exit a menu
    return 1;
}
public OnPlayerObjectMoved(playerid,objectid)
{
    return 1;
}
public OnPlayerRequestSpawn(playerid)
{
    return 1;
}
public OnPlayerSelectedMenuRow(playerid, row)
{
    return 1;
}
public OnPlayerEnterRaceCheckpoint(playerid)
{
    return 1;
}
public OnPlayerLeaveRaceCheckpoint(playerid)
{
    return 1;
}
public OnPlayerPickUpPickup(playerid, pickupid)
{
    return 1;
}
public OnRconCommand(cmd[])
{
    return 0;
}
public OnVehicleDamageStatusUpdate(vehicleid, playerid)
{
    return 1;
}
public OnVehicleStreamOut(vehicleid, forplayerid)
{
    return 1;
}
 
// Stock log sau khi chỉnh sửa
 
stock Log(sz_fileName[], sz_input[]) {
 
// Các bạn paste đè lên stock Log của các bạn nhé.
    new
        sz_logEntry[180],
        #if defined _LINUX
        File: logfile,
        #endif
        i_dateTime[2][3];
 
    gettime(i_dateTime[0][0], i_dateTime[0][1], i_dateTime[0][2]);
    getdate(i_dateTime[1][0], i_dateTime[1][1], i_dateTime[1][2]);
 
    format(sz_logEntry, sizeof(sz_logEntry), "[%i/%i/%i - %i:%02i:%02i] %s\r\n", i_dateTime[1][0], i_dateTime[1][1], i_dateTime[1][2], i_dateTime[0][0], i_dateTime[0][1], i_dateTime[0][2], sz_input);
    if(!fexist(sz_fileName)) logfile = fopen(sz_fileName, io_write);
    else logfile = fopen(sz_fileName, io_append);
    if(logfile)
    {
        fwrite(logfile, sz_logEntry);
        fclose(logfile);
    }
    return 1;
}