-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:40:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local dependencies = require(scriptParentParent.dependencies)

local AppStorageService = dependencies.AppStorageService
local useDispatch = dependencies.useDispatch
local useSelector = dependencies.useSelector
local useEffectOnce = dependencies.useEffectOnce
local FetchContactImporterParams = require(scriptParentParent.Networking.FetchContactImporterParams)
local PermissionsProtocol = dependencies.PermissionsProtocol
local useContactImporterConfiguration = require(script.Parent.useContactImporterConfiguration)

return function(tbl1)
    local var1 = useSelector(function(arg1)
        return arg1.LocalUserId
    end)

    local var2 = useDispatch()

    local function func1()
        var2(FetchContactImporterParams(var1, PermissionsProtocol.default, AppStorageService))
    end

    local shouldFetchContactImporterData = useContactImporterConfiguration(tbl1).shouldFetchContactImporterData

    if shouldFetchContactImporterData then
        if var1 then
            if var1 == "" then
                shouldFetchContactImporterData = false
            else
                shouldFetchContactImporterData = var1 ~= "0"
            end
        else
            shouldFetchContactImporterData = var1
        end
    end

    useEffectOnce(func1, shouldFetchContactImporterData)
end
