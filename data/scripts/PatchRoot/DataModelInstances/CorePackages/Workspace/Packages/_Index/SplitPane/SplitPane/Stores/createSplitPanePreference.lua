-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:31:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SplitPaneParent = script:FindFirstAncestor("SplitPane").Parent

local Signals = require(SplitPaneParent.Signals)
local MockableProxyServices = require(SplitPaneParent.MockableProxyServices)

local function createSplitPanePreference()
    local AppStorageService = MockableProxyServices.AppStorageService
    local var1, var2 = Signals.createSignal(nil)
    local bool1 = false
    local bool2 = false

    local function persist(bool3: boolean) -- Luacid: Inlined by compiler; 2 call sites recovered
        pcall(function()
            AppStorageService:SetItem("SplitPaneCollapsedPreference", tostring(bool3))
            AppStorageService:Flush()
        end)
    end

    pcall(function()
        AppStorageService:WhenLoaded(function()
            bool1 = true

            if bool2 then
                persist((var1(false)))
                return
            end
            local success, result = pcall(function()
                return AppStorageService:GetItem("SplitPaneCollapsedPreference")
            end)
            if success and (result == "true" or result == "false") then
                var2(result == "true")
            end
        end)
    end)

    return var1, function(bool3: boolean)
        bool2 = true
        var2(bool3)
        if bool1 then
            persist(bool3)
        end
    end
end

return createSplitPanePreference
