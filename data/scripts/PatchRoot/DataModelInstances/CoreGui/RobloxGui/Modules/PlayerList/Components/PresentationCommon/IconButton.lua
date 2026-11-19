-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:51:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Roact = require(CorePackages.Packages.Roact)
local t = require(CorePackages.Packages.t)
local UIBlox = require(CorePackages.Packages.UIBlox)
local Foundation = require(CorePackages.Packages.Foundation)
local IconSize = Foundation.Enums.IconSize

local withFoundationOrUIBloxStyle = require(CorePackages.Workspace.Packages.CoreGuiCommon).withFoundationOrUIBloxStyle

local FFlagCoreUiMigrateUIBloxToFoundation = require(CorePackages.Workspace.Packages.SharedFlags).FFlagCoreUiMigrateUIBloxToFoundation

local Connection = script.Parent.Parent.Connection
local WithLayoutValues = require(Connection.LayoutValues).WithLayoutValues

local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel

local var1 = Roact.PureComponent:extend("IconButton")

var1.validateProps = t.strictInterface({
    size = t.UDim2,
    position = t.UDim2,
    backgroundColor = t.Color3,
    icon = t.union(t.string, t.table),
    showBackground = t.boolean,
    onActivated = t.optional(t.callback)
})

function var1.init(arg1)
    arg1.state = { isHovered = false, isPressed = false }
end

function var1.render(arg1)
    return WithLayoutValues(function(arg2)
        return withFoundationOrUIBloxStyle(function(arg3)
            return {
                Theme = {
                    BackgroundOnHover = {
                        Color = arg3.Color.State.Hover.Color3,
                        Transparency = arg3.Color.State.Hover.Transparency
                    },
                    BackgroundOnPress = {
                        Color = arg3.Color.State.Press.Color3,
                        Transparency = arg3.Color.State.Press.Transparency
                    },
                    IconEmphasis = {
                        Color = arg3.Color.Content.Emphasis.Color3,
                        Transparency = arg3.Color.Content.Emphasis.Transparency
                    }
                }
            }
        end, function(arg3)
            local tbl1 = {
                Transparency = 1,
                Color = Color3.new(1, 1, 1)
            }
            if arg1.props.onActivated then
                if arg1.state.isPressed then
                    tbl1 = arg3.Theme.BackgroundOnPress
                elseif arg1.state.isHovered then
                    tbl1 = arg3.Theme.BackgroundOnHover
                end
            end

            local element

            if FFlagCoreUiMigrateUIBloxToFoundation then
                local icon = arg1.props.icon
                if typeof(icon) == "string" then
                    element = Roact.createElement("Frame", {
                        Position = UDim2.new(0.5, 0, 0.5, 0),
                        Size = UDim2.new(0, arg2.DropDownIconSize, 0, arg2.DropDownIconSize),
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        BackgroundTransparency = 1,
                        ZIndex = 2
                    }, {
                        Icon = Roact.createElement(Foundation.Icon, {
                            name = icon,
                            size = IconSize.Medium,
                            style = {
                                Color3 = arg3.Theme.IconEmphasis.Color,
                                Transparency = arg3.Theme.IconEmphasis.Transparency
                            },
                            AnchorPoint = Vector2.new(0.5, 0.5),
                            Position = UDim2.new(0.5, 0, 0.5, 0)
                        })
                    })
                else
                    element = Roact.createElement(Foundation.Image, {
                        Image = icon.Image,
                        imageRect = {
                            offset = icon.ImageRectOffset,
                            size = icon.ImageRectSize
                        },
                        Size = UDim2.new(0, arg2.DropDownIconSize, 0, arg2.DropDownIconSize),
                        imageStyle = {
                            Color3 = arg3.Theme.IconEmphasis.Color,
                            Transparency = arg3.Theme.IconEmphasis.Transparency
                        },
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Position = UDim2.new(0.5, 0, 0.5, 0),
                        BackgroundTransparency = 1,
                        ZIndex = 2
                    })
                end
            else
                element = Roact.createElement(ImageSetLabel, {
                    Position = UDim2.new(0.5, 0, 0.5, 0),
                    Size = UDim2.new(0, arg2.DropDownIconSize, 0, arg2.DropDownIconSize),
                    Image = arg1.props.icon,
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    BackgroundTransparency = 1,
                    ZIndex = 2
                })
            end

            local createElement = Roact.createElement
            local tbl2 = {
                Text = nil,
                Text = nil,
                Text = "",
                BorderSizePixel = 0,
                BackgroundTransparency = arg1.props.showBackground and arg2.IconButtonBackgroundTransparency or 1,
                BackgroundColor3 = arg1.props.backgroundColor,
                Position = arg1.props.position,
                Size = arg1.props.size,
                [Roact.Event.Activated] = arg1.props.onActivated
            }
            tbl2[Roact.Event.MouseButton1Down] = function()
                arg1:setState({ isPressed = true })
            end

            tbl2[Roact.Event.MouseButton1Up] = function()
                arg1:setState({ isPressed = false })
            end

            tbl2[Roact.Event.MouseEnter] = function()
                arg1:setState({ isHovered = true })
            end

            tbl2[Roact.Event.MouseLeave] = function()
                arg1:setState({ isHovered = false, isPressed = false })
            end

            return createElement("TextButton", tbl2, {
                HoverBackground = Roact.createElement("Frame", {
                    ZIndex = 1,
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = tbl1.Transparency,
                    BackgroundColor3 = tbl1.Color,
                    BorderSizePixel = 0
                }),
                ImageButton = element
            })
        end)
    end)
end

return var1
