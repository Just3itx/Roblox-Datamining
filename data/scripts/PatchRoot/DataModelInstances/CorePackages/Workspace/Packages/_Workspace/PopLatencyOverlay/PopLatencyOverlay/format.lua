-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:11:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = {
    " ",
    "▁",
    "▂",
    "▃",
    "▄",
    "▅",
    "▆",
    "▇",
    "█"
}

local reallyBlack = Color3.fromRGB(14, 14, 18)
local mediumBlue = Color3.fromRGB(70, 180, 200)
local white = Color3.fromRGB(255, 255, 255)
local hurricaneGrey = Color3.fromRGB(140, 140, 150)
local ghostGrey = Color3.fromRGB(200, 200, 220)
local persimmon = Color3.fromRGB(220, 90, 90)
local brightGreen = Color3.fromRGB(80, 220, 100)
local olive = Color3.fromRGB(220, 200, 80)
local persimmon2 = Color3.fromRGB(220, 80, 80)
local flint = Color3.fromRGB(110, 110, 120)

local function rttColor(num1: number): Color3 -- Luacid: Inlined by compiler; 3 call sites recovered
    return if num1 < 0 then flint elseif num1 < 30 then brightGreen elseif num1 < 80 then olive else persimmon2
end

local function rgbTag(color3: Color3) -- Luacid: Inlined by compiler; 26 call sites recovered
    return string.format("rgb(%d,%d,%d)", math.floor(color3.R * 255), math.floor(color3.G * 255), math.floor(color3.B * 255))
end

local function colorTag(color3: Color3, str1: string): string
    return string.format("<font color=\"%s\">%s</font>", rgbTag(color3), str1)
end

