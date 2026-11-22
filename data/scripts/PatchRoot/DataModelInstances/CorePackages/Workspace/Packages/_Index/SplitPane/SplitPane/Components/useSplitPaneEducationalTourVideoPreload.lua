-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:30:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SplitPaneParent = script:FindFirstAncestor("SplitPane").Parent

local React = require(SplitPaneParent.React)
local Responsive = require(SplitPaneParent.Responsive)

local SplitPaneEducationalTourSteps = require(script.Parent.SplitPaneEducationalTourSteps)
local getSplitPaneEducationalTourVideoAssetId = require(script.Parent.getSplitPaneEducationalTourVideoAssetId)

local function getPreloadAssetIds(bool1: boolean)
    local preloadAssetIds = {}
    local tbl1 = ({})
    local function add(str1: string) -- Luacid: Inlined by compiler; 2 call sites recovered
        if not tbl1[str1] then
            tbl1[str1] = true
            table.insert(preloadAssetIds, str1)
        end
    end
    for k, splitPaneEducationalTourStep in SplitPaneEducationalTourSteps do
        add((getSplitPaneEducationalTourVideoAssetId(splitPaneEducationalTourStep, bool1, false)))
        if k == 1 then
            add((getSplitPaneEducationalTourVideoAssetId(splitPaneEducationalTourStep, bool1, true)))
        end
    end
    return preloadAssetIds
end

local function useSplitPaneEducationalTourVideoPreload(bool1: boolean, tbl1)
    local bool2 = Responsive.usePreferredInput() == Responsive.Input.Directional

    local var1 = React.useRef(false)

    React.useEffect(function()
        if not bool1 or var1.current then
            return
        end
        var1.current = true
        local var2 = tbl1 or game:GetService("ContentProvider")
        local preloadAssetIds = getPreloadAssetIds(bool2)
        task.spawn(function()
            pcall(function()
                var2:PreloadAsync(preloadAssetIds)
            end)
        end)
    end, { bool1, bool2, tbl1 })
end

return useSplitPaneEducationalTourVideoPreload
