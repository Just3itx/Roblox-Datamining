-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:51:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedUtilities = script:FindFirstAncestor("SduiSharedUtilities")
local SduiSharedUtilitiesParent = SduiSharedUtilities.Parent
local DataHydration = require(SduiSharedUtilitiesParent.DataHydration)
local _SduiIntegrationTypes = require(SduiSharedUtilities.SduiIntegrationTypes)

local function collectUniverseIds(arg1, tbl1)
    if type(arg1) ~= "table" then
        return
    end
    for value, value2 in arg1 do
        if value == "universe_id" and (type(value2) == "string" or type(value2) == "number") then
            tbl1[tostring(value2)] = true
        elseif type(value2) == "table" then
            collectUniverseIds(value2, tbl1)
        end
    end
end

local function prewarmIcons(tbl1, arg1)
    local tbl2 = {}
    for _, value in tbl1 do
        collectUniverseIds(value, tbl2)
    end

    local tbl3 = {}
    for value in tbl2 do
        table.insert(tbl3, value)
    end
    if #tbl3 > 0 then
        DataHydration.Game.getGameIconStore(false).getAndFetchGameIcons(tbl3, arg1)
    end
end

return {
    collectUniverseIds = collectUniverseIds,
    prewarmSmallIcons = function(tbl1)
        prewarmIcons(tbl1, DataHydration.Game.GameIconSize.Small)
    end,
    prewarmLargeIcons = function(tbl1)
        prewarmIcons(tbl1, DataHydration.Game.GameIconSize.Large)
    end
}