local function escapeRich(str1: string) -- Luacid: Inlined by compiler; 14 call sites recovered
    return (str1:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"))
end

local function glyphPad(num1: number): string -- Luacid: Inlined by compiler; 6 call sites recovered
    return "<font transparency=\"1\">" .. string.rep("█", num1) .. "</font>"
end

local function cellPad(num1: number, bool1: boolean?) -- Luacid: Inlined by compiler; 1 call site recovered
    if bool1 then
        return glyphPad(num1)
    end

    local color3 = flint
    local str1 = string.rep(" ", num1)
    return string.format("<font color=\"%s\">%s</font>", rgbTag(color3), str1)
end

local function bar(num1: number)
    if num1 < 0 then
        return colorTag(flint, string.rep("░", 18))
    end
    local num2 = math.max(1, math.min(18, math.floor(math.min(num1 / 300, 1) * 18 + 0.5)))
    local num3 = 18 - num2
    local color3 = rttColor(num1)
    local str1 = string.rep("█", num2)
    local str2 = string.format("<font color=\"%s\">%s</font>", rgbTag(color3), str1)

    local color3_2 = flint
    local str3 = string.rep("▒", num3)
    return str2 .. string.format("<font color=\"%s\">%s</font>", rgbTag(color3_2), str3)
end

local function sparkline(tbl2, bool1: boolean?)
    if not tbl2 or #tbl2 == 0 then
        if bool1 then
            return glyphPad(12)
        end

        local color3 = flint
        local str1 = string.rep(" ", 12)
        return string.format("<font color=\"%s\">%s</font>", rgbTag(color3), str1)
    end

    local num1 = 1
    for _, value in ipairs(tbl2) do
        if value >= 0 and num1 < value then
            num1 = value
        end
    end

    local num2 = 12 - #tbl2
    local tbl3 = {}
    if num2 > 0 then
        local var1 = cellPad(num2, bool1)
        table.insert(tbl3, var1)
    end
    for _, value in ipairs(tbl2) do
        if value < 0 then
            table.insert(tbl3, colorTag(flint, if bool1 then "░" else "×"))
        else
            local num3 = math.min(#tbl1, math.max(1, math.floor(value / num1 * (#tbl1 - 1) + 1)))
            local var1

            if num3 == 1 and bool1 then
                var1 = glyphPad(1)
            else
                local color3 = rttColor(value)
                local str1 = tbl1[num3]
                var1 = string.format("<font color=\"%s\">%s</font>", rgbTag(color3), str1)
            end

            table.insert(tbl3, var1)
        end
    end
    return table.concat(tbl3)
end

local function committedHistory<T>(tbl2)
    local var1 = nil
    for i = 1, #tbl2 do
        local var2 = tbl2[i]
        if var2 and var2 >= 0 then
            var1 = i
            break
        end
    end

    if not var1 then
        return {}
    end
    local result = {}
    for i = var1, #tbl2 do
        result[#result + 1] = tbl2[i]
    end
    return result
end

local function historyStats(tbl2): (number, number, number)
    local num1 = 0
    local num2 = 0
    local num3 = 0
    for _, value in ipairs(tbl2) do
        if value < 0 then
            num1 += 1
        else
            num2 += value
            num3 += 1
        end
    end

    local var1

    if num3 >= 2 then
        local var2 = num2 / num3
        local num4 = 0
        for _, value in ipairs(tbl2) do
            if value >= 0 then
                num4 += (value - var2) * (value - var2)
            end
        end
        var1 = math.sqrt(num4 / num3)
    else
        var1 = 0
    end
    return #tbl2, num1, var1
end

local function historyMedian(tbl2)
    local tbl3 = {}
    for _, value in ipairs(tbl2) do
        if value >= 0 then
            tbl3[#tbl3 + 1] = value
        end
    end
    if #tbl3 == 0 then
        return nil
    end
    table.sort(tbl3)
    local num1 = #tbl3

    if num1 % 2 == 1 then
        return tbl3[(num1 + 1) // 2]
    end

    return (tbl3[num1 // 2] + tbl3[num1 // 2 + 1]) / 2
end

local function historyMean(tbl2) -- Luacid: Inlined by compiler; 2 call sites recovered
    local num1 = 0
    local num2 = 0
    for _, value in ipairs(tbl2) do
        if value >= 0 then
            num1 += value
            num2 += 1
        end
    end
    return if num2 == 0 then nil else num1 / num2
end

local function statsCell(tbl2)
    local num1, num2, num3 = historyStats(tbl2)
    if num1 == 0 then
        return colorTag(flint, (escapeRich(string.format("%-" .. 11 .. "s", "—"))))
    end
    local num4 = math.floor(num2 / num1 * 100 + 0.5)
    local var1 = string.format("%d%% ±%dms", num4, math.floor(num3 + 0.5))
    local color3 = num2 == 0 and brightGreen or num4 >= 25 and persimmon2 or olive
    return colorTag(color3, (escapeRich(string.format("%-" .. 11 .. "s", var1))))
end

local function rttCell(num1: number?)
    if not num1 or num1 < 0 then
        return colorTag(flint, string.rep(" ", 7) .. "—")
    end

    local str1 = string.format("%" .. 8 .. "s", string.format("%.1fms", num1))
    return colorTag(rttColor(num1), (escapeRich(str1)))
end

local function timeoutCell(): string -- Luacid: unused: defined but never referenced
    return colorTag(flint, (escapeRich(string.format("%" .. 8 .. "s", "timeout"))))
end

local function formatInterval(num1: number): string
    if not num1 or num1 <= 0 then
        return "?"
    end
    local num2 = math.floor(num1 / 1000 + 0.5)
    if num2 < 60 then
        return string.format("%ds", num2)
    end
    local num3 = num2 / 60
    if num3 == math.floor(num3) then
        return string.format("%dm", num3)
    end
    return string.format("%.1fm", num3)
end

local function formatElapsed(num1: number): string
    local num2 = math.max(0, math.floor(num1))
    local num3 = math.floor(num2 / 3600)
    local num4 = math.floor(num2 % 3600 / 60)
    local num5 = num2 % 60
    return string.format("%d:%02d:%02d", num3, num4, num5)
end

local function formatIp(str1: string): string
    local tbl2 = {}
    for value in str1:gmatch("[^.]+") do
        table.insert(tbl2, string.format("%3s", value))
    end
    return table.concat(tbl2, ".")
end

local function separator(num1: number?): string
    return colorTag(mediumBlue, string.rep("─", num1 or 96))
end

local function vipCell(str1: string, num1: number?, bool1: boolean, num2: number?): string
    local num3 = num2 or 20
    local str2 = ":" .. tostring(num1 and num1 > 0 and num1 or 3478)
    local var1

    if not bool1 then
        var1 = formatIp(str1) .. str2
    else
        local num4 = num3 - #str2 - 2
        if #str1 <= num4 then
            var1 = "[" .. str1 .. "]" .. str2
        else
            local num5 = num4 - 1
            local num6 = math.ceil(num5 / 2)
            local str3 = str1:sub(1, num6)
            local str4 = str1:sub(#str1 - (num5 - num6) + 1)
            local var2 = str3:match("^(.*:)[^:]*$")
            if var2 and #var2 * 2 >= #str3 then
                str3 = var2
            end

            local var3 = str4:match("^[^:]*(:.*)$")
            if var3 and #var3 * 2 >= #str4 then
                str4 = var3
            end

            var1 = "[" .. str3 .. "~" .. str4 .. "]" .. str2
        end
    end
    local num4 = utf8.len(var1) or #var1
    local func1 = colorTag
    local color3 = hurricaneGrey
    local rep = string.rep
    local num5 = num3 - num4
    return func1(color3, (escapeRich(var1 .. rep(" ", math.max(0, num5)))))
end

local str1 = "    └ v6" .. string.rep(" ", 6)

local str2 = "    └ v6 dbg" .. string.rep(" ", 2)

local function ipv6DeltaCell(num1: number?, num2: number?): string -- Luacid: Inlined by compiler; 1 call site recovered
    if not (num1 and num2) then
        return ""
    end
    local num3 = num1 - num2
    local color3 = num3 <= 0 and brightGreen or persimmon2
    local var1 = escapeRich(string.format("Δ %+.1fms", num3))
    return "   " .. string.format("<font color=\"%s\">%s</font>", rgbTag(color3), var1)
end

local function renderIpv6Row(arg1, num1: number?, num2: number)
    local tbl2 = committedHistory(arg1.history or {})
    local bool1 = not (arg1.rttMs == nil) and arg1.rttMs >= 0
    local var1 = if bool1 then historyMedian(tbl2) or nil else nil
    local var2 = if bool1 then historyMean(tbl2) or nil else nil
    local var3 = bool1 and rttCell(arg1.rttMs)

    if not var3 then
        local color3 = flint
        local var4 = escapeRich(string.format("%" .. 8 .. "s", "timeout"))
        var3 = string.format("<font color=\"%s\">%s</font>", rgbTag(color3), var4)
    end

    local color3 = hurricaneGrey
    local str3 = arg1.debug and str2 or str1
    local str4 = string.format("<font color=\"%s\">%s</font>", rgbTag(color3), str3)

    local str5 = rttCell(var1)
    local str6 = " "
    local str7 = rttCell(var2)
    local str8 = " "

    local str9 = "   "
    local str10 = statsCell(tbl2)
    local str11 = "   "
    local str12 = vipCell(tostring(arg1.ipString or "?"), tonumber(arg1.port), true, num2)
    local str13 = "   "
    local str14 = bar(var1 or -1)
    local str15 = "   "
    local str16 = sparkline(tbl2, true)
    local var4 = ipv6DeltaCell(var1, num1)
    return str4 .. str5 .. str6 .. str7 .. str8 .. var3 .. str9 .. str10 .. str11 .. str12 .. str13 .. str14 .. str15 .. str16 .. var4
end

local function renderPopRows(tbl2, arg1, str3: string, bool1: boolean, num1: number, bool2: boolean)
    local str4 = tostring(arg1.popCode or "?")
    local str5 = tostring(arg1.ipString or "—")

    local str6 = " "
    local color3 = bool1 and white or hurricaneGrey
    local var1 = escapeRich(string.format("%-10s", str4))
    local str7 = string.format("<font color=\"%s\">%s</font>", rgbTag(color3), var1)

    local str8 = rttCell(if bool1 then arg1.__med or nil else nil)
    local str9 = " "
    local str10 = rttCell(if bool1 then arg1.__avg or nil else nil)
    local str11 = " "
    local var2 = bool1 and rttCell(arg1.rttMs)

    if not var2 then
        local color3_2 = flint
        local var3 = escapeRich(string.format("%" .. 8 .. "s", "timeout"))
        var2 = string.format("<font color=\"%s\">%s</font>", rgbTag(color3_2), var3)
    end
    local str12 = statsCell(arg1.__hist)

    local var3 = tonumber(arg1.port)
    local str13 = ":" .. tostring(var3 and var3 > 0 and var3 or 3478)

    local str14 = formatIp(str5) .. str13

    local num2 = utf8.len(str14) or #str14
    local color3_2 = hurricaneGrey
    local rep = string.rep
    local num3 = (num1 or 20) - num2
    local var4 = escapeRich(str14 .. rep(" ", math.max(0, num3)))
    table.insert(
        tbl2,
        str3
            .. str6
                .. str7 .. str8 .. str9 .. str10 .. str11 .. var2 .. "   " .. str12 .. "   " .. string.format("<font color=\"%s\">%s</font>", rgbTag(color3_2), var4) .. "   " .. bar(bool1 and arg1.__sort or -1) .. "   " .. sparkline(arg1.__hist, bool2)
    )

    if arg1.v6 then
        table.insert(tbl2, (renderIpv6Row(arg1.v6, if bool1 then arg1.__med or nil else nil, num1)))
    end
end

local function prepareRows(tbl2)
    local tbl3 = {}
    local tbl4 = {}
    for _, value in ipairs(tbl2) do
        value.__hist = committedHistory(value.history or {})
        if value.rttMs and value.rttMs >= 0 then
            value.__med = historyMedian(value.__hist)
            value.__avg = historyMean(value.__hist)
            value.__sort = value.__med or value.rttMs
            table.insert(tbl3, value)
        else
            table.insert(tbl4, value)
        end
    end

    table.sort(tbl3, function(arg1, arg2): boolean
        return arg1.__sort < arg2.__sort
    end)
    table.sort(tbl4, function(arg1, arg2): boolean
        return tostring(arg1.popCode) < tostring(arg2.popCode)
    end)
    return tbl3, tbl4
end

local function anyIpv6Enabled(tbl2) -- Luacid: Inlined by compiler; 1 call site recovered
    for _, value in ipairs(tbl2) do
        if value.ipv6Enabled then
            return true
        end
    end
    return false
end

return {
    POLL_INTERVAL_SECONDS = 1,
    HISTORY_LEN = 12,
    TEXT_SIZE = 14,
    SEP_WIDTH = 96,
    COLOR_BG = reallyBlack,
    COLOR_BORDER = mediumBlue,
    COLOR_HEADER = ghostGrey,
    COLOR_DIM = hurricaneGrey,
    COLOR_CLOSE = persimmon,
    COLOR_RED = persimmon2,
    rttColor = rttColor,
    colorTag = colorTag,
    escapeRich = escapeRich,
    bar = bar,
    sparkline = sparkline,
    rttCell = rttCell,
    formatIp = formatIp,
    vipCell = vipCell,
    separator = separator,
    formatInterval = formatInterval,
    formatElapsed = formatElapsed,
    committedHistory = committedHistory,
    historyStats = historyStats,
    historyMedian = historyMedian,
    historyMean = historyMean,
    renderSnapshot = function(tbl2, num1: number, num2: number, num3: number): string
        local tbl3 = {}
        local tbl4 = {}
        for _, value in ipairs(tbl2) do
            table.insert(if value.debug then tbl4 or tbl3 else tbl3, value)
        end
        local tbl5, tbl6 = prepareRows(tbl3)
        local tbl7, tbl8 = prepareRows(tbl4)

        local bool1 = false
        for _, value in ipairs(tbl2) do
            if value.v6 then
                bool1 = true
                break
            end
        end

        local num4 = if bool1 then 107 else 96
        local num5 = 20
        for _, value in ipairs(tbl2) do
            if bool1 or (tonumber(value.port) or 0) >= 10000 then
                num5 = 21
                break
            end
        end

        local tbl9 = {}

        local num6 = 0
        for _, value in ipairs(tbl2) do
            local lastSampleEpochMs = value.lastSampleEpochMs or 0
            if num6 < lastSampleEpochMs then
                num6 = lastSampleEpochMs
            end
        end

        local var1

        if num6 > 0 and num3 and num3 > 0 then
            local num7 = math.max(0, math.floor((num6 + num3 - os.time() * 1000) / 1000 + 0.5))
            var1 = string.format("   next %ds", num7)
        else
            var1 = ""
        end
        local str3 = string.format("probe #%d   every %s%s   up %s", num1, formatInterval(num3), var1, formatElapsed(num2))
        local bool2 = anyIpv6Enabled(tbl2)
        local str4 = if bool2 then "[engine] [v6 enabled]" else "[engine]"
        local num7 = num4 - #("Roblox TURN/STUN UDP Latency Monitor " .. str4 .. "   " .. str3)
        local num8 = if num7 < 3 then 3 else num7
        table.insert(
            tbl9,
            string.format("<font color=\"%s\">%s</font>", rgbTag(white), "Roblox TURN/STUN UDP Latency Monitor")
                .. " " .. string.format("<font color=\"%s\">%s</font>", rgbTag(hurricaneGrey), str4) .. string.rep(" ", num8) .. string.format("<font color=\"%s\">%s</font>", rgbTag(hurricaneGrey), str3)
        )
        table.insert(tbl9, separator(num4))

        local str5 = "%" .. 8 .. "s"
        local str6 = "%-3s %-10s" .. str5 .. " " .. str5 .. " " .. str5 .. "   " .. ("%-" .. 11 .. "s") .. "   " .. ("%-" .. num5 .. "s") .. "   "
        local var2 = escapeRich(string.format(str6, "#", "PoP", "Med RTT", "Avg RTT", "Last RTT", "Loss/Jit", "TURN VIP")) .. "Bar" .. (if bool2 then glyphPad(15) else string.rep(" ", 15)) .. "   Trend" .. (if bool1 then glyphPad(7) .. "   Δ v6" else "")
        table.insert(tbl9, colorTag(ghostGrey, var2))
        table.insert(tbl9, separator(num4))

        local num9 = 1
        for _, value in ipairs(tbl5) do
            local func1 = renderPopRows
            local color3 = hurricaneGrey
            local var3 = escapeRich(string.format("%2d.", num9))
            func1(tbl9, value, string.format("<font color=\"%s\">%s</font>", rgbTag(color3), var3), true, num5, bool2)
            num9 += 1
        end
        for _, value in ipairs(tbl6) do
            renderPopRows(tbl9, value, string.format("<font color=\"%s\">%s</font>", rgbTag(flint), " — "), false, num5, bool2)
        end

        if #tbl4 > 0 then
            table.insert(tbl9, colorTag(hurricaneGrey, (escapeRich("debug — public STUN servers, not Roblox PoPs"))))
            for _, value in ipairs(tbl7) do
                renderPopRows(
                    tbl9,
                    value,
                    string.format("<font color=\"%s\">%s</font>", rgbTag(hurricaneGrey), " · "),
                    true,
                    num5,
                    bool2
                )
            end

            for _, value in ipairs(tbl8) do
                renderPopRows(tbl9, value, string.format("<font color=\"%s\">%s</font>", rgbTag(flint), " — "), false, num5, bool2)
            end
        end

        table.insert(tbl9, separator(num4))

        local num10 = 0
        local num11 = 0
        local var3 = nil
        local var4 = nil
        local var5 = nil
        local var6 = nil
        for _, value in ipairs(tbl5) do
            num10 += 1
            local __sort = value.__sort
            num11 += __sort
            if not var4 or __sort < var4 then
                var3 = tostring(value.popCode)
                var4 = __sort
            end
            if not var6 or var6 < __sort then
                var5 = tostring(value.popCode)
                var6 = __sort
            end
        end
        local var7 = num10 > 0 and num11 / num10 or 0
        local num12 = #tbl6
        local tbl10 = {}
        if var3 then
            local color3 = brightGreen
            local str7 = string.format("%s %.1fms", var3, var4)
            table.insert(tbl10, "best " .. string.format("<font color=\"%s\">%s</font>", rgbTag(color3), str7))
        end
        if var5 then
            local color3 = persimmon2
            local str7 = string.format("%s %.1fms", var5, var6)
            table.insert(tbl10, "worst " .. string.format("<font color=\"%s\">%s</font>", rgbTag(color3), str7))
        end
        if num10 > 0 then
            local color3 = olive
            local str7 = string.format("%.1fms", var7)
            table.insert(tbl10, "avg " .. string.format("<font color=\"%s\">%s</font>", rgbTag(color3), str7))
        end
        local str7 = string.format("%d ok   ", num10)
        local color3 = flint
        local str8 = string.format("%d timeout", num12)
        table.insert(tbl10, str7 .. string.format("<font color=\"%s\">%s</font>", rgbTag(color3), str8))

        local num13 = 0
        local num14 = 0
        for _, value in ipairs(tbl3) do
            if not value.v6 or value.v6.debug then
                continue
            end

            num13 += 1
            if value.v6.rttMs and value.v6.rttMs >= 0 then
                num14 += 1
            end
        end

        if num13 > 0 then
            local color3_2 = num14 > 0 and brightGreen or persimmon2
            local str9 = string.format("%d/%d ok", num14, num13)
            table.insert(tbl10, "v6 " .. string.format("<font color=\"%s\">%s</font>", rgbTag(color3_2), str9))
        end
        table.insert(tbl9, table.concat(tbl10, "   │   "))

        return table.concat(tbl9, "\n")
    end
}
