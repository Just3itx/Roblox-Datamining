-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:41:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local Signals = require(MomentsParent.Signals)

local _CommentCollectionTypes = require(script.Parent.Parent.GetCommentCollectionStore.CommentCollectionTypes)

local createSignal = Signals.createSignal

local tbl1 = {
    sessionHiddenCommentIds = {},
    recentlyBlockedAuthorIds = {}
}

local function createCommentSessionFiltersStore()
    local getFilters, var2 = createSignal(tbl1)

    return {
        getFilters = getFilters,
        reset = function()
            var2({ sessionHiddenCommentIds = {}, recentlyBlockedAuthorIds = {} })
        end,
        hideCommentForSession = function(str1: string)
            local var3 = getFilters(false)
            if var3.sessionHiddenCommentIds[str1] == true then
                return
            end
            local sessionHiddenCommentIds = table.clone(var3.sessionHiddenCommentIds)
            sessionHiddenCommentIds[str1] = true
            var2({ sessionHiddenCommentIds = sessionHiddenCommentIds, recentlyBlockedAuthorIds = var3.recentlyBlockedAuthorIds })
        end,
        markAuthorRecentlyBlocked = function(str1: string)
            local var3 = getFilters(false)
            if var3.recentlyBlockedAuthorIds[str1] == true then
                return
            end
            local recentlyBlockedAuthorIds = table.clone(var3.recentlyBlockedAuthorIds)
            recentlyBlockedAuthorIds[str1] = true
            var2({ sessionHiddenCommentIds = var3.sessionHiddenCommentIds, recentlyBlockedAuthorIds = recentlyBlockedAuthorIds })
        end,
        unmarkAuthorRecentlyBlocked = function(str1: string)
            local var3 = getFilters(false)
            if var3.recentlyBlockedAuthorIds[str1] ~= true then
                return
            end
            local recentlyBlockedAuthorIds = table.clone(var3.recentlyBlockedAuthorIds)
            recentlyBlockedAuthorIds[str1] = nil
            var2({ sessionHiddenCommentIds = var3.sessionHiddenCommentIds, recentlyBlockedAuthorIds = recentlyBlockedAuthorIds })
        end,
        isCommentSessionHidden = function(str1: string): boolean
            return getFilters(false).sessionHiddenCommentIds[str1] == true
        end,
        isAuthorRecentlyBlocked = function(str1: string): boolean
            return getFilters(false).recentlyBlockedAuthorIds[str1] == true
        end
    }
end
return createCommentSessionFiltersStore
