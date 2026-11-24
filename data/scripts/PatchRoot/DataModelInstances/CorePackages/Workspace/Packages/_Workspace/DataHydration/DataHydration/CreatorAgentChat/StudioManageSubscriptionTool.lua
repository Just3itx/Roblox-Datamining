-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:31:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _types = require(script.Parent.types)
local monetizationClientTool = require(script.Parent.monetizationClientTool)
local FFlagCreatorAgentChatMonetizationOneConsent = require(script.Parent.FFlagCreatorAgentChatMonetizationOneConsent)

local enum = {
    "create",
    "list",
    "update",
    "activate",
    "deactivate",
    "delete"
}

local MAXIMUM_SAFE_INTEGER = monetizationClientTool.MAXIMUM_SAFE_INTEGER
local tbl1 = { "consumable", "currency", "durable" }

local function hasRequiredCreateFields(tbl3): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return not (tbl3.name == nil or tbl3.name == "" or tbl3.productType == nil) and tbl3.priceInRobux ~= nil
end

return {
    TOOL_NAME = "manage_subscription",
    LOCAL_TOOL_DEFINITION = {
        name = "manage_subscription",
        inputSchema = {
            type = "object",
            additionalProperties = false,
            required = { "action" },
            properties = {
                action = { type = "string", enum = enum },
                name = { type = "string" },
                description = { type = "string" },
                productType = { type = "string", enum = tbl1 },
                priceInRobux = { type = "integer", minimum = 49, maximum = MAXIMUM_SAFE_INTEGER },
                subscriptionId = { type = "string" },
                cancelRenewals = { type = "boolean" },
                imageAssetId = { type = "integer", minimum = 1, maximum = MAXIMUM_SAFE_INTEGER },
                createAndGoLive = FFlagCreatorAgentChatMonetizationOneConsent
                    and {
                        type = "boolean",
                        description = "Only for create when the creator explicitly requests creation and activation in one approval. Creation stays inactive until a supported benefit is published and verified; custom or uncertain wiring stays inactive without another approval."
                    }
                    or nil
            }
        }
    },
    findRequestInTurnState = monetizationClientTool.createRequestFinder("manage_subscription"),
    parseInput = function(arg1)
        local action, var2 = monetizationClientTool.parseAction(arg1, enum)
        if action == nil then
            return nil, var2
        end

        local var3 = monetizationClientTool.checkStringFields(arg1, { "name", "description", "productType", "subscriptionId" })
        if var3 ~= nil then
            return nil, var3
        end
        if arg1.cancelRenewals ~= nil and typeof(arg1.cancelRenewals) ~= "boolean" then
            return nil, "cancelRenewals must be a boolean."
        end

        local priceInRobux, var5 = monetizationClientTool.parsePrice(arg1.priceInRobux, 49, MAXIMUM_SAFE_INTEGER)
        if var5 ~= nil then
            return nil, var5
        end

        local productType = if arg1.productType == nil then nil else string.lower(arg1.productType)

        if productType ~= nil and not table.find(tbl1, productType) then
            return nil, "productType must be consumable, currency or durable."
        end
        local tbl3 = {
            action = action,
            name = arg1.name,
            description = arg1.description,
            productType = productType,
            priceInRobux = priceInRobux,
            subscriptionId = if arg1.subscriptionId == "" then nil else arg1.subscriptionId,
            cancelRenewals = arg1.cancelRenewals,
            imageAssetId = monetizationClientTool.parsePositiveSafeInteger(arg1.imageAssetId)
        }
        if arg1.imageAssetId ~= nil and tbl3.imageAssetId == nil then
            return nil, ("imageAssetId must be a positive integer no greater than %.0f."):format(MAXIMUM_SAFE_INTEGER)
        end
        if arg1.createAndGoLive ~= nil and not FFlagCreatorAgentChatMonetizationOneConsent then
            return nil, "createAndGoLive is unavailable."
        end

        local createAndGoLive, var8 = monetizationClientTool.parseCreateAndGoLive(arg1.createAndGoLive, action)
        if var8 ~= nil then
            return nil, var8
        end
        tbl3.createAndGoLive = createAndGoLive
        if (action == "create" or action == "list") and arg1.subscriptionId ~= nil then
            return nil, "subscriptionId is only used to update, activate, deactivate or delete a subscription."
        end
        if action ~= "create"
            and action ~= "update"
            and (arg1.description ~= nil or arg1.priceInRobux ~= nil or arg1.imageAssetId ~= nil)
        then
            return nil, "Only create and update can set a subscription description, priceInRobux or imageAssetId."
        end
        if action ~= "create" and action ~= "update" and (arg1.name ~= nil or arg1.productType ~= nil) then
            return nil, "A subscription name and productType are only used on create."
        end
        if action ~= "deactivate" and arg1.cancelRenewals ~= nil then
            return nil, "cancelRenewals is only used on deactivate."
        end

        if action == "create" then
            if not hasRequiredCreateFields(tbl3) then
                return nil, "A name, productType and priceInRobux are required to create a subscription."
            end
        else
            if action ~= "list" and tbl3.subscriptionId == nil then
                return nil, "A subscriptionId is required for this action."
            end

            if action == "update" then
                if tbl3.name ~= nil then
                    return nil, "A subscription's name can't be changed after it is created."
                end
                if tbl3.productType ~= nil then
                    return nil, "A subscription's product type can't be changed after it is created."
                end
                if tbl3.description == nil and tbl3.priceInRobux == nil and tbl3.imageAssetId == nil then
                    return nil, "An update needs a description, priceInRobux or imageAssetId."
                end
            elseif action == "deactivate" and tbl3.cancelRenewals == nil then
                return nil, "cancelRenewals is required: ask the creator whether current subscribers keep renewing."
            end
        end

        return tbl3, nil
    end,
    getActionKind = monetizationClientTool.getActionKind,
    formatResultContent = monetizationClientTool.formatResultContent,
    formatRejectionContent = monetizationClientTool.formatRejectionContent
}
