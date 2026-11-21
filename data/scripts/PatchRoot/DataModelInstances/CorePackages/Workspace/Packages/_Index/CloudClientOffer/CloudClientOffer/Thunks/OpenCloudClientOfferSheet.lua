-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:01:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CloudClientOffer = script:FindFirstAncestor("CloudClientOffer")
local CloudClientOfferParent = CloudClientOffer.Parent

local CentralOverlay = require(CloudClientOfferParent.CentralOverlay)
local Signals = require(CloudClientOfferParent.Signals)
local CentralOverlayType = require(CloudClientOfferParent.RobloxAppEnums).CentralOverlayType

local _createCloudClientOffer = require(CloudClientOffer.createCloudClientOffer)

local SetCentralOverlay = CentralOverlay.Actions.SetCentralOverlay
local CloseCentralOverlay = CentralOverlay.Thunks.CloseCentralOverlay

local function OpenCloudClientOfferSheet(arg1, arg2)
    return function(arg3)
        local bool1 = false
        local function closeThen(callback: (...any) -> (...any)) -- Luacid: Inlined by compiler; 3 call sites recovered
            return function()
                if bool1 then
                    return
                end
                bool1 = true
                arg3:dispatch(CloseCentralOverlay())
                callback()
            end
        end

        local effect = nil
        arg3:dispatch(
            SetCentralOverlay(CentralOverlayType.CloudClientOfferSheet, {
                offerKind = arg2.kind,
                onAccept = closeThen(arg1.accept),
                onDecline = closeThen(arg1.decline),
                onDismiss = closeThen(arg1.dismiss),
                onUnmount = function()
                    if effect ~= nil then
                        effect()
                        effect = nil
                    end
                    if not bool1 then
                        bool1 = true
                        arg1.dismiss()
                    end
                end
            })
        )

        effect = Signals.createEffect(function(arg4)
            if arg1.getHeldOffer(arg4) == nil and not bool1 then
                bool1 = true
                arg3:dispatch(CloseCentralOverlay())
            end
        end)
    end
end

return OpenCloudClientOfferSheet
