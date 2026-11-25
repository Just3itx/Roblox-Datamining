-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T12:10:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent

local AvatarCreationService = game:GetService("AvatarCreationService")

local FocusNavigationUtils = require(scriptParentParent.FocusNavigationUtils)
local ReactUtils = require(scriptParentParent.ReactUtils)
local React = require(scriptParentParent.React)

local SelfieConsentPrompt = require(scriptParent.SelfieConsentPrompt)

local FocusRoot = FocusNavigationUtils.FocusRoot
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum

local useEventConnection = ReactUtils.useEventConnection

local function func1(tbl1)
    local var1 = React.useCallback(function()
        tbl1.displaySelfieConsent(true)
    end)
    useEventConnection(AvatarCreationService.OpenSelfieConsent, var1)
    return React.createElement(React.Fragment, {}, {})
end

return function(_)
    local var1, displaySelfieConsent = React.useState(false)
    local prompt = if var1 then React.createElement(SelfieConsentPrompt, { displaySelfieConsent = displaySelfieConsent }) else nil
    return React.createElement(React.Fragment, {}, {
        EventListener = React.createElement(func1, { displaySelfieConsent = displaySelfieConsent }),
        FocusNavigationCoreScriptsWrapper = if prompt == nil then nil else React.createElement(
            FocusRoot,
            {
                surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.CentralOverlay,
                isIsolated = true,
                isAutoFocusRoot = true
            },
            { Prompt = prompt }
        )
    })
end
