resource.AddSingleFile("materials/close.png")
resource.AddSingleFile("materials/down1.png")
resource.AddSingleFile("materials/up1.png")
resource.AddSingleFile("materials/uninvite.png")
resource.AddSingleFile("materials/bank.png")
include("ui/server/sv_ui.lua")
AddCSLuaFile('ui/vgui/font.lua')

hook.Add("Initialize", "Startserver", function()
    if !sql.TableExists("bands_bsystem") then
        sql.Query("CREATE TABLE bands_bsystem (title TEXT, steamid_leader TEXT, money TEXT, members INTEGER, rank_first TEXT, rank_second TEXT, rank_third TEXT)")
    end
    if !sql.TableExists("bands_members") then
        sql.Query("CREATE TABLE bands_members (steamid64 TEXT, title TEXT, rank TEXT)")
    end
end)