-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:50:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local React = require(ProfilePlatformParent.React)

local Enums = require(ProfilePlatform.Common.Enums)
local insertServiceLoadAsset = require(ProfilePlatform.Utils.insertServiceLoadAsset)
local useProfileJsonComponent = require(ProfilePlatform.Hooks.useProfileJsonComponent)

local function parseAssetId(tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    if tbl1 == nil then
        return nil
    end
    local assetId = tbl1.assetId
    if type(assetId) == "number" and assetId > 0 then
        return assetId
    end
    if type(assetId) == "string" then
        local var1 = tonumber(assetId)
        if var1 and var1 > 0 then
            return var1
        end
    end
    return nil
end

local function findInnerImageId(arg1)
    if type(arg1) == "table" then
        local imageId = arg1.ImageId
        if type(imageId) == "table" then
            local imageIdValue = imageId.Value
            if type(imageIdValue) == "number" and imageIdValue > 0 then
                return imageIdValue
            end
        end
        return nil
    end

    if typeof(arg1) ~= "Instance" then
        return nil
    end

    for _, descendant in ipairs(arg1:GetDescendants()) do
        local imageId = descendant:FindFirstChild("ImageId")
        if imageId == nil or not (imageId:IsA("IntValue") or imageId:IsA("NumberValue")) then
            continue
        end

        local imageIdValue = imageId.Value
        if type(imageIdValue) == "number" and imageIdValue > 0 then
            return imageIdValue
        end
    end

    return nil
end

local function useAvatarBackgroundFromWrapper()
    local var1 = parseAssetId((useProfileJsonComponent(Enums.Components.ProfileBackground)))

    local var2, var3 = React.useState(nil)

    React.useEffect(function()
        if var1 == nil then
            var3(nil)
            return nil
        end

        local bool1 = false
        task.spawn(function()
            local success, result = pcall(function()
                return insertServiceLoadAsset(var1)
            end)

            if not success or bool1 or result == nil then
                return
            end

            local innerImageId = findInnerImageId(result)
            if bool1 then
                return
            end

            if innerImageId == nil then
                var3(nil)
            else
                var3("rbxassetid://" .. tostring(innerImageId))
            end
        end)
        return function()
            bool1 = true
        end
    end, { var1, var3 })

    return var2
end

return useAvatarBackgroundFromWrapper
