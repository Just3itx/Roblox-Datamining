-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:20:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatformParent = script:FindFirstAncestor("ProfilePlatform").Parent

local React = require(ProfilePlatformParent.React)
local useNavigation = require(ProfilePlatformParent.Navigation).useNavigation

local RecentActivityInspectAndBuyView = require(script.Parent.RecentActivityInspectAndBuyView)
local useRecentActivityInspectAndBuyViewModel = require(script.Parent.useRecentActivityInspectAndBuyViewModel)

local tbl1 = {}

local function RecentActivityInspectAndBuyContainer()
    local var1 = useNavigation()

    local onClose = React.useCallback(function()
        var1.goBack()
    end, { var1 })

    local assetIds = var1.getParam("assetIds") or tbl1

    local var4 = useRecentActivityInspectAndBuyViewModel({ assetIds = assetIds, onClose = onClose })

    return React.createElement(RecentActivityInspectAndBuyView, var4)
end

return RecentActivityInspectAndBuyContainer
