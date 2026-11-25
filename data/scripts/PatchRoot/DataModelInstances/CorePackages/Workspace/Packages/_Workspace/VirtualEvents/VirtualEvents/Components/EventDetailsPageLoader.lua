-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:01:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualEvents = script:FindFirstAncestor("VirtualEvents")

local ApolloClient = require(VirtualEvents.Parent.ApolloClient)
local AppUserLayers = require(VirtualEvents.Parent.ExperimentLayers).AppUserLayers
local Cryo = require(VirtualEvents.Parent.Cryo)
local React = require(VirtualEvents.Parent.React)
local useUserExperiment = require(VirtualEvents.Parent.RoactAppExperiment).useUserExperiment
local UIBlox = require(VirtualEvents.Parent.UIBlox)
local Foundation = require(VirtualEvents.Parent.Foundation)
local useLocalization = require(VirtualEvents.Parent.Localization).Hooks.useLocalization
local EventDetailsPage = require(VirtualEvents.Components.EventDetailsPage)
local EventDetailsVerticalPage = require(VirtualEvents.Components.EventDetailsVerticalPage)
local EventNotFoundModal = require(VirtualEvents.Components.EventNotFoundModal)
local requests = require(VirtualEvents.requests)
local getRetrievalStatusFromApolloQuery = require(VirtualEvents.Common.getRetrievalStatusFromApolloQuery)

local useQuery = ApolloClient.useQuery
local LoadingStateContainer = UIBlox.App.Container.LoadingStateContainer
local RetrievalStatus = UIBlox.App.Loading.Enum.RetrievalStatus
local EmptyState = UIBlox.App.Indicator.EmptyState
local AppStyleProvider = UIBlox.App.Style.AppStyleProvider

local FFlagLuaAppCreatorSuccessVirtualEventsLayerUseRoactExperiment = require(VirtualEvents.Flags.FFlagLuaAppCreatorSuccessVirtualEventsLayerUseRoactExperiment)
local FFlagLuaAppFixEventNotFoundErrorStateExit = require(VirtualEvents.Flags.FFlagLuaAppFixEventNotFoundErrorStateExit)

local function EventDetailsPageLoader(arg1)
    local var1 = useQuery(requests.GET_VIRTUAL_EVENT, { variables = { virtualEventId = arg1.virtualEventId } })

    local retrievalStatusFromApolloQuery = getRetrievalStatusFromApolloQuery(var1)

    local var2 = useLocalization({ notFound = "Feature.VirtualEvents.EventNotFound" })

    if arg1.mockNetworkStatus then
        retrievalStatusFromApolloQuery = arg1.mockNetworkStatus
    end

    local var3 = nil
    local var4 = nil
    if FFlagLuaAppCreatorSuccessVirtualEventsLayerUseRoactExperiment then
        var3, var4 = useUserExperiment({ AppUserLayers.CreatorSuccessVirtualEvents }, function(arg2)
            local var5 = arg2[AppUserLayers.CreatorSuccessVirtualEvents] or {}
            return var5.EnableEventDetailsNewModal, var5.NotifyMeUseEmphasisVariant
        end, true)
    end

    return React.createElement(LoadingStateContainer, {
        dataStatus = RetrievalStatus.fromRawValue(retrievalStatusFromApolloQuery),
        renderOnLoaded = function()
            local var5 = Cryo.Dictionary.join(arg1, {
                virtualEvent = var1.data.virtualEvent,
                virtualEventId = Cryo.None,
                notifyMeUseEmphasisVariant = if FFlagLuaAppCreatorSuccessVirtualEventsLayerUseRoactExperiment then var4 else false
            })

            if not (FFlagLuaAppCreatorSuccessVirtualEventsLayerUseRoactExperiment and var3) then
                return React.createElement(React.Fragment, nil, { EventDetailsPage = React.createElement(EventDetailsPage, var5) })
            end

            return React.createElement(React.Fragment, nil, {
                FoundationProvider = React.createElement(
                    Foundation.FoundationProvider,
                    {
                        colorMode = Foundation.Enums.ColorMode.Dark
                    },
                    {
                        AppStyleProvider = React.createElement(
                            AppStyleProvider,
                            {
                                style = { themeName = "dark" }
                            },
                            {
                                EventDetailsPage = React.createElement(EventDetailsVerticalPage, var5)
                            }
                        )
                    }
                )
            })
        end,
        renderOnFailed = function()
            if FFlagLuaAppFixEventNotFoundErrorStateExit then
                return (React.createElement(EventNotFoundModal, { onClose = arg1.onClose }))
            end
            return (React.createElement(React.Fragment, nil, { EventNotFound = React.createElement(EmptyState, { text = var2.notFound }) }))
        end
    })
end

return EventDetailsPageLoader
