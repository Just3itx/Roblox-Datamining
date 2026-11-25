-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:40:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")

local NotificationsUpsell = script:FindFirstAncestor("NotificationsUpsell")
local NotificationsUpsellParent = NotificationsUpsell.Parent

local PermissionsProtocol = require(NotificationsUpsellParent.PermissionsProtocol).PermissionsProtocol
local Promise = require(NotificationsUpsellParent.Promise)
local SystemInfoProtocol = require(NotificationsUpsellParent.SystemInfoProtocol).SystemInfoProtocol

local FIntStreamPushPermissionClientAttributesTimeoutMs = require(NotificationsUpsell.Flags.FIntStreamPushPermissionClientAttributesTimeoutMs)

local Keys = {
    PERMISSION_STATUS = "pushNotificationPermissionStatus",
    UPSELL_STATUS = "pushNotificationUpsellStatus",
    RATIONALE_STATUS = "pushNotificationRationaleStatus",
    PUSH_NOTIFICATIONS_ENABLED = "pushNotificationsEnabled",
    CAN_OPEN_NOTIFICATION_SETTINGS = "canOpenNotificationSettings",
    ANDROID_SDK_LEVEL = "androidSdkLevel"
}

local module = { Keys = Keys, UNKNOWN = "UNKNOWN" }

function module._getPlatform(): Enum.Platform
    return UserInputService:GetPlatform()
end
module._permissionsProtocol = PermissionsProtocol
module._systemInfoProtocol = SystemInfoProtocol

local function toAttributeValue(arg1): string -- Luacid: Inlined by compiler; 3 call sites recovered
    return if typeof(arg1) == "string" and arg1 ~= "" then arg1 else "UNKNOWN"
end

local function getField(arg1, str1: string) -- Luacid: Inlined by compiler; 6 call sites recovered
    return if typeof(arg1) == "table" then arg1[str1] else nil
end

local function getPlatform() -- Luacid: Inlined by compiler; 1 call site recovered
    local success, result = pcall(module._getPlatform)
    return if success then result else nil
end

local function readCanOpenNotificationSettings(): string -- Luacid: Inlined by compiler; 1 call site recovered
    local success, result = pcall(module._permissionsProtocol.isOpenNotificationSettingsSupported)
    return if success then if result == true then "true" else "false" else "UNKNOWN"
end

local function readAndroidSdkLevel(): string -- Luacid: unused: defined but never referenced
    local _systemInfoProtocol = module._systemInfoProtocol
    local success, result = pcall(function()
        return _systemInfoProtocol.default:getSystemInfo({ _systemInfoProtocol.InfoNames.SYSTEM_VERSION })
    end)

    local field = if success then getField(result, "systemVersion") else nil
    return toAttributeValue(field)
end

local function settleWithin(read: (...any) -> (...any))
    return Promise.new(function(callback)
        Promise.try(read):andThen(function(arg1)
            callback((toAttributeValue(arg1)))
        end, function()
            callback("UNKNOWN")
        end)
        task.delay(FIntStreamPushPermissionClientAttributesTimeoutMs / 1000, callback, "UNKNOWN")
    end)
end

function module.build()
    local platform = getPlatform()
    local bool1 = platform == Enum.Platform.Android
    if platform ~= Enum.Platform.IOS and not bool1 then
        return Promise.resolve({})
    end

    local _permissionsProtocol = module._permissionsProtocol
    local tbl2 = { _permissionsProtocol.Permissions.POST_NOTIFICATIONS }
    local str1 = readCanOpenNotificationSettings()
    local tbl3 = {
        [Keys.CAN_OPEN_NOTIFICATION_SETTINGS] = str1
    }
    if bool1 then
        local androidSdkLevel = Keys.ANDROID_SDK_LEVEL
        local _systemInfoProtocol = module._systemInfoProtocol
        local success, result = pcall(function()
            return _systemInfoProtocol.default:getSystemInfo({ _systemInfoProtocol.InfoNames.SYSTEM_VERSION })
        end)

        local field = if success then getField(result, "systemVersion") else nil
        tbl3[androidSdkLevel] = toAttributeValue(field)
    end

    local tbl4 = {
        {
            key = Keys.PERMISSION_STATUS,
            read = function()
                return _permissionsProtocol.default:hasPermissions(tbl2):andThen(function(arg1)
                    return getField(arg1, "status")
                end)
            end
        },
        {
            key = Keys.UPSELL_STATUS,
            read = function()
                return _permissionsProtocol.default:shouldShowUpsell(tbl2):andThen(function(arg1)
                    return getField(arg1, "upsellStatus")
                end)
            end
        },
        {
            key = Keys.RATIONALE_STATUS,
            read = function()
                return _permissionsProtocol.default:shouldShowRationale(tbl2):andThen(function(arg1)
                    return getField(arg1, "upsellStatus")
                end)
            end
        }
    }

    if bool1 and str1 == "true" then
        table.insert(tbl4, {
            key = Keys.PUSH_NOTIFICATIONS_ENABLED,
            read = function()
                return _permissionsProtocol.default:getPushNotificationsEnabled():andThen(function(arg1): string?
                    local field = getField(arg1, "enabled")
                    return if field == true then "true" elseif field == false then "false" else nil
                end)
            end
        })
    end

    local tbl5 = {}
    for _, value in tbl4 do
        table.insert(tbl5, settleWithin(value.read))
    end

    return Promise.all(tbl5):andThen(function(tbl6)
        for value, value2 in tbl4 do
            tbl3[value2.key] = tbl6[value]
        end
        return tbl3
    end)
end

return module
