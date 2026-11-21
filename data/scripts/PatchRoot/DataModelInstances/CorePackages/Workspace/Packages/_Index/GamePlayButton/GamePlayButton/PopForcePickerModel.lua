-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T20:51:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = {
    AMS = "Amsterdam",
    ATL = "Atlanta",
    BOM = "Mumbai",
    CDG = "Paris",
    DFW = "Dallas",
    FRA = "Frankfurt",
    GRU = "São Paulo",
    HKG = "Hong Kong",
    IAD = "Washington, DC",
    ICN = "Seoul",
    LAX = "Los Angeles",
    LHR = "London",
    NRT = "Tokyo",
    ORD = "Chicago",
    SEA = "Seattle",
    SFO = "San Francisco",
    SIN = "Singapore",
    SJC = "San Jose",
    SYD = "Sydney"
}

local function isReachablePing(arg1): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return type(arg1) == "number" and arg1 >= 0 and arg1 < math.huge
end

local function getDisplayCode(str1: string): string -- Luacid: Inlined by compiler; 1 call site recovered
    return string.upper(str1)
end

return {
    buildRoster = function(tbl2, popCode: string)
        local tbl3 = ({})
        local roster = {}
        for _, value in ipairs(tbl2) do
            local popCode2 = value.popCode
            if type(popCode2) ~= "string" or popCode2 == "" then
                continue
            end

            local var1 = tbl3[popCode2]
            local var2 = var1 or { popCode = popCode2 }
            if not var1 then
                tbl3[popCode2] = var2
                table.insert(roster, var2)
            end
            local rttMs = value.rttMs

            if isReachablePing(rttMs) and (var2.rttMs == nil or rttMs < var2.rttMs) then
                var2.rttMs = rttMs
            end
        end

        if popCode ~= "" and tbl3[popCode] == nil then
            table.insert(roster, { popCode = popCode })
        end

        table.sort(roster, function(arg1, arg2): boolean
            if arg1.rttMs ~= nil and arg2.rttMs ~= nil then
                if arg1.rttMs == arg2.rttMs then
                    return arg1.popCode < arg2.popCode
                end

                return arg1.rttMs < arg2.rttMs
            end

            if arg1.rttMs == nil then
                if arg2.rttMs == nil then
                    return arg1.popCode < arg2.popCode
                end

                return false
            end

            return true
        end)

        return roster
    end,
    getDisplayCode = getDisplayCode,
    getLocationName = function(str1: string)
        local displayCode = getDisplayCode(str1)

        local var1 = string.match(displayCode, "^([A-Z][A-Z][A-Z])%d*$")
        return if var1 then tbl1[var1] or displayCode else displayCode
    end,
    formatPing = function(num1: number?)
        if num1 == nil or not isReachablePing(num1) then
            return "Ping unavailable"
        end

        return string.format("%.0f ms", math.floor(num1 + 0.5))
    end,
    getVisibleRoster = function(tbl2, popCode: string, bool1: boolean)
        if bool1 then
            return table.clone(tbl2)
        end

        local visibleRoster = {}
        for i, value in ipairs(tbl2) do
            if i <= 5 or value.popCode == popCode then
                table.insert(visibleRoster, value)
            end
        end
        return visibleRoster
    end
}
