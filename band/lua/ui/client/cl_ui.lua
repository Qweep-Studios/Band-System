scrh = ScrH()
scrw = ScrW()
function band_ui()
    local frame = vgui.Create("DPanel")
    frame:SetSize(scrw*0.5, scrh*0.5)
    frame:Center()
    frame:MakePopup()
    timer.Create("test", 3, 1, function() frame:Remove() end)
end