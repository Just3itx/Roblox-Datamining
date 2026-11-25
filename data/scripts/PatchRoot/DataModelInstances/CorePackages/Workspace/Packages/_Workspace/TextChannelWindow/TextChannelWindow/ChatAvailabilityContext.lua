-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:51:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")

local scriptParentParent = script.Parent.Parent
local React = require(scriptParentParent.React)
local useEventConnection = require(scriptParentParent.ReactUtils).useEventConnection

local tbl1 = {
    GeoBlocked = "geoBlocked",
    SettingsDisabled = "settingsOff",
    SettingsDisabledVpc = "parentalConsent",
    AgeCheckVpc = "parentalConsent",
    AgeVerificationRequired = "ageVerification",
    IdVerificationRequired = "ageVerification",
    AgeCheckGateExperiment = "ageVerification",
    Ineligible = "viewOnly",
    NoOne = "viewOnly"
}

local tbl2 = {
    geoBlocked = {
        key = "CoreScripts.TextChat.ChatWindow.ChatDisabled.RegionUnavailable",
        fallback = "You can only view system messages here. Chat is not available in your region."
    },
    settingsOff = {
        key = "CoreScripts.TextChat.ChatWindow.ChatDisabled.SettingOff",
        fallback = "You can only view system messages here. Update your Communication settings to turn on chat."
    },
    parentalConsent = {
        key = "CoreScripts.TextChat.ChatWindow.ChatDisabled.AskForPermission",
        fallback = "You can only view system messages here. Ask your parent for permission to chat in Communication settings."
    },
    ageVerification = {
        key = "CoreScripts.TextChat.ChatWindow.ChatDisabled.GetAnAgeCheck",
        fallback = "You can only view system messages here. Get an age check to chat."
    },
    viewOnly = {
        key = "CoreScripts.TextChat.ChatWindow.ChatDisabled.OnlyViewSystemMessages",
        fallback = "You can only view system messages here."
    }
}

local function resolve(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    local reason = tbl1[str1]
    local var2 = if reason then tbl2[reason] else nil
    return {
        canChat = reason == nil,
        reason = reason,
        messageKey = if var2 then var2.key else nil,
        messageFallback = if var2 then var2.fallback else nil
    }
end

local Context = React.createContext({ canChat = true, reason = nil, messageKey = nil, messageFallback = nil })

return {
    Context = Context,
    Provider = function(tbl3)
        local var1 = tbl3.subjectPlayer or Players.LocalPlayer

        local var2, var3 = React.useState(function()
            return if tbl3.value == nil then if var1 then var1.ChatAvailabilityStatus else "Enabled" else tbl3.value
        end)

        local var4 = useEventConnection
        local chatAvailabilityStatusChanged = if tbl3.value == nil and var1 then var1:GetPropertyChangedSignal("ChatAvailabilityStatus") else nil

        var4(chatAvailabilityStatusChanged, function()
            if var1 then
                var3(var1.ChatAvailabilityStatus)
            end
        end, {})

        React.useEffect(function()
            if tbl3.value ~= nil then
                var3(tbl3.value)
            end
        end, { tbl3.value })

        local value = React.useMemo(function()
            return resolve(var2)
        end, { var2 })

        return React.createElement(Context.Provider, { value = value }, tbl3.children)
    end,
    resolve = resolve,
    useLocalUserChatAvailability = function()
        return React.useContext(Context)
    end
}
