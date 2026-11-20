-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:50:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local FoundationParent = Foundation.Parent

local Dash = require(FoundationParent.Dash)
local React = require(FoundationParent.React)

local _Types = require(Foundation.Components.Types)
local blendColors = require(Foundation.Utility.blendColors)
local getOriginalBackgroundStyle = require(script.Parent.getOriginalBackgroundStyle)
local getStateLayerStyle = require(script.Parent.getStateLayerStyle)
local joinBindables = require(Foundation.Utility.joinBindables)
local mapBindable = require(Foundation.Utility.mapBindable)
local useCursor = require(Foundation.Providers.Cursor.useCursor)
local useGuiControlState = require(Foundation.Utility.Control.useGuiControlState)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withDefaults = require(Foundation.Utility.withDefaults)

local StateLayerAffordance = require(Foundation.Enums.StateLayerAffordance)

local _StateLayerMode = require(Foundation.Enums.StateLayerMode)

local ControlState = require(Foundation.Enums.ControlState)

local tbl1 = { component = "ImageButton", isDisabled = false }

local mediumStoneGrey = Color3.fromRGB(163, 162, 165)

return React.memo(React.forwardRef(function(arg1, arg2) -- name: Interactable
    local var1 = withDefaults(arg1, tbl1)
    local var2 = React.useRef(nil)
    local var3 = useTokens()
    local var4 = useCursor(var1.cursor)
    local controlState, var6 = React.useBinding(ControlState.Initialize)
    local var7 = React.useRef(nil)

    local var8 = React.useCallback(function(arg3)
        if controlState:getValue() == ControlState.Default and var2.current ~= nil then
            local color3 = var2.current:GetStyled("BackgroundColor3")
            local styled2 = var2.current:GetStyled("BackgroundTransparency")
            if color3 ~= mediumStoneGrey or styled2 ~= 0 then
                var7.current = { Color3 = color3, Transparency = styled2 }
            end
        end

        var6(arg3)
        if var1.onStateChanged ~= nil then
            var1.onStateChanged(arg3)
        end
    end, { var1.onStateChanged })

    local backgroundStyle = React.useMemo(function()
        return getOriginalBackgroundStyle(var1.BackgroundColor3, var1.BackgroundTransparency)
    end, { var1.BackgroundColor3, var1.BackgroundTransparency })

    local var10 = React.useCallback(function(arg3, arg4, arg5, none)
        if arg3 == ControlState.Initialize
            or arg3 == ControlState.Default
            or arg3 == ControlState.Disabled
            or none == StateLayerAffordance.None
        then
            return arg4
        end

        local tbl2 = {
            Color3 = arg4.Color3,
            Transparency = arg4.Transparency
        }

        if arg4.Color3 == nil then
            tbl2.Color3 = if var7.current then var7.current.Color3 else nil
        end

        if arg4.Transparency == nil then
            tbl2.Transparency = if var7.current then var7.current.Transparency else nil
        end

        local stateLayerStyle = getStateLayerStyle(var3, arg5, arg3)

        return blendColors(tbl2, stateLayerStyle)
    end, { var3, var1.BackgroundColor3, var1.BackgroundTransparency })

    local useMemo = React.useMemo
    local function func1()
        local var11 = joinBindables
        local tbl2 = {
            controlState = controlState,
            backgroundStyle = backgroundStyle,
            mode = if var1.stateLayer then var1.stateLayer.mode else nil,
            affordance = if var1.stateLayer then var1.stateLayer.affordance else nil
        }

        return var11(tbl2, function(arg3)
            return var10(arg3.controlState, arg3.backgroundStyle, arg3.mode, arg3.affordance)
        end)
    end

    local mode = if var1.stateLayer then var1.stateLayer.mode else nil
    local affordance = if var1.stateLayer then var1.stateLayer.affordance else nil
    local var11 = useMemo(func1, { backgroundStyle, controlState, var10, mode, affordance })

    local ref = useGuiControlState(var2, var8)

    React.useImperativeHandle(arg2, function()
        return var2.current
    end, {})

    local tbl2 = {
        BackgroundColor3 = mapBindable(var11, function(arg3)
            return arg3.Color3
        end),
        BackgroundTransparency = mapBindable(var11, function(arg3)
            return arg3.Transparency
        end),
        Active = not var1.isDisabled,
        Interactable = not var1.isDisabled,
        [React.Event.Activated] = if var1.isDisabled then nil else var1.onActivated,
        [React.Event.SecondaryActivated] = if var1.isDisabled then nil else var1.onSecondaryActivated,
        ref = ref,
        SelectionImageObject = var1.SelectionImageObject or var4
    }
    local var13 = Dash.union(var1, tbl2)

    var13.component = nil
    var13.isDisabled = nil
    var13.onActivated = nil
    var13.onSecondaryActivated = nil
    var13.onStateChanged = nil
    var13.stateLayer = nil
    var13.cursor = nil

    return React.createElement(var1.component, var13)
end))
