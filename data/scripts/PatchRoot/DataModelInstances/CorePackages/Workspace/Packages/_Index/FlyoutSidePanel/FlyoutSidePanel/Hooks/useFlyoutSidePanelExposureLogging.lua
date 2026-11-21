-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:50:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local IXPService = game:GetService("IXPService")

local FlyoutSidePanelParent = script:FindFirstAncestor("FlyoutSidePanel").Parent

local React = require(FlyoutSidePanelParent.React)
local useDrawerVisible = require(FlyoutSidePanelParent.Drawer).Hooks.useDrawerVisible

local str1 = game:DefineFastString("FlyoutSidePanelIxpLayer", "Universality.MorePage.Exposure")

local function useFlyoutSidePanelExposureLogging(arg1)
    local var1 = useDrawerVisible()
    React.useEffect(function()
        if var1 and str1 ~= "" then
            local var2 = if arg1 == nil then IXPService else arg1
            var2:LogFlagLinkedUserLayerExposure(str1)
        end
    end, { var1, arg1 })
end

return useFlyoutSidePanelExposureLogging
