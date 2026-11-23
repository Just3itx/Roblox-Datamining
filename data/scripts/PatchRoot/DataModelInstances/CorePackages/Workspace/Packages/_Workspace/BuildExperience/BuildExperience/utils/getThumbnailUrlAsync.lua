-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:11:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local HttpClient = require(BuildExperienceParent.HttpClient)
local Promise = require(BuildExperienceParent.Promise)
local Url = require(BuildExperienceParent.Http).Url

local debug2 = require(BuildExperienceParent.DataHydration.CreatorAgentChat).debug

local fetch = HttpClient.fetch
local asPromise = HttpClient.asPromise

local url = Url.THUMBNAILS_URL .. "v1/batch"

local function getThumbnailUrlAsync(num1: number, str1: string?)
    local size = str1 or "420x420"

    debug2.log("info", "thumbnail_url polling", { assetId = num1 })

    return Promise.new(function(callback, callback2)
        local num2 = 0

        local function poll(num3: number)
            local var2 = fetch({
                method = "POST",
                url = url,
                body = {{ targetId = num1, type = "Asset", size = size, format = "Png" }},
                analyticsKey = "build-experience.get-thumbnail-url",
                decode = function<T>(arg1: T): T
                    return arg1
                end
            })

            asPromise(var2):andThen(function(arg1)
                local data = arg1 and arg1.data
                if not data or #data == 0 then
                    callback2("No thumbnail data returned")
                    return
                end

                local var3 = data[1]
                if var3.state == "Completed" then
                    debug2.log("info", "thumbnail_url completed", { assetId = num1 })
                    callback({ status = "completed", imageUrl = var3.imageUrl })
                    return
                end

                if var3.state == "InReview" then
                    num2 += 1
                    if num2 >= 5 then
                        debug2.log("warn", "thumbnail_url in_review timeout", { assetId = num1 })
                        callback({ status = "in_review", assetId = num1 })
                        return
                    end
                    task.delay(2, function()
                        poll(num3 + 1)
                    end)
                elseif var3.state == "Pending" then
                    if num3 >= 15 then
                        debug2.log("warn", "thumbnail_url timed out", { assetId = num1 })
                        callback2("Thumbnail generation timed out")
                        return
                    end
                    task.delay(2, function()
                        poll(num3 + 1)
                    end)
                else
                    callback2(`Thumbnail failed: {var3.state}`)
                end
            end):catch(function(arg1)
                callback2(arg1)
            end)
        end

        poll(1)
    end)
end

return getThumbnailUrlAsync
