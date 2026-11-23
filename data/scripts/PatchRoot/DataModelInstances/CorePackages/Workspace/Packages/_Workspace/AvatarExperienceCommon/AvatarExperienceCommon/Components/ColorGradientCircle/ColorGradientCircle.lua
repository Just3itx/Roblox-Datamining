-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:20:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommonParent = script:FindFirstAncestor("AvatarExperienceCommon").Parent

local React = require(AvatarExperienceCommonParent.React)
local Foundation = require(AvatarExperienceCommonParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local generateColorSequence = require(script.Parent.Utils.generateColorSequence)

local bool1 = game:DefineFastFlag("AXColorGradientRenderFlatWithJustOneColor", false)

local function ColorGradientCircle(tbl1)
    local var1 = useTokens()

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        Size = tbl1.Size,
        Position = tbl1.Position,
        AnchorPoint = tbl1.AnchorPoint,
        BackgroundTransparency = 0
    }
    local tbl3 = {
        UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0.5, 0) }),
        UIGradient = 0,
        UIStroke = 0
    }
    local element

    if bool1 and #tbl1.Colors == 1 then
        element = React.createElement(
            Foundation.View,
            {
                tag = "size-full-full radius-circle",
                backgroundStyle = {
                    Color3 = tbl1.Colors[1],
                    Transparency = 0
                }
            }
        )
    else
        element = React.createElement("UIGradient", {
            Rotation = tbl1.Rotation or 45,
            Color = generateColorSequence(tbl1.Colors),
            Transparency = tbl1.Transparency or NumberSequence.new(0),
            Offset = tbl1.Offset or Vector2.new(0, 0)
        })
    end

    tbl3.UIGradient = element

    tbl3.UIStroke = if tbl1.hasBorder then React.createElement("UIStroke", { Thickness = 2, Color = var1.Color.System.Contrast.Color3 }) else nil
    return createElement(str1, tbl2, tbl3)
end

return ColorGradientCircle
