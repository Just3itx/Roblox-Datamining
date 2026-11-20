-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:41:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParentParent = scriptParentParent.Parent.Parent

local React = require(scriptParentParentParentParent.React)
local Object = require(scriptParentParentParentParent.LuauPolyfill).Object

local _StyleTypes = require(scriptParentParent.Style.StyleTypes)

local tbl1 = { zIndex = 1 }

return function(tbl2)
    local var1 = Object.assign({}, tbl1, tbl2)
    local createElement = React.createElement
    local str1 = "Frame"
    local tbl3 = {
        ZIndex = var1.zIndex,
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1
    }
    local tbl4 = { TopContainer = 0, BottomContainer = 0 }
    local createElement2 = React.createElement
    local str2 = "Frame"
    local tbl5 = {
        Position = UDim2.fromScale(0, 0),
        Size = UDim2.fromScale(1, 0.5),
        ClipsDescendants = true,
        BackgroundTransparency = 1
    }

    local tbl6 = {
        Content = React.createElement("Frame", {
            Position = UDim2.fromScale(0, 0),
            Size = UDim2.fromScale(1, 2),
            BackgroundColor3 = var1.background.Color,
            BackgroundTransparency = var1.background.Transparency
        }, {
            UICorner = if var1.topCornerRadius then React.createElement("UICorner", { CornerRadius = var1.topCornerRadius }) else nil
        })
    }
    tbl4.TopContainer = createElement2(str2, tbl5, tbl6)

    local createElement3 = React.createElement
    local str3 = "Frame"
    local tbl7 = {
        Position = UDim2.fromScale(0, 0.5),
        Size = UDim2.fromScale(1, 0.5),
        ClipsDescendants = true,
        BackgroundTransparency = 1
    }

    local tbl8 = {
        Content = React.createElement("Frame", {
            Position = UDim2.fromScale(0, -1),
            Size = UDim2.fromScale(1, 2),
            BackgroundColor3 = var1.background.Color,
            BackgroundTransparency = var1.background.Transparency
        }, {
            UICorner = if var1.bottomCornerRadius then React.createElement("UICorner", { CornerRadius = var1.bottomCornerRadius }) else nil
        })
    }
    tbl4.BottomContainer = createElement3(str3, tbl7, tbl8)
    return createElement(str1, tbl3, tbl4)
end
