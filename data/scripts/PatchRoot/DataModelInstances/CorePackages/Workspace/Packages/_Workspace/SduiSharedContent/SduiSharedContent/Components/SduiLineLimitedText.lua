-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:00:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent

local React = require(SduiSharedContentParent.React)
local Cryo = require(SduiSharedContentParent.Cryo)
local Foundation = require(SduiSharedContentParent.Foundation)
local SignalsReact = require(SduiSharedContentParent.SignalsReact)
local TextSize = require(SduiSharedContentParent.TextSize)
local getPreferredTextSizeLineBudget = require(SduiSharedContentParent.SduiSharedUtilities).getPreferredTextSizeLineBudget

local SduiText = require(script.Parent.SduiText)

local useTokens = Foundation.Hooks.useTokens

local function SduiLineLimitedText(arg1)
    local var1 = useTokens()
    local var2 = SignalsReact.useSignalState(function(arg2)
        return TextSize.getTextSizeStore(arg2).getTextSizeOffset(arg2)
    end)

    local num1 = math.max(arg1.maxLines or 1, 1)
    local var3 = arg1.fontStyle or var1.Typography.BodyMedium

    local var4 = num1 * var3.FontSize * var3.LineHeight + getPreferredTextSizeLineBudget(var2, num1)
    local x = if arg1.size then arg1.size.X else UDim.new(1, 0)
    return React.createElement(
        SduiText,
        Cryo.Dictionary.join(arg1, {
            automaticSize = Cryo.None,
            maxLines = Cryo.None,
            size = UDim2.new(x, UDim.new(0, math.ceil(var4))),
            textWrapped = if arg1.textWrapped ~= nil then arg1.textWrapped else num1 > 1,
            textTruncate = if arg1.textTruncate ~= nil then arg1.textTruncate else Enum.TextTruncate.SplitWord
        })
    )
end

return SduiLineLimitedText
