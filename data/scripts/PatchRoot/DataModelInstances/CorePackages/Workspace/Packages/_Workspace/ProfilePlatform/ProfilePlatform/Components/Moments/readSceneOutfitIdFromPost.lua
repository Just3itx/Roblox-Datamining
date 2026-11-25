-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:11:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local readSceneOutfitIdFromText = require(script.Parent.readSceneOutfitIdFromText)

local function readSceneOutfitIdFromPost(arg1)
    for _, value in arg1.tracks or {} do
        for _, value2 in value.slots or {} do
            local content = value2.content
            if content == nil or content.type ~= "visual" then
                continue
            end

            local content2 = content.value.content
            if content2 == nil or content2.type ~= "scene" then
                continue
            end

            local rbxmData = content2.value.rbxm_data
            if typeof(rbxmData) == "buffer" and buffer.len(rbxmData) > 0 then
                return readSceneOutfitIdFromText(buffer.tostring(rbxmData))
            end
        end
    end
    return nil
end

return readSceneOutfitIdFromPost
