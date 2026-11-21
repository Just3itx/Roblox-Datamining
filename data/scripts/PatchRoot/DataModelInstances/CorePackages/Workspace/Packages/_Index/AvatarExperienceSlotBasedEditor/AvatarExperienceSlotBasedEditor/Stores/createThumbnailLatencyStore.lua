-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:50:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceSlotBasedEditorParent = script:FindFirstAncestor("AvatarExperienceSlotBasedEditor").Parent

local Signals = require(AvatarExperienceSlotBasedEditorParent.Signals)

local function createThumbnailLatencyStore()
    local getStartTime, var2 = Signals.createSignal(nil)
    local getEndTime, var4 = Signals.createSignal(nil)
    local getThumbnailMap, var6 = Signals.createSignal({})

    local tbl1 = ({})

    return {
        getStartTime = getStartTime,
        getEndTime = getEndTime,
        getThumbnailMap = getThumbnailMap,
        getAnyLoaded = Signals.createComputed(function(arg1)
            for _, value in getThumbnailMap(arg1) do
                if value then
                    return true
                end
            end
            return false
        end),
        getIsLoaded = function(str1: string)
            local var7 = tbl1[str1]
            if var7 then
                return var7
            end
            local computed = Signals.createComputed(function(arg1): boolean
                return getThumbnailMap(arg1)[str1] == true
            end)
            tbl1[str1] = computed
            return computed
        end,
        startTracking = function()
            var2(os.clock())
            var4(nil)
            var6({})
        end,
        appendThumbnail = function(str1: string)
            local var7 = getThumbnailMap(false)
            if var7[str1] ~= nil then
                return
            end
            local var8 = table.clone(var7)
            var8[str1] = false
            var6(var8)
        end,
        setThumbnailLoaded = function(str1: string)
            local var7 = getThumbnailMap(false)
            if var7[str1] == true then
                return
            end
            local var8 = table.clone(var7)
            var8[str1] = true
            var6(var8)
        end,
        endTracking = function()
            var4(os.clock())
        end
    }
end
return createThumbnailLatencyStore
