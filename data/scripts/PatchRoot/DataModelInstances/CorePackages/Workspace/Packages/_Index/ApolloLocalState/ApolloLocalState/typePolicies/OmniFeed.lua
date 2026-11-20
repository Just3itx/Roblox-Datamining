-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T22:20:47Z
-- Luau bytecode version: 14 | Luau type version: 3
local makeDefaultReadPolicy = require(script.Parent.utils.makeDefaultReadPolicy)

local GetFFlagEnableMergeOmniFeedSorts = require(script.Parent.Parent.Flags).GetFFlagEnableMergeOmniFeedSorts

local makeMergeOverlappingArraysPolicy = require(script.Parent.utils.makeMergeOverlappingArraysPolicy)

return {
    keyFields = { "pageType" },
    fields = {
        sorts = {
            merge = if GetFFlagEnableMergeOmniFeedSorts() then makeMergeOverlappingArraysPolicy("topicId") else nil
        },
        nextPageToken = {
            read = makeDefaultReadPolicy("")
        },
        globalLayoutData = {
            read = makeDefaultReadPolicy({})
        }
    }
}
