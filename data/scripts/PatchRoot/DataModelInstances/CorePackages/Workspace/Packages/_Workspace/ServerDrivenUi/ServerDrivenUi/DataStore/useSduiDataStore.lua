-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:31:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUi = script:FindFirstAncestor("ServerDrivenUi")

local ServerDrivenUiParent = ServerDrivenUi.Parent
local React = require(ServerDrivenUiParent.React)

local _SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)

local useSduiSocialData = require(ServerDrivenUi.DataStore.useSduiSocialData)

local function useSduiDataStore()
    local social = useSduiSocialData()

    return React.useMemo(function()
        return { social = social }
    end, { social })
end

return useSduiDataStore
