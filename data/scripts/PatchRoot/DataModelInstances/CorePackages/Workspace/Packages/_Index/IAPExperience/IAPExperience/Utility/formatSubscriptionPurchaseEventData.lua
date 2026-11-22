-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:30:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(purchaseFlowUuid: string, purchaseFlowEventType: string, viewName: string, inputType: string?, subscriptionProviderId: string, str1: string, localizedSubscriptionName: string, localizedSubscriptionDescription: string, subscriptionPeriod: string, priceInCentsUsd: number, displayPrice: string)
    local var1 = nil
    local var2 = nil
    for value, value2 in string.gmatch(str1, "(%w+)-(%w+)") do
        var2 = string.upper(value)
        var1 = value2
    end

    return {
        purchase_flow_uuid = purchaseFlowUuid,
        purchase_flow_event_type = purchaseFlowEventType,
        view_name = viewName,
        input_type = inputType,
        subscription_provider_id = subscriptionProviderId,
        subscription_product_type_prefix = var2,
        subscription_id = var1,
        localized_subscription_name = localizedSubscriptionName,
        localized_subscription_description = localizedSubscriptionDescription,
        subscription_period = subscriptionPeriod,
        price_in_cents_usd = priceInCentsUsd,
        display_price = displayPrice
    }
end
