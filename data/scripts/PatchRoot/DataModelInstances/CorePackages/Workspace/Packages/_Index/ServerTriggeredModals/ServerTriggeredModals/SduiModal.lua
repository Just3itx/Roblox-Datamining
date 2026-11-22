-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:40:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerTriggeredModals = script:FindFirstAncestor("ServerTriggeredModals")
local ServerTriggeredModalsParent = ServerTriggeredModals.Parent

local ServerDrivenUi = require(ServerTriggeredModalsParent.ServerDrivenUi)
local RobloxAppEnums = require(ServerTriggeredModalsParent.RobloxAppEnums)
local React = require(ServerTriggeredModalsParent.React)
local reportModalImpression = require(ServerTriggeredModals.reportModalImpression)
local sendModalImpressionEvent = require(ServerTriggeredModalsParent.ServerTriggeredModalImpressions).sendModalImpressionEvent
local RoactServiceTags = require(ServerTriggeredModalsParent.RoactServiceTags)
local useRoactService = require(ServerTriggeredModalsParent.RobloxAppHooks).useRoactService

local AppPage = RobloxAppEnums.AppPage
local useSduiContext = ServerDrivenUi.useSduiContext
local SduiComponent = ServerDrivenUi.SduiComponent

return React.memo(function(tbl1)
    local var1 = useRoactService(RoactServiceTags.RoactNetworking)
    local sduiContext = useSduiContext({ appPage = AppPage.Home, dataUpdatedTimestamp = os.time() })

    local modalId = tbl1.modalId
    local modalType = tbl1.modalType

    React.useEffect(function()
        reportModalImpression(var1, modalId, modalType)
        sendModalImpressionEvent(modalId, modalType)
    end, {})

    return React.createElement(
        SduiComponent,
        {
            debugName = "SduiModal",
            componentConfig = tbl1.sduiComponentConfig,
            sduiContext = sduiContext
        }
    )
end)
