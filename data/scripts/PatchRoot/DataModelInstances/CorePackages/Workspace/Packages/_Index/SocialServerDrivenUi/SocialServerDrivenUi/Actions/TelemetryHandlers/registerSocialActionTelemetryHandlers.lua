-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T19:50:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialServerDrivenUiParent = script:FindFirstAncestor("SocialServerDrivenUi").Parent

local getSduiTelemetryHandlerNameRegistry = require(SocialServerDrivenUiParent.SduiCoreSystem).getSduiTelemetryHandlerNameRegistry

local SharedFlags = require(SocialServerDrivenUiParent.SharedFlags)
local FFlagSduiSearchPeoplePlayerTileTelemetry = SharedFlags.FFlagSduiSearchPeoplePlayerTileTelemetry
local FFlagSduiSocialUpsellButtonClickTelemetry = SharedFlags.FFlagSduiSocialUpsellButtonClickTelemetry
local function registerSocialActionTelemetryHandlers()
    getSduiTelemetryHandlerNameRegistry().registerTelemetryHandlers({
        PlayerTileClick = FFlagSduiSearchPeoplePlayerTileTelemetry and {
            lazyHandler = function()
                return require(script.Parent.SduiPlayerTileClickTelemetryHandler)
            end
        } or nil,
        SocialUpsellButtonClick = FFlagSduiSocialUpsellButtonClickTelemetry and {
            lazyHandler = function()
                return require(script.Parent.SduiSocialUpsellButtonClickTelemetryHandler)
            end
        } or nil,
        SocialProofTextClick = {
            lazyHandler = function()
                return require(script.Parent.SduiSocialProofTextClickTelemetryHandler)
            end
        }
    })
end

return registerSocialActionTelemetryHandlers
