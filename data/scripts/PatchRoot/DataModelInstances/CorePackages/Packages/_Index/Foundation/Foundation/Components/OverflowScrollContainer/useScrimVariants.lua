-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:11:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local Icon = require(FoundationParent.BuilderIcons).Icon

local getBuilderIconForKeycode = require(Foundation.Utility.getBuilderIconForKeycode)

local _Tokens = require(Foundation.Providers.Style.Tokens)

local VariantsContext = require(Foundation.Providers.Style.VariantsContext)

local numberSequence = NumberSequence.new(
    { NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.25, 0), NumberSequenceKeypoint.new(1, 1) }
)

local numberSequence2 = NumberSequence.new(
    { NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.4, 0), NumberSequenceKeypoint.new(1, 1) }
)

local numberSequence3 = NumberSequence.new(
    { NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.75, 0), NumberSequenceKeypoint.new(1, 0) }
)

local numberSequence4 = NumberSequence.new(
    { NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.6, 0), NumberSequenceKeypoint.new(1, 0) }
)

local function variantsFactory(arg1)
    local size1000 = arg1.Size.Size_1000

    local gradient = {
        [Enum.HorizontalAlignment.Right] = { [true] = numberSequence4, [false] = numberSequence3 },
        [Enum.HorizontalAlignment.Left] = { [true] = numberSequence2, [false] = numberSequence }
    }

    return {
        fade = size1000,
        directionIcon = {
            [Enum.HorizontalAlignment.Right] = {
                [Enum.PreferredInput.Gamepad] = getBuilderIconForKeycode(Enum.KeyCode.ButtonR1) or Icon.ChevronSmallRight,
                [Enum.PreferredInput.KeyboardAndMouse] = Icon.ChevronSmallRight,
                [Enum.PreferredInput.Touch] = Icon.ChevronSmallRight
            },
            [Enum.HorizontalAlignment.Left] = {
                [Enum.PreferredInput.Gamepad] = getBuilderIconForKeycode(Enum.KeyCode.ButtonL1) or Icon.ChevronSmallLeft,
                [Enum.PreferredInput.KeyboardAndMouse] = Icon.ChevronSmallLeft,
                [Enum.PreferredInput.Touch] = Icon.ChevronSmallLeft
            }
        },
        gradient = gradient,
        iconAlignmentTag = {
            [Enum.HorizontalAlignment.Right] = "anchor-center-right position-center-right",
            [Enum.HorizontalAlignment.Left] = "anchor-center-left position-center-left"
        }
    }
end
return function(arg1, arg2, arg3)
    local var1 = VariantsContext.useVariants("OverflowScrollContainerScrim", variantsFactory, arg1)

    return {
        fade = var1.fade,
        gradient = var1.gradient[arg2][false],
        hoverGradient = var1.gradient[arg2][true],
        directionIcon = var1.directionIcon[arg2][arg3],
        iconAlignmentTag = var1.iconAlignmentTag[arg2]
    }
end
