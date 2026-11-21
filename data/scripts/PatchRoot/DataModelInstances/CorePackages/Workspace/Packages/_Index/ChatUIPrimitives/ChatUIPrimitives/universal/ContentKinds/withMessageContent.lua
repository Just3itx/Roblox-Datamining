-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:31:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitivesParent = script:FindFirstAncestor("ChatUIPrimitives").Parent
local React = require(ChatUIPrimitivesParent.React)
local _Signals = require(ChatUIPrimitivesParent.Signals)

local _Types = require(script.Parent.Parent.Types)

local function withMessageContent(arg1, func1: (...any) -> (...any))
    local function MessageContentAdapter(tbl1)
        local getContent = React.useMemo(function()
            return function(arg2)
                local var1 = func1(tbl1.getContent(arg2))
                assert(var1 ~= nil, "Message content did not match its registered renderer")
                return var1
            end
        end, { tbl1.getContent })

        return React.createElement(arg1, { getContent = getContent, LayoutOrder = tbl1.LayoutOrder })
    end

    return MessageContentAdapter
end

return withMessageContent
