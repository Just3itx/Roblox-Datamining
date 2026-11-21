-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:50:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")
local AuthCommonParent = AuthCommon.Parent

local AuthLocalStorageKeys = require(AuthCommon.Enums.AuthLocalStorageKeys)
local AppStorageService = game:GetService("AppStorageService")
local HttpService = game:GetService("HttpService")
local GetFFlagEnableMultiPageSignup = require(AuthCommonParent.SharedFlags).GetFFlagEnableMultiPageSignup

local _PreviousAccountEntry = require(AuthCommon.Utils.PreviousAccountEntry)
local GameParams = require(AuthCommonParent.ExperienceService).GameParams

local module = {}

function module.setRobloxLocaleId(str1: string)
    AppStorageService:SetItem(AuthLocalStorageKeys.RobloxLocaleId, str1)
end

function module.setGameLocaleId(str1: string)
    AppStorageService:SetItem(AuthLocalStorageKeys.GameLocaleId, str1)
end

function module.getAuthenticatedTheme(): string
    return AppStorageService:GetItem(AuthLocalStorageKeys.AuthenticatedTheme)
end

function module.setAuthenticatedTheme(str1: string)
    AppStorageService:SetItem(AuthLocalStorageKeys.AuthenticatedTheme, str1)
end

function module.getAccountBlob()
    if game:GetEngineFeature("AccountSwitchFeatureEnabled") then
        return AppStorageService:GetItem(AuthLocalStorageKeys.AccountBlob) or ""
    end

    return ""
end

function module.setAccountBlob(arg1)
    if game:GetEngineFeature("AccountSwitchFeatureEnabled") then
        AppStorageService:SetItem(AuthLocalStorageKeys.AccountBlob, arg1 or "")
    end
end

function module.getDefaultUsername(): string
    return AppStorageService:GetItem(AuthLocalStorageKeys.CredentialValue)
end

function module.getSignupActionRequired(): string
    return AppStorageService:GetItem(AuthLocalStorageKeys.SignupActionRequired)
end

function module.setSignupActionRequired(str1: string)
    AppStorageService:SetItem(AuthLocalStorageKeys.SignupActionRequired, str1)
end

function module.getAccountSwitcherMetadataMap()
    if game:GetEngineFeature("AccountSwitcherMetadataMapKeyAvailable") then
        return AppStorageService:GetItem(AuthLocalStorageKeys.AccountSwitcherMetadataMap) or ""
    end

    return ""
end

function module.setAccountSwitcherMetadataMap(arg1)
    if game:GetEngineFeature("AccountSwitcherMetadataMapKeyAvailable") then
        AppStorageService:SetItem(AuthLocalStorageKeys.AccountSwitcherMetadataMap, arg1 or "")
    end
end

function module.setAccountSwitchStartupQueryParams(input)
    if typeof(input) == "table" then
        input = HttpService:JSONEncode(input)
    end

    if not game:GetEngineFeature("AccountSwitcherMetadataMapKeyAvailable") then
        return
    end

    local accountSwitcherMetadataMap = module.getAccountSwitcherMetadataMap()
    local input2

    if accountSwitcherMetadataMap == nil or accountSwitcherMetadataMap == "" then
        input2 = { AccountSwitchStartupQueryParams = input }
    else
        input2 = HttpService:JSONDecode(accountSwitcherMetadataMap)
        input2.AccountSwitchStartupQueryParams = input
    end

    module.setAccountSwitcherMetadataMap(HttpService:JSONEncode(input2))
end

function module.clearAccountSwitchStartupGameParams()
    module.setAccountSwitchStartupQueryParams("")
end

