-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:51:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local _MomentsTypes = require(DataHydrationParent.MomentsTypes)
local decodeEmojiSets = require(script.Parent.decodeEmojiSets)
local validateMomentsEmojiCatalog = require(script.Parent.validateMomentsEmojiCatalog)

return {
    parseMomentsEmojiFallbackCatalogJson = function(str1: string)
        if str1 == "" then
            return nil
        end

        local success, result = pcall(HttpService.JSONDecode, HttpService, str1)
        if not (success and validateMomentsEmojiCatalog.isValidGetEmojiSetsResponseShape(result)) then
            return nil
        end

        return decodeEmojiSets.flattenEmojis(decodeEmojiSets.decodeGetEmojiSetsResponse(result))
    end
}
