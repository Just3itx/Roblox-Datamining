-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:41:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitivesParent = script:FindFirstAncestor("ChatUIPrimitives").Parent
local React = require(ChatUIPrimitivesParent.React)

local MessageClockContext = require(script.Parent.Parent.Adornments.MessageClockContext)
local useMessageClock = require(script.Parent.Parent.Adornments.useMessageClock)

local function MessageListClock(tbl1)
    local var1 = React.useContext(MessageClockContext)
    local enabled = tbl1.enabled and var1 == nil
    local var3 = useMessageClock({ enabled = enabled })
    local createElement = React.createElement
    local provider = MessageClockContext.Provider
    local tbl2 = { value = 0 }
    if var1 ~= nil then
        var3 = var1
    elseif not enabled then
        var3 = nil
    end

    tbl2.value = var3
    return createElement(provider, tbl2, tbl1.children)
end

return MessageListClock
