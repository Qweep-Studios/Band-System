local f1 = Color(40, 40, 45, 232)
local f2 = Color(30, 30, 35)
local f3 = Color(41, 41, 53)
local f4 = Color(55, 55, 63)
local cb1 = Color(255, 255, 255)
local cb2 = Color(185, 185, 185)
local color_panelplayer = Color(46, 46, 46)
local color_panelHOVplayer = Color(54, 54, 54)
local color_green = Color(0, 255, 0)
local color_red = Color(255, 0, 0)
local color_bred = Color(150, 50, 50)
local color_bgreen = Color(50, 150, 50)
local up = Material("materials/up1.png")
local down = Material("materials/down1.png")

local members = "0" -- Дефолтное количество

local close = Material("materials/close.png")

function mainmenu()
    local frame = vgui.Create("DFrame")
    frame:SetSize(scrw*0.6, scrh*0.7)
    frame:SetTitle('')
    frame:Center()
    --frame:MakePopup()
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
    mframe.Paint = function(self, w, h)
        draw.RoundedBox(8, 0, 0, w, h, f2)
    end

    sp = vgui.Create('DScrollPanel', mframe)
    sp:Dock(FILL)
    sp:GetVBar():SetWide(0) -- убирает линию и кнопки sp

    net.Start("Members")
    net.SendToServer()

    net.Receive("Members", function()
        allmembers = net.ReadTable() -- Получение всех участников банды
        allranks = net.ReadTable()
        ranks = {}

        for i, rank_second in ipairs(allranks) do
            table.insert(ranks, rank_second.rank)
        end
        allmem = {}
        for i, ply in ipairs(allmembers) do
            steamworks.RequestPlayerInfo(ply.steamid64, function(name)
                table.insert(allmem, name)
            end)
        end
        --PrintTable(allmem) -- debug
        scroll()
    end)
end

function scroll()
    for i, ply in ipairs(allmem) do
        local player_panel = vgui.Create('DPanel', sp) --- Поменял на dlabel
        player_panel:SetSize(scrw*0.13, scrh*0.10)
        player_panel:SetPos(scrw*0.030, scrh*0.050)
        player_panel:SetText("")
        player_panel:Dock(TOP)
        player_panel:SetTall(42)
        player_panel:DockMargin(15, 6, 15, 3)

        local up_button = vgui.Create("DButton", player_panel)
        up_button:SetPos(player_panel:GetWide() * 3.5, (player_panel:GetTall() - 32) * 0.5)
        up_button:SetSize(32, 32)
        up_button:SetText("")

        local down_button = vgui.Create("DButton", player_panel)
        down_button:SetPos(player_panel:GetWide() * 3.65, (player_panel:GetTall() - 32) * 0.5)
        down_button:SetSize(32, 32)
        down_button:SetText("")

        player_panel.Paint = function(_, w, h)

            draw.RoundedBox(4, 0, 0, w, h, f1)
            local gradient = Material("gui/center_gradient")
            surface.SetMaterial(gradient)
            surface.SetDrawColor(27, 27, 27, 200)
            surface.DrawTexturedRect(0, 0, w, h)
            target_rank = ranks[i]
            draw.SimpleText(ply, "ui.font0", w * 0.06, h * 0.5, cb1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            draw.SimpleText(target_rank, "ui.font0", w * 0.5, h * 0.5, cb1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER) --- Поменять rank на другое
        end

        up_button.Paint = function(_, w, h)
            surface.SetDrawColor(up_button:IsHovered() and color_green or color_bgreen) --- проверь как выглядят
            surface.SetMaterial(up)
            surface.DrawTexturedRect(0, 0, w, h)
        end
        down_button.Paint = function(_, w, h)
            surface.SetDrawColor(down_button:IsHovered() and color_red or color_bred)
            surface.SetMaterial(down)
            surface.DrawTexturedRect(0, 0, w, h)
        end

        up_button.DoClick = function() -- Можно было сделать умнее, но мне было лень
            net.Start("CheckRank")
            net.SendToServer()
            net.Receive("CheckRank", function()
               local pl_rank = net.ReadString()
            end)
            if pl_rank == "Участник" then
                LocalPlayer():ChatPrint("Недостаточно прав!")
                return 
            end
            if target_rank == "Глава" then
                return 
            end

            if pl_rank == "Глава" then --- тут какой-то ебаный баг, надо найти в чем проблема
                if target_rank == "Заместитель" then
                    LocalPlayer():ChatPrint("Максимальный ранг!")
                end
                if target_rank == "Модератор" then
                    local targetid = allmembers[i].steamid64
                    sql.Query("UPDATE bands_members SET rank = " .. sql.SQLStr("Заместитель") .. " WHERE steamid64 = " .. sql.SQLStr(targetid))
                    LocalPlayer():ChatPrint("Игрок успешно повышен до заместителя!")
                end
            end
        end

        down_button.DoClick = function()
            --
        end
    end
end

function settings_menu()
    sframe = vgui.Create("DPanel", frame)
    sframe:SetSize(scrw*0.59, scrh*0.59)
    sframe:SetPos(scrw*0.205, scrh*0.255)
    sframe:MakePopup()
    sframe.Paint = function(self, w, h)
        draw.RoundedBox(8, 0, 0, w, h, f2)
    end
end