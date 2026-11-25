-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:11:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local format = require(script.Parent.format)

local function regionOf(popCode: string): string -- Luacid: Inlined by compiler; 3 call sites recovered
    return string.upper(string.sub(popCode, 1, 3))
end

local function median(tbl1) -- Luacid: Inlined by compiler; 2 call sites recovered
    return format.historyMedian(tbl1)
end

local function pooledHistory(tbl1): {number}
    local num1 = 0
    for _, value in tbl1 do
        num1 = math.max(num1, #value)
    end
    local tbl2 = table.create(num1, -1)
    for i = 0, num1 - 1 do
        local tbl3 = {}
        for _, value in tbl1 do
            local var1 = value[#value - i]
            if var1 ~= nil and var1 >= 0 then
                table.insert(tbl3, var1)
            end
        end

        tbl2[num1 - i] = median(tbl3) or -1
    end
    return tbl2
end

local function statsByRegion(tbl1)
    local tbl2 = ({})
    local tbl3 = ({})
    for _, value in tbl1 do
        if typeof(value.popCode) ~= "string" then
            continue
        end

        local str1 = regionOf(value.popCode)
        tbl2[str1] = tbl2[str1] or {}
        tbl3[str1] = tbl3[str1] or {}
        local var1 = format.committedHistory(value.history or {})
        local bool1 = false
        for _, value2 in var1 do
            if value2 >= 0 then
                table.insert(tbl2[str1], value2)
                bool1 = true
            end
        end

        if not bool1 and typeof(value.rttMs) == "number" and value.rttMs >= 0 then
            table.insert(tbl2[str1], value.rttMs)
        end
        if #var1 > 0 then
            table.insert(tbl3[str1], var1)
        end
    end

    local result = ({})
    for value, value2 in tbl2 do
        local medianMs = median(value2)

        if not medianMs then
            continue
        end
        local _, _, var2 = format.historyStats(value2)
        local tbl4 = { medianMs = medianMs, jitterMs = 0, history = 0 }
        if not (#value2 >= 2) then
            var2 = nil
        end

        tbl4.jitterMs = var2
        tbl4.history = pooledHistory(tbl3[value])
        result[value] = tbl4
    end

    return result
end

local function msText(num1: number?) -- Luacid: Inlined by compiler; 8 call sites recovered
    if num1 == nil or num1 < 0 then
        return format.colorTag(format.COLOR_RED, "—")
    end
    return format.colorTag(format.rttColor(num1), string.format("%.0f ms", num1))
end

local function jitterText(num1: number?) -- Luacid: Inlined by compiler; 2 call sites recovered
    if num1 then
        return (format.colorTag(format.COLOR_DIM, string.format(" ±%.0f ms jitter", num1)))
    end

    return ""
end

local function alternatives(tbl1, str1: string?)
    local result = {}
    for region, value2 in tbl1 do
        if region == str1 then
            continue
        end

        table.insert(result, { region = region, medianMs = value2.medianMs, jitterMs = value2.jitterMs })
    end

    table.sort(result, function(arg1, arg2): boolean
        return arg1.medianMs < arg2.medianMs
    end)
    while #result > 3 do
        table.remove(result)
    end
    return result
end

local function dim(str1: string) -- Luacid: Inlined by compiler; 12 call sites recovered
    return format.colorTag(format.COLOR_DIM, str1)
end

local str1 = string.rep(" ", 24)

local function deltaText(num1: number?, num2: number?) -- Luacid: Inlined by compiler; 2 call sites recovered
    if num1 and num2 then
        return (format.colorTag(format.COLOR_DIM, string.format("%+.0f ms", num1 - num2)))
    end

    return nil
end

local tbl1 = { Server = "Server", Automatic = "Client (Automatic)" }

local function addPingLines(tbl2, tbl3): boolean
    local bool1 = not (tbl3.lastMs == nil or tbl3.serverMs == nil) and tbl3.clientMs ~= nil
    local str2 = "  Data Ping (RCC)       "
    local dataMs = tbl3.dataMs
    table.insert(
        tbl2,
        str2 .. (if dataMs == nil or dataMs < 0 then msText(nil) else format.colorTag(format.rttColor(dataMs), string.format("%.0f ms", dataMs)))
    )

    if bool1 then
        local str3 = "  Last ping             "
        local lastMs = tbl3.lastMs
        table.insert(
            tbl2,
            str3 .. (if lastMs == nil or lastMs < 0 then msText(nil) else format.colorTag(format.rttColor(lastMs), string.format("%.0f ms", lastMs)))
        )
        local str4 = "    server              "
        local serverMs = tbl3.serverMs
        table.insert(
            tbl2,
            str4 .. (if serverMs == nil or serverMs < 0 then msText(nil) else format.colorTag(format.rttColor(serverMs), string.format("%.0f ms", serverMs)))
        )
        local str5 = "    client              "
        local clientMs = tbl3.clientMs
        table.insert(
            tbl2,
            str5 .. (if clientMs == nil or clientMs < 0 then msText(nil) else format.colorTag(format.rttColor(clientMs), string.format("%.0f ms", clientMs)))
        )
        local str6 = "    network (RakNet)    "
        local splitRakMs = tbl3.splitRakMs
        table.insert(
            tbl2,
            str6 .. (if splitRakMs == nil or splitRakMs < 0 then msText(nil) else format.colorTag(format.rttColor(splitRakMs), string.format("%.0f ms", splitRakMs)))
        )
        local var1 = if tbl3.lastMs and tbl3.serverMs and tbl3.clientMs and tbl3.splitRakMs then tbl3.lastMs - (tbl3.serverMs + tbl3.clientMs + tbl3.splitRakMs) else nil

        if var1 and var1 < -10 then
            table.insert(tbl2, "    unaccounted         " .. dim("stages out of sync"))
        elseif var1 and var1 > 10 then
            table.insert(tbl2, "    unaccounted         " .. dim(string.format("+%.0f ms", var1)))
        end
    end
    if tbl3.fps and tbl3.fps > 0 then
        table.insert(
            tbl2,
            "  Client frame rate     " .. string.format("%.0f fps", tbl3.fps) .. dim(string.format(" · %.1f ms/frame", 1000 / tbl3.fps))
        )
        if tbl3.worstFrameMs then
            local str3 = string.format("worst frame %.0f ms", tbl3.worstFrameMs)
            table.insert(tbl2, str1 .. (if tbl3.worstFrameMs >= 100 then format.colorTag(format.COLOR_RED, str3) else dim(str3)))
        end
    end

    return bool1
end

local function addProbeLines(tbl2, tbl3, tbl4)
    local str2 = "  PoP probe             "
    local medianMs = if tbl4 then tbl4.medianMs else nil
    local var1 = if medianMs == nil or medianMs < 0 then msText(nil) else format.colorTag(format.rttColor(medianMs), string.format("%.0f ms", medianMs))
    local jitterMs = if tbl4 then tbl4.jitterMs else nil
    table.insert(tbl2, str2 .. var1 .. jitterText(jitterMs))

    if tbl4 and #tbl4.history > 0 then
        table.insert(tbl2, str1 .. format.sparkline(tbl4.history))
    end
    if tbl3.probeIntervalMs and tbl3.probeIntervalMs > 0 then
        local var2 = tbl3.probeTargets or {}
        table.insert(
            tbl2,
            string.format("  Probe rate            %.0f/s", 1000 / tbl3.probeIntervalMs) .. dim(string.format(" · every %.0f ms · %d PoP%s", tbl3.probeIntervalMs, #var2, if #var2 == 1 then "" else "s"))
        )
    end

    if tbl3.probeDown then
        table.insert(tbl2, "  Probe loss (1 s)      " .. dim("no replies · probe server may be draining"))
        return
    end

    if not tbl3.probeLoss then
        return
    end

    local str3 = string.format("%.0f %%", tbl3.probeLoss * 100)
    local probeSilentPops = tbl3.probeSilentPops

    local str4 = "  Probe loss (1 s)      "
    if tbl3.probeLoss > 0 then
        str3 = format.colorTag(format.COLOR_RED, str3)
    end

    table.insert(
        tbl2,
        str4 .. str3 .. dim(
            if probeSilentPops then if #probeSilentPops > 0 then " · " .. format.escapeRich(table.concat(probeSilentPops, ", ")) .. " not answering" else " · your link to the edge" else " · your link to the edge"
        )
    )
end

local function addPeerLines(tbl2, tbl3)
    if tbl3.peerStatsInvalid then
        table.insert(tbl2, "  RakNet peer stats     " .. dim("unavailable"))
    end
    if tbl3.loss then
        local str2 = string.format("%.1f %%", tbl3.loss * 100)

        local str3 = "  Packet loss           "
        if tbl3.loss >= 0.01 then
            str2 = format.colorTag(format.COLOR_RED, str2)
        end

        table.insert(tbl2, str3 .. str2)
    end

    if tbl3.resendMsgs then
        table.insert(
            tbl2,
            string.format(
                "  Resend queue          %d %s%s",
                tbl3.resendMsgs,
                if tbl3.resendMsgs == 1 then "msg" else "msgs",
                if tbl3.resendBytes then dim(string.format(" · %.1f KB", tbl3.resendBytes / 1024)) else ""
            )
        )
    end
    if tbl3.sendKbps or tbl3.receiveKbps then
        table.insert(
            tbl2,
            string.format("  Bandwidth             ↑ %.0f kB/s · ↓ %.0f kB/s", tbl3.sendKbps or 0, tbl3.receiveKbps or 0)
        )
    end

    if tbl3.congested ~= nil then
        table.insert(
            tbl2,
            "  Congestion limited    " .. (if tbl3.congested then format.colorTag(format.COLOR_RED, "<b>YES</b>") else "no")
        )
    end
end

local function locationText(tbl2, str2: string?)
    if tbl2 == nil then
        return "Connecting…"
    end

    if tbl2.localServer == true then
        return "LOCAL RCC" .. dim(" · this machine, region not applicable")
    end

    if not str2 then
        return format.escapeRich(string.format("unknown location (DC %s)", tostring(tbl2.dataCenterId or "?")))
    end

    local escapeRich = format.escapeRich

    if tbl2.popCode then
        str2 = string.upper(tbl2.popCode)
    end

    return escapeRich(str2)
end

return {
    render = function(tbl2, tbl3, tbl4, str2: string?): string
        local tbl5 = statsByRegion(tbl3)
        local var1 = if tbl2 == nil or tbl2.localServer or not tbl2.popCode then nil else regionOf(tbl2.popCode)
        local var2 = if var1 then tbl5[var1] else nil
        local bool1 = not (tbl2 == nil) and tbl2.localServer == true
        local tbl6 = {}
        table.insert(tbl6, dim("CONNECTED TO"))
        table.insert(tbl6, "<b>" .. locationText(tbl2, var1) .. "</b>")
        if tbl2 and tbl2.udmuxEndpoint then
            table.insert(tbl6, "  Edge (UDMUX)          " .. dim((format.escapeRich(tbl2.udmuxEndpoint))))
        end
        if tbl2 and tbl2.rccEndpoint then
            table.insert(tbl6, "  RCC                   " .. dim((format.escapeRich(tbl2.rccEndpoint))))
        end
        if tbl2 and tbl2.ipVersion then
            table.insert(tbl6, "  IP version            IPv" .. tostring(tbl2.ipVersion))
        end
        if str2 then
            table.insert(tbl6, "  Authority             " .. format.escapeRich(tbl1[str2] or str2))
        end

        local bool2 = addPingLines(tbl6, tbl4)

        table.insert(tbl6, "")
        table.insert(tbl6, dim("CONNECTION"))
        local str3 = "  RakPing               "
        local rakMs = tbl4.rakMs
        table.insert(
            tbl6,
            str3 .. (if rakMs == nil or rakMs < 0 then msText(nil) else format.colorTag(format.rttColor(rakMs), string.format("%.0f ms", rakMs)))
        )

        if not bool1 then
            addProbeLines(tbl6, tbl4, var2)
        end
        if not bool2 then
            local var3 = deltaText(tbl4.dataMs, tbl4.rakMs)
            if var3 then
                table.insert(tbl6, "  Replication overhead  " .. var3)
            end
        end

        local var3

        if bool1 then
            var3 = nil
        else
            local rakMs2 = tbl4.rakMs
            local medianMs = if var2 then var2.medianMs else nil
            var3 = deltaText(rakMs2, medianMs)
        end

        if var3 then
            table.insert(tbl6, "  RakPing vs probe      " .. var3)
        end
        addPeerLines(tbl6, tbl4)

        local tbl7 = alternatives(tbl5, var1)
        if #tbl7 > 0 then
            table.insert(tbl6, "")
            table.insert(tbl6, dim(if bool1 then "PoP REGIONS · probe only" else "OTHER REGIONS · probe only"))
            for _, value in tbl7 do
                local format2 = string.format
                local str4 = "  %-20s  %s%s"
                local var4 = format.escapeRich(value.region)
                local medianMs = value.medianMs
                table.insert(
                    tbl6,
                    format2(
                        str4,
                        var4,
                        if medianMs == nil or medianMs < 0 then msText(nil) else format.colorTag(format.rttColor(medianMs), string.format("%.0f ms", medianMs)),
                        (jitterText(value.jitterMs))
                    )
                )
            end
        end
        return table.concat(tbl6, "\n")
    end,
    peerStatsPlausible = function(num1: number?, num2: number?): boolean
        return not (num1 and (num1 < 0 or num1 > 1)) and not (num2 and (num2 < 0 or num2 > 1000000))
    end,
    statsByRegion = statsByRegion,
    currentRegion = function(tbl2)
        if tbl2 == nil or tbl2.localServer then
            return nil
        elseif tbl2.popCode then
            return regionOf(tbl2.popCode)
        end
        return nil
    end,
    recentProbe = function(tbl2, str2: string, num1: number)
        local num2 = 0
        local num3 = 0
        local num4 = 0
        local tbl3 = {}
        local silentPops = {}
        for _, value in tbl2 do
            if typeof(value.popCode) ~= "string" or regionOf(value.popCode) ~= str2 then
                continue
            end

            num4 += 1
            local var1 = format.committedHistory(value.history or {})
            local tbl5 = {}
            local num5 = #var1 - num1 + 1

            for i = math.max(1, num5), #var1 do
                table.insert(tbl5, var1[i])
            end
            local tbl6 = {}
            for _, value2 in tbl5 do
                if value2 >= 0 then
                    table.insert(tbl6, value2)
                end
            end
            if num1 <= #tbl5 and #tbl6 == 0 then
                table.insert(silentPops, value.popCode)
            else
                num2 += #tbl5
                num3 += #tbl5 - #tbl6
                for _, value2 in tbl6 do
                    table.insert(tbl3, value2)
                end
            end
        end

        return {
            loss = if num2 > 0 then num3 / num2 else nil,
            medianMs = format.historyMedian(tbl3),
            silentPops = silentPops,
            allSilent = num4 > 0 and #silentPops == num4
        }
    end
}
