-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:41:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")
local AuthCommonParent = AuthCommon.Parent

local GuiService = game:GetService("GuiService")

local NotificationType = require(AuthCommonParent.RobloxAppEnums).NotificationType
local Promise = require(AuthCommonParent.Promise)
local ExperienceService = require(AuthCommonParent.ExperienceService).ExperienceService
local GameParams = require(AuthCommonParent.ExperienceService).GameParams

local SharedFlags = require(AuthCommonParent.SharedFlags)
local FFlagEnableLuaAccountSwitch = SharedFlags.FFlagEnableLuaAccountSwitch

local FFlagLuaEnableLoginAndSignupDifferentiatedStatusValues = SharedFlags.FFlagLuaEnableLoginAndSignupDifferentiatedStatusValues

local AppStorageUtilities = require(AuthCommon.Utils.AppStorageUtilities)
local User = require(AuthCommon.Thunks.User)
local AccountSwitcherConstants = require(AuthCommon.Common.AccountSwitcherConstants)
local RedeemAuthenticationTicket = require(AuthCommon.Http.Requests.RedeemAuthenticationTicket)

local function castStringToInferredType(str1: string): boolean | number | string -- Luacid: Inlined by compiler; 1 call site recovered
    return tonumber(str1) or str1 == "true" or not (str1 == "false") and str1
end

local function parsePlaceLauncherUrl(str1: string?)
    if not str1 or str1 == "" then
        return {}
    end

    local var1 = str1:gsub("%%(%x%x)", function(arg1): string
        return string.char(tonumber(arg1, 16))
    end)

    local result = ({})
    local _, var2 = string.find(var1, "?")

    if not var2 then
        return result
    end

    local str2 = string.sub(var1, var2 + 1)

    for value in string.gmatch(str2, "[^&]+") do
        local var3, var4 = string.match(value, "([^=]+)=?(.*)")
        if var3 then
            result[var3] = var4
        end
    end

    return result
end

return function(arg1, arg2, arg3, arg4, arg5)
    return (RedeemAuthenticationTicket(arg1, arg2):andThen(function(arg6)
        local tbl1 = parsePlaceLauncherUrl(arg3)

        local var1 = tonumber(tbl1.placeId)
        if var1 then
            local placeId = GameParams.fromPlaceId(var1)

            for k, value in pairs(tbl1) do
                if k ~= "placeId" then
                    placeId[k] = castStringToInferredType(value)
                end
            end

            local accountBlob = AppStorageUtilities.getAccountBlob()
            local bool1 = User.fromLocalStorage().userId ~= -1

            if not FFlagEnableLuaAccountSwitch or not bool1 and accountBlob == "" then
                return Promise.resolve(arg4()):andThen(function()
                    ExperienceService:LaunchExperience(placeId, "AuthTicket", nil)
                end)
            end

            Promise.resolve(arg5()):andThen(function()
                local var2 = if FFlagLuaEnableLoginAndSignupDifferentiatedStatusValues then AccountSwitcherConstants.AccountSwitcherSwitchedFromLoginStatus else AccountSwitcherConstants.AccountSwitcherSwitchedStatus
                AppStorageUtilities.setAccountSwitchStatus(var2)
                AppStorageUtilities.setAccountBlob(arg6.responseBody.accountBlob)
                AppStorageUtilities.setAccountSwitchStartupQueryParams(tbl1)
                AppStorageUtilities.flush()

                GuiService:BroadcastNotification("", NotificationType.DID_SWITCH_ACCOUNT)
            end, function(arg7)
                print("error: ", arg7)
            end)
        end

        return Promise.resolve()
    end, function(arg6)
        return Promise.reject(arg6)
    end))
end
