-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T12:31:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProgressLoadingParent = script:FindFirstAncestor("ProgressLoading").Parent

local Url = require(ProgressLoadingParent.Http).Url
local UrlBuilder = require(ProgressLoadingParent.UrlBuilder).UrlBuilder

local function buildPlayerLocalizationChoiceUrl(universeId: string)
    return UrlBuilder.new(
        {
            base = Url.GAME_INTERNATIONALIZATION_URL,
            path = "v1/user-localization-settings/player-choice/{universeId}"
        }
    )(
        { universeId = universeId }
    )
end

return buildPlayerLocalizationChoiceUrl
