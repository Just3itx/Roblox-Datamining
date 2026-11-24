-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T21:31:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceSideSheetParent = script:FindFirstAncestor("InExperienceSideSheet").Parent

local _Chrome = require(InExperienceSideSheetParent.Chrome)
local Foundation = require(InExperienceSideSheetParent.Foundation)
local React = require(InExperienceSideSheetParent.React)
local _Signals = require(InExperienceSideSheetParent.Signals)
local SignalsReact = require(InExperienceSideSheetParent.SignalsReact)

local View = Foundation.View

local FFlagSideSheetFocusNav = require(InExperienceSideSheetParent.SharedFlags).FFlagSideSheetFocusNav

return React.memo(function(tbl1) -- name: SideSheetWidgetList
    local var1 = SignalsReact.useSignalState(tbl1.integrationsGetter)

    if #var1 == 0 then
        return nil
    end

    local tbl2 = ({})

    for layoutOrder, value2 in var1 do
        local id = value2.id
        tbl2[id] = React.createElement(value2.component, {
            layoutOrder = layoutOrder,
            placement = tbl1.placement,
            firstIntegrationToFocusCallback = if FFlagSideSheetFocusNav and layoutOrder == 1 then tbl1.firstIntegrationToFocusCallback else nil
        })
    end

    return React.createElement(View, { tag = "col size-full-0 auto-y", LayoutOrder = tbl1.layoutOrder }, tbl2)
end)
