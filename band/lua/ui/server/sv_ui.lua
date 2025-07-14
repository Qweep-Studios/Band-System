util.AddNetworkString("MoneyRemove")
util.AddNetworkString("BandTitle")
util.AddNetworkString("BandMembers")
util.AddNetworkString("Members")
util.AddNetworkString("CheckRank")

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
    local query = "SELECT members FROM bands_bsystem WHERE steamid_leader = " .. sql.SQLStr(steamid64)
    local result = sql.Query(query)
    local count = "0"

    count = result[1].members
    
    net.Start("BandMembers")
    net.WriteString(count)
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