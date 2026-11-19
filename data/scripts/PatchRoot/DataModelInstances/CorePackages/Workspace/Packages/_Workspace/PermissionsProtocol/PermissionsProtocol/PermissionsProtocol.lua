-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T12:30:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local scriptParentParent = script.Parent.Parent
local MessageBus = require(scriptParentParent.MessageBus).MessageBus
local Promise = require(scriptParentParent.Promise)
local t = require(scriptParentParent.t)

local isVersionAtLeast = require(script.Parent.isVersionAtLeast)

local GetFFlagLuaEnableShowUpsellMethod = require(scriptParentParent.SharedFlags).GetFFlagLuaEnableShowUpsellMethod

local bool1 = game:DefineFastFlag("ScopedSubscribersForPermissionsProtocol2", false)

local _PermissionsProtocolTypes = require(script.Parent.PermissionsProtocolTypes)

game:DefineFastFlag("DebugRomarkAudioPermissionsBypass", false)

game:DefineFastFlag("EnableAndroidOpenNotificationSettings", false)
game:DefineFastString("AndroidOpenNotificationSettingsMinVersion", "")
game:DefineFastFlag("PermissionsProtocolNonStickyResponses", false)

local Permissions = {
    CAMERA_ACCESS = "CAMERA_ACCESS",
    MICROPHONE_ACCESS = "MICROPHONE_ACCESS",
    LOCAL_NETWORK = "LOCAL_NETWORK",
    CONTACTS_ACCESS = "CONTACTS_ACCESS",
    WRITE_MEDIA_STORAGE = "WRITE_MEDIA_STORAGE",
    POST_NOTIFICATIONS = "POST_NOTIFICATIONS"
}

local Status = {
    AUTHORIZED = "AUTHORIZED",
    DENIED = "DENIED",
    RESTRICTED = "RESTRICTED",
    UNSUPPORTED = "UNSUPPORTED"
}

local UpsellStatus = { SHOW = "SHOW", HIDE = "HIDE", UNSUPPORTED = "UNSUPPORTED" }

local OpenSettingsStatus = {
    OPENED_NOTIFICATION_SETTINGS = "OPENED_NOTIFICATION_SETTINGS",
    OPENED_APP_SETTINGS = "OPENED_APP_SETTINGS",
    FAILED = "FAILED"
}

local var1 = t.array(t.valueOf(Permissions))
local status = t.valueOf(Status)
local upsellStatus = t.valueOf(UpsellStatus)

