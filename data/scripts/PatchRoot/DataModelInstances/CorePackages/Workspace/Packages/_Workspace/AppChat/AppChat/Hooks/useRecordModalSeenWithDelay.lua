-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:41:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local AppChatNetworking = require(AppChatParent.AppChatNetworking)
local React = require(AppChatParent.React)
local useDispatch = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useDispatch
local LuauPolyfill = require(AppChatParent.LuauPolyfill)
local clearTimeout = LuauPolyfill.clearTimeout
local setTimeout = LuauPolyfill.setTimeout
local StatusCodes = require(AppChatParent.Http).StatusCodes
local Logger = require(AppChat.Logger)

local useRecordModalSequenceResponseForConversation = require(AppChat.Hooks.useRecordModalSequenceResponseForConversation)

local function useRecordModalSeenWithDelay(tbl1)
    local var1 = useDispatch()
    local var2, var3 = React.useState(false)

    local var4 = useRecordModalSequenceResponseForConversation(tbl1.conversationId)
    React.useEffect(function()
        var3(false)
    end, {
        tbl1.modalSequence,
        tbl1.modalId,
        tbl1.conversationId,
        tbl1.modalVariant
    })

    local var5 = tbl1.canRecordAction and not var2 and tbl1.actionToRecord and tbl1.modalSequence and (tbl1.modalId or tbl1.modalVariant)
    local var6 = React.useCallback(function()
        local actionToRecord = tbl1.actionToRecord
        local var6 = if tbl1.conversationId then var4(actionToRecord, tbl1.modalSequence, tbl1.modalId, tbl1.modalVariant) else var1(AppChatNetworking.rodux.RecordModalSequenceResponse.API(actionToRecord, tbl1.modalSequence, tbl1.modalId))

        var6:andThen(function(arg1)
            if arg1 and arg1.responseCode == StatusCodes.OK then
                var3(true)
            end
        end):catch(function(arg1)
            Logger:warning(
                `Error in {tbl1.modalSequence} {tbl1.modalId} -> RecordModalSequenceResponse seen: {tostring(arg1)}`
            )
        end)
    end, {
        var1,
        tbl1.actionToRecord,
        tbl1.modalId,
        tbl1.modalSequence,
        tbl1.conversationId,
        var4
    })

    React.useEffect(function()
        local var7 = nil
        if var5 then
            if tbl1.delayMs and tbl1.delayMs > 0 then
                var7 = setTimeout(var6, tbl1.delayMs)
            else
                var6()
            end
        end
        return function()
            if var7 then
                clearTimeout(var7)
            end
        end
    end, { tbl1.delayMs, var6, var5 })
end
return useRecordModalSeenWithDelay
