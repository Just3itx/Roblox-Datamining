-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:31:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SplitPaneParent = script:FindFirstAncestor("SplitPane").Parent

local Signals = require(SplitPaneParent.Signals)

local function createSplitL3Store()
    local getPendingSplitSubPaneTag, setPendingSplitSubPaneTag = Signals.createSignal(nil)
    local getPendingSplitSubPaneDetail, setPendingSplitSubPaneDetail = Signals.createSignal(nil)
    local getSplitL2SessionVersion, setSplitL2SessionVersion = Signals.createSignal(0)
    local getSplitL3AppliedDetail, setSplitL3AppliedDetail = Signals.createSignal(nil)

    return {
        getPendingSplitSubPaneTag = getPendingSplitSubPaneTag,
        setPendingSplitSubPaneTag = setPendingSplitSubPaneTag,
        getPendingSplitSubPaneDetail = getPendingSplitSubPaneDetail,
        setPendingSplitSubPaneDetail = setPendingSplitSubPaneDetail,
        getSplitL2SessionVersion = getSplitL2SessionVersion,
        setSplitL2SessionVersion = setSplitL2SessionVersion,
        getSplitL3AppliedDetail = getSplitL3AppliedDetail,
        setSplitL3AppliedDetail = setSplitL3AppliedDetail
    }
end

local var1 = nil
return {
    getStore = function()
        if var1 == nil then
            var1 = createSplitL3Store()
        end
        return var1
    end
}
