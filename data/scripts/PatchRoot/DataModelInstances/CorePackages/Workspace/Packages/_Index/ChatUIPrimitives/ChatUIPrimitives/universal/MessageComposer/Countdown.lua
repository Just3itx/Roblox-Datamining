-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:31:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitives = script:FindFirstAncestor("ChatUIPrimitives")
local ChatUIPrimitivesParent = ChatUIPrimitives.Parent

local RunService = game:GetService("RunService")

local Foundation = require(ChatUIPrimitivesParent.Foundation)
local React = require(ChatUIPrimitivesParent.React)
local useEventConnection = require(ChatUIPrimitivesParent.ReactUtils).useEventConnection
local useRobloxLocale = require(ChatUIPrimitives.Hooks.useRobloxLocale)

local function formatRemaining(untilTimestamp: number, locale: string): string -- Luacid: Inlined by compiler; 1 call site recovered
    local unixTimestamp = math.max(math.floor(untilTimestamp - DateTime.now().UnixTimestamp), 0)
    local format = if unixTimestamp >= 3600 then "HH:mm:ss" else "m:ss"
    return DateTime.fromUnixTimestamp(unixTimestamp):FormatUniversalTime(format, locale)
end

local function Countdown(tbl1)
    local locale = useRobloxLocale()
    local untilTimestamp = tbl1.untilTimestamp
    local var1 = tbl1.testHeartbeat or RunService.Heartbeat
    local var2, var3 = React.useBinding(formatRemaining(untilTimestamp, locale))

    local var4 = React.useCallback(function()
        local str1 = formatRemaining(untilTimestamp, locale)
        if str1 ~= var2:getValue() then
            var3(str1)
        end
    end, {
        untilTimestamp,
        locale,
        var2,
        var3
    })

    useEventConnection(var1, var4)

    return React.createElement(Foundation.Text, {
        tag = "auto-xy text-title-medium text-no-wrap content-default",
        Text = var2,
        testId = "countdown",
        LayoutOrder = tbl1.LayoutOrder
    })
end

return Countdown
