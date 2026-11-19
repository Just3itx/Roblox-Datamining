-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:40:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local UIBlox = InGameMenuDependencies.UIBlox
local t = InGameMenuDependencies.t

local scriptParentParent = script.Parent.Parent

local Assets = require(scriptParentParent.Resources.Assets)
local divideTransparency = require(scriptParentParent.Utility.divideTransparency)

local ImageSetButton = UIBlox.Core.ImageSet.ImageSetButton
local withFoundationOrUIBloxStyle = require(CorePackages.Workspace.Packages.CoreGuiCommon).withFoundationOrUIBloxStyle
local Foundation = require(CorePackages.Packages.Foundation)
local FFlagCoreUiMigrateUIBloxToFoundation = require(CorePackages.Workspace.Packages.SharedFlags).FFlagCoreUiMigrateUIBloxToFoundation
local var1 = if FFlagCoreUiMigrateUIBloxToFoundation then Foundation.UNSTABLE.withCursorMigration else UIBlox.App.SelectionImage.withSelectionCursorProvider
local var2 = if FFlagCoreUiMigrateUIBloxToFoundation then Foundation.Enums.CursorType else UIBlox.App.SelectionImage.CursorKind
local var3 = Roact.PureComponent:extend("ThemedButton")

var3.validateProps = t.strictInterface({
    normalThemeKey = t.string,
    hoverThemeKey = t.string,
    imageProps = t.strictInterface({ Image = t.union(t.string, t.table), ScaleType = t.enum(Enum.ScaleType), SliceCenter = t.Rect }),
    enabled = t.optional(t.boolean),
    renderChildren = t.callback,
    onActivated = t.callback,
    AnchorPoint = t.optional(t.Vector2),
    LayoutOrder = t.optional(t.integer),
    Position = t.optional(t.UDim2),
    Size = t.optional(t.UDim2),
    Visible = t.optional(t.boolean),
    ButtonRef = t.optional(t.union(t.callback, t.table))
})

var3.defaultProps = {
    imageProps = Assets.Images.RoundedRect,
    enabled = true
}

function var3.init(arg1)
    arg1:setState({ hover = false, press = false })
end

