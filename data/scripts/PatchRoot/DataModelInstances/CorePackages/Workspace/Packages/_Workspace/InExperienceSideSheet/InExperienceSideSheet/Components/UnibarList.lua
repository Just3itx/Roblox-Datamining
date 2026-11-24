-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T21:31:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceSideSheet = script:FindFirstAncestor("InExperienceSideSheet")

local InExperienceSideSheetParent = InExperienceSideSheet.Parent

local Foundation = require(InExperienceSideSheetParent.Foundation)
local React = require(InExperienceSideSheetParent.React)
local SignalsReact = require(InExperienceSideSheetParent.SignalsReact)

local View = Foundation.View

local GetIntegrationsStore = require(InExperienceSideSheet.Stores.GetIntegrationsStore)
local UnibarItem = require(InExperienceSideSheet.Components.UnibarItem)

local FFlagSideSheetFocusNav = require(InExperienceSideSheetParent.SharedFlags).FFlagSideSheetFocusNav

local function getIntegrations(arg1)
    return GetIntegrationsStore(arg1).getUnibarIntegrations(arg1)
end

return React.memo(function(tbl1) -- name: UnibarList
    local var1 = SignalsReact.useSignalState(getIntegrations)

    if #var1 == 0 then
        return nil
    end

    local tbl2 = ({})

    for layoutOrder, value2 in var1 do
        local id = value2.id
        tbl2[id] = React.createElement(UnibarItem, {
            label = value2.integration.label,
            layoutOrder = layoutOrder,
            onActivated = value2.activated,
            icon = value2.component,
            notification = value2.integration.notification,
            disableGamepadDirections = FFlagSideSheetFocusNav and layoutOrder == 1 and {
                left = true
            } or nil
        })
    end

    return React.createElement(View, { tag = "auto-xy row gap-xsmall align-y-center", LayoutOrder = tbl1.layoutOrder }, tbl2)
end)
