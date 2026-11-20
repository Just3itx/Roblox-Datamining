-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:20:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)
local Cryo = require(scriptParentParentParentParent.Cryo)

local useStyle = require(scriptParentParent.Style.useStyle)
local useCursor = require(scriptParentParentParent.App.SelectionCursor.useCursor)
local Interactable = require(scriptParent.Interactable)
local ControlState = require(scriptParent.Enum.ControlState)

local tbl1 = {
    anchorPoint = Vector2.new(0.5, 0.5),
    position = UDim2.fromScale(0.5, 0.5),
    size = UDim2.fromScale(1, 1),
    isDisabled = false,
    selectable = true,
    affordance = "Background",
    stateStyle = "Standard",
    outset = {
        top = UDim.new(0, 0),
        right = UDim.new(0, 0),
        bottom = UDim.new(0, 0),
        left = UDim.new(0, 0)
    }
}

local var1 = ControlState.Initialize.rawValue()

local tbl2 = {
    [ControlState.Initialize.rawValue()] = "Idle",
    [ControlState.Default.rawValue()] = "Idle",
    [ControlState.Pressed.rawValue()] = "Press",
    [ControlState.Hover.rawValue()] = "Hover",
    [ControlState.Selected.rawValue()] = "Idle",
    [ControlState.SelectedPressed.rawValue()] = "Press",
    [ControlState.Disabled.rawValue()] = "Idle"
}

local function getStateTokens(tokens, str1: string) -- Luacid: Inlined by compiler; 3 call sites recovered
    if str1 == "Standard" then
        return tokens.Color.State
    elseif str1 == "Inverse" then
        return tokens.Inverse.State
    elseif str1 == "Lighten" then
        return tokens.DarkMode.State
    end

    return tokens.LightMode.State
end

local var2 = React.forwardRef(function(tbl3, ref)
    local var2 = Cryo.Dictionary.join(tbl1, tbl3)

    local tokens = useStyle().Tokens
    local stateStyle = var2.stateStyle
    local var3 = if stateStyle == "Standard" then getStateTokens(tokens, "Standard") elseif stateStyle == "Inverse" then getStateTokens(tokens, "Inverse") elseif stateStyle == "Lighten" then getStateTokens(tokens, "Lighten") else tokens.LightMode.State
    local var4 = var3[tbl2[var1]]
    local backgroundColor3, var6 = React.useBinding(var4.Color3)
    local backgroundTransparency, var8 = React.useBinding(var4.Transparency)
    local selectionImageObject = useCursor(var2.cornerRadius)

    local tbl4 = {
        ref = ref,
        AnchorPoint = var2.anchorPoint,
        Position = var2.position,
        Size = var2.size,
        LayoutOrder = var2.layoutOrder,
        ZIndex = var2.zIndex,
        BackgroundTransparency = 1
    }

    local tbl5 = {}

    if var2.cornerRadius ~= nil then
        tbl5.UICorner = React.createElement("UICorner", { CornerRadius = var2.cornerRadius })
    end

    if var2.affordance == "Border" then
        tbl5.UIStroke = React.createElement(
            "UIStroke",
            {
                Thickness = tokens.Stroke.Standard,
                Color = backgroundColor3,
                Transparency = backgroundTransparency
            }
        )
        tbl4.BackgroundTransparency = 1
    elseif var2.affordance == "Background" then
        tbl4.BackgroundColor3 = backgroundColor3
        tbl4.BackgroundTransparency = backgroundTransparency
    end

    local outset = var2.outset
    local uDim2 = UDim2.new(
        1 + outset.left.Scale + outset.right.Scale,
        outset.left.Offset + outset.right.Offset,
        1 + outset.top.Scale + outset.bottom.Scale,
        outset.top.Offset + outset.bottom.Offset
    )
    local uDim2_2 = UDim2.new(-outset.left.Scale, -outset.left.Offset, -outset.top.Scale, -outset.top.Offset)
    local onStateChanged = React.useCallback(function(arg1, arg2)
        local var10 = var3[tbl2[arg2.rawValue()]]
        var6(var10.Color3)
        var8(var10.Transparency)
        if var2.onStateChanged then
            var2.onStateChanged(arg1, arg2)
        end
    end, {
        var3,
        var6,
        var8,
        var2.onStateChanged
    })

    tbl5.Button = React.createElement(Interactable, {
        Size = uDim2,
        Position = uDim2_2,
        BackgroundTransparency = 1,
        Selectable = not var2.isDisabled and var2.selectable,
        SelectionImageObject = selectionImageObject,
        [React.Event.Activated] = var2.onActivated,
        onStateChanged = onStateChanged,
        isDisabled = var2.isDisabled,
        userInteractionEnabled = not var2.isDisabled
    })

    return React.createElement("Frame", tbl4, tbl5)
end)

return React.memo(var2)
