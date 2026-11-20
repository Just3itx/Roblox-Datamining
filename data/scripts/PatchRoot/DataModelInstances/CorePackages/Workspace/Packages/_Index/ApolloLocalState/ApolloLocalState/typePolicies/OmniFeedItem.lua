-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T22:20:49Z
-- Luau bytecode version: 14 | Luau type version: 3
local ApolloLocalStateParent = script:FindFirstAncestor("ApolloLocalState").Parent
local GetFFlagEnableMergeOmniFeedSorts = require(script.Parent.Parent.Flags).GetFFlagEnableMergeOmniFeedSorts
local _ApolloClient = require(ApolloLocalStateParent.ApolloClient)

local makeMergeOverlappingArraysPolicy = require(script.Parent.utils.makeMergeOverlappingArraysPolicy)
local makeDefaultReadPolicy = require(script.Parent.utils.makeDefaultReadPolicy)

return {
    fields = {
        topicLayoutData = {
            read = makeDefaultReadPolicy({})
        },
        recommendations = {
            read = makeDefaultReadPolicy({}),
            merge = if GetFFlagEnableMergeOmniFeedSorts() then makeMergeOverlappingArraysPolicy("contentId") else nil
        },
        experiences = {},
        hasMoreRows = {}
    }
}
