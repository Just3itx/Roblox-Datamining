-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:30:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local AppStorageService = game:GetService("AppStorageService")
local ProfilePlatformParent = ProfilePlatform.Parent
local React = require(ProfilePlatformParent.React)

local useLocalUserId = require(ProfilePlatformParent.RobloxAppHooks).useLocalUserId

local useEffectOnce = require(ProfilePlatformParent.RoactUtils).Hooks.useEffectOnce
local Cryo = require(ProfilePlatformParent.Cryo)

local DataHydration = require(ProfilePlatformParent.DataHydration)
local useSignalState = require(ProfilePlatformParent.SignalsReact).useSignalState
local Signals = require(ProfilePlatformParent.Signals)

local useProfileWrapperContext = require(ProfilePlatform.Contexts.useProfileWrapperContext)
local SocialIdentity = require(ProfilePlatform.Components.UserProfileHeader.SocialIdentity)
local FFlagEnableBlackbirdCheck = require(ProfilePlatformParent.SharedFlags).FFlagEnableBlackbirdCheck
local useIsRobloxSubscriber = require(ProfilePlatformParent.UserProfiles).Hooks.useIsRobloxSubscriber

local var1 = DataHydration.TrustedConnections.TrustedConnectionsStore.get()

local function SocialIdentityContainer(tbl1)
    local profileId = useProfileWrapperContext().profileId
    local isLocalUser = profileId == useLocalUserId()

    local key = if isLocalUser then "NamesDisplayNameTooltipImpressionCount" else "NamesProfileTooltip"

    local num1 = tonumber(AppStorageService:GetItem(key)) or 0
    local var2 = React.useRef(num1)

    local var3 = React.useCallback(function(num2: number)
        AppStorageService:SetItem(key, tostring(num2 or 0))
        AppStorageService:Flush()
    end)

    local dismissTooltip = React.useCallback(function()
        var2.current = 3
        var3(3)
    end)

    useEffectOnce(function()
        if var2.current then
            var3(var2.current + 1)
        end
    end, false)

    local var5 = if FFlagEnableBlackbirdCheck then useIsRobloxSubscriber(profileId or nil) else nil

    local var6 = React.useMemo(function()
        return Signals.createComputed(function(arg1)
            if profileId and profileId ~= "" then
                return (var1.getIsTrustedConnection(profileId).data(arg1))
            end

            return nil
        end)
    end, { profileId })
    local isTrustedConnection = useSignalState(var6)

    local createElement = React.createElement
    local var8 = SocialIdentity
    local union = Cryo.Dictionary.union
    local tbl2 = {
        isLocalUser = isLocalUser,
        isTooltipActive = false,
        dismissTooltip = dismissTooltip,
        isTrustedConnection = isTrustedConnection,
        isRobloxSubscriber = 0
    }

    if not FFlagEnableBlackbirdCheck then
        var5 = nil
    end

    tbl2.isRobloxSubscriber = var5
    return createElement(var8, (union(tbl1, tbl2)))
end

return SocialIdentityContainer
