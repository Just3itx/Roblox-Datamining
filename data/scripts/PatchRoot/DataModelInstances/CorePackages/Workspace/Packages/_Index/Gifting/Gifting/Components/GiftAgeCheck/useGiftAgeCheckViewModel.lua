-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:21:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GiftingParent = script:FindFirstAncestor("Gifting").Parent
local React = require(GiftingParent.React)
local Foundation = require(GiftingParent.Foundation)

local _GiftAgeCheckView = require(script.Parent.GiftAgeCheckView)

local function useGiftAgeCheckViewModel(tbl1)
    local mobileSnapPoint = Foundation.Hooks.useScaledValue(363)
    local xOffset = Foundation.Hooks.useScaledValue(320)
    local yOffset = Foundation.Hooks.useScaledValue(180)
    local pictogramSize = React.useMemo(function(): UDim2
        return UDim2.fromOffset(xOffset, yOffset)
    end, { xOffset, yOffset })

    return {
        isOpen = tbl1.isOpen,
        titleText = tbl1.copy.titleText,
        descriptionText = tbl1.copy.descriptionText,
        continueLabel = tbl1.copy.continueLabel,
        mobileSnapPoint = mobileSnapPoint,
        pictogramSize = pictogramSize,
        onContinue = tbl1.onContinue,
        onClose = tbl1.onClose
    }
end

return useGiftAgeCheckViewModel
