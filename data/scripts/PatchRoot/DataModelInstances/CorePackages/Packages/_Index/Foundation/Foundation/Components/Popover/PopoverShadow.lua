-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:40:40Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local Constants = require(Foundation.Constants)
local Flags = require(Foundation.Utility.Flags)
local Image = require(Foundation.Components.Image)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)
local useTokens = require(Foundation.Providers.Style.useTokens)

local SHADOW_IMAGE = Constants.SHADOW_IMAGE
local var1 = if Flags.FoundationPopoverPluginOverlayMeasurement and Flags.FoundationPluginShadowSize then Constants.PLUGIN_SHADOW_SIZE else Constants.SHADOW_SIZE

local function PopoverShadow(tbl1)
    local var2 = useTokens()

    if not (Flags.FoundationPopoverPluginOverlayMeasurement and Flags.FoundationPluginShadowSize) then
        return (React.createElement(Image, {
            AnchorPoint = tbl1.AnchorPoint,
            Image = SHADOW_IMAGE,
            Size = tbl1.contentSize:map(function(uDim2: UDim2)
                return uDim2 + UDim2.fromOffset(var1, var1)
            end),
            Position = tbl1.position,
            ZIndex = tbl1.ZIndex,
            slice = {
                center = Rect.new(var1, var1, var1 + 1, var1 + 1)
            },
            imageStyle = var2.Color.Extended.Black.Black_20,
            testId = tbl1.testId
        }))
    end

    local createElement = React.createElement
    local var3 = View
    local tbl2 = {
        Size = tbl1.contentSize:map(function(uDim2: UDim2)
            return uDim2 + UDim2.fromOffset(var1, var1)
        end),
        Position = tbl1.position,
        ZIndex = tbl1.ZIndex,
        Transparency = 1,
        tag = {
            [tbl1.radiusTag] = true
        },
        testId = tbl1.testId
    }

    return (createElement(
        var3,
        tbl2,
        React.createElement("UIShadow", {
            Offset = UDim2.fromOffset(0, 2),
            Transparency = 0.92,
            BlurRadius = UDim.new(0, 4),
            Color = var2.Color.Extended.Black.Black_100.Color3,
            ZIndex = -1,
            Spread = UDim2.fromOffset(-1, -1)
        })
    ))
end
return PopoverShadow
