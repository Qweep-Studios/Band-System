scrh = ScrH()
scrw = ScrW()

surface.CreateFont('ui.font0', {
    font = 'Overpass Bold',
    extended = true,
    size = math.ceil(40 / 1800 * ScrH())
})

surface.CreateFont('ui.font1', {
    font = 'Overpass Bold',
    extended = true,
    size = math.ceil(30 / 1800 * ScrH())
})

local f1 = Color(40, 40, 45, 232)
local f2 = Color(30, 30, 35)
local cb1 = Color(255, 255, 255)
local cb2 = Color(185, 185, 185)
local te1 = Color(68, 68, 73, 240)

local close = Material("qwscoreboard/close.png")

function buy_band_ui()
    local frame = vgui.Create("DFrame")
    frame:SetSize(scrw*0.5, scrh*0.7)
    frame:SetTitle('')
    frame:Center()
    frame:MakePopup()
    frame:ShowCloseButton(false)
    frame:SetDraggable(false)
    frame:SetAlpha(0)

    local startTime = CurTime()
    local animDuration = 0.2

    frame.Paint = function(self, w, h)
        local progress = (CurTime() - startTime) / animDuration
        progress = math.Clamp(progress, 0, 1)
        self:SetAlpha(Lerp(progress, 0, 255))

        draw.RoundedBox(8, 0, 0, w, h, f1)
        draw.RoundedBoxEx(8, 0, 0, w, 40, f2, true, true, false, false)
    end

    local closebtn = vgui.Create('DButton', frame)
    closebtn:SetSize(scrw*0.020, scrh*0.020)
    closebtn:SetText("")
    closebtn:SetPos(frame:GetWide() - 40, 10)
    closebtn.DoClick = function()
        frame:Close()
    end
    closebtn.Paint = function(self, w, h)
        surface.SetMaterial(close)
        surface.SetDrawColor(self:IsHovered() and cb2 or cb1)
        surface.DrawTexturedRect(0, 0, 20, 20)
    end

    local textentry = vgui.Create('DTextEntry', frame)
    textentry:SetSize(scrw*0.10, scrh*0.030)
    textentry:Center()
    textentry:SetTextColor(cb1)
    textentry:SetFont('ui.font0')
    textentry.Paint = function(self, w, h)
        draw.RoundedBox(6, 0, 0, w, h, te1)

        local inputText = textentry:GetText()

        if inputText == "" then
            draw.SimpleText('Введите сюда название...', 'ui.font1', 0, 0, cb2, TEXT_ALIGN_LEFT)
        end

        self:DrawTextEntryText(
            self:GetTextColor(),
            self:GetHighlightColor(),
            self:GetCursorColor()
        )
    end
end