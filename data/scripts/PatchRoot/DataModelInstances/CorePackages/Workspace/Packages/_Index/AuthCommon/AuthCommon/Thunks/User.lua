-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:50:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")

local AppStorageService = game:GetService("AppStorageService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local AuthCommonParent = AuthCommon.Parent
local AuthLocalStorageKeys = require(AuthCommon.Enums.AuthLocalStorageKeys)
local Logger = require(AuthCommonParent.Loggers).Logger

local FFlagEnableBlackbirdCheck = require(AuthCommonParent.SharedFlags).FFlagEnableBlackbirdCheck
local engineFeature = game:GetEngineFeature("HasRobloxSubscriptionStorageKey")

local module = {}
module.__index = module

function module.new(userId: number, username: string, membershipType: number, isUnder13: boolean, countryCode: string, displayName: string, hasRobloxSubscription: boolean?)
    local tbl1 = {
        userId = userId,
        username = username,
        displayName = displayName or nil,
        membershipType = membershipType,
        isUnder13 = isUnder13,
        countryCode = countryCode,
        hasRobloxSubscription = hasRobloxSubscription
    }

    setmetatable(tbl1, module)
    return tbl1
end

function module.fromRequest(arg1)
    local bool1 = if FFlagEnableBlackbirdCheck then arg1.responseBody.HasRobloxSubscription == true else nil
    return module.new(
        arg1.responseBody.UserId,
        arg1.responseBody.Username,
        tonumber(arg1.responseBody.MembershipType),
        arg1.responseBody.AgeBracket == 1,
        arg1.responseBody.CountryCode,
        arg1.responseBody.DisplayName or nil,
        bool1
    )
end

function module.fromUserInfoRequest(arg1)
    local num1 = if arg1.responseBody.isPremium then 4 else 0
    local bool1 = if FFlagEnableBlackbirdCheck then arg1.responseBody.hasRobloxSubscription == true else nil
    return module.new(
        arg1.responseBody.id,
        arg1.responseBody.name,
        num1,
        arg1.responseBody.ageBracket == 1,
        arg1.responseBody.countryCode,
        arg1.responseBody.displayName or nil,
        bool1
    )
end

function module.fromLocalStorage()
    local var1 = nil
    if FFlagEnableBlackbirdCheck and engineFeature then
        local success, result = pcall(function(): string
            return AppStorageService:GetItem(AuthLocalStorageKeys.HasRobloxSubscription)
        end)
        if success then
            var1 = result == "true"
        else
            Logger:warning("Failed to read HasRobloxSubscription from local storage: {}", tostring(result))
        end
    end
    local new = module.new
    local num1 = tonumber(AppStorageService:GetItem(AuthLocalStorageKeys.UserId)) or -1
    local item = AppStorageService:GetItem(AuthLocalStorageKeys.Username)
    local appStorageService = AppStorageService
    local membership = AuthLocalStorageKeys.Membership
    return new(
        num1,
        item,
        tonumber(appStorageService:GetItem(membership)) or 0,
        AppStorageService:GetItem(AuthLocalStorageKeys.IsUnder13) == "true",
        AppStorageService:GetItem(AuthLocalStorageKeys.CountryCode) or nil,
        AppStorageService:GetItem(AuthLocalStorageKeys.DisplayName) or nil,
        var1
    )
end

function module.clearLocalStorage()
    AppStorageService:SetItem(AuthLocalStorageKeys.UserId, "-1")
    AppStorageService:SetItem(AuthLocalStorageKeys.Username, "")
    AppStorageService:SetItem(AuthLocalStorageKeys.Membership, "")
    AppStorageService:SetItem(AuthLocalStorageKeys.IsUnder13, "")
    AppStorageService:SetItem(AuthLocalStorageKeys.DisplayName, "")
    AppStorageService:SetItem(AuthLocalStorageKeys.CountryCode, "")
    if FFlagEnableBlackbirdCheck and engineFeature then
        local success, result = pcall(function()
            AppStorageService:SetItem(AuthLocalStorageKeys.HasRobloxSubscription, "")
        end)
        if not success then
            Logger:warning("Failed to clear HasRobloxSubscription from local storage: {}", tostring(result))
        end
    end
    AppStorageService:Flush()
end

function module:setToLocalPlayer()
    if FFlagEnableBlackbirdCheck and self.hasRobloxSubscription ~= nil then
        Players:SetLocalPlayerInfo(
            self.userId,
            self.username,
            self.displayName or "",
            self.membershipType,
            self.isUnder13,
            self.hasRobloxSubscription
        )
        return
    end

    Players:SetLocalPlayerInfo(self.userId, self.username, self.displayName or "", self.membershipType, self.isUnder13)
end

function module:setToLocalStorage()
    AppStorageService:SetItem(AuthLocalStorageKeys.UserId, tostring(self.userId))
    AppStorageService:SetItem(AuthLocalStorageKeys.Username, self.username)
    AppStorageService:SetItem(AuthLocalStorageKeys.Membership, tostring(self.membershipType))
    AppStorageService:SetItem(AuthLocalStorageKeys.IsUnder13, tostring(self.isUnder13))
    AppStorageService:SetItem(AuthLocalStorageKeys.DisplayName, tostring(self.displayName))
    AppStorageService:SetItem(AuthLocalStorageKeys.CountryCode, tostring(self.countryCode))
    if FFlagEnableBlackbirdCheck and engineFeature then
        local success, result = pcall(function()
            AppStorageService:SetItem(AuthLocalStorageKeys.HasRobloxSubscription, tostring(self.hasRobloxSubscription == true))
        end)

        if not success then
            Logger:warning("Failed to save HasRobloxSubscription to local storage: {}", tostring(result))
        end
    end
    AppStorageService:Flush()
end

function module:isSame(arg1): boolean
    return self.userId == arg1.userId
end

function module:isEqual(arg1)
    local bool1

    if self.userId == arg1.userId
        and self.username == arg1.username
        and self.membershipType == arg1.membershipType
        and self.isUnder13 == arg1.isUnder13
        and self.displayName == arg1.displayName
        and self.countryCode == arg1.countryCode
    then
        if FFlagEnableBlackbirdCheck then
            return self.hasRobloxSubscription == arg1.hasRobloxSubscription
        end

        bool1 = true
    else
        bool1 = false
    end

    return bool1
end

function module:toString()
    local var1 = string.format(
        "userId:%s, username:%s, membershipType:%s, isUnder13:%s, countryCode:%s",
        tostring(self.userId),
        self.username,
        tostring(self.membershipType),
        tostring(self.isUnder13),
        tostring(self.countryCode)
    )
    if FFlagEnableBlackbirdCheck then
        var1 ..= string.format(", hasRobloxSubscription:%s", tostring(self.hasRobloxSubscription))
    end
    return var1
end

function module:toJsonData(): string
    local input = {
        userId = self.userId,
        username = self.username,
        displayName = self.displayName or nil,
        membershipType = self.membershipType,
        isUnder13 = self.isUnder13,
        countryCode = self.countryCode
    }
    if FFlagEnableBlackbirdCheck then
        input.hasRobloxSubscription = self.hasRobloxSubscription
    end
    return HttpService:JSONEncode(input)
end

return module
