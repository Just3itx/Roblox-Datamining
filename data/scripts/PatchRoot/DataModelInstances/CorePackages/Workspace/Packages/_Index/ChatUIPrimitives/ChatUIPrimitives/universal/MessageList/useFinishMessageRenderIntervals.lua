-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:41:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitives = script:FindFirstAncestor("ChatUIPrimitives")
local ChatUIPrimitivesParent = ChatUIPrimitives.Parent
local React = require(ChatUIPrimitivesParent.React)
local Signals = require(ChatUIPrimitivesParent.Signals)
local SignalsReact = require(ChatUIPrimitivesParent.SignalsReact)

local useFinishChatWindowMessageRenderIntervals = require(ChatUIPrimitives.Hooks.useFinishChatWindowMessageRenderIntervals)
local _groupMessages = require(script.Parent.groupMessages)

local function useFinishMessageRenderIntervals(arg1)
    local var1 = React.useMemo(function()
        return Signals.createComputed(function(arg2)
            return arg1(arg2).id
        end)
    end, { arg1 })
    local var2 = SignalsReact.useSignalState(var1)
    local var3 = React.useCallback(function()
        return var2
    end, { var2 })
    local var4 = useFinishChatWindowMessageRenderIntervals(var3)
    React.useEffect(function()
        var4()
    end, { var4 })
end

return useFinishMessageRenderIntervals
