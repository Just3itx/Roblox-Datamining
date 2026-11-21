-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:21:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitives = script:FindFirstAncestor("ChatUIPrimitives")
local ChatUIPrimitivesParent = ChatUIPrimitives.Parent
local React = require(ChatUIPrimitivesParent.React)
local Foundation = require(ChatUIPrimitivesParent.Foundation)
local Signals = require(ChatUIPrimitivesParent.Signals)
local SignalsReact = require(ChatUIPrimitivesParent.SignalsReact)
local useInExperienceLocalization = require(ChatUIPrimitives.Hooks.useInExperienceLocalization)
local useRobloxLocale = require(ChatUIPrimitives.Hooks.useRobloxLocale)
local formatTimestamp = require(script.Parent.Parent.MessageList.formatTimestamp)
local getRelativeTimestampLabel = require(script.Parent.getRelativeTimestampLabel)
local MessageClockContext = require(script.Parent.MessageClockContext)
local useMessageClock = require(script.Parent.useMessageClock)
local TimestampFormatContext = require(script.Parent.TimestampFormatContext)

return React.memo(function(tbl1) -- name: MessageTimestamp
    local var1 = useInExperienceLocalization()
    local var2 = useRobloxLocale()
    local var3 = React.useContext(MessageClockContext)
    local var4 = useMessageClock({ enabled = var3 == nil })
    if var3 == nil then
        var3 = var4
    end
    local getSentAtUnixMilliseconds = tbl1.getSentAtUnixMilliseconds
    local bool1 = React.useContext(TimestampFormatContext) == "absolute"

    local var5 = React.useMemo(function()
        local function formatAbsolute(num1: number, num2: number)
            return formatTimestamp(num1, num2, var2)
        end
        return Signals.createComputed(function(arg1)
            local sentAtUnixMilliseconds = getSentAtUnixMilliseconds(arg1)
            local var5 = var3(arg1)
            if bool1 then
                return formatAbsolute(sentAtUnixMilliseconds, var5)
            end
            return getRelativeTimestampLabel(sentAtUnixMilliseconds, var5, var1, formatAbsolute)
        end)
    end, {
        getSentAtUnixMilliseconds,
        var3,
        var1,
        var2,
        bool1
    })

    local var6 = SignalsReact.useSignalBinding(var5)

    local tag = Foundation.Hooks.useDefaultTags(tbl1.tag, "auto-xy")
    return React.createElement(Foundation.Text, { tag = tag, Text = var6, LayoutOrder = tbl1.LayoutOrder, testId = tbl1.testId })
end)
