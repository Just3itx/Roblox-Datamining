-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T16:41:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialBlockingModalParent = script:FindFirstAncestor("SocialBlockingModal").Parent

local React = require(SocialBlockingModalParent.React)

local useDispatch = require(SocialBlockingModalParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useLocalization = require(SocialBlockingModalParent.Localization).Hooks.useLocalization
local SetCurrentToastMessage = require(SocialBlockingModalParent.ToastRodux).Actions.SetCurrentToastMessage

local function useShowToastOnError()
    local var1 = useDispatch()
    local var2 = useLocalization({
        somethingIsWrongToast = "Feature.Toast.NetworkingError.SomethingIsWrong",
        blockLimitReachedToast = "Feature.Profile.Message.BlockError",
        blocktargetAlreadyBlockedToast = "Feature.Friends.Error.TargetAlreadyBlockedError"
    })

    return React.useCallback(function(tbl1)
        local var3 = tbl1 and tbl1.Body and tonumber(tbl1.Body) or nil

        if var3 == 1 then
            var1(SetCurrentToastMessage({ toastMessage = var2.blocktargetAlreadyBlockedToast, isLocalized = true }))
        elseif var3 == 2 then
            var1(SetCurrentToastMessage({ toastMessage = var2.blockLimitReachedToast, isLocalized = true }))
        else
            var1(SetCurrentToastMessage({ toastMessage = var2.somethingIsWrongToast, isLocalized = true }))
        end
    end, { var1, var2 })
end

return useShowToastOnError
