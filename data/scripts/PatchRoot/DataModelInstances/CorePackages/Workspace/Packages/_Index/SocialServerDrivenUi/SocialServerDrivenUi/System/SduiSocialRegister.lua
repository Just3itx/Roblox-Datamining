-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T20:00:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialServerDrivenUi = script:FindFirstAncestor("SocialServerDrivenUi")
local SocialServerDrivenUiParent = SocialServerDrivenUi.Parent
local React = require(SocialServerDrivenUiParent.React)

local registerSocialActions = require(SocialServerDrivenUi.Actions.registerSocialActions)

local registerSocialActionTelemetryHandlers = require(SocialServerDrivenUi.Actions.TelemetryHandlers.registerSocialActionTelemetryHandlers)
local registerSocialComponents = require(SocialServerDrivenUi.System.registerSocialComponents)
local registerSocialImpressions = require(SocialServerDrivenUi.Impressions.registerSocialImpressions)

local FFlagSduiCreateSocialTelemetryRegistries = require(SocialServerDrivenUi.Flags.FFlagSduiCreateSocialTelemetryRegistries)

return React.memo(function() -- name: SduiSocialRegister
    React.useEffect(function()
        registerSocialComponents()
        registerSocialActions()
        if FFlagSduiCreateSocialTelemetryRegistries then
            registerSocialImpressions()
            registerSocialActionTelemetryHandlers()
        end
    end, {})
    return nil
end)
