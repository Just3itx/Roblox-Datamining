-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:31:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local RoactRodux = InGameMenuDependencies.RoactRodux
local UIBlox = InGameMenuDependencies.UIBlox

local withFoundationOrUIBloxStyle = require(CorePackages.Workspace.Packages.CoreGuiCommon).withFoundationOrUIBloxStyle
local Foundation = require(CorePackages.Packages.Foundation)
local FFlagCoreUiMigrateUIBloxToFoundation = require(CorePackages.Workspace.Packages.SharedFlags).FFlagCoreUiMigrateUIBloxToFoundation
local var1 = if FFlagCoreUiMigrateUIBloxToFoundation then Foundation.UNSTABLE.withCursorMigration else UIBlox.App.SelectionImage.withSelectionCursorProvider
local var2 = if FFlagCoreUiMigrateUIBloxToFoundation then Foundation.Enums.CursorType else UIBlox.App.SelectionImage.CursorKind
local scriptParentParent = script.Parent.Parent
local NavigateUp = require(scriptParentParent.Thunks.NavigateUp)
local Assets = require(scriptParentParent.Resources.Assets)
local Constants = require(scriptParentParent.Resources.Constants)

local ZonePortal = require(scriptParentParent.Components.ZonePortal)
local Direction = require(scriptParentParent.Enums.Direction)

local ImageSetButton = UIBlox.Core.ImageSet.ImageSetButton

local Image = Foundation.Image

local ThemedTextLabel = require(script.Parent.ThemedTextLabel)

local function renderWithSelectionCursor(arg1, arg2)
    return withFoundationOrUIBloxStyle(function(arg3)
        return {
            Theme = {
                IconEmphasis = {
                    Color = arg3.Color.Content.Emphasis.Color3,
                    Transparency = arg3.Color.Content.Emphasis.Transparency
                },
                BackgroundContrast = {
                    Color = arg3.Color.Surface.Surface_100.Color3,
                    Transparency = arg3.Color.Surface.Surface_100.Transparency
                }
            }
        }
    end, function(arg3)
        local tbl1 = {
            ExtraChildren = arg1.titleChildren,
            BackButton = 0
        }
        local element

        if FFlagCoreUiMigrateUIBloxToFoundation then
            element = Roact.createElement(Image, {
                Image = Assets.Images.NavigateBack,
                tag = "content-emphasis anchor-center-left size-900",
                backgroundStyle = { Transparency = 1 },
                Position = UDim2.new(0, 4, 0.5, 0),
                selection = {
                    NextSelectionDown = arg1.NextSelectionDown,
                    SelectionImageObject = arg2(var2.RoundedRect)
                },
                onActivated = arg1.navigateUp,
                ref = arg1.buttonRef
            })
        else
            element = Roact.createElement(ImageSetButton, {
                BackgroundTransparency = 1,
                Image = Assets.Images.NavigateBack,
                AnchorPoint = Vector2.new(0, 0.5),
                ImageColor3 = arg3.Theme.IconEmphasis.Color,
                ImageTransparency = arg3.Theme.IconEmphasis.Transparency,
                Position = UDim2.new(0, 4, 0.5, 0),
                Size = UDim2.new(0, 36, 0, 36),
                NextSelectionDown = arg1.NextSelectionDown,
                [Roact.Event.Activated] = arg1.navigateUp,
                [Roact.Ref] = arg1.buttonRef,
                SelectionImageObject = arg2(var2.RoundedRect)
            })
        end

        tbl1.BackButton = element

        return Roact.createElement("TextButton", {
            AutoButtonColor = false,
            Text = "",
            BackgroundColor3 = arg3.Theme.BackgroundContrast.Color,
            BackgroundTransparency = arg3.Theme.BackgroundContrast.Transparency,
            BorderSizePixel = 0,
            Position = arg1.position,
            Size = UDim2.new(1, 0, 1, 0),
            Visible = arg1.visible and not arg1.pageIsModal,
            ZIndex = arg1.zIndex,
            Selectable = false
        }, {
            PageTitle = Roact.createElement(ThemedTextLabel, {
                fontKey = "Header1",
                themeKey = "TextEmphasis",
                AnchorPoint = Vector2.new(0.5, 0),
                Position = UDim2.new(0.5, 0, 0, 28),
                Size = UDim2.new(1, -48, 0, 28),
                Text = arg1.pageTitle
            }, tbl1),
            PageContainer = Roact.createElement("Frame", {
                AnchorPoint = Vector2.new(0, 1),
                BackgroundTransparency = 1,
                Position = UDim2.new(0, Constants.Zone.ContentOffset, 1, 0),
                Size = UDim2.new(1, -Constants.Zone.ContentOffset, 1, -68)
            }, arg1[Roact.Children]),
            ZonePortal = Roact.createElement(ZonePortal, { targetZone = 0, direction = Direction.Left })
        })
    end)
end

return RoactRodux.UNSTABLE_connect2(nil, function(callback)
    return {
        navigateUp = function()
            callback(NavigateUp)
        end
    }
end)(function(arg1) -- name: Page
    return var1(function(arg2)
        return renderWithSelectionCursor(arg1, arg2)
    end)
end)
