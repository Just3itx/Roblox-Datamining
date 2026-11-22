-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T20:00:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialServerDrivenUi = script:FindFirstAncestor("SocialServerDrivenUi")
local SocialServerDrivenUiParent = SocialServerDrivenUi.Parent

local SduiCoreSystem = require(SocialServerDrivenUiParent.SduiCoreSystem)
local SduiImpressionEventType = SduiCoreSystem.SduiImpressionEventType
local getSduiImpressionHandlerRegistry = SduiCoreSystem.getSduiImpressionHandlerRegistry

local FFlagSduiSearchPeoplePlayerTileTelemetry = require(SocialServerDrivenUiParent.SharedFlags).FFlagSduiSearchPeoplePlayerTileTelemetry

local function registerSocialImpressions()
    local tbl1 = {
        [SduiImpressionEventType.playerTileImpressions] = FFlagSduiSearchPeoplePlayerTileTelemetry and {
            lazyHandler = function()
                return require(SocialServerDrivenUi.Impressions.SduiPlayerTileImpressionsHandler)
            end,
            skipItemImpressionsLog = true
        } or nil,
        [SduiImpressionEventType.socialProofTextImpressions] = {
            lazyHandler = function()
                return require(SocialServerDrivenUi.Impressions.SduiSocialProofTextImpressionsHandler)
            end,
            skipItemImpressionsLog = true
        }
    }

    getSduiImpressionHandlerRegistry().registerImpressionHandlerConfigs(tbl1)
end

return registerSocialImpressions
