-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:10:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InsertService = game:GetService("InsertService")

local AvatarExperienceCommonParent = script:FindFirstAncestor("AvatarExperienceCommon").Parent

local Promise = require(AvatarExperienceCommonParent.Promise)

local _types = require(script.Parent.types)

local function createAssetSource(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return function(num1: number)
        return Promise.new(function(arg2, arg3)
            task.spawn(function()
                local success, result = pcall(function()
                    return arg1:LoadAsset(num1)
                end)
                if not (success and result) then
                    return arg3(`loadAsset failed for asset {num1}: {tostring(result)}`)
                end

                local avatarBackground = result:FindFirstChild("AvatarBackground")
                local imageId = avatarBackground and avatarBackground:FindFirstChild("ImageId")
                local color = avatarBackground and avatarBackground:FindFirstChild("Color")
                if not (avatarBackground and imageId and color) then
                    result:Destroy()
                    return arg3(`asset {num1} missing AvatarBackground/ImageId/Color`)
                end

                local imageIdValue = imageId.Value
                local colorValue = color.Value
                result:Destroy()

                return arg2({ imageId = imageIdValue, backgroundColor = colorValue })
            end)
        end)
    end
end

return {
    create = createAssetSource,
    default = createAssetSource(InsertService)
}