local module = {
    Permissions = Permissions,
    Status = Status,
    UpsellStatus = UpsellStatus,
    OpenSettingsStatus = OpenSettingsStatus,
    PERMISSION_REQUEST_PROTOCOL_METHOD_REQUEST_DESCRIPTOR = {
        protocolName = "PermissionsProtocol",
        methodName = "PermissionsRequest",
        validateParams = t.strictInterface({ permissions = var1 })
    },
    PERMISSION_REQUEST_PROTOCOL_METHOD_RESPONSE_DESCRIPTOR = {
        protocolName = "PermissionsProtocol",
        methodName = "PermissionsRequest",
        validateParams = t.strictInterface({ status = status, missingPermissions = var1 })
    },
    HAS_PERMISSIONS_PROTOCOL_METHOD_REQUEST_DESCRIPTOR = {
        protocolName = "PermissionsProtocol",
        methodName = "HasPermissions",
        validateParams = t.strictInterface({ permissions = var1 })
    },
    HAS_PERMISSIONS_PROTOCOL_METHOD_RESPONSE_DESCRIPTOR = {
        protocolName = "PermissionsProtocol",
        methodName = "HasPermissions",
        validateParams = t.strictInterface({ status = status, missingPermissions = var1 })
    },
    SUPPORTS_PERMISSIONS_PROTOCOL_METHOD_REQUEST_DESCRIPTOR = {
        protocolName = "PermissionsProtocol",
        methodName = "SupportsPermissions",
        validateParams = t.strictInterface({ includeStatus = t.literal(false) })
    },
    SUPPORTS_PERMISSIONS_PROTOCOL_METHOD_RESPONSE_DESCRIPTOR = {
        protocolName = "PermissionsProtocol",
        methodName = "SupportsPermissions",
        validateParams = t.strictInterface({ permissions = var1 })
    },
    SHOULD_SHOW_PERMISSION_UPSELL_PROTOCOL_METHOD_REQUEST_DESCRIPTOR = {
        protocolName = "PermissionsProtocol",
        methodName = "ShouldShowPermissionUpsell",
        validateParams = t.strictInterface({ permissions = var1 })
    },
    SHOULD_SHOW_PERMISSION_UPSELL_PROTOCOL_METHOD_RESPONSE_DESCRIPTOR = {
        protocolName = "PermissionsProtocol",
        methodName = "ShouldShowPermissionUpsell",
        validateParams = t.strictInterface({ hiddenUpsellPermissions = var1, upsellStatus = upsellStatus })
    },
    SHOULD_SHOW_PERMISSION_RATIONALE_PROTOCOL_METHOD_REQUEST_DESCRIPTOR = {
        protocolName = "PermissionsProtocol",
        methodName = "ShouldShowRequestPermissionRationale",
        validateParams = t.strictInterface({ permissions = var1 })
    },
    SHOULD_SHOW_PERMISSION_RATIONALE_PROTOCOL_METHOD_RESPONSE_DESCRIPTOR = {
        protocolName = "PermissionsProtocol",
        methodName = "ShouldShowRequestPermissionRationale",
        validateParams = t.strictInterface({ hiddenUpsellPermissions = var1, upsellStatus = upsellStatus })
    },
    OPEN_NOTIFICATION_SETTINGS_PROTOCOL_METHOD_REQUEST_DESCRIPTOR = {
        protocolName = "PermissionsProtocol",
        methodName = "OpenNotificationSettings",
        validateParams = t.strictInterface({ permissions = var1 })
    },
    OPEN_NOTIFICATION_SETTINGS_PROTOCOL_METHOD_RESPONSE_DESCRIPTOR = {
        protocolName = "PermissionsProtocol",
        methodName = "OpenNotificationSettings",
        validateParams = t.strictInterface({ status = t.valueOf(OpenSettingsStatus) })
    },
    GET_PUSH_NOTIFICATIONS_ENABLED_PROTOCOL_METHOD_REQUEST_DESCRIPTOR = {
        protocolName = "PermissionsProtocol",
        methodName = "GetPushNotificationsEnabled",
        validateParams = t.strictInterface({ permissions = var1 })
    },
    GET_PUSH_NOTIFICATIONS_ENABLED_PROTOCOL_METHOD_RESPONSE_DESCRIPTOR = {
        protocolName = "PermissionsProtocol",
        methodName = "GetPushNotificationsEnabled",
        validateParams = t.strictInterface({ enabled = t.boolean })
    },
    _getPlatform = function(): Enum.Platform
        return UserInputService:GetPlatform()
    end,
    _getVersion = function(): string
        return RunService:GetRobloxVersion()
    end,
    _openNotificationSettingsTimeoutSeconds = 5,
    _getPushNotificationsEnabledTimeoutSeconds = 1
}

module.__index = module

local function getPermissionRequestTelemetryData(permissions)
    local permissionRequestTelemetryData = ({})
    for _, permission in pairs(permissions) do
        if permission == module.Permissions.CAMERA_ACCESS then
            permissionRequestTelemetryData.camera_access_requested = ""
        end
        if permission == module.Permissions.MICROPHONE_ACCESS then
            permissionRequestTelemetryData.microphone_access_requested = ""
        end
        if permission == module.Permissions.LOCAL_NETWORK then
            permissionRequestTelemetryData.local_network_requested = ""
        end
        if permission == module.Permissions.CONTACTS_ACCESS then
            permissionRequestTelemetryData.contacts_access_requested = ""
        end
    end
    return permissionRequestTelemetryData
end

local function createSequencedProtocolMethodCall(activeCalls, arg1, arg2, arg3, tbl5, bool2: boolean?)
    assert(arg2.validateParams(arg3))

    local var4 = (activeCalls[arg1] or Promise.resolve()):finally(function()
        return Promise.new(function(callback)
            local subscriber = MessageBus.Subscriber.new()
            subscriber:subscribeProtocolMethodResponse(arg1, function(arg4)
                subscriber:unsubscribeToProtocolMethodResponse(arg1)
                callback(arg4)
            end, bool2)
            MessageBus.publishProtocolMethodRequest(arg2, arg3, tbl5)
        end)
    end)

    activeCalls[arg1] = var4
    return var4
end

local function getResponseSticky(): boolean? -- Luacid: Inlined by compiler; 10 call sites recovered
    return not game:GetFastFlag("PermissionsProtocolNonStickyResponses") and nil
end

local function getPlatform() -- Luacid: Inlined by compiler; 3 call sites recovered
    local success, result = pcall(module._getPlatform)
    return if success then result else nil
end

local function isAndroidNotificationSettingsGateOpen() -- Luacid: Inlined by compiler; 2 call sites recovered
    return game:GetFastFlag("EnableAndroidOpenNotificationSettings")
        and isVersionAtLeast(module._getVersion(), game:GetFastString("AndroidOpenNotificationSettingsMinVersion"))
