-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T12:01:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedUtilitiesParent = script:FindFirstAncestor("SduiSharedUtilities").Parent

local React = require(SduiSharedUtilitiesParent.React)
local useDeviceInsets = require(SduiSharedUtilitiesParent.Responsive).useDeviceInsets

local AppNavBar = require(SduiSharedUtilitiesParent.AppNavBar)
local VisibilityControl = AppNavBar.VisibilityControl
local getScrollAwayEnabled = AppNavBar.getScrollAwayEnabled

local function useScrollAwayHeaderPosition(tbl1)
    local headerHeightBinding = tbl1.headerHeightBinding
    local scrollAwayEnabled

    if tbl1.enabled == true then
        scrollAwayEnabled = getScrollAwayEnabled()

        if scrollAwayEnabled then
            if tbl1.scrollAwayHeight == nil then
                scrollAwayEnabled = false
            else
                scrollAwayEnabled = tbl1.scrollAwayHeight > 0
            end
        end
    else
        scrollAwayEnabled = false
    end

    local top = useDeviceInsets().top
    return React.useMemo(function()
        if not (scrollAwayEnabled and tbl1.scrollAwayHeight) then
            return UDim2.fromOffset(0, 0)
        end
        local scrollAwayHeight = tbl1.scrollAwayHeight

        local var1 = not (top > 0 and top < scrollAwayHeight) and -math.huge or top - scrollAwayHeight

        local var2 = if headerHeightBinding ~= nil then headerHeightBinding else VisibilityControl.getHeaderBinding():map(function(num1: number)
            return num1 * scrollAwayHeight
        end)
        return var2:map(function(num1: number)
            return UDim2.new(0, 0, 0, math.max(num1 - scrollAwayHeight, var1))
        end)
    end, {
        scrollAwayEnabled,
        tbl1.scrollAwayHeight,
        top,
        headerHeightBinding
    })
end
return useScrollAwayHeaderPosition
