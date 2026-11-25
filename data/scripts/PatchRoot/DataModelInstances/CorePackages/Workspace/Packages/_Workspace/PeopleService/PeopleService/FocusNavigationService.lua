-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:00:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local GuiService = game:GetService("GuiService")

local scriptParent = script.Parent
local var1 = if require(scriptParent.Flags).GetFFlagPeoplePageEnablePersonSignalStore() then require(scriptParent.ServiceLocator).get("PeopleListStore") else require(scriptParent.PeopleListStore)
local PeopleUtility = require(scriptParent.PeopleUtility)
local SettingsHubService = require(scriptParent.Integration.SettingsHubService)

local function createFocusNavigationService()
    local tbl1 = ({})
    local tbl2 = ({})
    local tbl3 = ({})
    local tbl4 = ({})
    local tbl5 = ({})
    local var2 = nil
    local var3 = nil

    local canvasPosition = nil
    local bool1 = false

    local function restoreScrollPosition() -- Luacid: Inlined by compiler; 1 call site recovered
        if not canvasPosition then
            return
        end

        local var4 = SettingsHubService.hubRef()
        if var4 and var4.PageView then
            var4.PageView.CanvasPosition = canvasPosition
            canvasPosition = nil
            bool1 = false
        end
    end

    local function getFirstPersonButton()
        local var4 = nil
        local huge = math.huge

        for k, value in pairs(tbl1) do
            if k == -1 then
                continue
            end

            local var5 = tbl3[k]
            if not (var5 < huge) then
                continue
            end

            local var6 = nil
            local huge2 = math.huge

            for _, value2 in pairs(value) do
                if value2.LayoutOrder and value2.LayoutOrder < huge2 then
                    huge2 = value2.LayoutOrder
                    var6 = value2
                end
            end

            if var6 then
                var4 = var6
                huge = var5
            end
        end

        return var4
    end

    local function handleSelectionChange()
        local selectedCoreObject = GuiService.SelectedCoreObject

        if var3 and selectedCoreObject then
            local var4 = tbl2[var3]
            local var5 = tbl2[selectedCoreObject]

            if var4 and var4 < 0 and var5 and var5 >= 0 then
                local firstPersonButton = getFirstPersonButton()
                if firstPersonButton then
                    task.defer(function()
                        GuiService.SelectedCoreObject = firstPersonButton
                    end)
                end
            end
        end

        if selectedCoreObject then
            local var4 = tbl2[selectedCoreObject]
            if var4 then
                if bool1 and canvasPosition then
                    restoreScrollPosition()
                    return
                end

                local var5 = tbl5[var4]
                if var5 then
                    var5()
                else
                    local var6 = tbl4[var4]
                    if var6 then
                        local var7 = SettingsHubService.hubRef()
                        if var7 then
                            task.defer(function()
                                var7:ScrollToFrame(var6, true)
                            end)
                        end
                    end
                end
            end
        end

        var3 = selectedCoreObject
    end

    local function initializeSelectionListener() -- Luacid: Inlined by compiler; 1 call site recovered
        var2 = var2 or GuiService:GetPropertyChangedSignal("SelectedCoreObject"):Connect(handleSelectionChange)
    end

    local function disconnectSelectionListener() -- Luacid: Inlined by compiler; 1 call site recovered
        if var2 then
            var2:Disconnect()
            var2 = nil
        end
    end

    local function getFocusedPersonInfo() -- Luacid: Inlined by compiler; 1 call site recovered
        local selectedCoreObject = GuiService.SelectedCoreObject

        if selectedCoreObject then
            local var4 = tbl2[selectedCoreObject]
            local selectedCoreObjectName = selectedCoreObject.Name

            if var4 and selectedCoreObjectName then
                return var4, selectedCoreObjectName
            end
        end

        return nil, nil
    end

    local function findButtonForUser(num1: number, str1: string)
        local var4 = tbl1[num1]
        if not var4 then
            return nil
        end

        local var5 = var4[str1]
        if var5 then
            return var5
        end

        local var6 = nil
        for _, value in pairs(var4) do
            if not var6 or value.LayoutOrder < var6.LayoutOrder then
                var6 = value
            end
        end

        return var6
    end

    local function findNearestPerson(userId: number, tbl6) -- Luacid: Inlined by compiler; 1 call site recovered
        if #tbl6 == 0 then
            return nil
        end

        local var4 = tbl3[userId]

        if not var4 then
            return tbl6[1].UserId
        end

        if tbl6[var4] then
            return tbl6[var4].UserId
        end

        if var4 > 1 and tbl6[var4 - 1] then
            return tbl6[var4 - 1].UserId
        end

        return tbl6[1].UserId
    end

    return {
        registerButtonRow = function(num1: number, tbl6, num2: number)
            if not tbl1[num1] then
                tbl1[num1] = {}
            end

            tbl3[num1] = num2

            for _, value in ipairs(tbl6) do
                local valueName = value.Name

                tbl1[num1][valueName] = value
                tbl2[value] = num1
            end

            initializeSelectionListener()
        end,
        unregisterButtonRow = function(num1: number)
            local var4 = tbl1[num1]
            if var4 then
                for _, value in pairs(var4) do
                    tbl2[value] = nil
                end
            end
            tbl1[num1] = nil
            tbl3[num1] = nil

            tbl5[num1] = nil

            if not next(tbl1) then
                disconnectSelectionListener()
            end
        end,
        registerFrame = function(arg1, num1: number)
            tbl4[num1] = arg1
        end,
        unregisterFrame = function(num1: number)
            tbl4[num1] = nil
        end,
        registerScrollCallback = function(num1: number, func1: (...any) -> (...any))
            tbl5[num1] = func1
        end,
        unregisterScrollCallback = function(num1: number)
            tbl5[num1] = nil
        end,
        handlePersonRemoved = function(userId: number)
            local var4 = var1.people(false)
            for _, value in ipairs(var4) do
                if value.UserId == userId then
                    return
                end
            end

            local var5, var6 = getFocusedPersonInfo()

            if var5 ~= userId or not var6 then
                return
            end

            local nearestPerson = findNearestPerson(userId, var4)

            if nearestPerson and tbl1[nearestPerson] then
                local selectedCoreObject = findButtonForUser(nearestPerson, var6)
                if selectedCoreObject then
                    task.defer(function()
                        GuiService.SelectedCoreObject = selectedCoreObject
                    end)
                    return
                end
            end

            for k, _ in pairs(tbl1) do
                if k == userId then
                    continue
                end

                local selectedCoreObject = findButtonForUser(k, var6)
                if selectedCoreObject then
                    task.defer(function()
                        GuiService.SelectedCoreObject = selectedCoreObject
                    end)
                    return
                end
            end
        end,
        hasSelectablePlatformButton = function(num1: number?)
            if not num1 then
                return false
            end

            local platformName = var1.getPlatformName(num1)
            local platformProfileId = var1.getPlatformProfileId(num1)

            local bool2 = platformName(false)
            local var4 = platformProfileId(false)

            if bool2 then
                if type(bool2) == "string" then
                    bool2 = string.len(bool2) > 0
                else
                    bool2 = false
                end
            end

            local var5 = PeopleUtility.canShowPlatformProfile(var4 or "")

            return bool2 and var5
        end,
        saveScrollPosition = function()
            local var4 = SettingsHubService.hubRef()
            if var4 and var4.PageView then
                canvasPosition = var4.PageView.CanvasPosition
            end
        end,
        setBlockingModalRestoreMode = function(bool2: boolean)
            bool1 = bool2
        end,
        getFirstPersonButton = getFirstPersonButton
    }
end

return (createFocusNavigationService())
