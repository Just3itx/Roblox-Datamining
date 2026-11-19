-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:31:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local t = InGameMenuDependencies.t
local UIBlox = InGameMenuDependencies.UIBlox

local scriptParentParent = script.Parent.Parent

local Assets = require(scriptParentParent.Resources.Assets)

local GlobalConfig = require(scriptParentParent.GlobalConfig)

local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel

local Image = require(CorePackages.Packages.Foundation).Image
local FFlagCoreUiMigrateUIBloxToFoundation = require(CorePackages.Workspace.Packages.SharedFlags).FFlagCoreUiMigrateUIBloxToFoundation

local tbl1 = {
    [Enum.UserInputType.MouseButton1] = Assets.Images.Mouse1Press,
    [Enum.UserInputType.MouseButton2] = Assets.Images.Mouse2Press,
    [Enum.UserInputType.MouseWheel] = Assets.Images.MouseWheelScroll
}

local var1 = t.strictInterface({
    input = t.enum(Enum.UserInputType),
    AnchorPoint = t.optional(t.Vector2),
    Position = t.optional(t.UDim2),
    LayoutOrder = t.optional(t.integer)
})

local function PointerLabel(arg1)
    if GlobalConfig.propValidation then
        assert(var1(arg1))
    end

    local image = tbl1[arg1.input]

    if not FFlagCoreUiMigrateUIBloxToFoundation then
        return Roact.createElement(ImageSetLabel, {
            BackgroundTransparency = 1,
            Image = image,
            Size = UDim2.new(0, 36, 0, 36),
            Position = arg1.Position,
            AnchorPoint = arg1.AnchorPoint,
            LayoutOrder = arg1.LayoutOrder
        })
    end

    return Roact.createElement(Image, {
        Image = image.Image,
        imageRect = {
            offset = image.ImageRectOffset,
            size = image.ImageRectSize
        },
        Size = UDim2.new(0, 36, 0, 36),
        Position = arg1.Position,
        AnchorPoint = arg1.AnchorPoint,
        LayoutOrder = arg1.LayoutOrder
    })
end

return PointerLabel
