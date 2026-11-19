-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:50:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local t = require(CorePackages.Packages.t)
local UIBlox = require(CorePackages.Packages.UIBlox)

local Foundation = require(CorePackages.Packages.Foundation)
local IconName = Foundation.Enums.IconName
local IconVariant = Foundation.Enums.IconVariant
local IconSize = Foundation.Enums.IconSize
local normalizeFontFace = Foundation.Utility.normalizeFontFace

local withFoundationOrUIBloxStyle = require(CorePackages.Workspace.Packages.CoreGuiCommon).withFoundationOrUIBloxStyle

local FFlagCoreUiMigrateUIBloxToFoundation = require(CorePackages.Workspace.Packages.SharedFlags).FFlagCoreUiMigrateUIBloxToFoundation

local scriptParentParent = script.Parent.Parent
local Connection = scriptParentParent.Connection
local WithLayoutValues = require(Connection.LayoutValues).WithLayoutValues

local IconButton = require(scriptParentParent.PresentationCommon.IconButton)

local Colors = require(CorePackages.Workspace.Packages.Style).Colors

local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local Images = UIBlox.App.ImageSet.Images
local ChromeEnabled = require(CorePackages.Workspace.Packages.Chrome).Enabled

local scriptParentParentParent = scriptParentParent.Parent

local FFlagAllowDisplayingFoundationIconsForDropdown = require(scriptParentParentParent.Flags.FFlagAllowDisplayingFoundationIconsForDropdown)

local function isFoundationIconName(icon): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return IconName[icon] ~= nil
end

local var1 = Roact.PureComponent:extend("DropDownButton")

var1.validateProps = t.strictInterface({
    text = t.string,
    layoutOrder = t.optional(t.integer),
    icon = t.union(t.string, t.table),
    lastButton = t.boolean,
    forceShowOptions = t.boolean,
    screenSizeX = t.number,
    screenSizeY = t.number,
    onActivated = t.optional(t.callback),
    onDecline = t.optional(t.callback),
    onDismiss = t.optional(t.callback),
    animatingAccept = t.optional(t.boolean),
    animatingDecline = t.optional(t.boolean),
    animatingPercentage = t.optional(t.number)
})

function var1.init(arg1)
    arg1.state = {
        isHovered = false,
        isPressed = false,
        sizeX = 100,
        absolutePosX = 0,
        absolutePosY = 0
    }
end

function var1.getColorBackgroundAnimation(arg1, arg2)
    if arg1.props.animatingPercentage == nil then
        return 0, 0
    end

    local var2 = arg1.state.sizeX - arg2.DropDownRightOptionSize
    local dropDownRightOptionSize = arg2.DropDownRightOptionSize
    if arg1.props.animatingDecline then
        var2 -= arg2.DropDownRightOptionSize
    end

    local var3 = arg1.state.sizeX - arg2.DropDownRightOptionSize
    local var4 = dropDownRightOptionSize + var3 * arg1.props.animatingPercentage
    local var5 = var2 - var3 * arg1.props.animatingPercentage * 0.5

    if var5 + var4 > arg1.state.sizeX then
        var5 -= var5 + var4 - arg1.state.sizeX
    end
    return var5, var4
end

