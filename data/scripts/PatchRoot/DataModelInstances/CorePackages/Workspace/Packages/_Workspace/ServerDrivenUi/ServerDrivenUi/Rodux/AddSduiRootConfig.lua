-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:40:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent
local makeActionCreator = require(ServerDrivenUiParent.Rodux).makeActionCreator

local _SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)

return makeActionCreator(script.Name, function(page: string, rootConfig, dataUpdatedTimestamp: number, expectedSduiFeedItems, customFeedStoreKey: string?)
    return {
        page = page,
        rootConfig = rootConfig,
        dataUpdatedTimestamp = dataUpdatedTimestamp,
        expectedSduiFeedItems = expectedSduiFeedItems,
        customFeedStoreKey = customFeedStoreKey
    }
end)
