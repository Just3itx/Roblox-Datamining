-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:01:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCommon = script:FindFirstAncestor("MomentsCommon")
local MomentsCommonParent = MomentsCommon.Parent

local Cryo = require(MomentsCommonParent.Cryo)
local Foundation = require(MomentsCommonParent.Foundation)
local React = require(MomentsCommonParent.React)

local View = Foundation.View

local getEasingNumberSequence = require(MomentsCommon.Utils.getEasingNumberSequence)

local useMemo = React.useMemo

local tbl1 = {
    anchorPoint = Vector2.new(0, 0),
    endingTransparency = 1,
    position = UDim2.fromScale(0, 0),
    startingTransparency = 0.4
}

return function(tbl2)
    local var1 = Cryo.Dictionary.union(tbl1, tbl2)

    local var2 = useMemo(function()
        return NumberSequence.new(
            getEasingNumberSequence(
                var1.startingTransparency,
                var1.endingTransparency,
                15,
                Enum.EasingStyle.Sine,
                Enum.EasingDirection.InOut
            )
        )
    end, { var1.startingTransparency, var1.endingTransparency })

    return React.createElement(View, {
        AnchorPoint = var1.anchorPoint,
        tag = "bg-contrast",
        Position = var1.position,
        Size = var1.size,
        ZIndex = var1.zIndex or 1
    }, {
        UIGradient = React.createElement("UIGradient", {
            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, var1.color3), ColorSequenceKeypoint.new(1, var1.color3) }),
            Rotation = var1.rotation,
            Transparency = var2
        })
    })
end
