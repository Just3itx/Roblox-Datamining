-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:20:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommonParent = script:FindFirstAncestor("AvatarExperienceCommon").Parent
local React = require(AvatarExperienceCommonParent.React)
local Foundation = require(AvatarExperienceCommonParent.Foundation)
local useTokens = Foundation.Hooks.useTokens

local stateLayer = {
    affordance = Foundation.Enums.StateLayerAffordance.None
}

local function getHoverTransparency(arg1): number
    return if arg1 then 0 else 0.2
end

local function useHoverBinding()
    local var1, var2 = React.useBinding(false)

    return var1, (React.useCallback(function(arg1)
        if arg1 == Foundation.Enums.ControlState.Default then
            var2(false)
        elseif arg1 == Foundation.Enums.ControlState.Hover then
            var2(true)
        end
    end, {}))
end

return React.forwardRef(function(tbl2, ref) -- name: ContextualActionButton
    local var1 = useTokens()

    local var2, var3 = useHoverBinding()

    local var4 = React.useCallback(function(arg1)
        if arg1 then
            return var1.Color.Shift.Shift_200
        end

        if tbl2.isActive then
            return var1.Color.Shift.Shift_400
        end

        return {
            Color3 = var1.Color.Shift.Shift_200.Color3,
            Transparency = 1
        }
    end, { tbl2.isActive, var1 })

    local createElement = React.createElement
    local view = Foundation.View
    local tbl3 = {
        ref = ref,
        backgroundStyle = var1.Color.OverMedia.OverMedia_0,
        LayoutOrder = tbl2.LayoutOrder,
        stateLayer = stateLayer,
        onStateChanged = 0,
        onActivated = 0,
        disabled = 0,
        selection = 0,
        tag = "radius-circle clip auto-xy"
    }

    if tbl2.disabled then
        var3 = nil
    end

    tbl3.onStateChanged = var3
    tbl3.onActivated = tbl2.onActivated
    tbl3.disabled = tbl2.disabled
    tbl3.selection = {
        Selectable = tbl2.Selectable or false
    }
    local tbl4 = {
        HoverHandler = React.createElement(
            Foundation.View,
            {
                Size = if tbl2.size then UDim2.new(tbl2.size, tbl2.size) else UDim2.fromScale(1, 1),
                GroupTransparency = tbl2.GroupTransparencyOverwrite or var2:map(getHoverTransparency),
                backgroundStyle = var2:map(var4),
                tag = "padding-small radius-circle clip auto-xy"
            },
            {
                Children = React.createElement(React.Fragment, nil, tbl2.children)
            }
        )
    }
    return createElement(view, tbl3, tbl4)
end)
