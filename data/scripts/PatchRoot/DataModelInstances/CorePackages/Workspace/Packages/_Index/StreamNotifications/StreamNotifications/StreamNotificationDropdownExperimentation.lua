-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T23:30:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local StreamNotifications = script:FindFirstAncestor("StreamNotifications")
local StreamNotificationsParent = StreamNotifications.Parent

local FFlagStreamNotificationUXDropdown = require(StreamNotificationsParent.SharedFlags).FFlagStreamNotificationUXDropdown
local ixpHelper = require(StreamNotificationsParent.NotificationsCommon).ixpHelper
local constants = require(StreamNotifications.constants)

local str1 = game:DefineFastString("StreamNotificationUXExposureLayer", "Notifications.StreamNotificationUXExposure")

local str2 = game:DefineFastString("StreamNotificationUXDropdownVariant", "enableStreamDropdown")

local function getIsLargeScreen(): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    local currentCamera = workspace.CurrentCamera
    return not (currentCamera == nil) and currentCamera.ViewportSize.X >= constants.Modal.WidthLimit
end

local function getIsUserInTreatment(): boolean -- Luacid: unused: defined but never referenced
    local ixpLayerData = ixpHelper.getIxpLayerData(str1)

    return if ixpLayerData and ixpLayerData[str2] ~= nil then ixpLayerData[str2] == true else false
end

return {
    getDropdownEnabled = function()
        local isLargeScreen = FFlagStreamNotificationUXDropdown and getIsLargeScreen()

        if isLargeScreen then
            local ixpLayerData = ixpHelper.getIxpLayerData(str1)

            if ixpLayerData and ixpLayerData[str2] ~= nil then
                return ixpLayerData[str2] == true
            end

            isLargeScreen = false
        end

        return isLargeScreen
    end,
    logExposure = function()
        if not FFlagStreamNotificationUXDropdown or not getIsLargeScreen() then
            return
        end

        local ixpLayerData = ixpHelper.getIxpLayerData(str1)
        if ixpLayerData and ixpLayerData[str2] ~= nil then
            ixpHelper.logUserLayerExposure(str1)
        end
    end
}
