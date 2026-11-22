-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:40:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local AppNavBar = require(MomentsParent.AppNavBar)

local function createNavBarChromeAdapter(tbl1)
    local tbl2 = tbl1 or {}

    local var1 = tbl2.visibilityControl or AppNavBar.VisibilityControl
    local isEnabled = (tbl2.isScrollAwayEnabled or AppNavBar.getScrollAwayEnabled)()

    return {
        isEnabled = isEnabled,
        setVisible = function(bool1: boolean)
            if not isEnabled then
                return
            end

            if bool1 then
                var1.show()
            else
                var1.hide()
            end
        end,
        dispose = function()
            if not isEnabled then
                return
            end
            var1.show()
        end
    }
end
return createNavBarChromeAdapter