function var1.render(arg1)
    return WithLayoutValues(function(arg2)
        return withFoundationOrUIBloxStyle(function(tokens, arg3)
            return {
                Tokens = tokens,
                Theme = {
                    BackgroundContrast = {
                        Color = tokens.Color.Surface.Surface_100.Color3,
                        Transparency = tokens.Color.Surface.Surface_100.Transparency
                    },
                    BackgroundOnHover = {
                        Color = tokens.Color.State.Hover.Color3,
                        Transparency = tokens.Color.State.Hover.Transparency
                    },
                    BackgroundOnPress = {
                        Color = tokens.Color.State.Press.Color3,
                        Transparency = tokens.Color.State.Press.Transparency
                    },
                    BackgroundUIContrast = {
                        Color = tokens.Color.OverMedia.OverMedia_0.Color3,
                        Transparency = tokens.Color.OverMedia.OverMedia_0.Transparency
                    },
                    Divider = {
                        Color = tokens.Color.Stroke.Emphasis.Color3,
                        Transparency = tokens.Color.Stroke.Emphasis.Transparency
                    },
                    IconEmphasis = {
                        Color = tokens.Color.Content.Emphasis.Color3,
                        Transparency = tokens.Color.Content.Emphasis.Transparency
                    },
                    TextEmphasis = {
                        Color = tokens.Color.Content.Emphasis.Color3,
                        Transparency = tokens.Color.Content.Emphasis.Transparency
                    }
                },
                Font = {
                    BaseSize = 1,
                    Header2 = {
                        Font = tokens.Typography.TitleLarge.Font,
                        RelativeSize = tokens.Typography.TitleLarge.FontSize
                    }
                },
                Settings = {
                    PreferredTransparency = arg3.preferredTransparency
                }
            }
        end, function(arg3)
            local tbl1 = {
                Color = if ChromeEnabled() then arg3.Theme.BackgroundUIContrast.Color else arg3.Theme.BackgroundContrast.Color,
                Transparency = arg2.OverrideBackgroundTransparency * arg3.Settings.PreferredTransparency
            }
            local tbl2 = {
                Transparency = 1,
                Color = Color3.new(1, 1, 1)
            }
            if arg1.state.isPressed then
                tbl2 = arg3.Theme.BackgroundOnPress
            elseif arg1.state.isHovered then
                tbl2 = arg3.Theme.BackgroundOnHover
            end

            local image = if arg1.props.lastButton then "rbxasset://textures/ui/BottomRoundedRect8px.png" else ""

            local var2 = arg1.props.onActivated ~= nil or arg1.props.animatingAccept
            local var3 = arg1.props.onDecline ~= nil or arg1.props.animatingDecline
            local var4 = arg1.props.onDecline ~= nil or arg1.props.animatingPercentage ~= nil or arg1.props.forceShowOptions

            local xOffset, xOffset2 = arg1:getColorBackgroundAnimation(arg2)
            local green = Colors.Green
            if arg1.props.animatingDecline then
                green = Colors.Red
            elseif arg1.props.forceShowOptions then
                green = Colors.White
            end

            local var5 = arg2.DropDownPadding * 2 + arg2.DropDownIconSize
            local xOffset3 = arg2.DropDownRightOptionSize * 2
            if var4 then
                var5 += xOffset3
            end

            local function onMouseButton1Down()
                if not var4 then
                    arg1:setState({ isPressed = true })
                end
            end

            local function onMouseButton1Up()
                arg1:setState({ isPressed = false })
            end

            local icon = arg1.props.icon
            local element

            if FFlagAllowDisplayingFoundationIconsForDropdown and isFoundationIconName(icon) or FFlagCoreUiMigrateUIBloxToFoundation then
                local var6 = nil
                local var7 = nil

                if isFoundationIconName(icon) then
                    var6 = IconName[icon]
                    var7 = IconSize.Large
                elseif FFlagCoreUiMigrateUIBloxToFoundation then
                    if typeof(icon) == "string" then
                        var6 = icon
                    else
                        var6 = nil
                    end

                    var7 = IconSize.Medium
                end

                if var6 then
                    element = Roact.createElement(
                        "Frame",
                        {
                            LayoutOrder = 1,
                            Size = UDim2.new(0, arg2.DropDownIconSize, 0, arg2.DropDownIconSize),
                            BackgroundTransparency = 1
                        },
                        {
                            Icon = Roact.createElement(Foundation.Icon, {
                                name = var6,
                                variant = IconVariant.Regular,
                                size = var7,
                                style = {
                                    Color3 = arg3.Theme.IconEmphasis.Color,
                                    Transparency = arg3.Theme.IconEmphasis.Transparency
                                },
                                AnchorPoint = Vector2.new(0.5, 0.5),
                                Position = UDim2.new(0.5, 0, 0.5, 0)
                            })
                        }
                    )
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
                        BackgroundTransparency = 1,
                        LayoutOrder = 1
                    })
                end
            else
                element = Roact.createElement(ImageSetLabel, {
                    LayoutOrder = 1,
                    Size = UDim2.new(0, arg2.DropDownIconSize, 0, arg2.DropDownIconSize),
                    ImageColor3 = arg3.Theme.IconEmphasis.Color,
                    Image = arg1.props.icon,
                    BackgroundTransparency = 1
                })
            end

            local createElement = Roact.createElement
            local str2 = "ImageButton"
            local tbl3 = {
                LayoutOrder = nil,
                LayoutOrder = nil,
                LayoutOrder = nil,
                LayoutOrder = nil,
                LayoutOrder = arg1.props.layoutOrder,
                Image = image,
                ScaleType = Enum.ScaleType.Slice,
                SliceCenter = Rect.new(8, 8, 24, 16),
                SliceScale = 0.5,
                ImageTransparency = arg1.props.lastButton and tbl1.Transparency or 1,
                ImageColor3 = tbl1.Color,
                Size = UDim2.new(1, 0, 0, arg2.DropDownButtonSizeY),
                BackgroundTransparency = if arg1.props.lastButton then 1 else tbl1.Transparency,
                BackgroundColor3 = tbl1.Color,
                AutoButtonColor = false,
                BorderSizePixel = 0,
                [Roact.Event.Activated] = if var4 then nil else arg1.props.onActivated or nil
            }
            tbl3[Roact.Event.MouseEnter] = function()
                if not var4 then
                    arg1:setState({ isHovered = true })
                end
            end

            tbl3[Roact.Event.MouseLeave] = function()
                arg1:setState({ isHovered = false, isPressed = false })
            end

            tbl3[Roact.Change.AbsoluteSize] = function(arg4)
                arg1:setState({ sizeX = arg4.AbsoluteSize.X })
            end

            tbl3[Roact.Change.AbsolutePosition] = function(arg4)
                arg1:setState({ absolutePosX = arg4.AbsolutePosition.X, absolutePosY = arg4.AbsolutePosition.Y })
            end

            tbl3[Roact.Event.MouseButton1Down] = onMouseButton1Down
            tbl3[Roact.Event.MouseButton1Up] = onMouseButton1Up
            local tbl4 = {
                ColorBackground = Roact.createElement("ImageLabel", {
                    Visible = arg1.props.animatingPercentage ~= nil,
                    ZIndex = 1,
                    Size = UDim2.new(0, xOffset2, 1, 0),
                    Position = UDim2.new(0, xOffset, 0, 0),
                    Image = image,
                    ScaleType = Enum.ScaleType.Slice,
                    SliceCenter = Rect.new(8, 8, 24, 16),
                    SliceScale = 0.5,
                    ImageTransparency = arg1.props.lastButton and arg2.IconButtonBackgroundTransparency or 1,
                    ImageColor3 = green,
                    BackgroundTransparency = if arg1.props.lastButton then 1 else arg2.IconButtonBackgroundTransparency,
                    BackgroundColor3 = green,
                    BorderSizePixel = 0
                }),
                HoverBackground = 0,
                DismissInputHandler = 0,
                Divider = 0
            }

            local createElement2 = Roact.createElement
            local str3 = "ImageLabel"
            local tbl5 = {
                ZIndex = 2,
                Size = UDim2.new(1, 0, 1, 0),
                Image = image,
                ScaleType = Enum.ScaleType.Slice,
                SliceCenter = Rect.new(8, 8, 24, 16),
                SliceScale = 0.5,
                ImageTransparency = arg1.props.lastButton and tbl2.Transparency or 1,
                ImageColor3 = tbl2.Color,
                BackgroundTransparency = if arg1.props.lastButton then 1 else tbl2.Transparency,
                BackgroundColor3 = tbl2.Color,
                BorderSizePixel = 0
            }
            local tbl6 = {
                InitalPadding = Roact.createElement("UIPadding", { PaddingLeft = UDim.new(0, arg2.DropDownPadding) }),
                ListLayout = Roact.createElement("UIListLayout", {
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    FillDirection = Enum.FillDirection.Horizontal,
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                    Padding = UDim.new(0, arg2.DropDownPadding)
                }),
                Icon = element,
                Text = Roact.createElement("TextLabel", {
                    LayoutOrder = 2,
                    Size = UDim2.new(1, -var5, 1, 0),
                    Text = arg1.props.text,
                    FontFace = normalizeFontFace(arg3.Tokens.Typography.TitleLarge.Font),
                    TextSize = arg3.Font.BaseSize * arg3.Font.Header2.RelativeSize,
                    TextColor3 = arg3.Theme.TextEmphasis.Color,
                    TextTransparency = arg3.Theme.TextEmphasis.Transparency,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    BackgroundTransparency = 1
                }),
                ButtonContainer = 0
            }

            local createElement3 = Roact.createElement
            local str4 = "Frame"
            local tbl7 = {
                LayoutOrder = 3,
                Visible = var4,
                BackgroundTransparency = 1,
                Size = UDim2.new(0, xOffset3, 1, 0)
            }
            local tbl8 = { ConfirmButton = 0, DeclineButton = 0 }
            local element2

            if var2 then
                element2 = Roact.createElement(IconButton, {
                    size = UDim2.new(0.5, 0, 1, 0),
                    position = UDim2.new(0.5, 0, 0, 0),
                    backgroundColor = arg1.props.onDecline and Colors.Green or Colors.White,
                    icon = if FFlagCoreUiMigrateUIBloxToFoundation then "icons/actions/accept" else Images["icons/actions/accept"],
                    showBackground = arg1.props.animatingPercentage == nil,
                    onActivated = arg1.props.onActivated
                })
                    or nil
            else
                element2 = nil
            end

            tbl8.ConfirmButton = element2
            local element3

            if var3 then
                element3 = Roact.createElement(IconButton, {
                    size = UDim2.new(0.5, 0, 1, 0),
                    position = UDim2.new(0, 0, 0, 0),
                    backgroundColor = Colors.Red,
                    icon = if FFlagCoreUiMigrateUIBloxToFoundation then "icons/actions/reject" else Images["icons/actions/reject"],
                    showBackground = arg1.props.animatingPercentage == nil,
                    onActivated = arg1.props.onDecline
                })
                    or nil
            else
                element3 = nil
            end

            tbl8.DeclineButton = element3
            tbl6.ButtonContainer = createElement3(str4, tbl7, tbl8)
            tbl4.HoverBackground = createElement2(str3, tbl5, tbl6)

            tbl4.DismissInputHandler = Roact.createElement("ImageButton", {
                Image = "",
                BackgroundTransparency = 1,
                Size = UDim2.new(0, arg1.props.screenSizeX, 0, arg1.props.screenSizeY),
                Position = UDim2.new(0, -arg1.state.absolutePosX, 0, -arg1.state.absolutePosY),
                Visible = arg1.props.onDismiss ~= nil,
                [Roact.Event.Activated] = arg1.props.onDismiss
            })

            tbl4.Divider = not arg1.props.lastButton
                and Roact.createElement("Frame", {
                    ZIndex = 3,
                    Size = UDim2.new(1, 0, 0, 1),
                    Position = UDim2.new(0, 0, 1, 0),
                    AnchorPoint = Vector2.new(0, 1),
                    BackgroundTransparency = arg3.Theme.Divider.Transparency,
                    BackgroundColor3 = arg3.Theme.Divider.Color,
                    BorderSizePixel = 0
                })
            return createElement(str2, tbl3, tbl4)
        end)
    end)
end

return RoactRodux.UNSTABLE_connect2(function(arg1) -- name: mapStateToProps
    return {
        screenSizeX = arg1.screenSize.X,
        screenSizeY = arg1.screenSize.Y
    }
end, nil)(var1)
