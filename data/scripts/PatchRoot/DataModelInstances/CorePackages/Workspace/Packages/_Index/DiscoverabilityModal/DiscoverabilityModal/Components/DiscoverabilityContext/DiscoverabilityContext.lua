-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:11:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local dependencies = require(scriptParentParentParent.dependencies)
local Constants = require(scriptParentParentParent.Common.Constants)
local React = dependencies.React
local DiscoverabilityModalAnalyticsContext = require(scriptParentParentParent.Analytics.DiscoverabilityModalAnalyticsContext)
local setupFireAnalyticsEvents = require(scriptParentParentParent.Analytics.setupFireAnalyticsEvents)
local AnalyticsService = require(scriptParentParentParent.Analytics.AnalyticsService)

local useSelector = dependencies.Hooks.useSelector

local function Container(arg1)
    return function(arg2)
        local uid = useSelector(function(arg3)
            return arg3.LocalUserId
        end)

        return React.createElement(DiscoverabilityModalAnalyticsContext.Provider, {
            value = {
                fireAnalyticsEvent = setupFireAnalyticsEvents({
                    analytics = AnalyticsService,
                    defaultAnalyticsInfo = {
                        uid = uid,
                        entry = if arg2.navigation then arg2.navigation.getParam(Constants.ENTRY_POINT) else arg2.entryPoint
                    }
                })
            }
        }, { React.createElement(arg1, arg2) })
    end
end

return Container
