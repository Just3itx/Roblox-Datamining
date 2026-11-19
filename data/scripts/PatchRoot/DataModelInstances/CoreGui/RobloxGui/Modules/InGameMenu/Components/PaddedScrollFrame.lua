-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:31:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local t = InGameMenuDependencies.t

local withFoundationOrUIBloxStyle = require(CorePackages.Workspace.Packages.CoreGuiCommon).withFoundationOrUIBloxStyle

local scriptParentParent = script.Parent.Parent

local Assets = require(scriptParentParent.Resources.Assets)

local GlobalConfig = require(scriptParentParent.GlobalConfig)

local var1 = t.strictInterface({
    Size = t.optional(t.UDim2),
    AnchorPoint = t.optional(t.UDim2),
    CanvasSize = t.optional(t.UDim2),
    Position = t.optional(t.UDim2),
    [Roact.Children] = t.optional(t.table)
})

local function PaddedScrollFrame(arg1)
    if GlobalConfig.propValidation then
        assert(var1(arg1))
    end
    return withFoundationOrUIBloxStyle(function(arg2)
        return {
            Theme = {
                UIEmphasis = {
                    Color = arg2.Color.Shift.Shift_400.Color3,
                    Transparency = arg2.Color.Shift.Shift_400.Transparency
                }
            }
        }
    end, function(arg2)
        return Roact.createElement("ScrollingFrame", {
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ScrollBarImageColor3 = arg2.Theme.UIEmphasis.Color,
            ScrollBarImageTransparency = arg2.Theme.UIEmphasis.Transparency,
            BottomImage = Assets.Images.ScrollBottom,
            MidImage = Assets.Images.ScrollMid,
            TopImage = Assets.Images.ScrollTop,
            ClipsDescendants = false,
            ScrollBarThickness = 12,
            Size = arg1.Size,
            AnchorPoint = arg1.AnchorPoint,
            CanvasSize = arg1.CanvasSize,
            Position = arg1.Position
        }, arg1[Roact.Children])
    end)
end

return PaddedScrollFrame
