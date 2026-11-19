-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:40:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local t = InGameMenuDependencies.t
local Roact = InGameMenuDependencies.Roact
local UIBlox = InGameMenuDependencies.UIBlox

local ImageSetButton = UIBlox.Core.ImageSet.ImageSetButton
local Images = UIBlox.App.ImageSet.Images
local Foundation = require(CorePackages.Packages.Foundation)
local FFlagCoreUiMigrateUIBloxToFoundation = require(CorePackages.Workspace.Packages.SharedFlags).FFlagCoreUiMigrateUIBloxToFoundation
local var1 = if FFlagCoreUiMigrateUIBloxToFoundation then Foundation.UNSTABLE.withCursorMigration else UIBlox.App.SelectionImage.withSelectionCursorProvider
local var2 = if FFlagCoreUiMigrateUIBloxToFoundation then Foundation.Enums.CursorType else UIBlox.App.SelectionImage.CursorKind
local Image = Foundation.Image

local var3 = if FFlagCoreUiMigrateUIBloxToFoundation then "icons/menu/home_on" else Images["icons/menu/home_on"]
local var4 = if FFlagCoreUiMigrateUIBloxToFoundation then "icons/menu/home_off" else Images["icons/menu/home_off"]

local var5 = Roact.PureComponent:extend("HomeButton")

var5.validateProps = t.strictInterface({
    on = t.optional(t.boolean),
    anchorPoint = t.optional(t.Vector2),
    position = t.optional(t.UDim2),
    layoutOrder = t.optional(t.integer),
    onActivated = t.callback
})

var5.defaultProps = { on = false }

function var5.renderWithSelectionCursor(arg1, arg2)
    local image = arg1.props.on and var3 or var4
    local createElement = Roact.createElement
    local str1 = "Frame"
    local tbl1 = {
        AnchorPoint = arg1.props.anchorPoint,
        BackgroundTransparency = 1,
        Position = arg1.props.position,
        Size = UDim2.fromOffset(64, 64),
        LayoutOrder = arg1.props.layoutOrder
    }
    local tbl2 = { HomeButton = 0 }
    local element

    if FFlagCoreUiMigrateUIBloxToFoundation then
        element = Roact.createElement(Image, {
            Image = image,
            tag = "position-center-center anchor-center-center size-800",
            backgroundStyle = { Transparency = 1 },
            selection = {
                SelectionImageObject = arg2(var2.RoundedRect)
            },
            onActivated = arg1.props.onActivated
        })
    else
        element = Roact.createElement(ImageSetButton, {
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            Image = image,
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromOffset(32, 32),
            SelectionImageObject = arg2(var2.RoundedRect),
            [Roact.Event.Activated] = arg1.props.onActivated
        })
    end

    tbl2.HomeButton = element
    return createElement(str1, tbl1, tbl2)
end

function var5.render(arg1)
    return var1(function(arg2)
        return arg1:renderWithSelectionCursor(arg2)
    end)
end

return var5
