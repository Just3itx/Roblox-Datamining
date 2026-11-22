-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T10:41:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local NotificationService = game:GetService("NotificationService")
local Players = game:GetService("Players")

local ProfileCtaServiceParent = script:FindFirstAncestor("ProfileCtaService").Parent

local var1 = require(ProfileCtaServiceParent.RealtimeDelivery).RobloxEventReceiver.new(NotificationService)
local getLocalPlayerUserId = require(ProfileCtaServiceParent.DataHydration).DataHydrationUtils.getLocalPlayerUserId

local Constants = require(script.Parent.Constants)

local function createProfileCTAEventListener(callback: (...any) -> (...any))
    local localPlayerUserId = getLocalPlayerUserId()
    local connection = Players:GetPropertyChangedSignal("LocalPlayer"):Connect(function()
        local localPlayerUserId2 = getLocalPlayerUserId()
        if localPlayerUserId2 ~= localPlayerUserId then
            localPlayerUserId = localPlayerUserId2
        end
    end)

    local var2 = var1:observeEvent(Constants.FRIENDSHIP_NOTIFICATIONS, function(tbl1)
        if not (tbl1.EventArgs and tbl1.EventArgs.UserId1 and tbl1.EventArgs.UserId2) then
            return
        end

        local str1 = tostring(localPlayerUserId)
        local userId1 = tbl1.EventArgs.UserId1
        local var2 = if str1 == tostring(userId1) then tostring(tbl1.EventArgs.UserId2) else tostring(tbl1.EventArgs.UserId1)
        callback(var2)
    end)

    local var3 = var1:observeEvent(Constants.PRESENCE_BULK_NOTIFICATIONS, function(tbl1)
        if not tbl1 or type(tbl1) ~= "table" then
            return
        end
        for _, value in ipairs(tbl1) do
            if value and value.UserId then
                local str1 = tostring(value.UserId)
                callback(str1)
            end
        end
    end)

    return function()
        if connection then
            connection:Disconnect()
            connection = nil
        end

        if var2 then
            var2:disconnect()
            var2 = nil
        end

        if var3 then
            var3:disconnect()
            var3 = nil
        end
    end
end

return createProfileCTAEventListener
