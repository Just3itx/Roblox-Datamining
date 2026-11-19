-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:20:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local RoactRodux = InGameMenuDependencies.RoactRodux
local UIBlox = InGameMenuDependencies.UIBlox
local t = InGameMenuDependencies.t

local withFoundationOrUIBloxStyle = require(CorePackages.Workspace.Packages.CoreGuiCommon).withFoundationOrUIBloxStyle
local Foundation = require(CorePackages.Packages.Foundation)

local FFlagCoreUiMigrateUIBloxToFoundation = require(CorePackages.Workspace.Packages.SharedFlags).FFlagCoreUiMigrateUIBloxToFoundation
local var1 = if FFlagCoreUiMigrateUIBloxToFoundation then Foundation.UNSTABLE.withCursorMigration else UIBlox.App.SelectionImage.withSelectionCursorProvider
local var2 = if FFlagCoreUiMigrateUIBloxToFoundation then Foundation.Enums.CursorType else UIBlox.App.SelectionImage.CursorKind
local scriptParentParentParent = script.Parent.Parent.Parent

local GlobalConfig = require(scriptParentParentParent.GlobalConfig)

local ThemedTextLabel = require(script.Parent.Parent.ThemedTextLabel)
local Divider = require(script.Parent.Parent.Divider)

local NavigateBack = require(scriptParentParentParent.Actions.NavigateBack)

local withLocalization = require(scriptParentParentParent.Localization.withLocalization)

local Assets = require(scriptParentParentParent.Resources.Assets)

local ImageSetButton = UIBlox.Core.ImageSet.ImageSetButton
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel

local Image = Foundation.Image

local var3 = t.strictInterface({
    titleText = t.string,
    [Roact.Children] = t.optional(t.table),
    onClosed = t.callback,
    closeButtonRef = t.optional(t.table)
})

local function ControlLayoutContainerWithSelectionCursor(arg1, arg2)
    if GlobalConfig.propValidation then
        assert(var3(arg1))
    end

    return withLocalization({ titleText = arg1.titleText })(function(arg3)
        return withFoundationOrUIBloxStyle(function(arg4)
            return {
                Theme = {
                    Overlay = {
                        Color = arg4.Color.Common.Scrim.Color3,
                        Transparency = arg4.Color.Common.Scrim.Transparency
                    }
                }
            }
        end, function(arg4)
            local createElement = Roact.createElement
            local str1 = "Frame"
            local tbl1 = {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundColor3 = arg4.Theme.Overlay.Color,
                BackgroundTransparency = 0,
                Active = true
            }

            local tbl2 = {
                PageContent = Roact.createElement("Frame", {
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 1, -132),
                    Position = UDim2.new(0, 0, 0, 132),
                    ClipsDescendants = true
                }, arg1[Roact.Children]),
                HeaderContainer = 0,
                RadialGlowBig = 0,
                RadialGlowSquashed = 0
            }
            local createElement2 = Roact.createElement
            local str2 = "Frame"
            local tbl3 = {
                Size = UDim2.new(1, 0, 0, 132),
                BackgroundTransparency = 1
            }
            local tbl4 = {
                Padding = Roact.createElement("UIPadding", { PaddingLeft = UDim.new(0, 95), PaddingRight = UDim.new(0, 95) }),
                CloseButton = 0,
                HeaderTextLabel = 0,
                HeaderDivider = 0
            }
            local element

            if FFlagCoreUiMigrateUIBloxToFoundation then
                element = Roact.createElement(Image, {
                    AnchorPoint = Vector2.new(0, 0.5),
                    Position = UDim2.new(0, 0, 0, 100),
                    Size = UDim2.new(0, 36, 0, 36),
                    backgroundStyle = { Transparency = 1 },
                    Image = Assets.Images.CloseModal,
                    selection = {
                        SelectionImageObject = arg2(var2.RoundedRect)
                    },
                    onActivated = arg1.onClosed,
                    ref = arg1.closeButtonRef
                })
            else
                element = Roact.createElement(ImageSetButton, {
                    AnchorPoint = Vector2.new(0, 0.5),
                    Position = UDim2.new(0, 0, 0, 100),
                    Size = UDim2.new(0, 36, 0, 36),
                    Image = Assets.Images.CloseModal,
                    BackgroundTransparency = 1,
                    SelectionImageObject = arg2(var2.RoundedRect),
                    [Roact.Event.Activated] = arg1.onClosed,
                    [Roact.Ref] = arg1.closeButtonRef
                })
            end

            tbl4.CloseButton = element

            tbl4.HeaderTextLabel = Roact.createElement(ThemedTextLabel, {
                fontKey = "Header1",
                themeKey = "TextEmphasis",
                Size = UDim2.new(0, 250, 0, 28),
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.new(0.5, 0, 0, 100),
                Text = arg3.titleText
            })
            tbl4.HeaderDivider = Roact.createElement(
                Divider,
                {
                    Size = UDim2.new(1, 0, 0, 2),
                    AnchorPoint = Vector2.new(0.5, 1),
                    Position = UDim2.new(0.5, 0, 1, 0)
                }
            )
            tbl2.HeaderContainer = createElement2(str2, tbl3, tbl4)
            local element2

            if FFlagCoreUiMigrateUIBloxToFoundation then
                element2 = Roact.createElement(Image, {
                    Image = Assets.Images.RadialGlow,
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.new(0.5, 0, 0.5, 0),
                    backgroundStyle = { Transparency = 1 },
                    SizeConstraint = Enum.SizeConstraint.RelativeXX,
                    Size = UDim2.new(1, 0, 1, 0)
                })
            else
                element2 = Roact.createElement(ImageSetLabel, {
                    BackgroundTransparency = 1,
                    Image = Assets.Images.RadialGlow,
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.new(0.5, 0, 0.5, 0),
                    SizeConstraint = Enum.SizeConstraint.RelativeXX,
                    Size = UDim2.new(1, 0, 1, 0)
                })
            end

            tbl2.RadialGlowBig = element2
            local element3

            if FFlagCoreUiMigrateUIBloxToFoundation then
                element3 = Roact.createElement(Image, {
                    Image = Assets.Images.RadialGlow,
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.new(0.5, 0, 1, 0),
                    backgroundStyle = { Transparency = 1 },
                    SizeConstraint = Enum.SizeConstraint.RelativeXX,
                    Size = UDim2.new(1, 0, 0.6, 0)
                })
            else
                element3 = Roact.createElement(ImageSetLabel, {
                    BackgroundTransparency = 1,
                    Image = Assets.Images.RadialGlow,
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.new(0.5, 0, 1, 0),
                    SizeConstraint = Enum.SizeConstraint.RelativeXX,
                    Size = UDim2.new(1, 0, 0.6, 0)
                })
            end

            tbl2.RadialGlowSquashed = element3
            return createElement(str1, tbl1, tbl2)
        end)
    end)
end

return RoactRodux.UNSTABLE_connect2(nil, function(callback)
    return {
        onClosed = function()
            callback(NavigateBack())
        end
    }
end)(function(arg1) -- name: ControlLayoutContainer
    return var1(function(arg2)
        return ControlLayoutContainerWithSelectionCursor(arg1, arg2)
    end)
end)
