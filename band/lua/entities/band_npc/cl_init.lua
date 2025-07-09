include("shared.lua")

function ENT:Draw()
    self:DrawModel()
end

net.Receive("Bandnpc", function()
    local ply = net.ReadPlayer()
    if timer.Exists("Cdnpc") then
        ply:ChatPrint("Подождите...")
        return
    end
    ply:ChatPrint("Вас зовут: " .. ply:Nick())  --- Сюда менюшку надо будет добавить
    timer.Create("Cdnpc", 5, 1, function() end)
end)