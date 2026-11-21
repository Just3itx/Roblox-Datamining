-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:41:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitives = script:FindFirstAncestor("ChatUIPrimitives")
local ChatUIPrimitivesParent = ChatUIPrimitives.Parent
local React = require(ChatUIPrimitivesParent.React)
local Foundation = require(ChatUIPrimitivesParent.Foundation)
local Signals = require(ChatUIPrimitivesParent.Signals)
local SignalsReact = require(ChatUIPrimitivesParent.SignalsReact)
local useRobloxLocale = require(ChatUIPrimitives.Hooks.useRobloxLocale)
local _groupMessages = require(script.Parent.groupMessages)
local formatTimestamp = require(script.Parent.formatTimestamp)
local Sizing = require(script.Parent.Parent.Sizing)

local function TimestampText(tbl1)
    local var1 = Sizing.useSizing()
    local tag = Foundation.Hooks.useDefaultTags(var1.timestamp.tag, "size-full-0 auto-y text-align-x-center")
    return React.createElement(Foundation.Text, { tag = tag, Text = tbl1.label })
end

return if require(ChatUIPrimitives.Flags.FFlagExpChatLocalizeMessageTimestamp) then function(tbl1) -- name: TimestampItemLocalized
    local var1 = useRobloxLocale()
    local itemSignal = tbl1.itemSignal
    local var2 = React.useMemo(function()
        return Signals.createComputed(function(arg1)
            local var2 = itemSignal(arg1)
            return formatTimestamp(var2.displayUnixMilliseconds, var2.referenceUnixMilliseconds, var1)
        end)
    end, { itemSignal, var1 })
    local label = SignalsReact.useSignalBinding(var2)
    return React.createElement(TimestampText, { label = label })
end else function(tbl1) -- name: TimestampItemDefault
    local label = SignalsReact.useSignalBinding(function(arg1)
        local var1 = tbl1.itemSignal(arg1)
        return formatTimestamp(var1.displayUnixMilliseconds, var1.referenceUnixMilliseconds)
    end)
    return React.createElement(TimestampText, { label = label })
end
