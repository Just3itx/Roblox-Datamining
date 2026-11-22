-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T00:31:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Home = script:FindFirstAncestor("Home")
local HomeParent = Home.Parent

local Signals = require(HomeParent.Signals)
local CollectionViews = require(HomeParent.CollectionViews)
local Display = require(HomeParent.Display)

local measureHomeCollectionLayout = require(Home.measureHomeCollectionLayout)
local writeHomePageSduiCollectionLayout = require(Home.writeHomePageSduiCollectionLayout)

local function startHomeCollectionLayoutSync()
    local mainCollectionLayoutStore = CollectionViews.getMainCollectionLayoutStore(false)
    local displayStore = Display.GetDisplayStore(false)

    local computed = Signals.createComputed(function(arg1)
        mainCollectionLayoutStore.getContainerWidth(arg1)
        mainCollectionLayoutStore.getIsContainerMeasured(arg1)
        displayStore.getViewportSize(arg1)
        displayStore.getTopBarHeight(arg1)
        local var1 = measureHomeCollectionLayout()
        return if var1 then var1.rows_above_fold else nil
    end)

    local bool1 = false
    return Signals.createEffect(function(arg1)
        local var1 = computed(arg1)

        mainCollectionLayoutStore.getNumItemsForAllCategories(arg1)

        if var1 == nil or bool1 then
            return
        end
        bool1 = true
        task.delay(1, function()
            bool1 = false
            local var2 = measureHomeCollectionLayout()
            if var2 then
                writeHomePageSduiCollectionLayout(var2)
            end
        end)
    end)
end

return startHomeCollectionLayoutSync
