resource.AddSingleFile("materials/close.png")
include("ui/server/sv_ui.lua")
AddCSLuaFile('ui/vgui/font.lua')

hook.Add("Initialize", "Startserver", function()
    if !sql.TableExists("bands_bsystem") then
        sql.Query("CREATE TABLE bands_bsystem (title TEXT, steamid_leader TEXT, members INTEGER, rank_first TEXT, rank_second TEXT, rank_third TEXT)")
    end
    if !sql.TableExists("bands_members") then
        sql.Query("CREATE TABLE bands_members (steamid64 TEXT, title TEXT, rank TEXT)")
    end
end)