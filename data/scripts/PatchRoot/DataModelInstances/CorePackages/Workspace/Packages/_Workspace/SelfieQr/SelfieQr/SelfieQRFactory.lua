-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T12:11:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local SelfieQr = script:FindFirstAncestor("SelfieQr")
local SelfieQrParent = SelfieQr.Parent

local CoreScriptsRootProvider = require(SelfieQrParent.CoreScriptsRoactCommon).CoreScriptsRootProvider
local React = require(SelfieQrParent.React)
local Roact = require(SelfieQrParent.Roact)
local RoactNetworking = require(SelfieQrParent.RoactServiceTags).RoactNetworking
local RoactServices = require(SelfieQrParent.RoactServices).RoactServices
local SelfieQRConnection = require(SelfieQr.SelfieQRConnection)

local requestInternalWrapper = require(SelfieQrParent.Http).NetworkLayers.requestInternalWrapper

local module = {}
local bool1 = false

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

    return Roact.mount(element2, arg1, "SelfieQRRoot")
end

function module.createFactory()
    local module2 = {}
    function module2.mountCoreUI(arg1)
        if bool1 then
            return
        end

        bool1 = true

        module2._coreUiHandle = func1(arg1, { SelfieQR = React.createElement(SelfieQRConnection, {}) })
    end

    return module2
end

return module
