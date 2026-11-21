-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:50:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FlyoutSidePanel = script:FindFirstAncestor("FlyoutSidePanel")
local FlyoutSidePanelParent = FlyoutSidePanel.Parent

local React = require(FlyoutSidePanelParent.React)
local useDrawerVisible = require(FlyoutSidePanelParent.Drawer).Hooks.useDrawerVisible
local FStringFlyoutProfileEntryIxpLayer = require(FlyoutSidePanel.Flags.FStringFlyoutProfileEntryIxpLayer)

local IXPService = game:GetService("IXPService")

local function useFlyoutProfileEntryExposureLogging(arg1)
    local var1 = useDrawerVisible()
    React.useEffect(function()
        if var1 then
            (arg1 or IXPService):LogFlagLinkedUserLayerExposure(FStringFlyoutProfileEntryIxpLayer)
        end
    end, { var1, arg1 })
end

return useFlyoutProfileEntryExposureLogging
