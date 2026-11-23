-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:31:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceInspectAndBuy = script:FindFirstAncestor("AvatarExperienceInspectAndBuy")
local AvatarExperienceInspectAndBuyParent = AvatarExperienceInspectAndBuy.Parent
local React = require(AvatarExperienceInspectAndBuyParent.React)
local useSelector = require(AvatarExperienceInspectAndBuyParent.RoactUtils).Hooks.RoactRodux.useSelector
local tutils = require(AvatarExperienceInspectAndBuyParent.tutils)
local useTokens = require(AvatarExperienceInspectAndBuyParent.Foundation).Hooks.useTokens

local ViewType = require(AvatarExperienceInspectAndBuy.Enums.ViewType)

local function selectView(arg1)
    return arg1.view
end

local function useViewBreakpoints(yOffset: number)
    local var1 = useTokens()
    return React.useMemo(function()
        return {
            [ViewType.Wide] = {
                ContainerSize = UDim2.new(0, 800, 0.9, -yOffset),
                ContainerAnchorPoint = Vector2.new(0.5, 0.5),
                ContainerPosition = UDim2.new(0.5, 0, 0.5, yOffset / 2),
                OverlaySize = UDim2.new(1, 0, 1, yOffset),
                OverlayPosition = UDim2.new(0, 0, 0, -yOffset)
            },
            [ViewType.WideLandscape] = {
                ContainerSize = UDim2.new(0.95, 0, 1, -yOffset),
                ContainerAnchorPoint = Vector2.new(0.5, 0),
                ContainerPosition = UDim2.new(0.5, 0, 0, yOffset + var1.Padding.XSmall),
                OverlaySize = UDim2.new(1, 0, 1, yOffset),
                OverlayPosition = UDim2.new(0, 0, 0, -yOffset)
            },
            [ViewType.Compact] = {
                ContainerSize = UDim2.new(1, 0, 1, -yOffset),
                ContainerAnchorPoint = Vector2.new(0, 0),
                ContainerPosition = UDim2.new(0, 0, 0, yOffset + var1.Padding.Small),
                OverlaySize = UDim2.new(1, 0, 1, yOffset),
                OverlayPosition = UDim2.new(0, 0, 0, -yOffset)
            }
        }
    end, { yOffset })[useSelector(selectView, tutils.deepEqual)] or {}
end

return useViewBreakpoints
