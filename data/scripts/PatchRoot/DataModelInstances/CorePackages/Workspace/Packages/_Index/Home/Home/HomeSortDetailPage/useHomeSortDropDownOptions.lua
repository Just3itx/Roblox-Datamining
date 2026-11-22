-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T00:30:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Home = script:FindFirstAncestor("Home")
local HomeParent = Home.Parent

local React = require(HomeParent.React)
local SduiSharedUtilities = require(HomeParent.SduiSharedUtilities)

local buildHomeSortDropDownOptions = require(Home.HomeSortDetailPage.buildHomeSortDropDownOptions)
local HomeConstants = require(Home.HomeConstants)

local function useHomeSortDropDownOptions()
    local var1 = SduiSharedUtilities.useInputData(HomeConstants.ConfigKey, HomeConstants.ContentIdentifier)
    return React.useMemo(function()
        return buildHomeSortDropDownOptions(var1)
    end, { var1 })
end

return useHomeSortDropDownOptions
