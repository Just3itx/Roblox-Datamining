-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:00:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local _MomentsTypes = require(DataHydrationParent.MomentsTypes)

local GetFStringMomentsEmojiFallbackCatalogJSON = require(DataHydration.Moments.Flags.GetFStringMomentsEmojiFallbackCatalogJSON)
local FFlagMomentsEmojiSetsApi = require(DataHydration.Moments.FFlagMomentsEmojiSetsApi)
local FFlagMomentsReactToFeedItemV2 = require(DataHydration.Moments.FFlagMomentsReactToFeedItemV2)
local compiledMomentsEmojiFallbackCatalog = require(DataHydration.Moments.Util.compiledMomentsEmojiFallbackCatalog)
local decodeEmojiSets = require(DataHydration.Moments.Util.decodeEmojiSets)
local hardcodedMomentsEmojis = require(DataHydration.Moments.Util.hardcodedMomentsEmojis)
local parseMomentsEmojiFallbackCatalog = require(DataHydration.Moments.Util.parseMomentsEmojiFallbackCatalog)
local validateMomentsEmojiCatalog = require(DataHydration.Moments.Util.validateMomentsEmojiCatalog)

local var1 = decodeEmojiSets.decodeGetEmojiSetsResponse(
    compiledMomentsEmojiFallbackCatalog.COMPILED_MOMENTS_EMOJI_FALLBACK_API_PAYLOAD
)
local emojis = decodeEmojiSets.flattenEmojis(var1)

local function resolveFromCachedResponse(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if not validateMomentsEmojiCatalog.isValidCachedGetEmojiSetsResponse(arg1) then
        return nil
    end
    return decodeEmojiSets.flattenEmojis(arg1)
end

local function resolveFromFString() -- Luacid: Inlined by compiler; 1 call site recovered
    return parseMomentsEmojiFallbackCatalog.parseMomentsEmojiFallbackCatalogJson(GetFStringMomentsEmojiFallbackCatalogJSON())
end

return {
    resolveMomentsEmojiCatalog = function(arg1)
        if not FFlagMomentsEmojiSetsApi then
            return { emojis = hardcodedMomentsEmojis, source = "legacy" }
        end

        local var2 = resolveFromCachedResponse(arg1)

        if var2 ~= nil then
            return { emojis = var2, source = "cache" }
        end

        if not FFlagMomentsReactToFeedItemV2 then
            return { emojis = hardcodedMomentsEmojis, source = "legacy" }
        end

        local var3 = resolveFromFString()

        return if var3 == nil then { emojis = emojis, source = "compiled" } else {
            emojis = var3,
            source = "fstring"
        }
    end,
    shouldUseLegacyWireStringCatalog = function(): boolean
        return not FFlagMomentsEmojiSetsApi
    end,
    shouldUseUuidFallbackCatalog = function()
        return FFlagMomentsReactToFeedItemV2
    end
}
