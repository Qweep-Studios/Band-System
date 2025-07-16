AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("ui/client/cl_ui.lua")
AddCSLuaFile("ui/client/cl_main_ui.lua")
AddCSLuaFile("ui/vgui/vgui.lua")
include("shared.lua")
util.AddNetworkString("Bandnpc")
util.AddNetworkString("mainBandnpc")

function ENT:Initialize()
    self:SetModel("models/Humans/Group01/male_02.mdl")
    self:SetHullType(HULL_HUMAN)
    self:SetHullSizeNormal()
    self:SetNPCState(NPC_STATE_SCRIPT)
    self:SetSolid(SOLID_BBOX)
    self:CapabilitiesAdd(CAP_ANIMATEDFACE, CAP_TURN_HEAD)
    self:SetUseType(SIMPLE_USE)
    self:DropToFloor()
end

function ENT:Use(ply)
    local steamid64 = ply:SteamID64()
    local steamlead = sql.Query("SELECT title FROM bands_bsystem WHERE steamid_leader = " .. sql.SQLStr(steamid64)) -- Сделай чтобы тут проверяло не по лидеру а по тому находиться ли он в банде вообще и в какой
    if steamlead then
        net.Start("mainBandnpc")
        net.WritePlayer(ply)
        net.Send(ply)
    end
    if !steamlead then
        net.Start("Bandnpc")
        net.WritePlayer(ply)
        net.Send(ply)
    end
end