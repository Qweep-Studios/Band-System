
local f1 = Color(40, 40, 45, 232)
local f2 = Color(30, 30, 35)
local f3 = Color(41, 41, 53)
local f4 = Color(55, 55, 63)
local cb1 = Color(255, 255, 255)
local cb2 = Color(185, 185, 185)

local close = Material("materials/close.png")

function mainmenu()
    local frame = vgui.Create("DFrame")
    frame:SetSize(scrw*0.6, scrh*0.7)
    frame:SetTitle('')
    frame:Center()
    frame:MakePopup()
    frame:ShowCloseButton(false)
    frame:SetDraggable(false)
    frame:SetAlpha(0)

    local startTime = CurTime()
    local animDuration = 0.2

    frame.Paint = function(self, w, h)
        local text = "Неизвестно"

        local progress = (CurTime() - startTime) / animDuration
        progress = math.Clamp(progress, 0, 1)
        self:SetAlpha(Lerp(progress, 0, 255))

        draw.RoundedBox(8, 0, 0, w, h, f1)
        draw.RoundedBoxEx(8, 0, 0, w, 40, f2, true, true, false, false)

        draw.SimpleText(text, "ui.font0", w * 0.5, 10, cb1, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
    end

    local closebtn = vgui.Create('DButton', frame)
    closebtn:SetSize(scrw*0.020, scrh*0.020)
    closebtn:SetText("")
    closebtn:SetPos(frame:GetWide() - 30, 10)
    closebtn.DoClick = function()
        frame:Close()
    end
    closebtn.Paint = function(self, w, h)
        surface.SetMaterial(close)
        surface.SetDrawColor(self:IsHovered() and cb2 or cb1)
        surface.DrawTexturedRect(0, 0, 20, 20)
    end

    local uppanel = vgui.Create('DPanel', frame)
    uppanel:SetSize(scrw*0.58, scrh*0.05)
    uppanel:Center()
    uppanel:SetPos(uppanel:GetX(), uppanel:GetY() - 300)
    uppanel.Paint = function(self, w, h)
        draw.RoundedBox(10, 0, 0, w, h, f2)
    end

    local general = vgui.Create("DButton", uppanel)
    general:SetSize(scrw*0.08, scrh*0.04)
    general:SetText("")
    general:SetPos(frame:GetWide() - 1140, 5)
    general.Paint = function(self, w, h)
        local gradient = Material("gui/center_gradient")

        draw.RoundedBox(8, 0, 0, w, h, self:IsHovered() and f3 or f1)
        surface.SetMaterial(gradient)
        surface.SetDrawColor(f4)
        surface.DrawTexturedRect(0, 0, w, h)
        draw.SimpleText('Основное', "ui.font0", w * 0.5, h * 0.5, cb1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    general.DoClick = function()
        general_menu()
    end

    local playerlist = vgui.Create("DButton", uppanel)
    playerlist:SetSize(scrw*0.08, scrh*0.04)
    playerlist:SetText("")
    playerlist:SetPos(frame:GetWide() - 970, 5)
    playerlist.Paint = function(self, w, h)
        local gradient = Material("gui/center_gradient")

        draw.RoundedBox(8, 0, 0, w, h, self:IsHovered() and f3 or f1)
        surface.SetMaterial(gradient)
        surface.SetDrawColor(f4)
        surface.DrawTexturedRect(0, 0, w, h)
        draw.SimpleText('Участники', "ui.font0", w * 0.5, h * 0.5, cb1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    playerlist.DoClick = function()
        -- пока нечего
    end

    local settings = vgui.Create("DButton", uppanel)
    settings:SetSize(scrw*0.08, scrh*0.04)
    settings:SetText("")
    settings:SetPos(frame:GetWide() - 800, 5)
    settings.Paint = function(self, w, h)
        local gradient = Material("gui/center_gradient")

        draw.RoundedBox(8, 0, 0, w, h, self:IsHovered() and f3 or f1)
        surface.SetMaterial(gradient)
        surface.SetDrawColor(f4)
        surface.DrawTexturedRect(0, 0, w, h)
        draw.SimpleText('Настройки', "ui.font0", w * 0.5, h * 0.5, cb1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    settings.DoClick = function()
        -- пока нечего
    end

end

function general_menu()
    local gframe = vgui.Create("DFrame")
    gframe:SetSize(scrw*0.5, scrh*0.5)
    gframe:CenterHorizontal()
    gframe:CenterVertical()
    gframe:MakePopup()
end

concommand.Add('mainmenu', mainmenu)