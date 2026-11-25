-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T12:11:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarCreationService = game:GetService("AvatarCreationService")

local SelfieQr = script:FindFirstAncestor("SelfieQr")
local SelfieQrParent = SelfieQr.Parent

local FocusNavigationUtils = require(SelfieQrParent.FocusNavigationUtils)
local React = require(SelfieQrParent.React)
local ReactUtils = require(SelfieQrParent.ReactUtils)
local SelfieQRCode = require(SelfieQr.SelfieQRCode)

local FocusRoot = FocusNavigationUtils.FocusRoot
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum

local useEventConnection = ReactUtils.useEventConnection

local function func1(tbl1)
    local var1 = React.useCallback(function(url, jobId)
        tbl1.displaySelfieQRCode(true)
        tbl1.jobData.url = url
        tbl1.jobData.jobId = jobId
    end)
    useEventConnection(AvatarCreationService.OpenSelfieQRCode, var1)
    return React.createElement(React.Fragment, {}, {})
end

return function(_)
    local var1, displaySelfieQrCode = React.useState(false)
    local current = React.useRef({ url = "", jobId = "" }).current
    local dialog = if var1 then React.createElement(
        SelfieQRCode,
        {
            displaySelfieQRCode = displaySelfieQrCode,
            url = current.url,
            jobId = current.jobId
        }
    ) else nil
    return React.createElement(React.Fragment, {}, {
        EventListener = React.createElement(func1, { displaySelfieQRCode = displaySelfieQrCode, jobData = current }),
        FocusNavigationCoreScriptsWrapper = if dialog == nil then nil else React.createElement(
            FocusRoot,
            {
                surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.CentralOverlay,
                isIsolated = true,
                isAutoFocusRoot = true
            },
            { Dialog = dialog }
        )
    })
end
