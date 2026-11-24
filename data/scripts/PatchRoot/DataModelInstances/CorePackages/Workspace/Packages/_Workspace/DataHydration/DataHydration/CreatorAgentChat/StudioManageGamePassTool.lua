-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:31:10Z
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
    "deactivate"
}

local MAXIMUM_SAFE_INTEGER = monetizationClientTool.MAXIMUM_SAFE_INTEGER

return {
    TOOL_NAME = "manage_game_pass",
    LOCAL_TOOL_DEFINITION = {
        name = "manage_game_pass",
        inputSchema = {
            type = "object",
            additionalProperties = false,
            required = { "action" },
            properties = {
                action = { type = "string", enum = enum },
                name = { type = "string" },
                description = { type = "string" },
                priceInRobux = { type = "integer", minimum = 1, maximum = 999999999 },
                gamePassId = { type = "integer", minimum = 1, maximum = MAXIMUM_SAFE_INTEGER },
                createAndGoLive = FFlagCreatorAgentChatMonetizationOneConsent
                    and {
                        type = "boolean",
                        description = "Only for create when the creator explicitly requests creation and sale in one approval. Creation stays off sale until a supported benefit is published and verified; custom or uncertain wiring stays off sale without another approval."
                    }
                    or nil
            }
        }
    },
    findRequestInTurnState = monetizationClientTool.createRequestFinder("manage_game_pass"),
    parseInput = function(arg1, bool1: boolean?)
        local action, var2 = monetizationClientTool.parseAction(arg1, enum)
        if action == nil then
            return nil, var2
        end
        local var3 = monetizationClientTool.checkStringFields(arg1, { "name", "description" })
        if var3 ~= nil then
            return nil, var3
        end

        local priceInRobux, var5 = monetizationClientTool.parsePrice(arg1.priceInRobux, 1, 999999999)
        if var5 ~= nil then
            return nil, var5
        end
        local tbl2 = {
            action = action,
            name = arg1.name,
            description = arg1.description,
            priceInRobux = priceInRobux,
            gamePassId = monetizationClientTool.parsePositiveSafeInteger(arg1.gamePassId)
        }
        if arg1.gamePassId ~= nil and tbl2.gamePassId == nil then
            return nil, ("gamePassId must be a positive integer no greater than %.0f."):format(MAXIMUM_SAFE_INTEGER)
        end
        if bool1 then
            tbl2.imageAssetId = monetizationClientTool.parsePositiveSafeInteger(arg1.imageAssetId)
            if arg1.imageAssetId ~= nil and tbl2.imageAssetId == nil then
                return nil, ("imageAssetId must be a positive integer no greater than %.0f."):format(MAXIMUM_SAFE_INTEGER)
            end
        end
        if arg1.createAndGoLive ~= nil and not FFlagCreatorAgentChatMonetizationOneConsent then
            return nil, "createAndGoLive is unavailable."
        end

        local createAndGoLive, var7 = monetizationClientTool.parseCreateAndGoLive(arg1.createAndGoLive, action)
        if var7 ~= nil then
            return nil, var7
        end
        tbl2.createAndGoLive = createAndGoLive
        if (action == "create" or action == "list") and arg1.gamePassId ~= nil then
            return nil, "gamePassId is only used to update, activate or deactivate a game pass."
        elseif action ~= "create"
            and action ~= "update"
            and (arg1.name ~= nil or arg1.description ~= nil or arg1.priceInRobux ~= nil or tbl2.imageAssetId ~= nil)
        then
            local var8 = nil
            if bool1 then
                return var8, "Only create and update can set a game pass name, description, priceInRobux or imageAssetId."
            end

            return var8, "Only create and update can set a game pass name, description or priceInRobux."
        else
            if action == "create" then
                if tbl2.name == nil or tbl2.name == "" or tbl2.priceInRobux == nil then
                    return nil, "A name and priceInRobux are required to create a game pass."
                end
            else
                if action ~= "list" and tbl2.gamePassId == nil then
                    return nil, "A gamePassId is required for this action."
                end

                if action == "update"
                    and tbl2.name == nil
                    and tbl2.description == nil
                    and tbl2.priceInRobux == nil
                    and tbl2.imageAssetId == nil
                then
                    local var8 = nil
                    if bool1 then
                        return var8, "An update needs a name, description, priceInRobux or imageAssetId."
                    end

                    return var8, "An update needs a name, description or priceInRobux."
                end

                if action == "update" and tbl2.name == "" then
                    return nil, "A game pass name cannot be empty."
                end
            end

            return tbl2, nil
        end
    end,
    getActionKind = monetizationClientTool.getActionKind,
    formatResultContent = monetizationClientTool.formatResultContent,
    formatRejectionContent = monetizationClientTool.formatRejectionContent
}
