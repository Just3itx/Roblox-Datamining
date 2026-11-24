-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T21:31:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")

local InExperienceSideSheetParent = script:FindFirstAncestor("InExperienceSideSheet").Parent

local Signals = require(InExperienceSideSheetParent.Signals)

local num1 = game:DefineFastInt("MaxIGMBackgroundTransparencyPercent", 30)

local function createSideSheetConfigStore()
    local getBackgroundTransparency, var2 = Signals.createSignal(0)
    local getSideSheetDrawerWidth, setSideSheetDrawerWidth = Signals.createSignal(0)
    local getIsPeoplePageOpen, setIsPeoplePageOpen = Signals.createSignal(false)
    local getDidSideSheetOpenWithPeoplePage, setDidSideSheetOpenWithPeoplePage = Signals.createSignal(false)

    local function updateBackgroundTransparency() -- Luacid: Inlined by compiler; 2 call sites recovered
        return var2(GuiService.PreferredTransparency * num1 / 100)
    end

    updateBackgroundTransparency()

    local connection = GuiService:GetPropertyChangedSignal("PreferredTransparency"):Connect(function()
        updateBackgroundTransparency()
    end)

    return {
        getBackgroundTransparency = getBackgroundTransparency,
        getSideSheetDrawerWidth = getSideSheetDrawerWidth,
        setSideSheetDrawerWidth = setSideSheetDrawerWidth,
        getIsPeoplePageOpen = getIsPeoplePageOpen,
        setIsPeoplePageOpen = setIsPeoplePageOpen,
        getDidSideSheetOpenWithPeoplePage = getDidSideSheetOpenWithPeoplePage,
        setDidSideSheetOpenWithPeoplePage = setDidSideSheetOpenWithPeoplePage,
        cleanUp = function()
            connection:Disconnect()
        end
    }
end
return createSideSheetConfigStore
