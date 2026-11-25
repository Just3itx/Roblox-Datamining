-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:31:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialUpsell = script:FindFirstAncestor("SocialUpsell")
local SocialUpsellParent = SocialUpsell.Parent

local React = require(SocialUpsellParent.React)
local RealtimeDelivery = require(SocialUpsellParent.RealtimeDelivery)
local GetAgeVerifiedChangedSignal = require(SocialUpsell.Signals.GetAgeVerifiedChangedSignal)

local FStringAEGIS2AppChatAgeVerifiedRealtimeNamespace = require(SocialUpsellParent.SharedFlags).FStringAEGIS2AppChatAgeVerifiedRealtimeNamespace

function SocialUpsellEventReceiver(tbl1)
    RealtimeDelivery.useRealtimeConnectionStateChanged(FStringAEGIS2AppChatAgeVerifiedRealtimeNamespace, function(connectionState, arg1)
        if connectionState == Enum.ConnectionState.Connected and arg1 then
            GetAgeVerifiedChangedSignal():fire()
        end
    end, {})

    React.useEffect(function()
        if tbl1.shouldRequestAppAgeSignals then
            require(SocialUpsellParent.AppStoreAgeSignalsManager).AppAgeSignalsManager.requestAppAgeSignals():catch(function() end)
        end
    end, { tbl1.shouldRequestAppAgeSignals })

    React.useEffect(function()
        local connection = if tbl1.onAgeVerifiedChange then GetAgeVerifiedChangedSignal():connect(tbl1.onAgeVerifiedChange) else nil

        return function()
            if connection then
                connection:disconnect()
            end
        end
    end, { tbl1.onAgeVerifiedChange })

    return nil
end

return SocialUpsellEventReceiver
