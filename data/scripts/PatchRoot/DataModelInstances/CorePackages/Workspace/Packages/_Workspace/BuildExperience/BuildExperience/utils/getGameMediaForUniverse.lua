-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:11:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local React = require(BuildExperienceParent.React)
local Signals = require(BuildExperienceParent.Signals)

local getGameMediaStore = require(BuildExperienceParent.DataHydration).Game.getGameMediaStore

local function useGameMediaForUniverse(num1: number)
    local var1, var2 = React.useState(getGameMediaStore().getAndFetchGameMedia(tostring(num1)).data)

    React.useEffect(function()
        local effect = Signals.createEffect(function(arg1)
            local var3 = getGameMediaStore(arg1).getAndFetchGameMedia(tostring(num1))
            var2(var3.data(arg1))
        end)
        return function()
            effect()
        end
    end, { num1 })

    return {
        icon = React.useMemo(function(): string
            return string.format("rbxthumb://type=GameIcon&id=%d&w=512&h=512", num1)
        end, { num1 }),
        thumbnails = React.useMemo(function()
            if not var1 then
                return {}
            end

            local result = {}
            for _, value in var1 do
                local str1 = "image"

                local id = tostring(value.videoId or value.imageId)
                local var3, tbl1, var4

                if value.videoId then
                    var3 = "rbxassetid://" .. tostring(value.videoId)
                    str1 = "video"
                    tbl1 = { id = id, mediaType = str1, assetSource = var3, assetResourceName = 0 }
                    if value.imageId then
                        var4 = `assets/{value.imageId}`
                    else
                        var4 = nil
                    end

                    tbl1.assetResourceName = var4
                    table.insert(result, tbl1)
                elseif value.imageId then
                    var3 = "rbxassetid://" .. tostring(value.imageId)

                    tbl1 = { id = id, mediaType = str1, assetSource = var3, assetResourceName = 0 }
                    if value.imageId then
                        var4 = `assets/{value.imageId}`
                    else
                        var4 = nil
                    end

                    tbl1.assetResourceName = var4
                    table.insert(result, tbl1)
                end
            end
            return result
        end, { var1 })
    }
end

return useGameMediaForUniverse
