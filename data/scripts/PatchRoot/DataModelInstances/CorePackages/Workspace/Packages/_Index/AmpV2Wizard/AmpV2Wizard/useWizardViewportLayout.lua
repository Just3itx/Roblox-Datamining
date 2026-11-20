-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:50:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local React = require(scriptParentParent.React)
local Responsive = require(scriptParentParent.Responsive)
local getWizardViewportLayout = require(scriptParent.getWizardViewportLayout)

local function useWizardViewportLayout()
    local var1 = Responsive.useDeviceInsets()
    local var2, var3 = React.useState(nil)
    local var4 = React.useCallback(function(arg1)
        if arg1 == nil then
            return
        end
        local rect = Rect.new(arg1.AbsolutePosition, arg1.AbsolutePosition + arg1.AbsoluteSize)
        var3(function(rect2: Rect?): Rect? | Rect
            return if rect2 == rect then rect2 else rect
        end)
    end, {})

    local var5 = Responsive.HardwareSafeAreaInsets.fullscreenGui()
    local rect = Rect.new(var5.AbsolutePosition, var5.AbsolutePosition + var5.AbsoluteSize)

    return if var2 and var2.Width > 0 and var2.Height > 0 then getWizardViewportLayout(var2, rect, var1) else nil, var4
end

return useWizardViewportLayout
