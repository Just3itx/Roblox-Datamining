-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:41:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpUpsell = script:FindFirstAncestor("AmpUpsell")
local AmpUpsellParent = AmpUpsell.Parent
local React = require(AmpUpsellParent.React)
local UrlBase = require(AmpUpsellParent.UrlBuilder).UrlBase
local AppScreens = require(AmpUpsell.Common.AppScreens)
local _Enums = require(AmpUpsell.Common.Enums)

local function useCompletionCallbackWithReturnPage(arg1, callback: (...any) -> (...any), arg2)
    return React.useCallback(function(arg3, tbl1)
        if not (arg2 and arg2.returnPage) then
            callback(arg3, tbl1)

            return
        end

        local detail = UrlBase.new("www") .. "/" .. arg2.returnPage
        arg1.pop()
        arg1.push(
            AppScreens.GenericWebPage,
            {
                detail = detail,
                extraProps = { titleKey = "CommonUI.Features.Label.Settings" }
            }
        )
    end, { arg2, callback, arg1 })
end

return useCompletionCallbackWithReturnPage
