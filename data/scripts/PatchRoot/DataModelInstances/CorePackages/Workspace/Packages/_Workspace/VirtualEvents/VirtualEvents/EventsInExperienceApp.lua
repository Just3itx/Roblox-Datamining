-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:11:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent

local HttpService = game:GetService("HttpService")

local React = require(scriptParentParent.React)
local RoactCompat = require(scriptParentParent.RoactCompat)
local RoactNetworking = require(scriptParentParent.RoactServiceTags).RoactNetworking
local RoactServices = require(scriptParentParent.RoactServices).RoactServices
local requestInternalWrapper = require(scriptParentParent.Http).NetworkLayers.requestInternalWrapper

local CoreScriptsRootProvider = require(scriptParentParent.CoreScriptsRoactCommon).CoreScriptsRootProvider

local EventInExperiencePrompts = require(scriptParent.Components.CoreUI.EventInExperiencePrompts)

local module = {}

local function func1(arg1, tbl1)
    local element = React.createElement(CoreScriptsRootProvider, {}, {
        RoactServicesProvider = React.createElement(
            RoactServices.ServiceProvider,
            {
                services = {
                    [RoactNetworking] = requestInternalWrapper(HttpService)
                }
            },
            tbl1
        )
    })

    local element2 = React.createElement("Folder", nil, element)
    return RoactCompat.mount(element2, arg1, "EventsInExperienceRoot")
end

function module.createApp()
    local module2 = { _coreUiHandle = nil }

    function module2.mountCoreUI(arg1)
        module2._coreUiHandle = func1(arg1, { EventInExperiencePrompts = React.createElement(EventInExperiencePrompts) })
    end

    function module2.unMountCoreUI()
        if module2._coreUiHandle then
            RoactCompat.unmount(module2._coreUiHandle)
            module2._coreUiHandle = nil
        end
    end

    return module2
end

return module
