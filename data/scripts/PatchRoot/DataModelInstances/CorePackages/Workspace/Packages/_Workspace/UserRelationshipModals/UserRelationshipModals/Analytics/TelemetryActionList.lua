-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T21:10:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserRelationshipModalsParent = script:FindFirstAncestor("UserRelationshipModals").Parent

local SocialLuaAnalytics = require(UserRelationshipModalsParent.SocialLuaAnalytics)
local SupportedTelemetryBackends = SocialLuaAnalytics.Analytics.Enums.SupportedTelemetryBackends
local EventTypes = SocialLuaAnalytics.Analytics.Enums.EventTypes
local Contexts = SocialLuaAnalytics.Analytics.Enums.Contexts
local EventNames = require(script.Parent.EventNames)

return {
    defaults = {
        throttlingThousandths = game:DefineFastInt("UserRelationshipModalsAnalyticsThrottlingThousandths", 10000),
        links = ""
    },
    [EventNames.ModalSeen] = {
        description = "Userrelationshipsmodal was opened",
        lastUpdated = { 26, 4, 16 },
        backendsList = {
            {
                type = SupportedTelemetryBackends.RobloxTelemetryCounter
            },
            {
                type = SupportedTelemetryBackends.EventIngest,
                overrideName = function()
                    return EventTypes.UserSeen
                end,
                staticCustomFields = {
                    eventContext = Contexts.UserRelationshipModals,
                    placeId = game.PlaceId
                }
            }
        }
    },
    [EventNames.ModalClosed] = {
        description = "User-relationship-modal was closed without changing the user relationship",
        lastUpdated = { 26, 4, 16 },
        backendsList = {
            {
                type = SupportedTelemetryBackends.RobloxTelemetryCounter
            },
            {
                type = SupportedTelemetryBackends.EventIngest,
                overrideName = function()
                    return EventTypes.ButtonClick
                end,
                staticCustomFields = {
                    eventContext = Contexts.UserRelationshipModals,
                    btn = "Close",
                    placeId = game.PlaceId
                }
            }
        }
    },
    [EventNames.CreateActionPressed] = {
        description = "User pressed on the create action button on a user-relationship-modal",
        lastUpdated = { 26, 4, 16 },
        backendsList = {
            {
                type = SupportedTelemetryBackends.RobloxTelemetryCounter
            },
            {
                type = SupportedTelemetryBackends.EventIngest,
                overrideName = function()
                    return EventTypes.ButtonClick
                end,
                staticCustomFields = {
                    eventContext = Contexts.UserRelationshipModals,
                    btn = "Create",
                    placeId = game.PlaceId
                }
            }
        }
    }
}
