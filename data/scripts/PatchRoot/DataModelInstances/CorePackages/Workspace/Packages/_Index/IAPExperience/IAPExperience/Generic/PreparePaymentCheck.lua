-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:10:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local UserInputService = game:GetService("UserInputService")
local PaymentPlatform = require(scriptParentParent.Enums.PaymentPlatform)
local Url = require(scriptParentParentParent.Http).Url
local HttpRbxApiService = game:GetService("HttpRbxApiService")
local HttpService = game:GetService("HttpService")
local IsVRAppBuild = require(scriptParentParentParent.AppCommonLib).IsVRAppBuild
local isTenFootInterface = require(scriptParentParentParent.AppCommonLib).isTenFootInterface
local getBlockingConsolePreparePaymentCheck = require(scriptParentParent.Flags.getBlockingConsolePreparePaymentCheck)
local getIsQuestPlatform = require(scriptParentParent.Utility.getIsQuestPlatform)
local default = require(scriptParentParentParent.LoggingProtocol).default
local PreparePaymentCheckCounter = require(scriptParent.Events.PreparePaymentCheckCounter)

local bool1 = game:DefineFastFlag("UsePlaystationPaymentsProtocolCommonFunctions", false)

function GetPaymentMethod(platform): string
    if platform == Enum.Platform.PS4 then
        return "PlaystationStore"
    end

    if platform == PaymentPlatform.Maquettes or getIsQuestPlatform() then
        return "QuestStore"
    end

    if platform == Enum.Platform.XBoxOne then
        return "XboxStore"
    end

    return ""
end

function IsPreparePaymentSuccessful(paymentMethod: string, providerProductId: string): boolean
    local str1 = HttpService:JSONEncode({ paymentMethod = paymentMethod, providerProductId = providerProductId })

    local success, result = pcall(function(): string
        return HttpRbxApiService:PostAsyncFullUrl(Url.APIS_URL .. "payments-gateway/v1/prepare-payment", str1)
    end)

    if not success then
        default:logRobloxTelemetryCounter(PreparePaymentCheckCounter, 1, { paymentMethod = paymentMethod, result = "Error" })

        return true
    elseif HttpService:JSONDecode(result).isSuccess then
        default:logRobloxTelemetryCounter(PreparePaymentCheckCounter, 1, { paymentMethod = paymentMethod, result = "Success" })

        return true
    else
        default:logRobloxTelemetryCounter(PreparePaymentCheckCounter, 1, { paymentMethod = paymentMethod, result = "Failed" })

        return false
    end
end

function ConsolePreparePaymentCheck(str1: string)
    local platform = UserInputService:GetPlatform()
    local paymentMethod = GetPaymentMethod(platform)

    if bool1 and (platform == Enum.Platform.PS4 or platform == Enum.Platform.PS5)
        or paymentMethod == ""
        or platform == Enum.Platform.XBoxOne
    then
        return true
    end

    return IsPreparePaymentSuccessful(paymentMethod, str1)
end

return function(str1: string)
    if not (IsVRAppBuild() or isTenFootInterface()) then
        return true
    end

    local var1 = ConsolePreparePaymentCheck(str1)
    if not getBlockingConsolePreparePaymentCheck() then
        var1 = true
    end

    return var1
end
