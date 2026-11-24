-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:01:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")

local _Types = require(InExperienceShop.Types)

local function parseRedeemedEndTime(endTime) -- Luacid: Inlined by compiler; 1 call site recovered
    if typeof(endTime) ~= "string" then
        return nil
    end
    return DateTime.fromIsoDate(endTime)
end

local function clearPass(tbl1: {active: {[any]: any}, available: {[any]: any}, redeemed: {[any]: any}}, str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    tbl1.available[str1] = nil
    tbl1.active[str1] = nil
    tbl1.redeemed[str1] = nil
end

local function parseGamePassTrialAvailabilities(tbl1)
    local tbl2 = {
        available = {},
        active = {},
        redeemed = {}
    }

    for _, value in tbl1 do
        if typeof(value) ~= "table" or value.gamePassId == nil then
            continue
        end

        local gamePassId = tostring(value.gamePassId)
        local status = value.status
        if status ~= "Available" and status ~= "Active" and status ~= "Redeemed" then
            continue
        end

        clearPass(tbl2, gamePassId)

        if status == "Available" then
            tbl2.available[gamePassId] = true
        elseif status == "Active" then
            tbl2.active[gamePassId] = true
        else
            local redeemed = tbl2.redeemed
            redeemed[gamePassId] = {
                gamePassId = gamePassId,
                endTime = parseRedeemedEndTime(value.endTime)
            }
        end
    end
    return tbl2
end

return parseGamePassTrialAvailabilities
