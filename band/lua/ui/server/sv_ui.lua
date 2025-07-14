util.AddNetworkString("MoneyRemove")
util.AddNetworkString("BandTitle")
util.AddNetworkString("BandMembers")

net.Receive("MoneyRemove", function(len, ply)
    local price_band = net.ReadInt(18)
    local title_band = net.ReadString()
    local defoult = 5 --- Поменять на конфиг
    local defoult_rank1 = "Участник"
    local defoult_rank2 = "Модератор"
    local defoult_rank3 = "Заместитель"
    ply:ChatPrint(ply:Nick() .. ", вы успешно создали банду!")
    local lead_steamid = ply:SteamID64()
    ply:addMoney(-price_band)
    sql.Query("INSERT INTO bands_bsystem (title, steamid_leader, members, rank_first, rank_second, rank_third) VALUES (" .. sql.SQLStr(title_band) .. "," .. sql.SQLStr(lead_steamid) .. "," .. defoult .. "," .. sql.SQLStr(defoult_rank1) .. "," .. sql.SQLStr(defoult_rank2) .. "," .. sql.SQLStr(defoult_rank3) .. ")")
    sql.Query("INSERT INTO bands_members (steamid64, title, rank) VALUES (" .. sql.SQLStr(lead_steamid) .. "," .. sql.SQLStr(title_band) .. "," .. sql.SQLStr("Глава") ..")")
end)

net.Receive("BandTitle", function(len, ply)
    local steamid64 = ply:SteamID64()
    local query = "SELECT title FROM bands_members WHERE steamid64 = " .. sql.SQLStr(steamid64)
    local rank = sql.Query("SELECT rank FROM bands_members WHERE steamid64 = " .. sql.SQLStr(steamid64))
    local result = sql.Query(query)
    local title = "Неизвестно"
    
    title = result[1].title
    rank = rank[1].rank
    
    net.Start("BandTitle")
    net.WriteString(title)
    net.WriteString(rank)
    net.Send(ply)
end)

net.Receive("BandMembers", function(len, ply)
    local steamid64 = ply:SteamID64()
    local query = sql.Query("SELECT title FROM bands_members WHERE steamid64 = " .. sql.SQLStr(steamid64))
    local bandname = query[1].title
    local members = sql.Query("SELECT steamid64 FROM bands_members WHERE title = " .. sql.SQLStr(bandname))
    local membercount = #members

    local onlinecount = 0
    for _, member in ipairs(members) do
        if player.GetBySteamID64(member.steamid64) then
            onlinecount = onlinecount + 1
        end
    end
    
    net.Start("BandMembers")
    net.WriteUInt(membercount, 8)
    net.WriteUInt(onlinecount, 8)
    net.Send(ply)
end)