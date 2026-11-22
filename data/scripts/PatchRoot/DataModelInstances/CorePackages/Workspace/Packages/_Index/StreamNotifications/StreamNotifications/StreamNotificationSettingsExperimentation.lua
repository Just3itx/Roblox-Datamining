-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T23:30:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local StreamNotificationsParent = script:FindFirstAncestor("StreamNotifications").Parent

local SharedFlags = require(StreamNotificationsParent.SharedFlags)
local FFlagStreamNotificationUXSettingsHeader = SharedFlags.FFlagStreamNotificationUXSettingsHeader
local GetFStringNotificationsStreamNotificationUXLayer = SharedFlags.GetFStringNotificationsStreamNotificationUXLayer
local ixpHelper = require(StreamNotificationsParent.NotificationsCommon).ixpHelper

local str1 = game:DefineFastString("StreamNotificationUXSettingsGearVariant", "enableStreamSettingsGear")

local function getLayerVariables() -- Luacid: Inlined by compiler; 2 call sites recovered
    return ixpHelper.getIxpLayerData(GetFStringNotificationsStreamNotificationUXLayer())
end

local function getIsUserInTreatment(): boolean -- Luacid: unused: defined but never referenced
    local layerVariables = getLayerVariables()

    return if layerVariables and layerVariables[str1] ~= nil then layerVariables[str1] == true else false
end

return {
    getSettingsGearEnabled = function()
        local var1 = FFlagStreamNotificationUXSettingsHeader

        if var1 then
            local layerVariables = getLayerVariables()

            if layerVariables and layerVariables[str1] ~= nil then
                return layerVariables[str1] == true
            end

            var1 = false
        end

        return var1
    end
}