end

local function callPushNotificationSettingsMethod(arg1, arg2, arg3)
    local permissions = { module.Permissions.POST_NOTIFICATIONS }
    local tbl6 = { permissions = permissions }

    local permissionRequestTelemetryData = getPermissionRequestTelemetryData(permissions)

    if bool1 then
        return (createSequencedProtocolMethodCall(arg1.activeCalls, arg3, arg2, tbl6, permissionRequestTelemetryData, false))
    end

    local promise = Promise.new(function(callback, _)
        arg1.subscriber:subscribeProtocolMethodResponse(arg3, function(arg4)
            arg1.subscriber:unsubscribeToProtocolMethodResponse(arg3)
            callback(arg4)
        end, false)
    end)
    MessageBus.publishProtocolMethodRequest(arg2, tbl6, permissionRequestTelemetryData)
    return promise
end

function module.new()
    return (setmetatable(
        {
            activeCalls = bool1 and {} or nil,
            subscriber = if bool1 then nil else MessageBus.Subscriber.new()
        },
        module
    ))
end

function module:hasPermissions(permissions)
    if bool1 then
        local hasPermissionsProtocolMethodResponseDescriptor = self.HAS_PERMISSIONS_PROTOCOL_METHOD_RESPONSE_DESCRIPTOR
        local hasPermissionsProtocolMethodRequestDescriptor = self.HAS_PERMISSIONS_PROTOCOL_METHOD_REQUEST_DESCRIPTOR
        return (createSequencedProtocolMethodCall(
            self.activeCalls,
            hasPermissionsProtocolMethodResponseDescriptor,
            hasPermissionsProtocolMethodRequestDescriptor,
            { permissions = permissions },
            getPermissionRequestTelemetryData(permissions),
            (getResponseSticky())
        ))
    end
    local promise = Promise.new(function(callback, _)
        local hasPermissionsProtocolMethodResponseDescriptor = self.HAS_PERMISSIONS_PROTOCOL_METHOD_RESPONSE_DESCRIPTOR
        self.subscriber:subscribeProtocolMethodResponse(hasPermissionsProtocolMethodResponseDescriptor, function(arg1)
            self.subscriber:unsubscribeToProtocolMethodResponse(hasPermissionsProtocolMethodResponseDescriptor)
            callback(arg1)
        end, (getResponseSticky()))
    end)

    MessageBus.publishProtocolMethodRequest(
        self.HAS_PERMISSIONS_PROTOCOL_METHOD_REQUEST_DESCRIPTOR,
        { permissions = permissions },
        (getPermissionRequestTelemetryData(permissions))
    )
    return promise
end

function module:requestPermissions(permissions)
    if game:GetFastFlag("DebugRomarkAudioPermissionsBypass") then
        local tbl5 = ({})
        tbl5.missingPermissions = {}
        tbl5.status = module.Status.AUTHORIZED
        return Promise.resolve(tbl5)
    elseif bool1 then
        local permissionRequestProtocolMethodResponseDescriptor = self.PERMISSION_REQUEST_PROTOCOL_METHOD_RESPONSE_DESCRIPTOR
        local permissionRequestProtocolMethodRequestDescriptor = self.PERMISSION_REQUEST_PROTOCOL_METHOD_REQUEST_DESCRIPTOR
        return (createSequencedProtocolMethodCall(
            self.activeCalls,
            permissionRequestProtocolMethodResponseDescriptor,
            permissionRequestProtocolMethodRequestDescriptor,
            { permissions = permissions },
            getPermissionRequestTelemetryData(permissions),
            (getResponseSticky())
        ))
    else
        local promise = Promise.new(function(callback, _)
            local permissionRequestProtocolMethodResponseDescriptor = self.PERMISSION_REQUEST_PROTOCOL_METHOD_RESPONSE_DESCRIPTOR
            self.subscriber:subscribeProtocolMethodResponse(permissionRequestProtocolMethodResponseDescriptor, function(arg1)
                self.subscriber:unsubscribeToProtocolMethodResponse(permissionRequestProtocolMethodResponseDescriptor)
                callback(arg1)
            end, (getResponseSticky()))
        end)

        MessageBus.publishProtocolMethodRequest(
            self.PERMISSION_REQUEST_PROTOCOL_METHOD_REQUEST_DESCRIPTOR,
            { permissions = permissions },
            (getPermissionRequestTelemetryData(permissions))
        )
        return promise
    end
end

