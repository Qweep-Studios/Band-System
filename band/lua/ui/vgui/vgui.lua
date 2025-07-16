surface.CreateFont('vgui.core.font0', {
    font = 'Overpass Bold',
    extended = true,
    size = 20
})

surface.CreateFont('vgui.core.font1', {
    font = 'Overpass Bold',
    extended = true,
    size = 25
})

qw = qw or {}
qw.ui = qw.ui or {}

function qw.ui.player_selector(title, on_select, filter_func)
    if IsValid(qw.ui.player_selector_frame) then
        qw.ui.player_selector_frame:Remove()
    end


    qw.ui.player_selector_frame = vgui.Create('DFrame')
    qw.ui.player_selector_frame:SetSize(300, 450)
    qw.ui.player_selector_frame:SetTitle("")
    qw.ui.player_selector_frame:Center()
    qw.ui.player_selector_frame:MakePopup()
    qw.ui.player_selector_frame:SetDraggable(false)
    qw.ui.player_selector_frame:ShowCloseButton(false)
    
    qw.ui.player_selector_frame.Paint = function(self, w, h)
        draw.RoundedBox(8, 0, 0, w, h, Color(40, 40, 45, 232))
        draw.RoundedBoxEx(8, 0, 0, w, 30, Color(30, 30, 35), true, true, false, false)
        draw.SimpleText(title or "Выберите игрока", "vgui.core.font0", 10, 15, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end


    local btn_close = vgui.Create("DButton", qw.ui.player_selector_frame)
    btn_close:SetSize(20, 20)
    btn_close:SetPos(270, 5)
    btn_close:SetText("×")
    btn_close:SetFont("DermaDefaultBold")
    btn_close:SetTextColor(Color(200, 200, 200))
    btn_close.Paint = function() end
    btn_close.DoClick = function()
        qw.ui.player_selector_frame:Remove()
        surface.PlaySound("buttons/button15.wav")
    end


    local scroll_panel = vgui.Create("DScrollPanel", qw.ui.player_selector_frame)
    scroll_panel:Dock(FILL)
    scroll_panel:DockMargin(5, 35, 5, 5)


    net.Start("RequestAllBandStatuses")
    net.SendToServer()


    net.Receive("ReceiveAllBandStatuses", function()
        local bandMembers = net.ReadTable()
        

        for _, ply in ipairs(player.GetAll()) do

            if bandMembers[ply:SteamID64()] then continue end
            

            if isfunction(filter_func) and not filter_func(ply) then continue end

            CreatePlayerButton(ply, scroll_panel, on_select)
        end


        CreateCancelButton()
    end)
end


function CreatePlayerButton(ply, parent, on_select)
    local player_panel = vgui.Create("DButton", parent)
    player_panel:Dock(TOP)
    player_panel:DockMargin(0, 0, 0, 5)
    player_panel:SetTall(40)
    player_panel:SetText("")

    player_panel.anim_hover = 0
    player_panel.Think = function(self)
        local target = self:IsHovered() and 1 or 0
        self.anim_hover = Lerp(FrameTime() * 10, self.anim_hover, target)
    end
    
    player_panel.Paint = function(self, w, h)
        local bg_color = Color(70, 70, 80)
        local gradient_color = Color(39, 39, 49, 200)
        local bg_hover = Color(60, 60, 70)
        local gradient_hover = Color(92, 92, 102, 220)
        
        local current_bg = Color(
            Lerp(self.anim_hover, bg_color.r, bg_hover.r),
            Lerp(self.anim_hover, bg_color.g, bg_hover.g),
            Lerp(self.anim_hover, bg_color.b, bg_hover.b)
        )
        
        local current_gradient = Color(
            Lerp(self.anim_hover, gradient_color.r, gradient_hover.r),
            Lerp(self.anim_hover, gradient_color.g, gradient_hover.g),
            Lerp(self.anim_hover, gradient_color.b, gradient_hover.b),
            Lerp(self.anim_hover, gradient_color.a, gradient_hover.a)
        )
        
        draw.RoundedBox(6, 0, 0, w, h, current_bg)
        
        local gradient = Material("gui/center_gradient")
        surface.SetMaterial(gradient)
        surface.SetDrawColor(current_gradient)
        surface.DrawTexturedRect(0, 0, w, h)
        
        local name_color = IsValid(ply) and (self:IsHovered() and Color(220, 220, 220) or color_white) or Color(255, 80, 80)
        local name_text = IsValid(ply) and ply:Name() or "Игрок вышел"
        
        draw.SimpleText(name_text, "vgui.core.font1", 50, h/2, name_color, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end

    player_panel.DoClick = function()
        if IsValid(ply) then
            surface.PlaySound("buttons/button15.wav")
            on_select(ply)
        else
            surface.PlaySound("buttons/button10.wav")
        end
        qw.ui.player_selector_frame:Remove()
    end

    local avatar = vgui.Create("AvatarImage", player_panel)
    avatar:SetSize(32, 32)
    avatar:SetPos(5, 4)
    avatar:SetPlayer(ply, 32)
end


function CreateCancelButton()
    local cancel_btn = vgui.Create("DButton", qw.ui.player_selector_frame)
    cancel_btn:Dock(BOTTOM)
    cancel_btn:DockMargin(5, 5, 5, 5)
    cancel_btn:SetTall(30)
    cancel_btn:SetText("Отмена")
    cancel_btn:SetFont("vgui.core.font1")
    cancel_btn:SetTextColor(color_white)

    cancel_btn.anim_hover = 0
    cancel_btn.Think = function(self)
        local target = self:IsHovered() and 1 or 0
        self.anim_hover = Lerp(FrameTime() * 10, self.anim_hover, target)
    end

    cancel_btn.Paint = function(self, w, h)
        local bg_color = Color(70, 70, 80)
        local gradient_color = Color(39, 39, 49, 200)
        local bg_hover = Color(60, 60, 70)
        local gradient_hover = Color(92, 92, 102, 220)
        
        local current_bg = Color(
            Lerp(self.anim_hover, bg_color.r, bg_hover.r),
            Lerp(self.anim_hover, bg_color.g, bg_hover.g),
            Lerp(self.anim_hover, bg_color.b, bg_hover.b)
        )
        
        local current_gradient = Color(
            Lerp(self.anim_hover, gradient_color.r, gradient_hover.r),
            Lerp(self.anim_hover, gradient_color.g, gradient_hover.g),
            Lerp(self.anim_hover, gradient_color.b, gradient_hover.b),
            Lerp(self.anim_hover, gradient_color.a, gradient_hover.a)
        )
        
        draw.RoundedBox(6, 0, 0, w, h, current_bg)
        
        local gradient = Material("gui/center_gradient")
        surface.SetMaterial(gradient)
        surface.SetDrawColor(current_gradient)
        surface.DrawTexturedRect(0, 0, w, h)
    end
    
    cancel_btn.DoClick = function()
        qw.ui.player_selector_frame:Remove()
        surface.PlaySound("buttons/button15.wav")
    end
end