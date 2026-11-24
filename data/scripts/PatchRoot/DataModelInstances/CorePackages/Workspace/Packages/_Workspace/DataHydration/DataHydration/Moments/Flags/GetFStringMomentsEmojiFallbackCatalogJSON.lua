-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:41:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local DataHydration = script:FindFirstAncestor("DataHydration")

local defaultValue = HttpService:JSONEncode(
    require(DataHydration.Moments.Util.compiledMomentsEmojiFallbackCatalog).COMPILED_MOMENTS_EMOJI_FALLBACK_API_PAYLOAD
)
game:DefineFastString("MomentsEmojiFallbackCatalogJSON", defaultValue)

return function(): string
    return game:GetFastString("MomentsEmojiFallbackCatalogJSON")
end
