-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T12:01:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedUtilities = script:FindFirstAncestor("SduiSharedUtilities")
local SduiSharedUtilitiesParent = SduiSharedUtilities.Parent
local React = require(SduiSharedUtilitiesParent.React)
local SignalsReact = require(SduiSharedUtilitiesParent.SignalsReact)
local getSduiPageEntrySnackbarStore = require(SduiSharedUtilities.getSduiPageEntrySnackbarStore)

local function usePageEntrySnackbar(str1: string)
    local var1 = getSduiPageEntrySnackbarStore().getSignal(str1)

    local snackbarConfig = SignalsReact.useSignalState(var1)

    local var3 = React.useCallback(function()
        if str1 then
            getSduiPageEntrySnackbarStore().hide(str1)
        end
    end, { str1 })

    React.useEffect(function()
        if snackbarConfig == nil then
            return
        end

        local durationSeconds = snackbarConfig.durationSeconds or 4
        local var4 = task.delay(durationSeconds, function()
            if str1 then
                getSduiPageEntrySnackbarStore().hide(str1)
            end
        end)

        return function()
            task.cancel(var4)
        end
    end, { snackbarConfig })

    return { snackbarConfig = snackbarConfig, dismissSnackbar = var3, onDismiss = var3 }
end

return usePageEntrySnackbar
