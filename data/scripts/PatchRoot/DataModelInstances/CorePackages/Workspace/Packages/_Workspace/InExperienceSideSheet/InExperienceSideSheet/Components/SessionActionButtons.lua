-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T21:30:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceSideSheet = script:FindFirstAncestor("InExperienceSideSheet")
local InExperienceSideSheetParent = InExperienceSideSheet.Parent

local React = require(InExperienceSideSheetParent.React)
local SignalsReact = require(InExperienceSideSheetParent.SignalsReact)

local View = require(InExperienceSideSheetParent.Foundation).View

local SharedFlags = require(InExperienceSideSheetParent.SharedFlags)
local FFlagEnableWhatsNew = SharedFlags.FFlagEnableWhatsNew
local FFlagShowSwitchServerButton = SharedFlags.FFlagShowSwitchServerButton
local isPioneerLaunch = require(InExperienceSideSheetParent.PioneerUtils).isPioneerLaunch
local WhatsNewAnchor = if FFlagEnableWhatsNew then require(InExperienceSideSheetParent.WhatsNew).WhatsNewAnchor else nil
local GetSessionActionButtonsStore = require(InExperienceSideSheet.Stores.GetSessionActionButtonsStore)

local buildSessionActionButtonLayout = require(InExperienceSideSheet.Utils.buildSessionActionButtonLayout)

local function getSessionActionButtonConfigs(arg1)
    return GetSessionActionButtonsStore(arg1).sessionActionButtonConfigs
end

return React.memo(function(tbl1) -- name: SessionActionButtons
    local var1 = SignalsReact.useSignalState(getSessionActionButtonConfigs)
    local tbl2

    if FFlagShowSwitchServerButton or isPioneerLaunch() then
        tbl2 = {}
        for _, value in var1 do
            if value.getIsHidden == nil or not value.getIsHidden() then
                table.insert(tbl2, value)
            end
        end
    else
        tbl2 = var1
    end

    local sessionActionButtonLayout = buildSessionActionButtonLayout(tbl2)

    local sessionActions = React.createElement(
        View,
        {
            tag = "col gap-small size-full-0 auto-y",
            LayoutOrder = tbl1.layoutOrder
        },
        sessionActionButtonLayout
    )

    if not FFlagEnableWhatsNew then
        return sessionActions
    end

    return React.createElement(
        WhatsNewAnchor,
        {
            anchorId = "LeaveRespawn",
            LayoutOrder = tbl1.layoutOrder
        },
        { SessionActions = sessionActions }
    )
end)
