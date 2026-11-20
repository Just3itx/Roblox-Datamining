-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:21:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Roact = require(CorePackages.Packages.Roact)
local Modules = game:GetService("CoreGui").RobloxGui.Modules
local Theme = require(Modules.Settings.Theme)

local var1 = Roact.PureComponent:extend("RectangleButton")
var1.defaultProps = { visible = true }

function var1.init(arg1)
    arg1.state = { isHovering = false }
end

function var1.render(arg1)
    local size = arg1.props.size
    local position = arg1.props.position
    local anchorPoint = arg1.props.anchorPoint
    local layoutOrder = arg1.props.layoutOrder
    local zIndex = arg1.props.zIndex
    local onClick = arg1.props.onClick
    local visible = arg1.props.visible
    local prop = arg1.props[Roact.Children] or {}

    prop.Border = Roact.createElement("UIStroke", {
        Color = Theme.color("DefaultButtonStroke"),
        Transparency = Theme.transparency("DefaultButtonStroke"),
        Thickness = Theme.DefaultStokeThickness
    })
    prop.UICorner = Roact.createElement("UICorner", { CornerRadius = Theme.DefaultCornerRadius })

    local createElement = Roact.createElement
    local tbl1 = {
        BackgroundTransparency = 1,
        Image = "",
        Selectable = false,
        Size = size,
        Position = position,
        AnchorPoint = anchorPoint,
        LayoutOrder = layoutOrder,
        ZIndex = zIndex,
        Visible = visible
    }
    tbl1[Roact.Event.InputBegan] = function()
        arg1:setState({ isHovering = true })
    end
    tbl1[Roact.Event.InputEnded] = function()
        arg1:setState({ isHovering = false })
    end

    tbl1[Roact.Event.Activated] = function()
        if onClick then
            arg1:setState({ isHovering = false })
            onClick()
        end
    end

    return createElement("ImageButton", tbl1, {
        ButtonBackgroundUIBlox = Roact.createElement("ImageLabel", {
            BackgroundColor3 = Theme.color(if arg1.state.isHovering then "DefaultButtonHover" else "DefaultButton"),
            BackgroundTransparency = Theme.transparency(if arg1.state.isHovering then "DefaultButtonHover" else "DefaultButton"),
            Position = UDim2.new(0, 0, 0, 0),
            Size = UDim2.new(1, 0, 1, 0),
            ZIndex = zIndex
        }, prop)
    })
end

return var1
