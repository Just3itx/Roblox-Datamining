-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:01:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local _FeedTypes = require(Moments.Components.Feed.FeedTypes)
local decodeMomentSceneProto = require(script.Parent.decodeMomentSceneProto)

local function defaultDeserializeInstancesAsync(buffer: buffer): {Instance}
    return game:GetService("SerializationService"):DeserializeInstancesAsync(buffer)
end

local function defaultBase64Decode(input: buffer)
    return game:GetService("EncodingService"):Base64Decode(input)
end

local function defaultDecodeMomentScene(buf1: buffer)
    return decodeMomentSceneProto(buf1)
end

local function defaultDestroyInstance(arg1)
    arg1:Destroy()
end

local function destroyRoots(tbl1, callback: (...any) -> (...any))
    for _, value in tbl1 do
        pcall(function()
            callback(value)
        end)
    end
end

local function findRecipeValue(tbl1)
    for _, value in tbl1 do
        if value.Name ~= "MomentScene" then
            value = value:FindFirstChild("MomentScene", true)
        end

        if value == nil then
            continue
        end

        local momentSceneData = value:FindFirstChild("MomentSceneData")
        if momentSceneData ~= nil and momentSceneData:IsA("StringValue") then
            return momentSceneData
        end
    end

    return nil
end

local function optionalPositiveNumber(arg1): number? -- Luacid: Inlined by compiler; 4 call sites recovered
    return if typeof(arg1) == "number" and arg1 > 0 then arg1 else nil
end

local function parseMomentScenesAsset(tbl1, num1: number)
    local parseSceneAsset = require(MomentsParent.MomentScenes).parseSceneAsset
    for _, value in tbl1 do
        local var1 = parseSceneAsset(value)
        if var1.type == nil and next(var1.args) == nil then
            continue
        end

        local type = var1.type or "AvatarMoment"
        if type ~= "AvatarMoment" then
            error(`Inline MomentScene type {type} is not AvatarMoment`)
        end
        local var2 = optionalPositiveNumber(var1.args.outfitId)
        if var2 == nil then
            error("Inline MomentScene has no valid outfit id")
        end
        if var2 ~= num1 then
            error(`MomentScene outfit {var2} does not match Post annotation {num1}`)
        end
        return {
            type = "AvatarMoment",
            args = var1.args
        }
    end

    error("Inline MomentScene RBXM has neither MomentScene/MomentSceneData nor a MomentScenes Type/Args folder")
end

local function optionalUtf8String(buf: buffer)
    local var1 = if typeof(buf) == "buffer" then buffer.tostring(buf) elseif typeof(buf) ~= "string" then "" else buf

    if var1 == "" then
        return nil
    end
    if utf8.len(var1) == nil then
        error("MomentScene emote_name is not valid UTF-8")
    end
    return var1
end

local function decodeInlineMomentScene(buf1: buffer, num1: number, tbl1)
    if buffer.len(buf1) == 0 then
        error("Inline MomentScene RBXM is empty")
    end
    if num1 <= 0 then
        error("Avatar annotation has no valid outfit id")
    end

    local tbl2 = tbl1 or {}

    local var1 = tbl2.deserializeInstancesAsync or defaultDeserializeInstancesAsync

    local var2 = tbl2.base64Decode or defaultBase64Decode
    local var3 = tbl2.decodeMomentScene or defaultDecodeMomentScene
    local var4 = tbl2.destroyInstance or defaultDestroyInstance
    local tbl3 = {}

    local success, result = pcall(function()
        tbl3 = var1(buf1)
        local recipeValue = findRecipeValue(tbl3)
        if recipeValue == nil then
            return parseMomentScenesAsset(tbl3, num1)
        end
        local recipeValueValue = recipeValue.Value
        if recipeValueValue == "" then
            error("MomentSceneData is empty")
        end
        local var5 = var2(buffer.fromstring(recipeValueValue))
        local var6 = var3(var5)
        local outfitId = optionalPositiveNumber(var6.outfit_id)
        if outfitId == nil then
            error("MomentScene recipe has no valid outfit id")
        end
        if outfitId ~= num1 then
            error(`MomentScene outfit {outfitId} does not match Post annotation {num1}`)
        end

        return {
            type = "AvatarMoment",
            args = {
                outfitId = outfitId,
                emoteId = optionalPositiveNumber(var6.emote_asset_id),
                backgroundAssetId = optionalPositiveNumber(var6.background_asset_id),
                emote = optionalUtf8String(var6.emote_name)
            }
        }
    end)

    destroyRoots(tbl3, var4)
    if not success then
        error(result)
    end
    return result
end

return decodeInlineMomentScene
