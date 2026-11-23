-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:11:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local HttpClient = require(BuildExperienceParent.HttpClient)
local Promise = require(BuildExperienceParent.Promise)

local FFlagBuildExperienceMonetizationFailureCauses = require(BuildExperience.Flags.FFlagBuildExperienceMonetizationFailureCauses)
local getThumbnailUrlAsync = require(script.Parent.getThumbnailUrlAsync)
local monetizationFailureCauses = require(script.Parent.monetizationFailureCauses)

local asPromise = HttpClient.asPromise
local fetch = HttpClient.fetch

local function downloadGeneratedImageAsync(num1: number)
    return getThumbnailUrlAsync(num1):andThen(function(arg1)
        if arg1.status ~= "completed" then
            return Promise.reject(monetizationFailureCauses.MESSAGES.imageInReview)
        end

        local var1 = fetch({
            method = "GET",
            url = arg1.imageUrl,
            analyticsKey = "build-experience.download-developer-product-image",
            responseEncoding = "protobuf",
            decode = function(buf1: buffer): buffer
                return buf1
            end
        })
        return asPromise(var1):andThen(function(buf: buffer)
            if buffer.len(buf) > 5242880 then
                return (Promise.reject(
                    if FFlagBuildExperienceMonetizationFailureCauses then monetizationFailureCauses.MESSAGES.imageTooLarge else "The generated image exceeds the 5 MB developer-product limit."
                ))
            end

            return {
                content = buffer.tostring(buf),
                contentType = "image/png",
                fileName = `generated-{num1}.png`
            }
        end)
    end)
end

return downloadGeneratedImageAsync
