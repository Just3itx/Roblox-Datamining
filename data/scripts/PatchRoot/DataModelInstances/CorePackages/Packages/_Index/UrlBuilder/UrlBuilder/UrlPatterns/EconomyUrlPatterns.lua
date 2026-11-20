-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:50:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1)
    return {
        paymentsGateway = {
            getUpsellProduct = arg1.fromString("apis:payments-gateway/v1/products/get-upsell-product"),
            preparePayment = arg1.fromString("apis:payments-gateway/v1/prepare-payment"),
            checkUserPurchaseSettings = arg1.fromString("apis:payments-gateway/v1/check-user-purchase-settings")
        },
        purchaseWarning = {
            getPurchaseWarning = function(str1: string?, num1: number?, bool1: boolean?)
                local var1

                if str1 ~= nil then
                    var1 = string.format("%s?mobileProductId=%s", "apis:purchase-warning/v1/purchase-warnings", str1)
                else
                    if num1 == nil then
                        warn(string.format("%s - Invalid parameters, needs mobileProductId or productId", tostring(script.Name)))
                        return nil
                    end

                    var1 = string.format("%s?productId=%d", "apis:purchase-warning/v1/purchase-warnings", num1)
                end

                if bool1 then
                    var1 = string.format("%s&is13To17ScaryModalEnabled=True", var1)
                end

                return arg1.fromString(var1)()
            end,
            ackPurchaseWarning = arg1.fromString("apis:purchase-warning/v1/purchase-warnings/acknowledge")
        },
        vngPayments = {
            getVngShopUrl = arg1.fromString("apis:vng-payments/v1/getVngShopUrl")
        },
        info = {
            developerProduct = arg1.fromString("www:developer-product/{universeId}/product/{productId}")
        }
    }
end
