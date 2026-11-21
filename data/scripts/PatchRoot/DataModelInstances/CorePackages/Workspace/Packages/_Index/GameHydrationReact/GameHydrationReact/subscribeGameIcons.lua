-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T18:50:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameHydrationReactParent = script:FindFirstAncestor("GameHydrationReact").Parent

local Signals = require(GameHydrationReactParent.Signals)
local DataHydration = require(GameHydrationReactParent.DataHydration)

local function toIds(tbl1)
    local result = {}
    if tbl1 == nil then
        return result
    end
    local tbl2 = ({})
    for _, value in tbl1 do
        local str1 = tostring(value)
        if not tbl2[str1] then
            tbl2[str1] = true
            table.insert(result, str1)
        end
    end
    return result
end

local function sameIds(tbl1, tbl2)
    if #tbl1 ~= #tbl2 then
        return false
    end
    local tbl3 = ({})
    for _, value in tbl1 do
        tbl3[value] = true
    end
    for _, value in tbl2 do
        if not tbl3[value] then
            return false
        end
    end
    return true
end

local function subscribeGameIcons(tbl1)
    local gameIconStore = DataHydration.Game.getGameIconStore(false)

    local var1, var2 = Signals.createSignal(toIds(tbl1.universeIds), sameIds)
    local getCurrent = {}

    local bool1 = true
    local dispose = Signals.createEffect(function(arg1)
        local var3 = var1(arg1)
        local tbl3 = ({})
        if #var3 > 0 then
            for value, value2 in (gameIconStore.getGameIcons(var3, tbl1.size)) do
                local var4 = value2.data(arg1)
                if var4 ~= nil then
                    tbl3[value] = var4
                end
            end
        end
        getCurrent = tbl3

        if bool1 then
            bool1 = false
            return
        end
        tbl1.onChange(tbl3)
    end)

    return {
        getCurrent = function()
            return getCurrent
        end,
        update = function(arg1)
            var2((toIds(arg1)))
        end,
        dispose = dispose
    }
end

return subscribeGameIcons
