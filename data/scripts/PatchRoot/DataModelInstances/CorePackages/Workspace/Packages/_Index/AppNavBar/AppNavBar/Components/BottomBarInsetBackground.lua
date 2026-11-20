-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T22:50:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local React = require(scriptParentParentParent.React)
local Foundation = require(scriptParentParentParent.Foundation)

local VisibilityControl = require(scriptParentParent.VisibilityControl)
local getScrollAwayEnabled = require(scriptParentParent.getScrollAwayEnabled)

local useTokens = Foundation.Hooks.useTokens

return React.memo(function(tbl1) -- name: BottomBarInsetBackground
    local var1 = useTokens()
    local color3 = var1.Color.Common.NavigationBar.Color3
    local navigationBarTransparency = var1.Color.Common.NavigationBar.Transparency
    local color3_2 = var1.Color.Surface.Surface_0.Color3
    local surface0Transparency = var1.Color.Surface.Surface_0.Transparency

    local backgroundColor3, var3 = React.useBinding(color3)
    local backgroundTransparency, var5 = React.useBinding(navigationBarTransparency)

    React.useEffect(function()
        local function update(num1: number) -- Luacid: Inlined by compiler; 2 call sites recovered
            local num2 = 1 - num1
            var3(color3:Lerp(color3_2, num2))
            var5(navigationBarTransparency + (surface0Transparency - navigationBarTransparency) * num2)
        end

        if not getScrollAwayEnabled() then
            update(if tbl1.isVisible then 1 else 0)
            return nil
        end

        local footerBinding = VisibilityControl.getFooterBinding()
        local var6 = React.__subscribeToBinding(footerBinding, update)
        update((footerBinding:getValue()))
        return var6
    end, {
        tbl1.isVisible,
        color3,
        navigationBarTransparency,
        color3_2,
        surface0Transparency
    })
    return React.createElement("Frame", {
        AnchorPoint = tbl1.AnchorPoint,
        Position = tbl1.Position,
        Size = tbl1.Size,
        BorderSizePixel = 0,
        BackgroundColor3 = backgroundColor3,
        BackgroundTransparency = backgroundTransparency,
        Active = true,
        ZIndex = 0
    })
end)
