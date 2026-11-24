-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:31:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local _types = require(script.Parent.types)
local monetizationClientTool = require(script.Parent.monetizationClientTool)
local FFlagCreatorAgentChatMonetizationOneConsent = require(script.Parent.FFlagCreatorAgentChatMonetizationOneConsent)

local FFlagBuildExperienceRemoveDevProductPriceCap = require(DataHydrationParent.SharedFlags).FFlagBuildExperienceRemoveDevProductPriceCap
local StudioManageDevProductTool = require(script.Parent.StudioManageDevProductTool)
local StudioManageGamePassTool = require(script.Parent.StudioManageGamePassTool)
local StudioManageSubscriptionTool = require(script.Parent.StudioManageSubscriptionTool)

local TOOL_NAME = StudioManageDevProductTool.TOOL_NAME
local MAXIMUM_SAFE_INTEGER = monetizationClientTool.MAXIMUM_SAFE_INTEGER

local description = "Per-kind ranges are checked on the client: developerProduct " .. (if FFlagBuildExperienceRemoveDevProductPriceCap then "at least 1" else "1 through 100") .. ", gamePass 1 through 999,999,999, subscription at least 49."

local tbl1 = {
    developerproduct = "developerProduct",
    gamepass = "gamePass",
    subscription = "subscription"
}

local tbl2 = {
    developerProduct = "productId",
    gamePass = "gamePassId",
    subscription = "subscriptionId"
}

local tbl3 = {
    developerProduct = {
        "gamePassId",
        "subscriptionId",
        "productType",
        "cancelRenewals",
        "createAndGoLive"
    },
    gamePass = {
        "productId",
        "subscriptionId",
        "productType",
        "cancelRenewals"
    },
    subscription = { "productId", "gamePassId" }
}

