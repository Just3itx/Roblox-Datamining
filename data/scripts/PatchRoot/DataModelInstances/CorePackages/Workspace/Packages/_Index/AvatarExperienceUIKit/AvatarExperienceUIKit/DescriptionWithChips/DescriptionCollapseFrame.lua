-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:01:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceUIKit = script:FindFirstAncestor("AvatarExperienceUIKit")
local AvatarExperienceUIKitParent = AvatarExperienceUIKit.Parent
local React = require(AvatarExperienceUIKitParent.React)
local ReactOtter = require(AvatarExperienceUIKitParent.ReactOtter)
local Foundation = require(AvatarExperienceUIKitParent.Foundation)
local makeOtterSpringValue = require(AvatarExperienceUIKit.Utils.makeOtterSpringValue)

local View = Foundation.View

local tbl1 = { dampingRatio = 1, frequency = 3.5 }

local function toFullWidthSize(yOffset: number): UDim2
    return UDim2.new(1, 0, 0, yOffset)
end

local function DescriptionCollapseFrame(tbl2)
    local var1, var2 = ReactOtter.useAnimatedBinding(tbl2.height)
    local var3 = React.useRef(tbl2.isExpanded)

    React.useEffect(function()
        if var3.current ~= tbl2.isExpanded then
            var3.current = tbl2.isExpanded
            var2(makeOtterSpringValue(tbl2.height, tbl1))
            return
        end
        var2((ReactOtter.instant(tbl2.height)))
    end, { tbl2.height, tbl2.isExpanded })

    local var4 = React.useMemo(function()
        return var1:map(toFullWidthSize)
    end, { var1 })

    return React.createElement(
        View,
        {
            tag = "clip",
            Size = var4,
            LayoutOrder = tbl2.LayoutOrder,
            testId = tbl2.testId
        },
        tbl2.children
    )
end
return DescriptionCollapseFrame
