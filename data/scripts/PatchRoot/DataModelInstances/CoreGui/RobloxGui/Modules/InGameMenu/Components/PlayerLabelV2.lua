-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:31:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local UIBlox = InGameMenuDependencies.UIBlox
local Cryo = InGameMenuDependencies.Cryo
local t = InGameMenuDependencies.t

local withFoundationOrUIBloxStyle = require(CorePackages.Workspace.Packages.CoreGuiCommon).withFoundationOrUIBloxStyle
local Foundation = require(CorePackages.Packages.Foundation)
local FFlagCoreUiMigrateUIBloxToFoundation = require(CorePackages.Workspace.Packages.SharedFlags).FFlagCoreUiMigrateUIBloxToFoundation
local var1 = if FFlagCoreUiMigrateUIBloxToFoundation then Foundation.UNSTABLE.withCursorMigration else UIBlox.App.SelectionImage.withSelectionCursorProvider
local var2 = if FFlagCoreUiMigrateUIBloxToFoundation then Foundation.Enums.CursorType else UIBlox.App.SelectionImage.CursorKind
local OpenTypeSupport = UIBlox.Utility.OpenTypeSupport

local scriptParentParent = script.Parent.Parent

local FFlagLuaMenuPerfImprovements = require(scriptParentParent.Flags.FFlagLuaMenuPerfImprovements)

local GetFFlagLuaAppEnableOpenTypeSupport = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagLuaAppEnableOpenTypeSupport

local GetFFlagLuaAppEnableOpenTypeIGMFix = require(CorePackages.Workspace.Packages.SharedFlags).GetFFlagLuaAppEnableOpenTypeIGMFix

local ThemedTextLabel = require(scriptParentParent.Components.ThemedTextLabel)

local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local Image = Foundation.Image

local tbl1 = {
    AnchorPoint = Vector2.new(0, 1),
    Position = UDim2.new(0, 24, 1, 1),
    Size = UDim2.new(0, 56, 0, 56)
}

local validatePropsWithForwardRef = require(CorePackages.Workspace.Packages.RoactUtils).validatePropsWithForwardRef

local var3 = Roact.PureComponent:extend("PlayerLabelV2")

local strictInterface = t.strictInterface
local tbl2 = {
    userId = t.number,
    username = t.string,
    displayName = t.string,
    isOnline = t.boolean,
    isSelected = t.boolean,
    LayoutOrder = t.integer,
    Visible = t.optional(t.boolean),
    onActivated = t.optional(t.callback),
    [Roact.Children] = t.optional(t.table),
    [Roact.Change.AbsolutePosition] = t.optional(t.callback),
    [Roact.Ref] = t.optional(t.union(t.callback, t.table))
}
var3.validateProps = strictInterface(validatePropsWithForwardRef(tbl2))

var3.defaultProps = { Visible = true }

if FFlagLuaMenuPerfImprovements then
    function var3.init(arg1)
        function arg1.onActivated()
            arg1.props.onActivated(arg1.props.userId)
        end
    end
end

function var3.renderButtons(arg1)
    local prop = arg1.props[Roact.Children] or {}
    return (Cryo.Dictionary.join(prop, {
        List = Roact.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Right,
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            Padding = UDim.new(0, 12)
        })
    }))
end

