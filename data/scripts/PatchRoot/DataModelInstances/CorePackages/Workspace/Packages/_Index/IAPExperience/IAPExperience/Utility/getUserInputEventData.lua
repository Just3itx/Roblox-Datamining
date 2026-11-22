-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:31:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(purchaseFlowUuid: string, str1: string?, purchaseFlow: string, viewName: string, inputType: string, eventMetadata: string?)
    if str1 then
        purchaseFlow = str1 .. purchaseFlow
    end
    return {
        purchase_flow_uuid = purchaseFlowUuid,
        purchase_flow = purchaseFlow,
        view_name = viewName,
        purchase_event_type = "UserInput",
        input_type = inputType,
        event_metadata = eventMetadata
    }
end
