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

    function general_menu()
        gframe = vgui.Create("DPanel", frame)
        gframe:SetSize(scrw*0.59, scrh*0.59)
        gframe:SetPos(scrw*0.205, scrh*0.255)
        gframe:MakePopup()
        gframe:SetDrawOnTop(true)
        gframe.Paint = function(self, w, h)
            draw.RoundedBox(8, 0, 0, w, h, f2)
        end
    end

    function members_menu()
        mframe = vgui.Create("DPanel", frame)
        mframe:SetSize(scrw*0.59, scrh*0.59)
        mframe:SetPos(scrw*0.205, scrh*0.255)
        mframe:MakePopup()
        mframe:SetDrawOnTop(true)
        mframe.Paint = function(self, w, h)
            draw.RoundedBox(8, 0, 0, w, h, f2)
        end
    end

    function settings_menu()
        sframe = vgui.Create("DPanel", frame)
        sframe:SetSize(scrw*0.59, scrh*0.59)
        sframe:SetPos(scrw*0.205, scrh*0.255)
        sframe:MakePopup()
        sframe:SetDrawOnTop(true)
        sframe.Paint = function(self, w, h)
            draw.RoundedBox(8, 0, 0, w, h, f2)
        end
    end

    general_menu()
    members_menu()
    settings_menu()
    gframe:SetVisible(true)
    mframe:SetVisible(false)
    sframe:SetVisible(false)

    local closebtn = vgui.Create('DButton', frame)
    closebtn:SetSize(scrw*0.020, scrh*0.020)
    closebtn:SetText("")
    closebtn:SetPos(frame:GetWide() - 30, 10)
    closebtn.DoClick = function()
        frame:Close()
        gframe:Remove()
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
        if (gframe:IsVisible() == true) then
            return
        end
        if (gframe:IsVisible() == false) then
            gframe:SetVisible(true)
        end
        if (mframe:IsVisible() == true) then
            mframe:SetVisible(false)
        end
        if (sframe:IsVisible() == true) then
            sframe:SetVisible(false)
        end
    end

    playerlist = vgui.Create("DButton", uppanel)
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
        if (mframe:IsVisible() == true) then
            return
        end
        if (mframe:IsVisible() == false) then
            mframe:SetVisible(true)
        end
        if (gframe:IsVisible() == true) then
            mframe:SetVisible(false)
        end
        if (sframe:IsVisible() == true) then
            sframe:SetVisible(false)
        end
    end

    settings = vgui.Create("DButton", uppanel)
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
        if (sframe:IsVisible() == true) then
            return
        end
        if (sframe:IsVisible() == false) then
            sframe:SetVisible(true)
        end
        if (mframe:IsVisible() == true) then
            mframe:SetVisible(false)
        end
        if (gframe:IsVisible() == true) then
            gframe:SetVisible(false)
        end
    end
end

concommand.Add('mainmenu', mainmenu)