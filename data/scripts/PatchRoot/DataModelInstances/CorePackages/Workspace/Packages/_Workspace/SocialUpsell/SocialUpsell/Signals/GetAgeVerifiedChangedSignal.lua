-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:40:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local NotificationService = game:GetService("NotificationService")

local SocialUpsellParent = script:FindFirstAncestor("SocialUpsell").Parent

local AppCommonLib = require(SocialUpsellParent.AppCommonLib)
local RealtimeDelivery = require(SocialUpsellParent.RealtimeDelivery)

local FStringAEGIS2AppChatAgeVerifiedRealtimeNamespace = require(SocialUpsellParent.SharedFlags).FStringAEGIS2AppChatAgeVerifiedRealtimeNamespace

local robloxEventReceiver = RealtimeDelivery.RobloxEventReceiver.new(NotificationService)

local Signal = AppCommonLib.Signal

local var1 = nil

return function()
    if not var1 then
        var1 = Signal.new()

        if FStringAEGIS2AppChatAgeVerifiedRealtimeNamespace and #FStringAEGIS2AppChatAgeVerifiedRealtimeNamespace > 0 then
            robloxEventReceiver:observeEvent(FStringAEGIS2AppChatAgeVerifiedRealtimeNamespace, function(arg1)
                if var1 then
                    var1:fire(arg1)
                end
            end)
        end
    end
    return var1
end
