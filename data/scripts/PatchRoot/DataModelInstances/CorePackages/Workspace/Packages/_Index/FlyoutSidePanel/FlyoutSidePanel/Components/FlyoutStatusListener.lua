-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:40:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FlyoutSidePanelParent = script:FindFirstAncestor("FlyoutSidePanel").Parent
local React = require(FlyoutSidePanelParent.React)

local useDrawerVisible = require(FlyoutSidePanelParent.Drawer).Hooks.useDrawerVisible

local function FlyoutStatusListener(tbl1)
    local var1 = useDrawerVisible()
    React.useEffect(function()
        if tbl1.onVisibleChanged then
            tbl1.onVisibleChanged(var1)
        end
    end, { var1, tbl1.onVisibleChanged })

    return nil
end

return FlyoutStatusListener
