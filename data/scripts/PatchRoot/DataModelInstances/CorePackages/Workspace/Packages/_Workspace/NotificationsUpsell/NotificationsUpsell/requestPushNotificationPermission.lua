-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:40:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppStorageService = game:GetService("AppStorageService")

local scriptParentParent = script.Parent.Parent
local default = require(scriptParentParent.PermissionsProtocol).PermissionsProtocol.default
local Promise = require(scriptParentParent.Promise)

local FFlagPushPermissionRequestOpensAndroidSettings = require(scriptParentParent.SharedFlags).FFlagPushPermissionRequestOpensAndroidSettings

local NotificationsUpsellConstants = require(script.Parent.NotificationsUpsellConstants)
local PushNotificationsUpsellUtils = require(script.Parent.Util.PushNotificationsUpsellUtils)
local pushPermissionRequestEnvironment = require(script.Parent.Util.pushPermissionRequestEnvironment)

local function requestOsPrompt()
    return default:requestPermissions({ default.Permissions.POST_NOTIFICATIONS }):andThen(function<T>(arg1: T): T
        PushNotificationsUpsellUtils.setPushSysUpsellPromptTimestamp(AppStorageService, os.time())
        PushNotificationsUpsellUtils.incrementPushUpsellPromptedCount(
            AppStorageService,
            NotificationsUpsellConstants.LocalStorageKeys.PromptShownCount
        )
        return arg1
    end)
end

local function settleWithin(func1: (...any) -> (...any)) -- Luacid: Inlined by compiler; 1 call site recovered
    return Promise.new(function(callback)
        Promise.try(func1):andThen(callback, function()
            callback(nil)
        end)
        task.delay(pushPermissionRequestEnvironment.statusReadTimeoutSeconds, callback, nil)
    end)
end

local function isHidden(arg1): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return typeof(arg1) == "table" and arg1.upsellStatus == default.UpsellStatus.HIDE
end

local function shouldOpenSettings()
    local success, result = pcall(pushPermissionRequestEnvironment.getPlatform)
    if not success or result ~= Enum.Platform.Android then
        return Promise.resolve(false)
    end
    local success2, result2 = pcall(default.isOpenNotificationSettingsSupported)
    if not success2 or result2 ~= true then
        return Promise.resolve(false)
    end

    local tbl1 = { default.Permissions.POST_NOTIFICATIONS }
    local all = Promise.all

    local var1 = settleWithin(function()
        return default:getPushNotificationsEnabled()
    end)
    local function func1()
        return default:shouldShowUpsell(tbl1)
    end

    local tbl2 = {
        var1,
        Promise.new(function(callback)
            Promise.try(func1):andThen(callback, function()
                callback(nil)
            end)
            task.delay(pushPermissionRequestEnvironment.statusReadTimeoutSeconds, callback, nil)
        end),
        settleWithin(function()
            return default:shouldShowRationale(tbl1)
        end)
    }

    return all(tbl2):andThen(function(arg1)
        local var2 = arg1[1]
        return typeof(var2) == "table" and var2.enabled == false and isHidden(arg1[2]) and isHidden(arg1[3])
    end)
end

local function openNotificationSettings()
    local openSettingsStatus = default.OpenSettingsStatus
    return default:openNotificationSettings():andThen(function(arg1)
        local var1 = if typeof(arg1) == "table" and arg1.status ~= nil then arg1.status else openSettingsStatus.FAILED

        if var1 == openSettingsStatus.FAILED then
            return Promise.reject({ openSettingsStatus = var1 })
        end
        return { openSettingsStatus = var1 }
    end)
end

return function(tbl1)
    if not FFlagPushPermissionRequestOpensAndroidSettings or tbl1 == nil or tbl1.allowOpenSettings ~= true then
        return requestOsPrompt()
    end

    return shouldOpenSettings():andThen(function(arg1)
        if arg1 then
            return openNotificationSettings()
        end
        return requestOsPrompt()
    end)
end
