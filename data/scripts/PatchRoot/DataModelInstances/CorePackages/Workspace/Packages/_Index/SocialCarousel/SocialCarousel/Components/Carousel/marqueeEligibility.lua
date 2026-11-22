-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T18:00:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCarousel = script:FindFirstAncestor("SocialCarousel")
local SocialCarouselParent = SocialCarousel.Parent

local SocialCommon = require(SocialCarouselParent.SocialCommon)

local Enums = require(SocialCarousel.Common.Enums)
local tileVisibility = require(script.Parent.tileVisibility)

local PresenceTypes = SocialCommon.Enums.PresenceTypes
local Tile = Enums.Tile

local function loopKey(str1: string, str2: string): string -- Luacid: Inlined by compiler; 3 call sites recovered
    return str1 .. "\0" .. str2
end

local function loopsLeft(id: string, str1: string, loopsRemaining) -- Luacid: Inlined by compiler; 1 call site recovered
    if loopsRemaining == nil then
        return 2
    end

    local var1 = loopsRemaining[loopKey(id, str1)]

    return if var1 == nil then 2 else var1
end

local function storedLoopKeys(tbl1, str1: string)
    local str2 = str1 .. "\0"
    local result = {}
    for value in tbl1 do
        local num1 = #str2

        if string.sub(value, 1, num1) == str2 then
            table.insert(result, value)
        end
    end
    return result
end

local function reconcileFriendPresence(tbl1, str1: string, str2: string?)
    local tbl2 = storedLoopKeys(tbl1, str1)
    if str2 == nil or str2 == "" then
        for _, value in tbl2 do
            tbl1[value] = nil
        end
        return
    end

    local str3 = loopKey(str1, str2)
    local bool1 = tbl1[str3] ~= nil
    for _, value in tbl2 do
        if value ~= str3 then
            tbl1[value] = nil
        end
    end
    if not bool1 then
        tbl1[str3] = 2
    end
end

local function inGameLocation(tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    if tbl1.tileType ~= Tile.Friend then
        return nil
    end
    local presence = tbl1.presence
    if presence == nil or presence.userPresenceType ~= PresenceTypes.InGame then
        return nil
    end
    local lastLocation = presence.lastLocation
    return if lastLocation == nil or lastLocation == "" then nil else lastLocation
end

local function friendIdFromLoopKey(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = string.find(str1, "\0", 1, true)
    if var1 == nil then
        return nil
    end
    return string.sub(str1, 1, var1 - 1)
end

local function isHoverEligible(tbl1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    if tbl1.tileType ~= Tile.Friend then
        return false
    end

    local presence = tbl1.presence
    if presence == nil or presence.userPresenceType ~= PresenceTypes.InGame then
        return false
    end

    local lastLocation = presence.lastLocation
    return lastLocation ~= nil and lastLocation ~= "" and tbl1.subtitle == lastLocation
end

local function isEligible(tbl1, num1: number, tbl2)
    if not isHoverEligible(tbl1) then
        return false
    end

    local presence = tbl1.presence
    local lastLocation = if presence == nil then nil else presence.lastLocation

    if lastLocation == nil or loopsLeft(tbl1.id, lastLocation, tbl2.loopsRemaining) <= 0 then
        return false
    end

    return tileVisibility.isAtLeast70PercentVisible(num1, tbl2.canvasX, tbl2.containerWidth, tbl2.tileWidth, tbl2.gap)
end

local function scanRow(tbl1, tbl2, id: string?)
    local tbl3 = {}
    local var1 = nil
    if tbl2.interacting or tbl2.reducedMotion then
        return tbl3, nil
    end

    for i, value in ipairs(tbl1) do
        if id ~= nil and var1 == nil and value.id == id then
            var1 = i
        end

        if isEligible(value, i, tbl2) then
            table.insert(tbl3, i)
        end
    end
    return tbl3, var1
end

local function leadingIndex(tbl1, textDirection) -- Luacid: Inlined by compiler; 3 call sites recovered
    local num1 = #tbl1

    if num1 == 0 then
        return nil
    end

    if textDirection == Enum.TextDirection.RightToLeft then
        return tbl1[num1]
    end

    return tbl1[1]
end

local function nextIndex(tbl1, num1: number?, textDirection)
    local num2 = #tbl1
    if num2 == 0 then
        return nil
    elseif num1 == nil then
        return leadingIndex(tbl1, textDirection)
    elseif textDirection == Enum.TextDirection.RightToLeft then
        for i = num2, 1, -1 do
            local var1 = tbl1[i]
            if var1 < num1 then
                return var1
            end
        end
        return tbl1[num2]
    else
        for _, value in ipairs(tbl1) do
            if num1 < value then
                return value
            end
        end
        return tbl1[1]
    end
end

local function leadingEligible(tbl1, tbl2) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = leadingIndex(scanRow(tbl1, tbl2, nil), tbl2.direction)

    return if var1 == nil then nil else tbl1[var1].id
end

return {
    DEFAULT_LOOPS = 2,
    loopKey = loopKey,
    recordFinishedLoop = function(tbl1, str1: string, str2: string)
        local str3 = loopKey(str1, str2)
        local var1 = tbl1[str3]
        tbl1[str3] = (if var1 == nil then 2 else var1) - 1
    end,
    reconcileFriendPresence = reconcileFriendPresence,
    reconcilePresence = function(tbl1, tbl2)
        local tbl3 = {}
        for _, value in ipairs(tbl2) do
            if value.tileType == Tile.Friend then
                tbl3[value.id] = true
                reconcileFriendPresence(tbl1, value.id, (inGameLocation(value)))
            end
        end

        local tbl4 = {}
        for value in tbl1 do
            local var1 = friendIdFromLoopKey(value)

            if var1 ~= nil and tbl3[var1] ~= true then
                table.insert(tbl4, value)
            end
        end
        for _, value in tbl4 do
            tbl1[value] = nil
        end
    end,
    isHoverEligible = isHoverEligible,
    leadingEligible = leadingEligible,
    resolveActiveTileId = function(tbl1, tbl2, id: string?)
        if id ~= nil then
            local tbl3, var1 = scanRow(tbl1, tbl2, id)
            if var1 ~= nil and table.find(tbl3, var1) ~= nil then
                return id
            end
        end

        return leadingEligible(tbl1, tbl2)
    end,
    nextEligibleAfter = function(tbl1, id: string, tbl2)
        local tbl3, var1 = scanRow(tbl1, tbl2, id)
        local var2 = nextIndex(tbl3, var1, tbl2.direction)

        return if var2 == nil then nil else tbl1[var2].id
    end
}