function var3.renderWithSelectionCursor(arg1, arg2)
    local props = arg1.props
    local var4 = props.displayName ~= "" and props.displayName or props.username

    return withFoundationOrUIBloxStyle(function(arg3)
        return {
            Theme = {
                BackgroundContrast = {
                    Color = arg3.Color.Surface.Surface_100.Color3,
                    Transparency = arg3.Color.Surface.Surface_100.Transparency
                },
                BackgroundOnHover = {
                    Color = arg3.Color.State.Hover.Color3,
                    Transparency = arg3.Color.State.Hover.Transparency
                }
            }
        }
    end, function(arg3)
        local backgroundContrast = arg3.Theme.BackgroundContrast
        if arg1.props.isSelected then
            backgroundContrast = arg3.Theme.BackgroundOnHover
        end

        local onActivated = arg1.props.onActivated
        if FFlagLuaMenuPerfImprovements then
            onActivated = arg1.props.onActivated and arg1.onActivated or nil
        end

        local forwardRef = arg1.props.forwardRef

        local createElement = Roact.createElement
        local str1 = "TextButton"
        local tbl3 = {
            BackgroundTransparency = backgroundContrast.Transparency,
            BackgroundColor3 = backgroundContrast.Color,
            BorderSizePixel = 0,
            LayoutOrder = props.LayoutOrder,
            Size = UDim2.new(1, 0, 0, 71),
            Visible = props.Visible,
            Text = "",
            AutoButtonColor = false,
            [Roact.Event.Activated] = onActivated,
            [Roact.Change.AbsolutePosition] = arg1.props[Roact.Change.AbsolutePosition],
            [Roact.Ref] = forwardRef,
            SelectionImageObject = arg2(var2.Square)
        }
        local tbl4 = {
            PlayerIcon = 0,
            DisplayNameLabel = 0,
            UsernameLabel = 0,
            ButtonContainer = 0
        }
        local element

        if FFlagCoreUiMigrateUIBloxToFoundation then
            element = Roact.createElement(
                Image,
                Cryo.Dictionary.join(tbl1, {
                    Image = props.userId > 0 and "rbxthumb://type=AvatarHeadShot&id=" .. props.userId .. "&w=60&h=60" or "",
                    imageStyle = {
                        Color3 = props.isOnline and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(115, 115, 115),
                        Transparency = 0
                    },
                    ZIndex = 2
                })
            )
        else
            element = Roact.createElement(
                ImageSetLabel,
                Cryo.Dictionary.join(tbl1, {
                    ImageColor3 = props.isOnline and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(115, 115, 115),
                    BackgroundTransparency = 1,
                    Image = props.userId > 0 and "rbxthumb://type=AvatarHeadShot&id=" .. props.userId .. "&w=60&h=60" or "",
                    ZIndex = 2
                })
            )
        end

        tbl4.PlayerIcon = element

        tbl4.DisplayNameLabel = Roact.createElement(ThemedTextLabel, {
            fontKey = "Header2",
            themeKey = "TextEmphasis",
            Position = UDim2.new(0, 104, 0, 14),
            AnchorPoint = Vector2.new(0, 0),
            Size = UDim2.new(0, 219, 0, 22),
            Text = var4,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextTruncate = Enum.TextTruncate.AtEnd
        })

        tbl4.UsernameLabel = Roact.createElement(ThemedTextLabel, {
            fontKey = "Header2",
            themeKey = "TextDefault",
            Position = UDim2.new(0, 104, 0, 36),
            Size = UDim2.new(0, 219, 0, 22),
            Text = "@" .. props.username,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextTruncate = Enum.TextTruncate.AtEnd,
            OpenTypeFeatures = if GetFFlagLuaAppEnableOpenTypeSupport() and GetFFlagLuaAppEnableOpenTypeIGMFix() then OpenTypeSupport:getUserNameStylisticAlternative() else nil
        })

        tbl4.ButtonContainer = Roact.createElement("Frame", {
            AnchorPoint = Vector2.new(1, 0),
            BackgroundTransparency = 1,
            Position = UDim2.new(1, -24, 0, 0),
            Size = UDim2.new(0, 0, 1, 0)
        }, arg1:renderButtons())
        return createElement(str1, tbl3, tbl4)
    end)
end

function var3.render(arg1)
    return var1(function(arg2)
        return arg1:renderWithSelectionCursor(arg2)
    end)
end

return Roact.forwardRef(function(arg1, forwardRef)
    return Roact.createElement(var3, Cryo.Dictionary.join(arg1, { forwardRef = forwardRef }))
end)