function module.getAccountSwitchStartupGameParams()
    if not game:GetEngineFeature("AccountSwitcherMetadataMapKeyAvailable") then
        return nil
    end

    local accountSwitcherMetadataMap = module.getAccountSwitcherMetadataMap()
    if accountSwitcherMetadataMap == nil or accountSwitcherMetadataMap == "" then
        return nil
    end
    local var1 = HttpService:JSONDecode(accountSwitcherMetadataMap)
    if var1 == nil or var1 == "" or next(var1) == nil or next(var1) == "" or var1.AccountSwitchTargetUsername == nil then
        return nil
    end

    local accountSwitchStartupQueryParams = var1.AccountSwitchStartupQueryParams
    if accountSwitchStartupQueryParams == nil or accountSwitchStartupQueryParams == "" then
        return nil
    end

    local var2 = HttpService:JSONDecode(accountSwitchStartupQueryParams)

    local function func1(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
        return tonumber(arg1) or arg1 == "true" or not (arg1 == "false") and arg1
    end

    local params = GameParams.fromParams(var2)

    for k, value in pairs(var2) do
        params[k] = func1(value)
    end

    return params
end

function module.getAccountSwitchTargetUsername()
    if not game:GetEngineFeature("AccountSwitcherMetadataMapKeyAvailable") then
        return ""
    end

    local accountSwitcherMetadataMap = module.getAccountSwitcherMetadataMap()
    if accountSwitcherMetadataMap == nil or accountSwitcherMetadataMap == "" then
        return ""
    end
    local var1 = HttpService:JSONDecode(accountSwitcherMetadataMap)
    return if var1 == nil or var1 == "" or next(var1) == nil or next(var1) == "" or var1.AccountSwitchTargetUsername == nil then "" else var1.AccountSwitchTargetUsername
end

function module.setAccountSwitchTargetUsername(accountSwitchTargetUsername)
    if not game:GetEngineFeature("AccountSwitcherMetadataMapKeyAvailable") then
        return
    end

    local accountSwitcherMetadataMap = module.getAccountSwitcherMetadataMap()
    local input

    if accountSwitcherMetadataMap == nil or accountSwitcherMetadataMap == "" then
        input = { AccountSwitchTargetUsername = accountSwitchTargetUsername }
    else
        input = HttpService:JSONDecode(accountSwitcherMetadataMap)
        input.AccountSwitchTargetUsername = accountSwitchTargetUsername
    end
    module.setAccountSwitcherMetadataMap(HttpService:JSONEncode(input))
end

function module.getAccountSwitchStatus()
    if not game:GetEngineFeature("AccountSwitcherMetadataMapKeyAvailable") then
        return ""
    end

    local accountSwitcherMetadataMap = module.getAccountSwitcherMetadataMap()
    if accountSwitcherMetadataMap == nil or accountSwitcherMetadataMap == "" then
        return ""
    end

    local var1 = HttpService:JSONDecode(accountSwitcherMetadataMap)
    return if var1 == nil or var1 == "" or next(var1) == nil or next(var1) == "" or var1.AccountSwitchStatus == nil then "" else var1.AccountSwitchStatus
end

function module.setAccountSwitchStatus(accountSwitchStatus)
    if not game:GetEngineFeature("AccountSwitcherMetadataMapKeyAvailable") then
        return
    end

    local accountSwitcherMetadataMap = module.getAccountSwitcherMetadataMap()
    local input

    if accountSwitcherMetadataMap == nil or accountSwitcherMetadataMap == "" then
        input = { AccountSwitchStatus = accountSwitchStatus }
    else
        input = HttpService:JSONDecode(accountSwitcherMetadataMap)
        input.AccountSwitchStatus = accountSwitchStatus
    end
    module.setAccountSwitcherMetadataMap(HttpService:JSONEncode(input))
end

function module.getMultipageSignupMetadataMap(): string
    return AppStorageService:GetItem(AuthLocalStorageKeys.MultipageSignupMetadataMap) or ""
end

function module.setMultipageSignupMetadataMap(arg1)
    AppStorageService:SetItem(AuthLocalStorageKeys.MultipageSignupMetadataMap, arg1 or "")
end

function module.getIncompleteSignupUserId()
    local multipageSignupMetadataMap = module.getMultipageSignupMetadataMap()
    if multipageSignupMetadataMap == nil or multipageSignupMetadataMap == "" then
        return ""
    end
    local var1 = HttpService:JSONDecode(multipageSignupMetadataMap)
    return if var1 == nil or var1 == "" or next(var1) == nil or next(var1) == "" or var1.IncompleteSignupUserId == nil then "" else var1.IncompleteSignupUserId
end

function module.setIncompleteSignupUserId(incompleteSignupUserId: string)
    if not GetFFlagEnableMultiPageSignup() then
        return
    end

    local multipageSignupMetadataMap = module.getMultipageSignupMetadataMap()
    local input

    if multipageSignupMetadataMap == nil or multipageSignupMetadataMap == "" then
        input = { IncompleteSignupUserId = incompleteSignupUserId }
    else
        input = HttpService:JSONDecode(multipageSignupMetadataMap)
        input.IncompleteSignupUserId = incompleteSignupUserId
    end
    module.setMultipageSignupMetadataMap(HttpService:JSONEncode(input))
end

function module.getIncompleteSignupUsername()
    local multipageSignupMetadataMap = module.getMultipageSignupMetadataMap()
    if multipageSignupMetadataMap == nil or multipageSignupMetadataMap == "" then
        return ""
    end
    local var1 = HttpService:JSONDecode(multipageSignupMetadataMap)
    return if var1 == nil or var1 == "" or next(var1) == nil or next(var1) == "" or var1.IncompleteSignupUsername == nil then "" else var1.IncompleteSignupUsername
end

function module.setIncompleteSignupUsername(incompleteSignupUsername: string)
    if not GetFFlagEnableMultiPageSignup() then
        return
    end

    local multipageSignupMetadataMap = module.getMultipageSignupMetadataMap()
    local input

    if multipageSignupMetadataMap == nil or multipageSignupMetadataMap == "" then
        input = { IncompleteSignupUsername = incompleteSignupUsername }
    else
        input = HttpService:JSONDecode(multipageSignupMetadataMap)
        input.IncompleteSignupUsername = incompleteSignupUsername
    end
    module.setMultipageSignupMetadataMap(HttpService:JSONEncode(input))
end

function getMultiPageSignupKey(str1: string)
    local multipageSignupMetadataMap = module.getMultipageSignupMetadataMap()
    if multipageSignupMetadataMap == nil or multipageSignupMetadataMap == "" then
        return ""
    end
    local var1 = HttpService:JSONDecode(multipageSignupMetadataMap)
    return if var1 == nil or var1 == "" or next(var1) == nil or next(var1) == "" or var1[str1] == nil then "" else var1[str1]
end

function setMultiPageSignupKey(str1: string, str2: string)
    if not game:GetEngineFeature("MultipageSignupMetadataMapKeyAvailable") then
        return
    end

    local multipageSignupMetadataMap = module.getMultipageSignupMetadataMap()
    local input

    if multipageSignupMetadataMap == nil or multipageSignupMetadataMap == "" then
        input = {
            [str1] = str2
        }
    else
        input = HttpService:JSONDecode(multipageSignupMetadataMap)
        input[str1] = str2
    end
    module.setMultipageSignupMetadataMap(HttpService:JSONEncode(input))
end

function module.getPasskeySignupUsername()
    return getMultiPageSignupKey("PasskeySignupName")
end

function module.setPasskeySignupUsername(str1: string)
    setMultiPageSignupKey("PasskeySignupName", str1)
end

function module.getPreviousAccountsList()
    if not game:GetEngineFeature("PreviousAccountsListAvailable") then
        return {}
    end

    local item = AppStorageService:GetItem(AuthLocalStorageKeys.PreviousAccountsList) or ""

    if item == "" then
        return {}
    end
    return (HttpService:JSONDecode(item))
end

function module.setPreviousAccountsList(input)
    if game:GetEngineFeature("PreviousAccountsListAvailable") then
        local str1 = HttpService:JSONEncode(input)
        AppStorageService:SetItem(AuthLocalStorageKeys.PreviousAccountsList, str1)

        AppStorageService:flush()
    end
end

function module.getLastSuccessfulSignInMethod()
    if game:GetEngineFeature("LastSuccessfulSignInMethodKeyAvailable") then
        return AppStorageService:GetItem(AuthLocalStorageKeys.LastSuccessfulSignInMethod)
    end
    return ""
end

function module.setLastSuccessfulSignInMethod(str1: string)
    if game:GetEngineFeature("LastSuccessfulSignInMethodKeyAvailable") then
        AppStorageService:SetItem(AuthLocalStorageKeys.LastSuccessfulSignInMethod, str1)
    end
end

function module.setDiscoveryClientFallbackCache(str1: string)
    if game:GetEngineFeature("UniversalAppDiscoveryClientFallbackCacheStorageKey") then
        AppStorageService:SetItem(AuthLocalStorageKeys.DiscoveryClientFallbackCache, str1)
    end
end

function module.flush()
    AppStorageService:flush()
end

return module