function var3.renderWithSelectionCursor(arg1, arg2)
    local props = arg1.props
    local normalThemeKey = props.normalThemeKey

    if props.enabled and arg1.state.hover then
        normalThemeKey = props.hoverThemeKey
    end

    return withFoundationOrUIBloxStyle(function(arg3)
        return {
            Theme = {
                BackgroundDefault = {
                    Color = arg3.Color.Surface.Surface_0.Color3,
                    Transparency = arg3.Color.Surface.Surface_0.Transparency
                },
                BackgroundContrast = {
                    Color = arg3.Color.Surface.Surface_100.Color3,
                    Transparency = arg3.Color.Surface.Surface_100.Transparency
                },
                BackgroundMuted = {
                    Color = arg3.Color.Surface.Surface_200.Color3,
                    Transparency = arg3.Color.Surface.Surface_200.Transparency
                },
                BackgroundUIDefault = {
                    Color = arg3.Color.Surface.Surface_300.Color3,
                    Transparency = arg3.Color.Surface.Surface_300.Transparency
                },
                BackgroundUIContrast = {
                    Color = arg3.Color.OverMedia.OverMedia_0.Color3,
                    Transparency = arg3.Color.OverMedia.OverMedia_0.Transparency
                },
                BackgroundOnHover = {
                    Color = arg3.Color.State.Hover.Color3,
                    Transparency = arg3.Color.State.Hover.Transparency
                },
                BackgroundOnPress = {
                    Color = arg3.Color.State.Press.Color3,
                    Transparency = arg3.Color.State.Press.Transparency
                },
                UIDefault = {
                    Color = arg3.Color.Shift.Shift_200.Color3,
                    Transparency = arg3.Color.Shift.Shift_200.Transparency
                },
                UIMuted = {
                    Color = arg3.Color.Shift.Shift_100.Color3,
                    Transparency = arg3.Color.Shift.Shift_100.Transparency
                },
                UIEmphasis = {
                    Color = arg3.Color.Shift.Shift_400.Color3,
                    Transparency = arg3.Color.Shift.Shift_400.Transparency
                },
                ContextualPrimaryDefault = {
                    Color = arg3.Color.ActionEmphasis.Background.Color3,
                    Transparency = arg3.Color.ActionEmphasis.Background.Transparency
                },
                ContextualPrimaryContent = {
                    Color = arg3.Color.ActionEmphasis.Foreground.Color3,
                    Transparency = arg3.Color.ActionEmphasis.Foreground.Transparency
                },
                SystemPrimaryDefault = {
                    Color = arg3.Color.ActionSubEmphasis.Background.Color3,
                    Transparency = arg3.Color.ActionSubEmphasis.Background.Transparency
                },
                SystemPrimaryContent = {
                    Color = arg3.Color.ActionSubEmphasis.Foreground.Color3,
                    Transparency = arg3.Color.ActionSubEmphasis.Foreground.Transparency
                },
                IconDefault = {
                    Color = arg3.Color.Content.Default.Color3,
                    Transparency = arg3.Color.Content.Default.Transparency
                },
                IconEmphasis = {
                    Color = arg3.Color.Content.Emphasis.Color3,
                    Transparency = arg3.Color.Content.Emphasis.Transparency
                },
                IconOnHover = {
                    Color = arg3.Color.Content.Emphasis.Color3,
                    Transparency = arg3.Color.Content.Emphasis.Transparency
                },
                TextEmphasis = {
                    Color = arg3.Color.Content.Emphasis.Color3,
                    Transparency = arg3.Color.Content.Emphasis.Transparency
                },
                TextDefault = {
                    Color = arg3.Color.Content.Default.Color3,
                    Transparency = arg3.Color.Content.Default.Transparency
                },
                TextMuted = {
                    Color = arg3.Color.Content.Muted.Color3,
                    Transparency = arg3.Color.Content.Muted.Transparency
                },
                TextLink = {
                    Color = arg3.Color.Content.Link.Color3,
                    Transparency = arg3.Color.Content.Link.Transparency
                },
                Divider = {
                    Color = arg3.Color.Stroke.Emphasis.Color3,
                    Transparency = arg3.Color.Stroke.Emphasis.Transparency
                },
                Overlay = {
                    Color = arg3.Color.Common.Scrim.Color3,
                    Transparency = arg3.Color.Common.Scrim.Transparency
                },
                DropShadow = {
                    Color = arg3.Color.Common.Shadow.Color3,
                    Transparency = arg3.Color.Common.Shadow.Transparency
                },
                NavigationBar = {
                    Color = arg3.Color.Common.NavigationBar.Color3,
                    Transparency = arg3.Color.Common.NavigationBar.Transparency
                },
                PlaceHolder = {
                    Color = arg3.Color.Common.Shimmer.Color3,
                    Transparency = arg3.Color.Common.Shimmer.Transparency
                },
                OnlineStatus = {
                    Color = arg3.Color.System.Success.Color3,
                    Transparency = arg3.Color.System.Success.Transparency
                },
                OfflineStatus = {
                    Color = arg3.Color.System.Neutral.Color3,
                    Transparency = arg3.Color.System.Neutral.Transparency
                },
                Success = {
                    Color = arg3.Color.System.Success.Color3,
                    Transparency = arg3.Color.System.Success.Transparency
                },
                Alert = {
                    Color = arg3.Color.System.Alert.Color3,
                    Transparency = arg3.Color.System.Alert.Transparency
                },
                Badge = {
                    Color = arg3.Color.System.Contrast.Color3,
                    Transparency = arg3.Color.System.Contrast.Transparency
                },
                BadgeContent = {
                    Color = arg3.Inverse.Content.Emphasis.Color3,
                    Transparency = arg3.Inverse.Content.Emphasis.Transparency
                },
                SecondaryDefault = {
                    Color = arg3.Color.Extended.White.White_70.Color3,
                    Transparency = arg3.Color.Extended.White.White_70.Transparency
                },
                SecondaryOnHover = {
                    Color = arg3.Color.Extended.White.White_100.Color3,
                    Transparency = arg3.Color.Extended.White.White_100.Transparency
                }
            }
        }
    end, function(arg3)
        local var4 = arg3.Theme[normalThemeKey]
        assert(var4 ~= nil, "theme key " .. normalThemeKey .. " is nil")
        local var5 = divideTransparency(var4.Transparency, if arg1.state.press then 2 else 1)
        local imageTransparency = if props.enabled then var5 else 0.5

        local createElement = Roact.createElement
        local var7 = ImageSetButton
        local tbl1 = {
            Visible = props.Visible,
            BackgroundTransparency = 1,
            ImageColor3 = var4.Color,
            Position = props.Position,
            Size = props.Size,
            AnchorPoint = props.AnchorPoint,
            ImageTransparency = imageTransparency,
            LayoutOrder = props.LayoutOrder,
            ScaleType = props.imageProps.ScaleType,
            SliceCenter = props.imageProps.SliceCenter,
            Image = props.imageProps.Image,
            SelectionImageObject = arg2(var2.RoundedRectNoInset)
        }

        tbl1[Roact.Event.Activated] = function()
            if props.enabled then
                props.onActivated()
            end
        end
        tbl1[Roact.Event.MouseEnter] = function()
            arg1:setState({ hover = true })
        end

        tbl1[Roact.Event.MouseLeave] = function()
            arg1:setState({ hover = false, press = false })
        end

        tbl1[Roact.Event.InputBegan] = function(_, arg4)
            if arg4.UserInputType == Enum.UserInputType.MouseButton1 or arg4.UserInputType == Enum.UserInputType.Touch then
                arg1:setState({ press = true })
            end
        end

        tbl1[Roact.Event.InputEnded] = function(_, arg4)
            if arg4.UserInputType == Enum.UserInputType.MouseButton1 or arg4.UserInputType == Enum.UserInputType.Touch then
                arg1:setState({ press = false })
            end
        end

        tbl1[Roact.Ref] = arg1.props.ButtonRef
        return createElement(
            var7,
            tbl1,
            props.renderChildren(imageTransparency, props.enabled and arg1.state.hover, props.enabled and arg1.state.press)
        )
    end)
end

function var3.render(arg1)
    return var1(function(arg2)
        return arg1:renderWithSelectionCursor(arg2)
    end)
end

return var3