function module:getSupportedPermissionsList()
    if bool1 then
        local supportsPermissionsProtocolMethodResponseDescriptor = self.SUPPORTS_PERMISSIONS_PROTOCOL_METHOD_RESPONSE_DESCRIPTOR
        local supportsPermissionsProtocolMethodRequestDescriptor = self.SUPPORTS_PERMISSIONS_PROTOCOL_METHOD_REQUEST_DESCRIPTOR
        return (createSequencedProtocolMethodCall(
            self.activeCalls,
            supportsPermissionsProtocolMethodResponseDescriptor,
            supportsPermissionsProtocolMethodRequestDescriptor,
            { includeStatus = false },
            {},
            (getResponseSticky())
        ))
    end
    local promise = Promise.new(function(callback, _)
        local supportsPermissionsProtocolMethodResponseDescriptor = self.SUPPORTS_PERMISSIONS_PROTOCOL_METHOD_RESPONSE_DESCRIPTOR
        self.subscriber:subscribeProtocolMethodResponse(supportsPermissionsProtocolMethodResponseDescriptor, function(arg1)
            self.subscriber:unsubscribeToProtocolMethodResponse(supportsPermissionsProtocolMethodResponseDescriptor)
            callback(arg1)
        end, (getResponseSticky()))
    end)

    MessageBus.publishProtocolMethodRequest(
        self.SUPPORTS_PERMISSIONS_PROTOCOL_METHOD_REQUEST_DESCRIPTOR,
        { includeStatus = false },
        {}
    )
    return promise
end

function module.supportsPermissions(arg1, arg2)
    assert(var1(arg2))

    return (arg1:getSupportedPermissionsList():andThen(function(arg3)
        local permissions = arg3 and arg3.permissions
        if not permissions then
            return Promise.reject()
        end

        for _, value in pairs(arg2) do
            local bool2 = false
            for _, permission in pairs(permissions) do
                if value == permission then
                    bool2 = true
                    break
                end
            end

            if not bool2 then
                return Promise.resolve(false)
            end
        end
        return Promise.resolve(true)
    end))
end

function module.checkOrRequestPermissions(arg1, arg2)
    assert(var1(arg2))

    return arg1:supportsPermissions(arg2):andThen(function(arg3)
        if not arg3 then
            return Promise.resolve(module.Status.UNSUPPORTED)
        end

        return (arg1:hasPermissions(arg2):andThen(function(arg4)
            if arg4.status == module.Status.AUTHORIZED then
                return Promise.resolve(arg4.status)
            end

            return arg1:requestPermissions(arg2):andThen(function(arg5)
                return Promise.resolve(arg5.status)
            end)
        end))
    end, function(_)
        return Promise.resolve(module.Status.UNSUPPORTED)
    end)
end

function module:shouldShowUpsell(permissions)
    if not GetFFlagLuaEnableShowUpsellMethod() then
        return Promise.resolve({})
    elseif bool1 then
        local shouldShowPermissionUpsellProtocolMethodResponseDescriptor = self.SHOULD_SHOW_PERMISSION_UPSELL_PROTOCOL_METHOD_RESPONSE_DESCRIPTOR
        local shouldShowPermissionUpsellProtocolMethodRequestDescriptor = self.SHOULD_SHOW_PERMISSION_UPSELL_PROTOCOL_METHOD_REQUEST_DESCRIPTOR
        return (createSequencedProtocolMethodCall(
            self.activeCalls,
            shouldShowPermissionUpsellProtocolMethodResponseDescriptor,
            shouldShowPermissionUpsellProtocolMethodRequestDescriptor,
            { permissions = permissions },
            getPermissionRequestTelemetryData(permissions),
            (getResponseSticky())
        ))
    else
        local promise = Promise.new(function(callback, _)
            local shouldShowPermissionUpsellProtocolMethodResponseDescriptor = self.SHOULD_SHOW_PERMISSION_UPSELL_PROTOCOL_METHOD_RESPONSE_DESCRIPTOR
            self.subscriber:subscribeProtocolMethodResponse(
                shouldShowPermissionUpsellProtocolMethodResponseDescriptor,
                function(arg1)
                    self.subscriber:unsubscribeToProtocolMethodResponse(shouldShowPermissionUpsellProtocolMethodResponseDescriptor)
                    callback(arg1)
                end,
                (getResponseSticky())
            )
        end)
        MessageBus.publishProtocolMethodRequest(
            self.SHOULD_SHOW_PERMISSION_UPSELL_PROTOCOL_METHOD_REQUEST_DESCRIPTOR,
            { permissions = permissions },
            (getPermissionRequestTelemetryData(permissions))
        )
        return promise
    end
