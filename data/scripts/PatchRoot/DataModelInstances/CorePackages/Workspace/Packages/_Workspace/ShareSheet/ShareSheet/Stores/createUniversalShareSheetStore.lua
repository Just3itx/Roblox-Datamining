-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T14:51:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ShareSheet = script:FindFirstAncestor("ShareSheet")
local ShareSheetParent = ShareSheet.Parent

local Signals = require(ShareSheetParent.Signals)
local RecipientSource = require(ShareSheet.Recipients.RecipientSource)
local ShareSheetTelemetry = require(ShareSheet.telemetry.ShareSheetTelemetry)

local function createUniversalShareSheetStore()
    local getIsPeoplePickerDisplayed, setIsPeoplePickerDisplayed = Signals.createSignal(false)

    local getRequest, var4 = Signals.createSignal(nil)

    local function hide(closeReason)
        setIsPeoplePickerDisplayed(false)
        local var5 = getRequest(false)
        if var5 == nil then
            return
        end

        var4(nil)
        ShareSheetTelemetry.logLifecycle({
            context = var5.context,
            telemetryId = var5.telemetryId or "",
            lifecycleType = ShareSheetTelemetry.LifecycleType.Close,
            closeReason = closeReason or ShareSheetTelemetry.CloseReason.Programmatic,
            recipientSource = var5.recipientSource
        })
        if var5.onHidden then
            var5.onHidden()
        end
    end

    return {
        getIsPeoplePickerDisplayed = getIsPeoplePickerDisplayed,
        getRequest = getRequest,
        setIsPeoplePickerDisplayed = setIsPeoplePickerDisplayed,
        show = function(tbl1)
            if tbl1.recipientSource ~= nil and not RecipientSource.isValidRecipientSource(tbl1.recipientSource) then
                error(`Invalid recipient source {tbl1.recipientSource}`)
            end
            hide(ShareSheetTelemetry.CloseReason.Replaced)
            var4(table.clone(tbl1))
            ShareSheetTelemetry.logLifecycle({
                context = tbl1.context,
                telemetryId = tbl1.telemetryId or "",
                lifecycleType = ShareSheetTelemetry.LifecycleType.Open,
                recipientSource = tbl1.recipientSource
            })

            if tbl1.onShown then
                tbl1.onShown()
            end
        end,
        hide = hide
    }
end

return createUniversalShareSheetStore
