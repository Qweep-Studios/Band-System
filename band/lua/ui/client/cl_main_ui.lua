local f1 = Color(40, 40, 45, 232)
local f2 = Color(30, 30, 35)
local f3 = Color(41, 41, 53)
local f4 = Color(55, 55, 63)
local cb1 = Color(255, 255, 255)
local cb2 = Color(185, 185, 185)
local color_panelplayer = Color(46, 46, 46)
local color_panelHOVplayer = Color(54, 54, 54)

local members = "0" -- Дефолтное количество

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
        net.Start("BandTitle")
        net.SendToServer()

        net.Receive("BandTitle", function()
            text = net.ReadString()
            rank = net.ReadString()
        end)

        local progress = (CurTime() - startTime) / animDuration
        progress = math.Clamp(progress, 0, 1)
        self:SetAlpha(Lerp(progress, 0, 255))

        draw.RoundedBox(8, 0, 0, w, h, f1)
        draw.RoundedBoxEx(8, 0, 0, w, 40, f2, true, true, false, false)

        draw.SimpleText(text, "ui.font0", w * 0.5, 10, cb1, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
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
        mframe:Remove()
        gframe:Remove()
        sframe:Remove()
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
        gframe:SetVisible(true)
        sframe:SetVisible(false)
        mframe:SetVisible(false)
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
        gframe:SetVisible(false)
        sframe:SetVisible(false)
        mframe:SetVisible(true)
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
        gframe:SetVisible(false)
        sframe:SetVisible(true)
        mframe:SetVisible(false)
    end
end

net.Receive("BandMembers", function()
    members = net.ReadString() or "0"
end)

function general_menu()
    gframe = vgui.Create("DPanel", frame)
    gframe:SetSize(scrw*0.59, scrh*0.59)
    gframe:SetPos(scrw*0.205, scrh*0.255)
    gframe:MakePopup()
    gframe:SetDrawOnTop(true)
    gframe.Paint = function(self, w, h)
        draw.RoundedBox(8, 0, 0, w, h, f2)
    end
    local member_panel = vgui.Create('DPanel', gframe)
    member_panel:SetSize(scrw*0.13, scrh*0.10)
    member_panel:SetPos(scrw*0.030, scrh*0.050)
    member_panel.Paint = function(self, w, h)

        draw.RoundedBox(8, 0, 0, w, h, f4)
        draw.SimpleText('Участников', 'ui.font2', w * 0.5, 40, cb1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        draw.SimpleText(members .. '/30', 'ui.font0', w * 0.5, 70, cb1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

        net.Start("BandMembers")
        net.SendToServer()

    end
    local online_panel = vgui.Create('DPanel', gframe)
    online_panel:SetSize(scrw*0.13, scrh*0.10)
    online_panel:SetPos(scrw*0.170, scrh*0.050)
    online_panel.Paint = function(self, w, h)
        draw.RoundedBox(8, 0, 0, w, h, f4)
        draw.SimpleText('Онлайн', 'ui.font2', w * 0.5, 40, cb1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        draw.SimpleText('1', 'ui.font0', w * 0.5, 70, cb1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
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

    local sp = vgui.Create('DScrollPanel', mframe)
    sp:Dock(FILL)

    for i, ply in ipairs(player.GetAll()) do
        local player_panel = vgui.Create('DButton', sp)
        player_panel:SetSize(scrw*0.13, scrh*0.10)
        player_panel:SetPos(scrw*0.030, scrh*0.050)
        player_panel:SetText("")
        player_panel:Dock(TOP)
        player_panel:SetTall(42)
        player_panel:DockMargin(15, 6, 15, 3)
        player_panel.Paint = function(_, w, h)
            local name = ply:Name()

            draw.RoundedBox(4, 0, 0, w, h, f1)
            local gradient = Material("gui/center_gradient")
            surface.SetMaterial(gradient)
            surface.SetDrawColor(27, 27, 27, 200)
            surface.DrawTexturedRect(0, 0, w, h)
            
            if player_panel:IsHovered() then
                draw.RoundedBox(4, 0, 0, w, h, color_panelHOVplayer)
                surface.SetMaterial(gradient)
                surface.SetDrawColor(49, 49, 49, 220)
                surface.DrawTexturedRect(0, 0, w, h)
            end

            draw.SimpleText(name, "ui.font0", w * 0.5, h * 0.5, cb1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
    end
    --- Переделай, ты лютую хуйню там написал
    --- А лучше дождись пока я проснусь
    --- p.s проблема с градиентом была, и код в общеем не правильный

    -- я просто взял с моего прошлого кода эту хуйню
end

--[[
function scroll()
    local scroll = vgui.Create("DScrollPanel", mframe)
    scroll:Dock(FILL)
    scroll:DockMargin(10, 0, 10, 10)
    scroll:GetVBar():SetWide(8)
    scroll:GetVBar():SetHideButtons(true)
    scroll:GetVBar().Paint = function(_, w, h)
        draw.RoundedBox(4, 0, 0, w, h, Color(30, 45, 60, 150))
    end
    scroll:GetVBar().btnGrip.Paint = function(_, w, h)
        draw.RoundedBox(4, 0, 0, w, h, Color(80, 120, 160))
    end

    for i, ply in ipairs(player.GetAll()) do
        local playerPanel = vgui.Create("DButton", scroll)
        playerPanel:Dock(TOP)
        playerPanel:SetTall(42)
        playerPanel:DockMargin(0, 0, 0, 3)
        playerPanel:SetText("")
        playerPanel:SetAlpha(0)

        playerPanel:AlphaTo(255, 0.2, 0.05 * i)
        playerPanel:SetPos(playerPanel:GetPos())
        local x, y = playerPanel:GetPos()
        playerPanel:SetPos(x, y + 10)
        local x, y = playerPanel:GetPos()
        playerPanel:MoveTo(x, y - 10, 0.2)
        
        playerPanel.Paint = function(_, w, h)
            draw.RoundedBox(4, 0, 0, w, h, color_panelplayer)
            local gradient = Material("gui/center_gradient")
            surface.SetMaterial(gradient)
            surface.SetDrawColor(15, 25, 40, 200)
            surface.DrawTexturedRect(0, 0, w, h)
            
            if playerPanel:IsHovered() then
                draw.RoundedBox(4, 0, 0, w, h, color_panelHOVplayer)
                surface.SetMaterial(gradient)
                surface.SetDrawColor(20, 35, 55, 220)
                surface.DrawTexturedRect(0, 0, w, h)
            end
        end
    end
end
]]--
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