end

function module:shouldShowRationale(permissions)
    if bool1 then
        local shouldShowPermissionRationaleProtocolMethodResponseDescriptor = self.SHOULD_SHOW_PERMISSION_RATIONALE_PROTOCOL_METHOD_RESPONSE_DESCRIPTOR
        local shouldShowPermissionRationaleProtocolMethodRequestDescriptor = self.SHOULD_SHOW_PERMISSION_RATIONALE_PROTOCOL_METHOD_REQUEST_DESCRIPTOR
        return (createSequencedProtocolMethodCall(
            self.activeCalls,
            shouldShowPermissionRationaleProtocolMethodResponseDescriptor,
            shouldShowPermissionRationaleProtocolMethodRequestDescriptor,
            { permissions = permissions },
            getPermissionRequestTelemetryData(permissions),
            (getResponseSticky())
        ))
    end
    local promise = Promise.new(function(callback, _)
        local shouldShowPermissionRationaleProtocolMethodResponseDescriptor = self.SHOULD_SHOW_PERMISSION_RATIONALE_PROTOCOL_METHOD_RESPONSE_DESCRIPTOR
        self.subscriber:subscribeProtocolMethodResponse(
            shouldShowPermissionRationaleProtocolMethodResponseDescriptor,
            function(arg1)
                self.subscriber:unsubscribeToProtocolMethodResponse(shouldShowPermissionRationaleProtocolMethodResponseDescriptor)
                callback(arg1)
            end,
            (getResponseSticky())
        )
    end)
    MessageBus.publishProtocolMethodRequest(
        self.SHOULD_SHOW_PERMISSION_RATIONALE_PROTOCOL_METHOD_REQUEST_DESCRIPTOR,
        { permissions = permissions },
        (getPermissionRequestTelemetryData(permissions))
    )
    return promise
end

function module.isOpenNotificationSettingsSupported()
    local platform = getPlatform()

    if platform == Enum.Platform.IOS then
        return true
    elseif platform == Enum.Platform.Android then
        return (isAndroidNotificationSettingsGateOpen())
    end

    return false
end

function module.openNotificationSettings(arg1)
    if not module.isOpenNotificationSettingsSupported() then
        return Promise.resolve({ status = OpenSettingsStatus.FAILED })
    end

    if getPlatform() == Enum.Platform.IOS then
        return arg1:requestPermissions({ module.Permissions.POST_NOTIFICATIONS }):andThen(function()
            return {
                status = OpenSettingsStatus.OPENED_APP_SETTINGS
            }
        end, function()
            return {
                status = OpenSettingsStatus.FAILED
            }
        end)
    end
    local openNotificationSettingsProtocolMethodRequestDescriptor = arg1.OPEN_NOTIFICATION_SETTINGS_PROTOCOL_METHOD_REQUEST_DESCRIPTOR
    local openNotificationSettingsProtocolMethodResponseDescriptor = arg1.OPEN_NOTIFICATION_SETTINGS_PROTOCOL_METHOD_RESPONSE_DESCRIPTOR
    return callPushNotificationSettingsMethod(
        arg1,
        openNotificationSettingsProtocolMethodRequestDescriptor,
        openNotificationSettingsProtocolMethodResponseDescriptor
    ):timeout(
        module._openNotificationSettingsTimeoutSeconds
    ):andThen(
        function(arg2)
            return {
                status = arg2.status
            }
        end,
        function()
            return {
                status = OpenSettingsStatus.FAILED
            }
        end
    )
end

function module.getPushNotificationsEnabled(arg1)
    if getPlatform() ~= Enum.Platform.Android or not isAndroidNotificationSettingsGateOpen() then
        return Promise.reject("UNSUPPORTED")
    end

    local getPushNotificationsEnabledProtocolMethodRequestDescriptor = arg1.GET_PUSH_NOTIFICATIONS_ENABLED_PROTOCOL_METHOD_REQUEST_DESCRIPTOR
    local getPushNotificationsEnabledProtocolMethodResponseDescriptor = arg1.GET_PUSH_NOTIFICATIONS_ENABLED_PROTOCOL_METHOD_RESPONSE_DESCRIPTOR
    return callPushNotificationSettingsMethod(
        arg1,
        getPushNotificationsEnabledProtocolMethodRequestDescriptor,
        getPushNotificationsEnabledProtocolMethodResponseDescriptor
    ):timeout(
        module._getPushNotificationsEnabledTimeoutSeconds,
        "TIMEOUT"
    ):andThen(
        function(arg2)
            return {
                enabled = arg2.enabled
            }
        end
    )
end

module.default = module.new()

return module
