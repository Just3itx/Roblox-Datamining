-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T23:30:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local StreamNotifications = script:FindFirstAncestor("StreamNotifications")
local StreamNotificationsParent = StreamNotifications.Parent

local NotificationHelper = require(StreamNotificationsParent.NotificationsCommon).NotificationHelper
local NavigateDownToNotificationSettings = require(StreamNotificationsParent.NavigationRodux).Thunks.NavigateDownToNotificationSettings
local EventStream = require(StreamNotifications.analytics.analyticsService).EventStream
local analyticsConstants = require(StreamNotifications.analytics.analyticsConstants)
local constants = require(StreamNotifications.constants)

return {
    createOnSettingsActivated = function(bool1: boolean, bool2: boolean, callback: (...any) -> (...any), callback2: (...any) -> (...any))
        return function()
            if not bool1 then
                return
            end

            NotificationHelper.fireEvent(
                EventStream,
                analyticsConstants.Context.click,
                analyticsConstants.EventNames.goToSettingPage,
                {
                    in_app = true,
                    sendrVersion = constants.SENDRVersion
                }
            )

            if bool2 then
                callback(false)
            end
            callback2(NavigateDownToNotificationSettings())
        end
    end
}
