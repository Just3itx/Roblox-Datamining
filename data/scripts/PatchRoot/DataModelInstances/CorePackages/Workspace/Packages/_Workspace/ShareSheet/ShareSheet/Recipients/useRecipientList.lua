-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T14:51:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ShareSheet = script:FindFirstAncestor("ShareSheet")
local ShareSheetParent = ShareSheet.Parent

local React = require(ShareSheetParent.React)
local Signals = require(ShareSheetParent.Signals)
local SignalsReact = require(ShareSheetParent.SignalsReact)
local ListRecipientsStatus = require(script.Parent.ListRecipientsStatus)
local RecipientLists = require(script.Parent.RecipientLists)
local _Types = require(ShareSheet.Types)
local _RecipientSource = require(script.Parent.RecipientSource)

local tbl1 = {
    getResult = Signals.createSignal(
        {
            recipients = {},
            status = ListRecipientsStatus.Ready,
            nextPageToken = nil,
            isFetchingNextPage = false
        }
    ),
    refresh = function() end,
    loadMore = function(_: string) end
}

local function useRecipientList(bool1: boolean, bool2: boolean)
    local var1 = React.useMemo(function()
        if bool2 then
            return (RecipientLists[bool1]())
        end

        return tbl1
    end, { bool1, bool2 })
    local var2 = SignalsReact.useSignalState(var1.getResult)

    React.useEffect(function()
        var1.refresh()
    end, { var1 })

    return var2, var1
end

return useRecipientList
