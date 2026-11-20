-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:21:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local Array = require(scriptParentParentParent.LuauPolyfill).Array

local function getSceneIndicesForInterpolationInputRange(arg1)
    local scene = arg1.scene
    local scenes = arg1.scenes

    local index = scene.index
    local scenesLen = #scenes
    if not scenes[scenesLen].isActive then
        local var1 = Array.indexOf(scenes, scene)

        local var2 = nil
        for value, value2 in scenes do
            if value2.isActive then
                var2 = value
                break
            end
        end

        local index2 = scenes[var2].index
        local index3 = scenes[scenesLen].index

        if index ~= index2 and var1 == scenesLen then
            return {
                first = math.min(index2, index - 1),
                last = index + 1
            }
        end

        if index == index2 and var1 == var2 then
            return {
                first = index - 1,
                last = math.max(index3, index + 1)
            }
        end

        if index == index2 or var2 < var1 then
            return nil
        end
    end

    return {
        first = index - 1,
        last = index + 1
    }
end

return getSceneIndicesForInterpolationInputRange
