-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:41:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local getFFlagServerCoreScriptSourceCode = game:DefineFastFlag("ServerCoreScriptSourceCode", false)

local module = {}

function module.getFFlagServerCoreScriptSourceCode()
    return getFFlagServerCoreScriptSourceCode
end

if getFFlagServerCoreScriptSourceCode then
    local InsertService = game:GetService("InsertService")
    local modules = game:GetService("CoreGui"):WaitForChild("RobloxGui", math.huge).Modules

    local function getRelativePathArray(modules2: Instance, arg1)
        local relativePathArray = {}

        while arg1 ~= modules2 do
            if arg1 == nil then
                return nil
            end
            table.insert(relativePathArray, 1, arg1.Name)
            arg1 = arg1.Parent
        end
        return relativePathArray
    end

    function module.getSourceForServerScript(arg1)
        if arg1.Source ~= "" then
            return arg1.Source
        end

        local var1 = modules
        local sourceCode = modules.SourceCode

        local relativePathArray = getRelativePathArray(var1, arg1)
        if relativePathArray == nil then
            error("Instance is not a descendant of the byte code root")
        end

        for i = 1, #relativePathArray do
            sourceCode = sourceCode:FindFirstChild(relativePathArray[i])
        end

        if sourceCode == nil then
            error("No source found for instance")
        end

        return sourceCode.Source
    end

    local function isByteCodeMode(): boolean -- Luacid: Inlined by compiler; 1 call site recovered
        return script.Source == ""
    end

    function module.initSourceCodeFolder()
        if not isByteCodeMode() then
            return
        end

        local localAssetResult = InsertService:LoadLocalAsset("rbxasset://models/ServerCoreScripts.rbxm")
        local sourceCode = Instance.new("Folder")
        sourceCode.Name = "SourceCode"
        sourceCode.Parent = modules

        local server = localAssetResult.Server
        local common = localAssetResult.Common
        server.Parent = sourceCode
        common.Parent = sourceCode
    end
end

return module
