-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:10:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local createAvatarSceneStage = require(script.Parent.createAvatarSceneStage)

local var1 = nil

local function getAvatarSceneStage()
    if var1 == nil then
        var1 = createAvatarSceneStage()
    end
    return var1
end

return getAvatarSceneStage
