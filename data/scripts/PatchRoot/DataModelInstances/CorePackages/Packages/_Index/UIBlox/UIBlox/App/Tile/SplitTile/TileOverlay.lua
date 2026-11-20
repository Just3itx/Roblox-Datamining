-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:10:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local Core = scriptParentParentParentParent.Core
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent

local React = require(scriptParentParentParentParentParent.React)

local Interactable = require(Core.Control.Interactable)
local useControlState = require(Core.Control.useControlState)
local useStyle = require(Core.Style.useStyle)
local ControlState = require(Core.Control.Enum.ControlState)

local setDefault = require(scriptParentParentParentParent.Utility.setDefault)

local uDim = UDim.new(0, 8)

local function TileOverlay(tbl1)
    local onActivated = tbl1.onActivated
    local var1 = setDefault(tbl1.isVisible, true)
    local var2 = setDefault(tbl1.isActive, true)
    local reservedBottomHeight = tbl1.reservedBottomHeight or 0
    local bool1 = reservedBottomHeight > 0

    if not (var1 or var2) then
        return nil
    end

    local var3, onStateChanged = useControlState()
    local theme = useStyle().Theme
    local var5 = nil
    local num1 = 1

    if var1 and var2 then
        if var3 == ControlState.Pressed then
            var5 = theme.BackgroundOnPress.Color
            num1 = theme.BackgroundOnPress.Transparency
        elseif var3 == ControlState.Hover then
            var5 = theme.BackgroundOnHover.Color
            num1 = theme.BackgroundOnHover.Transparency
        end
    end

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        ZIndex = tbl1.zIndex
    }
    local tbl3 = {
        UICorner = React.createElement("UICorner", { CornerRadius = uDim }),
        ClippingFrame = 0
    }
    local createElement2 = React.createElement
    local str2 = "Frame"
    local tbl4 = {
        Size = UDim2.new(1, 0, 1, if bool1 then -reservedBottomHeight else 0),
        BackgroundTransparency = 1,
        ClipsDescendants = true
    }

    local tbl5 = { Interactable = 0 }
    local createElement3 = React.createElement
    local var6 = Interactable
    local tbl6 = {
        Size = UDim2.new(1, 0, 1, if bool1 then uDim.Offset else 0),
        BackgroundColor3 = var5,
        BackgroundTransparency = num1,
        AutoButtonColor = false,
        onStateChanged = onStateChanged
    }
    local activated = React.Event.Activated

    if not var2 then
        onActivated = nil
    end

    tbl6[activated] = onActivated
    tbl6.ZIndex = 3
    tbl5.Interactable = createElement3(var6, tbl6, { UICorner = React.createElement("UICorner", { CornerRadius = uDim }) })
    tbl3.ClippingFrame = createElement2(str2, tbl4, tbl5)
    return createElement(str1, tbl2, tbl3)
end

return TileOverlay