local function resolveKind(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
    if typeof(arg1) == "table" and typeof(arg1.kind) == "string" then
        return tbl1[string.lower(arg1.kind)]
    end

    return nil
end

local function describeKindError(arg1): string
    if typeof(arg1) ~= "table" or arg1.kind == nil then
        return "kind is required: developerProduct, gamePass or subscription."
    end
    local kind = arg1.kind
    return ("Unsupported kind '%s'. Use developerProduct, gamePass or subscription."):format(tostring(kind))
end

local function findCrossKindError(arg1, kind: string)
    for _, value in tbl3[kind] do
        if arg1[value] == nil then
            continue
        end

        local var1 = tbl2[kind]
        if string.sub(value, -2) == "Id" then
            return (("%s does not apply to kind=%s. Use %s."):format(value, kind, var1))
        end

        return (("%s does not apply to kind=%s."):format(value, kind))
    end

    return if kind == "subscription" or typeof(arg1.action) ~= "string" or string.lower(arg1.action) ~= "delete" then nil else "delete is only supported for kind=subscription."
end

local tbl4 = {
    developerProduct = function(arg1) -- name: parseDeveloperProduct
        return StudioManageDevProductTool.parseManageDevProductInput(arg1), nil
    end,
    gamePass = function(arg1)
        return StudioManageGamePassTool.parseInput(arg1, true)
    end,
    subscription = StudioManageSubscriptionTool.parseInput
}

local function withLegacyKind(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if typeof(arg1) ~= "table" then
        return arg1
    end
    local var1 = table.clone(arg1)
    var1.kind = "developerProduct"
    return var1
end

return {
    TOOL_NAME = "manage_monetization",
    KINDS = { "developerProduct", "gamePass", "subscription" },
    resolveKind = resolveKind,
    createLocalToolDefinition = function(enum)
        local tbl5 = ({})
        for _, value in enum do
            tbl5[value] = true
        end
        local bool1 = tbl5.gamePass == true or tbl5.subscription == true
        local tbl6 = {
            "create",
            "list",
            "update",
            "activate",
            "deactivate"
        }

        if tbl5.subscription then
            table.insert(tbl6, "delete")
        end

        return {
            name = "manage_monetization",
            inputSchema = {
                type = "object",
                additionalProperties = false,
                required = { "kind", "action" },
                properties = {
                    kind = { type = "string", enum = enum },
                    action = { type = "string", enum = tbl6 },
                    name = { type = "string" },
                    description = { type = "string" },
                    priceInRobux = {
                        type = "integer",
                        minimum = 1,
                        maximum = MAXIMUM_SAFE_INTEGER,
                        description = description
                    },
                    productId = tbl5.developerProduct and { type = "integer" } or nil,
                    gamePassId = tbl5.gamePass and {
                        type = "integer",
                        minimum = 1,
                        maximum = MAXIMUM_SAFE_INTEGER
                    } or nil,
                    subscriptionId = tbl5.subscription and { type = "string" } or nil,
                    productType = tbl5.subscription and {
                        type = "string",
                        enum = { "consumable", "currency", "durable" }
                    } or nil,
                    cancelRenewals = tbl5.subscription and { type = "boolean" } or nil,
                    imageAssetId = { type = "integer", minimum = 1, maximum = MAXIMUM_SAFE_INTEGER },
                    createAndGoLive = FFlagCreatorAgentChatMonetizationOneConsent
                        and bool1
                        and {
                            type = "boolean",
                            description = "Only for create of a gamePass or subscription when the creator explicitly requests creation and going live in one approval. Creation stays off sale or inactive until a supported benefit is published and verified; custom or uncertain wiring stays off without another approval."
                        }
                        or nil
                }
            }
        }
    end,
    forKind = function(kind: string, tbl5)
        local function isKindEnabled(str2: string): boolean -- Luacid: Inlined by compiler; 1 call site recovered
            return str2 == "developerProduct" or tbl5 == nil or tbl5[str2] == true
        end

        local function ownsRequest(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
            local var1 = resolveKind(arg1)

            if var1 == nil then
                return kind == "developerProduct"
            end

            if var1 == kind then
                return true
            end

            return kind == "developerProduct" and not isKindEnabled(var1)
        end

        local function findRequestInTurnState(arg1, tbl6)
            local var1 = if tbl6 == nil then {} else table.clone(tbl6)

            while true do
                local var2, var3, var4, var5 = monetizationClientTool.findRequestInTurnState(arg1, "manage_monetization", var1)
                if var2 == nil then
                    break
                end

                if ownsRequest(var3) then
                    return var2, var3, var4, var5
                end
                var1[var2] = true
            end

            if kind ~= "developerProduct" then
                return nil, nil, nil, nil
            end

            local var2, var3, var4, var5 = monetizationClientTool.findRequestInTurnState(arg1, TOOL_NAME, var1)
            if var2 == nil then
                return nil, nil, nil, nil
            end
            return var2, withLegacyKind(var3), var4, var5
        end

        local function parseInput(arg1)
            local var1 = resolveKind(arg1)

            if var1 == nil then
                return nil, describeKindError(arg1)
            end

            if var1 ~= kind then
                return nil, ("kind=%s is not available in this session."):format(var1), "kind_unavailable"
            end
            local crossKindError = findCrossKindError(arg1, kind)
            if crossKindError ~= nil then
                return nil, crossKindError
            end
            local var2 = table.clone(arg1)
            var2.kind = nil
            return tbl4[kind](var2)
        end

        return {
            TOOL_NAME = "manage_monetization",
            KIND = kind,
            findRequestInTurnState = findRequestInTurnState,
            parseInput = parseInput,
            getActionKind = monetizationClientTool.getActionKind,
            formatResultContent = function(arg1)
                if typeof(arg1) == "table" and arg1.kind == nil then
                    arg1 = table.clone(arg1)
                    arg1.kind = kind
                end
                return monetizationClientTool.formatResultContent(arg1)
            end,
            formatRejectionContent = function(str2: string, str3: string?)
                return monetizationClientTool.formatRejectionContent(str2, str3, kind)
            end,
            findManageDevProductRequestInTurnState = findRequestInTurnState,
            parseManageDevProductInput = parseInput,
            resolveRequestKind = resolveKind
        }
    end
}
