-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:51:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreScriptSyncService = game:GetService("CoreScriptSyncService")

local function getFileInfo(str1: string, str2: string?, bool1: boolean?)
    local game = game
    for _, value in string.split(str1, ".") do
        if game == nil then
            break
        end

        game = game:FindFirstChild(value)
    end

    if typeof(game) ~= "Instance" or not game:IsA("ModuleScript") then
        warn("path led to non-ModuleScript:", str1, game.ClassName)
        game = nil
    end

    local scriptFilePath

    if game then
        scriptFilePath = CoreScriptSyncService:GetScriptFilePath(game)
        if str2 then
            local var1, var2 = string.find(scriptFilePath, str2, 1, true)
            if var1 then
                if not bool1 then
                    var1 = var2 + 1
                end

                scriptFilePath = string.sub(scriptFilePath, var1)
            end
        end
    else
        scriptFilePath = nil
    end

    return game, scriptFilePath
end

return getFileInfo
