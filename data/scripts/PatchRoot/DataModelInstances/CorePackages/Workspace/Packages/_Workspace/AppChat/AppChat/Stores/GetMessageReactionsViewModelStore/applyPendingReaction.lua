-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:20:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local _AppChatNetworking = require(AppChatParent.AppChatNetworking)

local _createMessageReactionsStore = require(script.Parent.Parent.GetMessageReactionsStore.createMessageReactionsStore)

local function removeViewer(arg1, userId: number?)
    local var1 = table.clone(arg1)
    var1.count = arg1.count - 1
    var1.has_user_reacted = false

    local reactionsPage = arg1.reactions_page
    if reactionsPage ~= nil then
        local reactors = {}
        for _, reactor in reactionsPage.reactors do
            if reactor.user_id ~= userId then
                table.insert(reactors, reactor)
            end
        end
        local var2 = table.clone(reactionsPage)
        var2.reactors = reactors
        var1.reactions_page = var2
    end
    return var1
end

local function addViewer(arg1, userId: number?)
    local var1 = table.clone(arg1)
    var1.count = arg1.count + 1
    var1.has_user_reacted = true

    if userId ~= nil then
        local reactionsPage = arg1.reactions_page
        local reactors = {{ user_id = userId }}
        if reactionsPage ~= nil then
            for _, reactor in reactionsPage.reactors do
                table.insert(reactors, reactor)
            end
            local var2 = table.clone(reactionsPage)
            var2.reactors = reactors
            var1.reactions_page = var2
            return var1
        end
        var1.reactions_page = { reactors = reactors }
    end

    return var1
end

local function applyPendingReaction(arg1, userId: number?)
    local pending = arg1.pending
    if pending == nil then
        return arg1.reactions
    end

    local emoteId = pending.emoteId
    local bool1 = false
    local result = {}
    for _, reaction in arg1.reactions do
        local bool2 = reaction.emote_id == emoteId
        if bool2 then
            bool1 = true
        end

        if reaction.has_user_reacted and not bool2 then
            if reaction.count > 1 then
                table.insert(result, (removeViewer(reaction, userId)))
            end
        elseif bool2 and not reaction.has_user_reacted then
            table.insert(result, (addViewer(reaction, userId)))
        else
            table.insert(result, reaction)
        end
    end

    if emoteId ~= nil and not bool1 then
        table.insert(result, (addViewer({ emote_id = emoteId, count = 0 }, userId)))
    end
    return result
end

return applyPendingReaction
