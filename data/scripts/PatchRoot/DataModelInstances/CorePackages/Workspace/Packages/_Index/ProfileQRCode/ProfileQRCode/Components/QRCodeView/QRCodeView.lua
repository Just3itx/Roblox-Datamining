-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T11:31:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfileQRCode = script:FindFirstAncestor("ProfileQRCode")
local ProfileQRCodeParent = ProfileQRCode.Parent
local React = require(ProfileQRCodeParent.React)
local useGetProfileShareUrl = require(ProfileQRCode.Networking.useGetProfileShareUrl)
local useAnalytics = require(ProfileQRCode.Analytics.useAnalytics)
local useShortUrl = require(ProfileQRCode.Rodux.useShortUrl)
local useHasLoadedSuccessfully = require(script.Parent.useHasLoadedSuccessfully)
local useLoadingState = require(ProfileQRCode.Networking.useLoadingState)
local useRefreshQrSession = require(ProfileQRCode.Networking.useRefreshQrSession)
local NetworkStatus = require(ProfileQRCode.Networking.configuredRoduxNetworking).Enum.NetworkStatus
local QRCodeFailedView = require(script.Parent.QRCodeFailedView)
local QRCodeSucceededView = require(script.Parent.QRCodeSucceededView)
local QRCodeLoadingView = require(script.Parent.QRCodeLoadingView)
local useEffectOnce = require(ProfileQRCodeParent.RoactUtils).Hooks.useEffectOnce
local EventNames = require(ProfileQRCode.Analytics.EventNames)

local useHasFailedToLoad = require(script.Parent.useHasFailedToLoad)

return function(tbl1)
    local var1 = useAnalytics()
    local var2 = useLoadingState()
    local onActivated = useGetProfileShareUrl()
    local var4 = useRefreshQrSession()

    local url = useShortUrl()
    local bool1 = url ~= nil
    local bool2 = var2 == NetworkStatus.Failed

    React.useEffect(function()
        var4():andThen(function(arg1)
            local var6 = not arg1 and {} or arg1.responseBody or {}
            local responseCode = arg1 and arg1.responseCode
            var1.fireEvent(EventNames.RefreshQrSession, { success = var6.Success, responseCode = responseCode })
        end)
    end, {})

    useEffectOnce(onActivated, not bool1)
    useHasLoadedSuccessfully(var1, bool1)
    useHasFailedToLoad(var1, bool2)
    local view = if bool1 then React.createElement(
        QRCodeSucceededView,
        {
            url = url,
            qrCodeLength = 200,
            padding = 24,
            isSmallScreen = tbl1.isSmallScreen
        }
    ) elseif bool2 then React.createElement(QRCodeFailedView, { onActivated = onActivated, padding = 24 }) else React.createElement(QRCodeLoadingView)
    local yOffset = if tbl1.isSmallScreen then 280 else 304

    return React.createElement(
        "Frame",
        {
            Size = UDim2.new(0, 304, 0, yOffset),
            LayoutOrder = tbl1.layoutOrder,
            BackgroundTransparency = 1
        },
        { View = view }
    )
end
