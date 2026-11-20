-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:01:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local connect = require(script.connect)
local Provider = require(script.Provider)
local Logger = require(script.Logger)

local getPolicyImplementations = script.getPolicyImplementations
local fromMemStorageService = require(getPolicyImplementations.fromMemStorageService)
local fromPolicyService = require(getPolicyImplementations.fromPolicyService)
local fromStaticSource = require(getPolicyImplementations.fromStaticSource)
local AppPolicyContext = require(script.AppPolicyContext)

return {
    withGetPolicyImplementation = function(arg1)
        assert(arg1.read, "expected getPolicyImpl to have `read` function")
        assert(arg1.onPolicyChanged, "expected getPolicyImpl to have `onPolicyChanged` function")
        return {
            connect = connect(arg1),
            Provider = Provider()
        }
    end,
    GetPolicyImplementations = {
        MemStorageService = fromMemStorageService(),
        PolicyService = fromPolicyService(),
        Static = fromStaticSource()
    },
    Logger = Logger,
    AppPolicyContext = AppPolicyContext
}
