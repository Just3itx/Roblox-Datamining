-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:40:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppStorageService = game:GetService("AppStorageService")
local HttpService = game:GetService("HttpService")

local scriptParent = script.Parent

local analyticsService = require(scriptParent.analytics.analyticsService)
local dependencies = require(scriptParent.dependencies)
local NotificationSnoozedSignal = require(scriptParent.Signals).NotificationSnoozedSignal
local type2 = require(scriptParent.type)

local Cryo = dependencies.Cryo
local LocalStorage = dependencies.LocalStorage
local NotificationModalsManager = dependencies.NotificationModalsManager
local Images = dependencies.UIBlox.App.ImageSet.Images

local LocalStorageKey = LocalStorage.Enums.LocalStorageKey

local module = {}

module.__index = module

function module:_batchNotificationAction(tbl1, actionType: string)
    local var1 = type(tbl1.notificationType) ~= "table" and { tbl1.notificationType } or tbl1.notificationType

    for _, value in ipairs(var1) do
        if actionType == type2.SnoozeActionEnum.Mute then
            local snoozedNotificationTypes = self.snoozedNotificationTypes
            local tbl2 = {
                durationMinutes = tbl1.durationMinutes,
                snoozedTimestampMs = DateTime.now().UnixTimestampMillis
            }
            snoozedNotificationTypes[value] = tbl2
        elseif actionType == type2.SnoozeActionEnum.Unmute and self.snoozedNotificationTypes[value] then
            self.snoozedNotificationTypes[value] = nil
        end
    end

    self:_updateAppStorage()

    local context = tbl1.context or ""
    for _, value in ipairs(var1) do
        local tbl2 = {
            action_type = actionType,
            duration_minutes = tbl1.durationMinutes,
            notification_type = value
        }

        self._eventStream.sendEventDeferred(context, "notificationSnoozedEvent", tbl2)

        NotificationSnoozedSignal:fire(
            {
                actionType = actionType,
                context = tbl1.context,
                durationMinutes = tbl1.durationMinutes,
                notificationType = value
            }
        )
    end
    if tbl1.modalMessage and tbl1.modalMessage ~= "" then
        self:_showNotificationsModal(tbl1.modalMessage)
    end
end

function module._isExpiredSnooze(tbl1): boolean
    return tbl1.durationMinutes ~= -1
        and (DateTime.now().UnixTimestampMillis - tbl1.snoozedTimestampMs) / 1000 >= tbl1.durationMinutes * 60
end

function module:_showNotificationsModal(toastTitle: string)
    NotificationModalsManager.SetUIBloxToast({ iconImage = Images["icons/common/notificationOn"], toastTitle = toastTitle })
end

function module:_updateAppStorage()
    self._appStorageService:SetItem(
        LocalStorageKey.SnoozedNotificationTypesLocalStorageKey,
        HttpService:JSONEncode(self.snoozedNotificationTypes)
    )
    self._appStorageService:Flush()
end

function module.unmuteNotification(tbl1, tbl2)
    tbl1:_batchNotificationAction(tbl2, type2.SnoozeActionEnum.Unmute)
end

function module.snoozeNotification(tbl1, tbl2)
    tbl1:_batchNotificationAction(tbl2, type2.SnoozeActionEnum.Mute)
end

function module:isSnoozedNotificationType(str1: string): boolean
    if not self.snoozedNotificationTypes[str1] then
        return false
    end

    if not self._isExpiredSnooze(self.snoozedNotificationTypes[str1]) then
        return true
    end

    self.snoozedNotificationTypes = Cryo.Dictionary.omit(self.snoozedNotificationTypes, str1)
    self:_updateAppStorage()
    return false
end

function module.new(_appStorageService)
    local tbl1 = {
        _appStorageService = _appStorageService,
        _eventStream = analyticsService.EventStream,
        snoozedNotificationTypes = {}
    }

    setmetatable(tbl1, module)

    local tbl2 = {}
    local snoozedNotificationTypes = ({})
    local bool1 = false

    local success, result = pcall(function()
        return tbl1._appStorageService:GetItem(LocalStorageKey.SnoozedNotificationTypesLocalStorageKey)
    end)

    if success and result ~= "" then
        local success2, result2 = pcall(function()
            return HttpService:JSONDecode(result)
        end)
        if success2 then
            tbl2 = result2
        end
    end

    for k, value in pairs(tbl2) do
        if tbl1._isExpiredSnooze(value) then
            bool1 = true
        else
            snoozedNotificationTypes[k] = value
        end
    end

    tbl1.snoozedNotificationTypes = snoozedNotificationTypes

    if bool1 then
        tbl1:_updateAppStorage()
    end

    return tbl1
end

module.default = module.new(AppStorageService)
return module
