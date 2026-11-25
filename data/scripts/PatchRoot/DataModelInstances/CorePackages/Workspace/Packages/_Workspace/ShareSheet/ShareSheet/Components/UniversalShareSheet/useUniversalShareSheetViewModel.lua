-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T14:41:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ShareSheet = script:FindFirstAncestor("ShareSheet")
local ShareSheetParent = ShareSheet.Parent

local SignalsReact = require(ShareSheetParent.SignalsReact)

local _useShareSheetViewModel = require(script.Parent.Parent.useShareSheetViewModel)
local GetUniversalShareSheetStore = require(ShareSheet.Stores.GetUniversalShareSheetStore)

local function useUniversalShareSheetViewModel()
    local universalShareSheetStore = GetUniversalShareSheetStore()
    local var1 = SignalsReact.useSignalState(universalShareSheetStore.getRequest)

    if var1 == nil then
        return nil
    end

    return {
        context = var1.context,
        formatSuccessSnackbarText = var1.formatSuccessSnackbarText,
        isOpen = true,
        messagePlaceholder = var1.messagePlaceholder,
        onCloseWithReason = universalShareSheetStore.hide,
        recipientSource = var1.recipientSource,
        telemetryId = var1.telemetryId,
        url = var1.url
    }
end

return useUniversalShareSheetViewModel
