-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:01:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local React = require(BuildExperienceParent.React)
local Signals = require(BuildExperienceParent.Signals)
local SignalsReact = require(BuildExperienceParent.SignalsReact)
local CreatorAgentChat = require(BuildExperienceParent.DataHydration.CreatorAgentChat)
local _createBuildModelSelectionStore = require(BuildExperience.Stores.GetBuildModelSelectionStore.createBuildModelSelectionStore)
local _ModelPickerTypes = require(BuildExperience.Components.ModelPicker.ModelPickerTypes)
local experimentOverride = CreatorAgentChat.experimentOverride

local var1 = (setmetatable({}, { __mode = "k" }))

local function useBuildInternalTesting(entry: string?, session: string?, routeSessionId: string?)
    local var2 = React.useRef(nil)

    local var3 = React.useMemo(function()
        local var3 = session or entry
        local current = var2.current
        local var4 = if var3 == nil then nil else var1[var3]

        if var4 == nil
            and current ~= nil
            and current.entry == entry
            and current.routeSessionId == routeSessionId
            and (current.session == nil or current.session.getCasSessionId() == nil)
        then
            var4 = current.pending
        end
        if var4 ~= nil then
            if var3 ~= nil then
                var1[var3] = var4
            end
            var2.current = {
                entry = entry,
                session = session,
                routeSessionId = routeSessionId,
                pending = var4
            }
            return var4
        end
        local key = experimentOverride.createPendingKey()
        local num1 = 0
        local pending = {
            key = key,
            retain = function()
                num1 += 1
                return function()
                    num1 -= 1
                    if num1 == 0 then
                        experimentOverride.clear(key)
                    end
                end
            end
        }
        if var3 ~= nil then
            var1[var3] = pending
        end
        var2.current = {
            entry = entry,
            session = session,
            routeSessionId = routeSessionId,
            pending = pending
        }
        return pending
    end, { entry, session, routeSessionId })
    local var4 = React.useRef(nil)
    local current = React.useMemo(function()
        return {}
    end, { entry, session })
    React.useLayoutEffect(function()
        var4.current = current
        return function()
            var4.current = nil
        end
    end, { current })
    React.useEffect(function()
        return var3.retain()
    end, { var3 })

    local var6 = React.useCallback(function()
        return experimentOverride.getKey(if session == nil then nil else session.getCasSessionId()) or var3.key
    end, { session, var3 })
    local var7 = React.useMemo(function()
        return Signals.createComputed(function(arg1)
            if session ~= nil then
                session.getModels(arg1)
            end
            return experimentOverride.getInternalSelection(var6(), arg1)
        end, function(arg1, arg2): boolean
            return arg1.isSelected == arg2.isSelected
                and arg1.previewHash == arg2.previewHash
                and arg1.previewSpecName == arg2.previewSpecName
        end)
    end, { session, var6 })
    local var8 = SignalsReact.useSignalState(var7)
    local function canEdit(): boolean -- Luacid: Inlined by compiler; 3 call sites recovered
        local selection = if entry == nil then nil else entry.getSelection(false)
        return var4.current == current and selection ~= nil and not selection.isBusy
    end
    local function adoptPending() -- Luacid: Inlined by compiler; 3 call sites recovered
        if session ~= nil then
            session.setPendingExperimentKey(var3.key)
        end
    end
    React.useLayoutEffect(function()
        if session ~= nil and experimentOverride.has(var3.key) then
            session.setPendingExperimentKey(var3.key)
        end
    end, { session, var3 })

    return entry ~= nil
        and {
            isSelected = var8.isSelected,
            previewHash = var8.previewHash,
            previewSpecName = var8.previewSpecName,
            onSelect = function()
                if canEdit() then
                    experimentOverride.selectInternal(var6(), true)
                    adoptPending()
                end
            end,
            onSaveSpec = function(str2: string?, arg1)
                if canEdit() and experimentOverride.getInternalSelection(var6(), false).isSelected then
                    experimentOverride.set(var6(), str2, arg1)
                    experimentOverride.selectInternal(var6(), true)
                    adoptPending()
                end
            end,
            onExit = function()
                if canEdit() and experimentOverride.getInternalSelection(var6(), false).isSelected then
                    experimentOverride.selectInternal(var6(), false)
                    adoptPending()
                end
            end
        }
        or nil, var3.key
end

return useBuildInternalTesting
