util.AddNetworkString("MoneyRemove")
util.AddNetworkString("BandTitle")
util.AddNetworkString("BandMembers")
util.AddNetworkString("Members")
util.AddNetworkString("CheckRank")
util.AddNetworkString("Up")
util.AddNetworkString("Down")
util.AddNetworkString("Kick")
util.AddNetworkString("Invite")
util.AddNetworkString("Leave")
util.AddNetworkString("RequestAllBandStatuses")
util.AddNetworkString("ReceiveAllBandStatuses")

net.Receive("MoneyRemove", function(len, ply)
    local price_band = net.ReadInt(18)
    local title_band = net.ReadString()
    local defoult = 5 --- Поменять на конфиг
    defoult_rank1 = "Участник"
    defoult_rank2 = "Модератор"
    defoult_rank3 = "Заместитель"
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

net.Receive("Members", function(len, ply)
    local ply64 = ply:SteamID64()
    local band_title = sql.Query("SELECT title FROM bands_members WHERE steamid64 = " .. sql.SQLStr(ply64))
    local title_first = band_title[1].title
    local allmembers = sql.Query("SELECT steamid64 FROM bands_members WHERE title = " .. sql.SQLStr(title_first))
    local allranks = sql.Query("SELECT rank FROM bands_members WHERE title = " .. sql.SQLStr(title_first))

    net.Start("Members")
    net.WriteTable(allmembers)
    net.WriteTable(allranks)
    net.Send(ply)
end)

net.Receive("CheckRank", function(len, ply)
    local ply_rank = sql.Query("SELECT rank FROM bands_members WHERE steamid64 = " .. sql.SQLStr(ply:SteamID64()))
    net.Start("CheckRank")
    net.WriteString(ply_rank[1].rank)
    net.Send(ply)
end)

net.Receive("Up", function(len, ply)
    local targetrank_1 = net.ReadString()
    local targetid = net.ReadString()
    sql.Query("UPDATE bands_members SET rank = " .. sql.SQLStr(targetrank_1) .. " WHERE steamid64 = " .. sql.SQLStr(targetid))
end)

net.Receive("Down", function(len, ply)
    local targetrank_1 = net.ReadString()
    local targetid = net.ReadString()
    sql.Query("UPDATE bands_members SET rank = " .. sql.SQLStr(targetrank_1) .. " WHERE steamid64 = " .. sql.SQLStr(targetid))
end)

net.Receive("Kick", function(len, ply)
    local targetid = net.ReadString()
    sql.Query("DELETE FROM bands_members WHERE steamid64 = " .. sql.SQLStr(targetid))
end)

net.Receive("Invite", function(len, ply)
    local title = net.ReadString()
    local pl = net.ReadEntity()

    sql.Query("INSERT INTO bands_members (steamid64, title, rank) VALUES (" .. sql.SQLStr(pl:SteamID64()) .. "," .. sql.SQLStr(title) .. "," .. sql.SQLStr("Участник") ..")")
end)

--[[
net.Receive("CheckInBand", function(len, ply)
    local playerband = net.ReadPlayer()
    local check = sql.Query("SELECT rank FROM bands_members WHERE steamid64 = " .. sql.SQLStr(playerband:SteamID64()))
    local check = (check[1] and check[1].rank) or 2
    if IsValid(check) == true then
        check = 1
    end
    -- check[1].rank
    print(check)
    net.Start("CheckInBand")
        net.WriteInt(check, 3)
    net.Send(ply)
end)
]]

net.Receive("RequestAllBandStatuses", function(_, ply)
    local bandMembers = {}
    local query = sql.Query("SELECT steamid64 FROM bands_members") or {}
    
    for _, row in ipairs(query) do
        bandMembers[row.steamid64] = true
    end
    
    net.Start("ReceiveAllBandStatuses")
        net.WriteTable(bandMembers)
    net.Send(ply)
end)

net.Receive("Leave", function(len, ply)
    local localsteamid = net.ReadString()
    sql.Query("DELETE FROM bands_members WHERE steamid64 = " .. sql.SQLStr(localsteamid))
end)