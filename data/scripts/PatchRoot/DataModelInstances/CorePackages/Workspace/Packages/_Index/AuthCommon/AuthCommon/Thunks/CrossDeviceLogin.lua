-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:41:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")
local AuthCommonParent = AuthCommon.Parent

local CentralOverlayType = require(AuthCommonParent.RobloxAppEnums).CentralOverlayType
local SetCentralOverlay = require(AuthCommonParent.CentralOverlay).Actions.SetCentralOverlay
local PostEnterLoginCode = require(AuthCommon.Http.Requests.PostEnterLoginCode)
local PostConfirmLoginCode = require(AuthCommon.Http.Requests.PostConfirmLoginCode)
local PostCreateLoginCode = require(AuthCommon.Http.Requests.PostCreateLoginCode)
local PostLoginCodeStatus = require(AuthCommon.Http.Requests.PostLoginCodeStatus)
local PostCancelLoginCode = require(AuthCommon.Http.Requests.PostCancelLoginCode)

local GetFFlagEnableCrossDeviceLoginUsingQRCodes = require(AuthCommonParent.SharedFlags).GetFFlagEnableCrossDeviceLoginUsingQRCodes
local FFlagEnableCrossDeviceApproverDialog = require(AuthCommon.Flags.FFlagEnableCrossDeviceApproverDialog)

local module = {}
function module.EnterCode(arg1, arg2)
    return function(_)
        return PostEnterLoginCode(arg1, arg2):andThen(function(arg3): {DeviceInfo: string}?
            if not (arg3 and arg3.responseBody) then
                return nil
            end

            local tbl1 = {
                DeviceInfo = string.format("%s\n%s", arg3.responseBody.deviceInfo or "", arg3.responseBody.location or "")
            }

            if FFlagEnableCrossDeviceApproverDialog then
                tbl1.Location = arg3.responseBody.location or ""
                tbl1.MapImagePath = arg3.responseBody.mapImagePath or ""
            end
            return tbl1
        end)
    end
end

function module.FetchDeviceCode(arg1)
    return function(_)
        return PostCreateLoginCode(arg1):andThen(function(arg2): {DeviceCode: any, PrivateKey: any, QrCodePath: number}?
            local responseBody = arg2 and arg2.responseBody
            if not responseBody then
                return nil
            end

            return {
                DeviceCode = responseBody.code,
                PrivateKey = responseBody.privateKey,
                QrCodePath = if GetFFlagEnableCrossDeviceLoginUsingQRCodes() then responseBody.imagePath else nil
            }
        end)
    end
end

function module.GetLoginStatus(arg1, arg2, arg3)
    return function(_)
        return PostLoginCodeStatus(arg1, arg2, arg3):andThen(function(arg4)
            local responseBody = arg4 and arg4.responseBody

            if not responseBody then
                return nil
            end

            return {
                Status = responseBody.status,
                AccountName = responseBody.accountName,
                AccountPictureUrl = responseBody.accountPictureUrl,
                ExpirationTime = responseBody.expirationTime
            }
        end)
    end
end

function module.OpenLoginCodePrompt(arg1)
    return function(arg2)
        arg2:dispatch(SetCentralOverlay(CentralOverlayType.CrossDeviceCodePrompt, arg1))
    end
end

function module.ConfirmDeviceAccess(arg1, arg2)
    return function(_)
        return PostConfirmLoginCode(arg1, arg2)
    end
end

function module.CancelLoginCode(arg1, arg2)
    return function(_)
        return PostCancelLoginCode(arg1, arg2)
    end
end

function module.OpenConfirmationOverlay(loginSuccess, closeCallback, retryCallback, deviceString)
    return function(arg1)
        arg1:dispatch(
            SetCentralOverlay(CentralOverlayType.CrossDeviceLoginConfirmation, {
                loginSuccess = loginSuccess,
                closeCallback = closeCallback,
                retryCallback = retryCallback,
                deviceString = deviceString
            })
        )
    end
end
return module
