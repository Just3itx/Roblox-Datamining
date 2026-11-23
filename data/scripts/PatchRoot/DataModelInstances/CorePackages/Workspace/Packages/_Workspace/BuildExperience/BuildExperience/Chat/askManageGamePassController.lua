-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T18:51:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local CreatorAgentChat = require(BuildExperienceParent.DataHydration.CreatorAgentChat)
local GamePassConfig = require(BuildExperienceParent.DataHydration.GamePassConfig)
local Promise = require(BuildExperienceParent.Promise)

local FFlagBuildExperienceManageMonetizationTool = require(BuildExperienceParent.SharedFlags).FFlagBuildExperienceManageMonetizationTool

local _chatTypes = require(script.Parent.chatTypes)
local _localToolOverlay = require(script.Parent.localToolOverlay)
local createManageGamePassStore = require(script.Parent.createManageGamePassStore)
local createMonetizationToolController = require(script.Parent.createMonetizationToolController)
local toolControllerUtils = require(script.Parent.toolControllerUtils)

local var1 = nil

local function getStore() -- Luacid: Inlined by compiler; 5 call sites recovered
    if var1 == nil then
        var1 = createManageGamePassStore()
    end
    return var1
end

local tbl1 = {
    tool = if FFlagBuildExperienceManageMonetizationTool then CreatorAgentChat.StudioManageMonetizationTool.forKind("gamePass") else CreatorAgentChat.StudioManageGamePassTool,
    itemKind = "gamePass",
    resultKey = "gamePass",
    list = 0,
    mutate = 0,
    itemIdOf = 0,
    cardFields = 0
}

function tbl1.list(num1: number)
    return getStore().list(num1):andThen(function(arg1)
        return {
            count = #arg1.gamePasses,
            gamePasses = arg1.gamePasses,
            nextPageToken = arg1.nextPageToken,
            truncated = arg1.isIncomplete == true
        }
    end, function(arg1)
        if typeof(arg1) ~= "table" or arg1.code ~= GamePassConfig.INCOMPLETE_LIST_CODE then
            return Promise.reject(arg1)
        end

        return {
            count = #arg1.gamePasses,
            gamePasses = arg1.gamePasses,
            nextPageToken = arg1.nextPageToken,
            truncated = true,
            truncatedReason = arg1.message
        }
    end)
end

function tbl1.mutate(num1: number, arg1)
    if arg1.action == "create" then
        return toolControllerUtils.withGeneratedImage(
            arg1.imageAssetId,
            "The pass image could not be loaded. No game pass was created.",
            function(imageFile)
                return getStore().create(num1, {
                    name = arg1.name,
                    description = arg1.description,
                    priceInRobux = arg1.priceInRobux,
                    isForSale = false,
                    imageFile = imageFile
                })
            end
        )
    elseif arg1.action == "update" then
        return toolControllerUtils.withGeneratedImage(
            arg1.imageAssetId,
            "The pass image could not be loaded. No changes were made.",
            function(imageFile)
                return getStore().update(
                    num1,
                    arg1.gamePassId,
                    {
                        name = arg1.name,
                        description = arg1.description,
                        priceInRobux = arg1.priceInRobux,
                        imageFile = imageFile
                    }
                )
            end
        )
    elseif arg1.action == "activate" then
        return getStore().activate(num1, arg1.gamePassId)
    elseif arg1.action == "deactivate" then
        return getStore().deactivate(num1, arg1.gamePassId)
    end
    local reject = Promise.reject
    local tbl2 = { errorMessage = 0 }
    local action = arg1.action
    tbl2.errorMessage = ("Unsupported action '%s'."):format(tostring(action))
    return reject(tbl2)
end

function tbl1.itemIdOf(arg1)
    if arg1.gamePassId == nil then
        return nil
    end

    return tostring(arg1.gamePassId)
end

function tbl1.cardFields(arg1)
    return {
        imageAssetId = arg1.imageAssetId
    }
end

return function(arg1, tbl2, arg2, arg3)
    return createMonetizationToolController(tbl1, arg1, tbl2, arg2, arg3)
end
