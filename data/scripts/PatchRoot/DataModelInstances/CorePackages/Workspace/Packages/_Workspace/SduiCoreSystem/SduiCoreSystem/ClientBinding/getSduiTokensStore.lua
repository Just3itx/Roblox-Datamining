-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T09:41:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")
local SduiCoreSystemParent = SduiCoreSystem.Parent
local Signals = require(SduiCoreSystemParent.Signals)
local _Foundation = require(SduiCoreSystemParent.Foundation)

local SduiErrors = require(SduiCoreSystem.SduiErrors)
local SduiLogger = require(SduiCoreSystem.SduiLogger)

local function createSduiTokensStore() -- Luacid: Inlined by compiler; 1 call site recovered
    local var1, setTokens = Signals.createSignal(nil)

    return {
        getTokens = function(arg1, str1: string)
            local var3 = var1(arg1)
            if var3 == nil then
                SduiLogger.reportError(SduiErrors.SduiErrorType.GetNilTokens, { message = "Getting tokens before they were set" }, str1)
            end

            return var3
        end,
        setTokens = setTokens
    }
end

local var1 = nil

local function getSduiTokensStore()
    if var1 == nil then
        var1 = createSduiTokensStore()
    end
    return var1
end

return getSduiTokensStore
