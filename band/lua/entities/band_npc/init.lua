AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("ui/client/cl_ui.lua")
include("shared.lua")
util.AddNetworkString("Bandnpc")

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
    net.Start("Bandnpc")
    net.WritePlayer(ply)
    net.Send(ply)
end