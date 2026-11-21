-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:40:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitivesParent = script:FindFirstAncestor("ChatUIPrimitives").Parent
local React = require(ChatUIPrimitivesParent.React)
local Signals = require(ChatUIPrimitivesParent.Signals)
local SignalsReact = require(ChatUIPrimitivesParent.SignalsReact)

local _Types = require(script.Parent.Parent.Parent.Types)
local _groupMessages = require(script.Parent.Parent.groupMessages)
local useMessageRowContents = require(script.Parent.Parent.useMessageRowContents)

local function hasIdentity(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
    return not (arg1.message.author == nil) and arg1.groupPosition.isFirst
end

local function renderKeyOf(arg1): string -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = if arg1.message.deliveryState == nil then "" else arg1.message.deliveryState
    local var2 = hasIdentity(arg1)
    return `{var2}|{var1}`
end

local function useMessageInlineViewModel(arg1)
    local var1 = useMessageRowContents(arg1)
    local var2 = React.useMemo(function()
        return Signals.createComputed(function(arg2): string
            return renderKeyOf((arg1(arg2)))
        end)
    end, { arg1 })
    local tbl1 = { arg1, (SignalsReact.useSignalState(var2)) }

    local var3 = React.useMemo(function()
        local var3 = arg1(false)
        return {
            hasIdentity = hasIdentity(var3),
            deliveryState = var3.message.deliveryState
        }
    end, tbl1)

    return {
        hasIdentity = var3.hasIdentity,
        getIdentity = var1.getIdentity,
        contents = var1.contents,
        deliveryState = var3.deliveryState,
        replyText = var1.replyText
    }
end

return useMessageInlineViewModel
