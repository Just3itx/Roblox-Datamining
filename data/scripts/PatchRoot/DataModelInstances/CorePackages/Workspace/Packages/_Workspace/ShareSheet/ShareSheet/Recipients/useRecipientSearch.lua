-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T14:51:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ShareSheet = script:FindFirstAncestor("ShareSheet")
local ShareSheetParent = ShareSheet.Parent

local React = require(ShareSheetParent.React)
local Signals = require(ShareSheetParent.Signals)
local SignalsReact = require(ShareSheetParent.SignalsReact)
local _Types = require(ShareSheet.Types)

local signal = Signals.createSignal(nil)

local function useRecipientSearch(str1: string, str2: string)
    local pageList = React.useMemo(function()
        if str2 ~= "" and str1.search ~= nil then
            return (str1.search(str2))
        end

        return nil
    end, { str1, str2 })
    local var2 = SignalsReact.useSignalState(if pageList then pageList.getResult else signal)

    React.useEffect(function()
        if pageList then
            pageList.refresh()
        end
    end, { pageList })

    local tbl1 = {
        filterQuery = if pageList then "" else str2,
        pageList = pageList or str1,
        result = 0
    }

    if not pageList then
        var2 = nil
    end

    tbl1.result = var2
    return tbl1
end

return useRecipientSearch
