-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:10:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContent = script:FindFirstAncestor("SduiSharedContent")
local SduiSharedContentParent = SduiSharedContent.Parent

local Promise = require(SduiSharedContentParent.Promise)
local React = require(SduiSharedContentParent.React)
local SignalsReact = require(SduiSharedContentParent.SignalsReact)

local _ContentReactionsStoreTypes = require(SduiSharedContent.Stores.ContentReactionsStoreTypes)
local createContentReactionsStore = require(SduiSharedContent.Stores.createContentReactionsStore)
local getContentReactionsStore = require(SduiSharedContent.Stores.getContentReactionsStore)

local tbl1 = {}

local function useOptimisticReactions(str1: string?, tbl2, func1: ((...any) -> (...any))?)
    local tbl3 = tbl2 or tbl1
    local str2 = str1 or ""
    local bool1 = str2 == ""
    local var1 = React.useMemo(function()
        if bool1 then
            return (createContentReactionsStore())
        end

        return nil
    end, { bool1 })
    local var2 = var1 or getContentReactionsStore(false)

    React.useEffect(function()
        return if var1 then var1.dispose else nil
    end, { var1 })

    local var3 = SignalsReact.useSignalState(var2.getContentReactions(str2).data)

    local var4 = React.useMemo(function()
        return var2.getReactions(str2, tbl3)
    end, {
        var2,
        str2,
        var3,
        tbl3
    })
    React.useEffect(function()
        var2.reconcileReactions(str2, tbl3)
    end, { var2, str2, tbl3 })

    return var4, (React.useCallback(function(arg1)
        local emoteId = arg1.emoteId
        if emoteId == "" or func1 == nil or var2.isReactionPending(str2, emoteId) then
            return
        end

        local bool2 = not arg1.hasUserAppliedReaction
        local var5 = func1(nil, nil, { emoteId = emoteId, shouldAdd = bool2 })

        if not Promise.is(var5) then
            return
        end

        var2.updateReaction(str2, tbl3, arg1, {
            emoteId = emoteId,
            reactionType = arg1.reactionType,
            hasUserAppliedReaction = bool2,
            reactionCount = math.max(0, (arg1.reactionCount or 0) + (if bool2 then 1 else -1))
        }, var5)
    end, {
        var2,
        str2,
        tbl3,
        func1
    }))
end
return useOptimisticReactions
