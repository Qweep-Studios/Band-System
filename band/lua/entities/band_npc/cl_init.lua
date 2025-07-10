include("shared.lua")
include("ui/client/cl_ui.lua")

function ENT:Draw()
    self:DrawModel()
end

net.Receive("Bandnpc", function()
    local ply = net.ReadPlayer()
    if timer.Exists("Cdnpc") then
        ply:ChatPrint("Подождите...")
        return
    end
    buy_band_ui() --- функция из ui/client/cl_ui.lua
    timer.Create("Cdnpc", 1, 1, function() end)
end)