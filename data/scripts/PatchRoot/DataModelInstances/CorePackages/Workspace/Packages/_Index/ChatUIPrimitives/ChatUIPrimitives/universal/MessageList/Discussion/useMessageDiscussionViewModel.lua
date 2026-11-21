-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:40:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitivesParent = script:FindFirstAncestor("ChatUIPrimitives").Parent
local React = require(ChatUIPrimitivesParent.React)
local Signals = require(ChatUIPrimitivesParent.Signals)
local SignalsReact = require(ChatUIPrimitivesParent.SignalsReact)

local _Types = require(script.Parent.Parent.Parent.Types)
local _groupMessages = require(script.Parent.Parent.groupMessages)
local useMessageRowContents = require(script.Parent.Parent.useMessageRowContents)

local function renderKeyOf(arg1): string -- Luacid: Inlined by compiler; 1 call site recovered
    local author = arg1.message.author
    local var1 = if author == nil then "" else author.userId
    return `{arg1.groupPosition.isFirst}|{var1}`
end

local function useMessageDiscussionViewModel(arg1)
    local var1 = useMessageRowContents(arg1)
    local var2 = React.useMemo(function()
        return Signals.createComputed(function(arg2): string
            return renderKeyOf((arg1(arg2)))
        end)
    end, { arg1 })
    local var3 = SignalsReact.useSignalState(var2)

    local getSentAtUnixMilliseconds = React.useMemo(function()
        return Signals.createComputed(function(arg2)
            return arg1(arg2).message.sentAtUnixMilliseconds
        end)
    end, { arg1 })

    return {
        showIdentity = React.useMemo(function()
            local var5 = arg1(false)
            return {
                showIdentity = var5.groupPosition.isFirst and var5.message.author ~= nil
            }
        end, { arg1, var3 }).showIdentity,
        getIdentity = var1.getIdentity,
        getSentAtUnixMilliseconds = getSentAtUnixMilliseconds,
        contents = var1.contents
    }
end

return useMessageDiscussionViewModel
