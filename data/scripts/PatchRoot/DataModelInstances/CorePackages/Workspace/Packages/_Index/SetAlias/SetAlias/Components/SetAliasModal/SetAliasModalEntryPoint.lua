-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T16:01:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local SocialLuaAnalytics = require(scriptParentParentParentParent.SocialLuaAnalytics)
local dependencies = require(scriptParentParentParent.dependencies)
local React = dependencies.React
local useLocalUserId = dependencies.Hooks.useLocalUserId

local Analytics = require(scriptParentParentParent.Analytics)
local Constants = require(scriptParentParentParent.Common.Constants)
local DefaultAnalyticsService = SocialLuaAnalytics.Analytics.DefaultAnalyticsService

local SetAliasModalContainer = require(script.Parent.SetAliasModalContainer)

return function(arg1)
    local uid = useLocalUserId()

    return React.createElement(Analytics.Context.Provider, {
        value = {
            fireAnalyticsEvent = Analytics.setupFireAnalyticsEvents({
                analytics = DefaultAnalyticsService,
                infoForAllEvents = {
                    uid = uid,
                    origin = arg1.navigation.getParam(Constants.ORIGIN)
                }
            })
        }
    }, { React.createElement(SetAliasModalContainer, arg1) })
end
