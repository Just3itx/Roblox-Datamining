-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T06:41:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local DisplacedBehavior = require(Foundation.Providers.ScreenRegion.DisplacedBehavior)
local RegionOrder = require(Foundation.Providers.ScreenRegion.RegionOrder)
local _ScreenRegionKind = require(Foundation.Providers.ScreenRegion.ScreenRegionKind)
local _regionPolicies = require(Foundation.Providers.ScreenRegion.regionPolicies)

local function ranksAbove(tbl1, tbl2, arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if arg1.order == RegionOrder.Priority then
        local priority = tbl1.priority or 0
        local priority2 = tbl2.priority or 0
        if priority ~= priority2 then
            return priority2 < priority
        end
    end
    local claimedAt = tbl1.claimedAt or 0
    local claimedAt2 = tbl2.claimedAt or 0

    if claimedAt == claimedAt2 then
        return tbl1.id > tbl2.id
    end

    return claimedAt2 < claimedAt
end

local function resolveRegion(tbl1, arg1)
    local tbl2 = {}
    for _, value in tbl1 do
        if value.isOpen and not value.isDismissed then
            table.insert(tbl2, value)
        end
    end
    table.sort(tbl2, function(arg2, arg3): boolean
        return ranksAbove(arg2, arg3, arg1)
    end)

    local tbl3 = {}
    local dismissed = {}
    local num1 = 0
    local tbl5 = {}
    for _, value in tbl2 do
        local var1 = if arg1.capacityPerKind then arg1.capacityPerKind[value.kind] else nil
        local var2 = tbl5[value.kind] or 0
        if num1 < arg1.capacity and (var1 == nil or var2 < var1) then
            tbl3[value.id] = value
            num1 += 1
            tbl5[value.kind] = var2 + 1
        elseif arg1.displaced[value.kind] == DisplacedBehavior.Dismiss then
            dismissed[value.id] = true
        end
    end

    local visible = ({})
    for value, value2 in tbl3 do
        local bool1 = false

        if arg1.sequential and not value2.isMounted then
            for _, value3 in tbl1 do
                if value3.isMounted and tbl3[value3.id] == nil then
                    bool1 = true
                    break
                end
            end
        end

        visible[value] = not bool1
    end

    return { visible = visible, dismissed = dismissed }
end

return resolveRegion
