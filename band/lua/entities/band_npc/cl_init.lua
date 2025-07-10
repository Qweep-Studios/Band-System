include("shared.lua")
include("ui/client/cl_ui.lua")
include("ui/client/cl_main_ui.lua")
include("ui/vgui/font.lua")

function ENT:Draw()
    self:DrawModel()

    if self:GetPos():Distance(LocalPlayer():GetPos()) < 1000 then
        local Ang = LocalPlayer():GetAngles()
        Ang:RotateAroundAxis(Ang:Forward(), 90)
        Ang:RotateAroundAxis(Ang:Right(), 90)
    
        cam.Start3D2D(self:GetPos() + self:GetUp() * 80, Ang, 0.05)
            
            draw.SimpleText('Бандит', "visor.font0", 0, 0, Color(173, 178, 180, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
            draw.SimpleText('Бандит', "visor.font1", 0, 0, Color(160, 160, 160, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
            draw.SimpleText('Бандит', "visor.font2", 0, 0, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)

        cam.End3D2D()
    end
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

