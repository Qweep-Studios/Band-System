util.AddNetworkString("MoneyRemove")

net.Receive("MoneyRemove", function(len, ply)
    local price_band = net.ReadInt(18)
    ply:ChatPrint(ply:Nick() .. ", вы успешно создали банду!")
    ply:addMoney(-price_band)
end)